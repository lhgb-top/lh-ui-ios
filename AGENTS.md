# lh-ui-ios —— AGENTS.md

> Swift Package `lh-ui-ios` · Swift + SwiftUI · **原生血脉**成员之一。
> 权威规范：本文件 > 家族根 `AGENTS.md` > 总纲 `docs/多端组件库规划.md`。

## 一、定位与血脉

- **原生血脉**：`lh-ui-core`（JSON 令牌 + 契约 + 黄金用例 + codegen）→ android / ios / harmony / windows。
- 本仓是 iOS 端 UI 层：**Swift + SwiftUI 手写 UI**，运行时零 JS、零 TS、零 npm 依赖。
- 与 web 血脉（`@lh-ui/share` → plus/vue2/react/uniapp）**互相独立、不得关联**（总纲 D13）。本仓不依赖
  `@lh-ui/share`，web 仓也不依赖本仓。视觉一致性靠《设计语言基线.md》人工对齐。
- 唯一外部令牌来源：core codegen 生成的 `LhTokens` / `LhDarkTokens` / `LhShadow`
  （SPM target `LhUITokens`）。

## 二、目录职责

```
lh-ui-ios/
├── Package.swift              # SPM 清单（LhUITokens / LhUI / LhUIDocs / LhUITests 四 target，iOS 15 / macOS 12）
├── scripts/
│   ├── link-tokens.mjs        # 令牌本地连接（三级存在性守卫，D18）
│   ├── gen-sim-tokens.mjs     # 文档模拟器令牌 CSS 生成（D19）
│   └── gen-doc-pages.mjs      # md → 原生文档页（D21）：产出 LhUIDocs/pages/ 与 DocRegistry.swift
├── Sources/
│   ├── LhUITokens/Sources/LhUITokens/   # 【生成物，gitignore】LhTokens / LhDarkTokens / LhShadow
│   ├── LhUI/
│   │   ├── Theme/LhTheme.swift              # LhColors 色板 + Light/DarkLhColors + Environment(\.lhColors) + LhTheme 容器
│   │   └── Components/<Comp>/               # 14 个组件：Button Cell Checkbox Dialog Icon Input
│   │                                       # Loading Navbar Picker Radio Switch Tag Textarea Toast
│   │       ├── Lh<Comp>.swift               # View + Lh<Comp>Style.resolveAppearance 纯函数 + Lh<Comp>Appearance 结构体
│   │       └── Lh<Comp>Previews.swift       # #Preview（Icon 另有 LhIconMap.swift 图标名→SF Symbol 表）
│   └── LhUIDocs/                            # 原生文档模块（D21）：真交互主场，对标 Android :docsui
│       ├── LhDocsView.swift                 # 宿主：自管返回栈 + LhNavbar dogfood + 明暗切换 + 全局 LhToast
│       ├── DocRegistry.swift                # 【生成物，禁手改】页面注册表（顺序对齐 docs 侧边栏）
│       ├── Model/DocModels.swift            # DocGroup/DocEntry/DocSection/DocTable/DocPreviewScope
│       ├── Widgets/                         # DocPalette（docs 令牌取色别名）/ DocHeading / DocProse /
│       │                                    # DocCodeBlock / DocTableView / DocPreviewFrame / StatefulPreview
│       ├── pages/                           # 【生成物，禁手改】19 个条目（14 组件 + 5 指南）
│       └── Previews/                        # 手写真交互预览：{Comp}Previews.swift，方法名对齐 SCENE_MAP
├── Tests/LhUITests/Lh<Comp>Tests.swift      # 每组件一份 XCTest（黄金用例，仅 macOS 宿主可跑）
├── docs/                      # VitePress 文档站（内联静态 HTML 模拟器，D19）
│   ├── guide/                 # introduction / installation / quickstart / theming / local-linking
│   ├── components/*.md        # 14 个组件页（md 是 LhUIDocs 页面与网页站的共同真源）
│   └── .vitepress/config.ts   # 数据驱动侧边栏：新增组件文档页必须在此登记 componentGroups
├── .changeset/                # 变更集（pnpm changeset / changeset:version）
└── package.json               # 构建期工具脚本入口（非运行时）
```

**待补缺口**：core 的 `specs/` 有 16 个组件，本仓已实现 14 个，`text` 组件尚未落地。

## 三、组件解剖约定（14 个组件一致遵守）

新增组件必须照抄这套形态，否则 XCTest 无法断言、文档无法对齐：

1. **三件套同文件**：`Lh<Comp>`（View）+ `Lh<Comp>Style`（纯函数 enum）+ `Lh<Comp>Appearance`
   （Equatable 结构体）写在同一个 `Lh<Comp>.swift` 里。**Button 是历史例外**——它的 Style 拆在
   独立的 `LhButtonStyle.swift`；新组件不要学它。`Lh<Comp>Previews.swift` 放 `#Preview`。
2. **`resolveAppearance` 必须是纯函数**：只吃 props + `LhColors`，吐 `Lh<Comp>Appearance`，
   不依赖 View、不读 Environment。View 的 `body` 调它一次再按结果布局。XCTest 只断言这个函数，
   不渲染 View（所以黄金用例在 macOS 宿主无需模拟器就能跑）。
3. **枚举 rawValue 与 spec 逐字对齐**：`LhToastType` / `LhIconSize` / `LhIconTone` 等 prop 枚举
   一律 `String, CaseIterable, Sendable`，rawValue 等于 `specs/<comp>.json` 的枚举值
   （`default` / `success` / `small` …）。遇 Swift 关键字加反引号。
4. **受控状态用 `@Binding`**：Dialog / Checkbox / Input / Picker / Radio / Switch / Textarea / Toast
   的可见性或值走 `@Binding`（如 Toast 的 `visible`、Switch 的 `isOn`）；命令式 spec 语义
   （show/hide/tick）在声明式 API 下等价为 Binding + `.task` 计时。
5. **`fontWeight(_:)` 映射逐组件复制**：`Typography.FontWeight` 令牌是 Int，`Font.Weight` 无公开数值
   初始化器，11 个组件各自 `private static func fontWeight(_ weight: Int) -> Font.Weight`
   （<500 → .regular，500..<650 → .semibold，其余 → .bold）。新组件照抄这份私有 helper，
   **不要**提取公共扩展（会破坏各组件自洽的令牌绑定）。
6. **图标走 LhIconMap**：spec 的 `icon` prop 是图标名（五端同名），iOS 端由
   `LhIconMap.symbol(for:)` 映射到 SF Symbols（`star` / `search` / `check` …）。未登记名返回 nil，
   调用方不绘制（`Color.clear` 占位）不崩溃。加新图标名改 `LhIconMap.swift`，并同步 web 血脉的
   `@lh-ui/share` 图标名表。
7. **无障碍**：组件统一带 `.accessibilityElement` + `.accessibilityLabel`，可点击组件
   （LhIcon / LhButton）按 `onClick != nil` 加 `.isButton` trait。

## 四、红线

1. **令牌唯一源**：组件实现禁止出现任何色值 / 间距 / 圆角 / 字号字面量（`Color(red:...)`、
   `CGFloat(40)`、字号数字等），只能引用 `LhTokens.Button.*` / `Environment(\.lhColors)`。违例即 drift。
2. **core 生成的令牌文件禁止手改**：`Sources/LhUITokens/` 是生成物（gitignore），改令牌去
   `lh-ui-core/tokens/*.json` → `pnpm codegen` → 本仓 `pnpm link:tokens`。
3. **只生成骨架不生成 UI**：core 不会、也不应生成任何 View 实现体；本仓的 View 全部手写。
4. **血脉隔离**：禁止 import 任何 `@lh-ui/share` / web 仓符号；本仓不发布到 npm。
5. **黄金用例对齐**：组件行为必须满足 `lh-ui-core/cases/<comp>.json`，并人工翻译为 XCTest
   （`resolveAppearance` 纯函数断言可在 macOS 宿主跑，无需模拟器）。
6. **命名与 spec 对齐**（R-n5）：props 名严格沿用 `lh-ui-core/specs/<comp>.json` 的驼峰命名
   （`type` / `size` / `disabled` / `loading` / `icon` / `bgPattern`），不得自创 `variant` / `dimension` 等。
7. **原生文档模块同样是零字面量**（D21）：`Sources/LhUIDocs/` 的取色取距只能走
   `LhTokens.Docs.*` / `LhDarkTokens.Docs.*` / `Environment(\.lhColors)`，与组件实现同等待遇。
8. **`Sources/LhUIDocs/pages/` 与 `DocRegistry.swift` 是生成物，禁手改**：改文档改 `docs/**/*.md`
   再 `pnpm gen:docs`；真交互预览手写在 `Sources/LhUIDocs/Previews/{Comp}Previews.swift`，
   方法名必须与 `scripts/gen-doc-pages.mjs` 的 SCENE_MAP 对齐，签名固定为
   `static func <scene>(_ scope: DocPreviewScope) -> AnyView`。

## 五、令牌消费机制（D18）

core 的 codegen 产物是 `LhTokens`（明）与 `LhDarkTokens`（暗）两个 public enum（无实例命名空间惯用法），
外加 `LhShadow` 结构体（SwiftUI 阴影载体）。

- **暗色模型是并列对象**：`LhDarkTokens` 只含 `Color` 子枚举，尺寸类令牌暗色不覆盖
  （与 android / harmony / windows 一致；docs 端是浅合并）。主题层据此设计。
- **本地连接**：`pnpm link:tokens`（脚本带三级守卫：本地 `../lh-ui-core/dist/ios` →
  npm `@lh-ui/core/dist/ios` → 报错）。禁止把生成的令牌文件提交入库。
- **回退形态**：家族布局不存在时（CI 单仓 clone），`@lh-ui/core` npm 包的 `files:["dist"]`
  含四端产物。SPM 远程依赖回退在 nM6 打通后接入。

**两层消费路径**（组件必须走第二层）：

1. **尺寸/圆角/字号/动效**：直接取 `LhTokens.<Comp>.*`（如 `LhTokens.Toast.fontSize`、
   `LhTokens.Motion.Duration.base`）——尺寸令牌无暗色变体，永远走明色对象。
2. **颜色**：取 `@Environment(\.lhColors)` 的 `LhColors` 字段（如 `colors.success`），
   由 `LhTheme(isDark:)` 注入明/暗色板。`LhColors` 是把 `LhTokens.Color` /
   `LhDarkTokens.Color` 平铺出来的不可变 struct（`LightLhColors` / `DarkLhColors` 是两个
   public 常量），单测直接构造它做断言。组件里**禁止**直接引用 `LhDarkTokens.Color`。

## 六、命名规范（总纲 D20）

- **模块名即包名**：SPM module `lh-ui-ios`，products `LhUI` / target `LhUITokens` 已带 LH 品牌前缀；
  iOS 无反域名包名概念，无 bundleName（由宿主 App 决定）。
- **自有标识符一律 LH 前缀**：类型 / 枚举 / 结构体 `Lh*`（`LhButton`、`LhButtonType`、
  `LhColors`、`LhDiagonalPatternFill`），按语言惯例定大小写；第三方符号不加。
- npm / ohpm 的 `@lh-ui/*` scope 不受此约束。

## 七、平台 gotcha

- **⚠ Windows / Linux 主机无法构建**：`Sources/LhUITokens` 的生成文件 `import SwiftUI`，
  Swift on Windows 没有 SwiftUI，`swift build` 会直接报 `no such module 'SwiftUI'`。
  **`swift build` / `swift test` 只能在 macOS 宿主跑**（Package.swift 声明 macOS 12 就是为了
  在 macOS 上跑 XCTest，无需 iOS 模拟器）。Windows 上只能改代码、做令牌/文档类工作，
  编译验证留到 macOS。此外 Windows 上 `swift build` 可能报 `.build/debug` 符号链接 I/O 错误
  （code 512，需开发者模式）——这也是构建走 macOS 的理由之一。
- **单位**：尺寸/字号都是 `CGFloat`（单位 pt，无 dp/sp 之分）。暗色对象不含尺寸令牌，
  取尺寸时始终走明色对象。
- **时长单位是秒**：`Motion.Duration.base = 0.300`——**与 android / harmony / windows（毫秒）不同**，
  SwiftUI 动画 API 直接消费。
- **⚠ spec 的时长 prop 是毫秒，端侧换算**：`LhToast.duration` 等 prop 按 spec 保留毫秒语义
  （`duration: Int = 2000`），View 层 `.task` + `Task.sleep` 前除以 1000 转秒
  （见 `LhToastStyle.resolveAppearance` 的 `durationSeconds`）。改计时组件时留意这个换算。
- **色值表达**：归一化 RGB `SwiftUI.Color(red:green:blue:)` + `.opacity()`，非 hex。
- **关键字成员名**：生成的成员名遇 Swift 关键字会带反引号（`` `default` ``，core ios target 已处理）；
  本仓引用时同样要写 `` LhTokens.Color.Primary.`default` ``。
- **Font.Weight**：`Typography.fontWeight` 令牌是 Int（400/600），`Font.Weight` 无公开数值
  初始化器，端侧做映射（<500 → .regular，500..<650 → .semibold，其余 → .bold）。
- **⚠ 尾随闭包不总是绑最后一个回调**：`LhInput` / `LhTextarea` 的回调顺序是
  `onValueChange` / `onFocus` / `onBlur`，尾随闭包会绑到 `onBlur`；要监听值变化必须显式写
  `onValueChange:`。`LhCheckbox` / `LhRadio` / `LhSwitch` / `LhTag` / `LhCell` 的回调才是末位，
  尾随闭包写法成立。写 `LhUIDocs/Previews/` 时尤其易错（本机无 SwiftUI 无法即时编译验证）。
- **圆角**：`Radius.circle` 是 0.5 分数，端侧取 `min(宽,高)/2` 换算，不能当 pt 用。
- **#Preview 即文档**：`Lh<Comp>Previews.swift` 是组件示例的第一现场，文档站 HTML 模拟器是第二现场。

## 八、命令速查

| 任务 | 命令 | 说明 |
| --- | --- | --- |
| 同步令牌 | `pnpm link:tokens` | 从 core dist 同步到本仓源码树（改令牌后必跑） |
| 令牌同步校验 | `pnpm link:tokens:check` | CI 门禁：检测令牌是否已同步 |
| 编译 | `swift build` | SPM 编译（含类型检查）。**仅 macOS**，Windows/Linux 无 SwiftUI |
| 单测 | `swift test` | 黄金用例（macOS 宿主可跑，无需 iOS 模拟器） |
| 单组件单测 | `swift test --filter LhToastTests` | 按 XCTestCase 类名过滤 |
| 文档 dev | `pnpm docs:dev` | 先 gen:sim 再起 VitePress（端口 5182） |
| 文档构建 | `pnpm docs:build` | 部署前跑，产物在 docs/.vitepress/dist |
| 原生文档页生成 | `pnpm gen:docs` | md → `Sources/LhUIDocs/pages/` + `DocRegistry.swift`（改 md 后必跑） |
| 写变更集 | `pnpm changeset` | 发版前写 `.changeset/*.md`；`pnpm changeset:version` 消费 |

## 九、Read before touching sensitive areas

- 改 `LhTheme.swift`：先读 core 的 `dist/ios/Sources/LhUITokens/LhDarkTokens.swift`，确认暗色覆盖范围
  （只 Color，不含尺寸），否则主题层取尺寸会拿到错误对象。`LhColors` 每加一个字段，
  `LightLhColors` / `DarkLhColors` / 公开 init 要四处同步（struct 无成员默认值，漏一处即编译错误）。
- 改任一组件的令牌绑定：先读 `../../lh-ui-core/specs/<comp>.json` 的 behaviors 与 tokenRefs，
  令牌绑定必须逐条对齐；黄金用例（`cases/<comp>.json`）会断言这些映射。
  `LhButtonStyle.swift`（Button 拆件）与各 `Lh<Comp>.swift` 内联的 Style 同理。
- 改 `LhIconMap.swift`：图标名表与 web 血脉 `@lh-ui/share` 的内置图标名逐字对齐，
  改一个名要五端同步（R-n5 要求五端同名）。
- 改 `docs/.vitepress/config.ts`：`search: { provider: 'local' }` 必须放在**顶层** `themeConfig`，
  不能放 `locales.root.themeConfig`——VitePress 的 `__VP_LOCAL_SEARCH__` 构建期常量只读
  `site.themeConfig`，放 locales 里会被求值为 false，搜索框渲染成空壳（见
  `.changeset/ios-docs-local-search.md`）。新增组件文档页要在 `componentGroups` 登记。
- 改 `scripts/*.mjs`：守卫逻辑改动影响四仓统一机制，先读 core 的
  `scripts/resolve-local-tokens.mjs` 与总纲 D18。
- 加新组件：先在 core 仓写 `specs/<comp>.json` + `cases/<comp>.json`（codegen 不生成 UI），
  再本仓建 `Sources/LhUI/Components/<Comp>/`（按第三节的三件套形态），
  翻译黄金用例为 `Tests/LhUITests/Lh<Comp>Tests.swift`，
  最后在 `config.ts` 的 `componentGroups` 登记文档页。
- 改 `scripts/gen-doc-pages.mjs` 或 `docs/**/*.md`：SCENE_MAP 的键是 md 的 `##` 标题，
  值是 `Sources/LhUIDocs/Previews/{Comp}Previews.swift` 里**已存在**的方法名；新增场景标题时
  两处必须同步，否则生成页会引用不存在的预览方法（本机无 SwiftUI，只有 `swift-frontend -parse`
  能做语法级兜底，类型错误发现不了）。改完跑 `pnpm gen:docs`。

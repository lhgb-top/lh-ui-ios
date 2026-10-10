# lh-ui-ios —— AGENTS.md

> Swift Package `lh-ui-ios` · Swift + SwiftUI · **原生血脉**成员之一。
> 权威规范：本文件 > 家族根 `AGENTS.md` > 总纲 `docs/多端组件库规划.md`。

## 一、定位与血脉

- **原生血脉**：`lh-ui-core`（JSON 令牌 + 契约 + 黄金用例 + codegen）→ android / ios / harmony / c。
- 本仓是 iOS 端 UI 层：**Swift + SwiftUI 手写 UI**，运行时零 JS、零 TS、零 npm 依赖。
- 与 web 血脉（`@lh-ui/share` → plus/vue2/react/uniapp）**互相独立、不得关联**（总纲 D13）。本仓不依赖
  `@lh-ui/share`，web 仓也不依赖本仓。视觉一致性靠《设计语言基线.md》人工对齐。
- 唯一外部令牌来源：core codegen 生成的 `LhTokens` / `LhDarkTokens` / `LhShadow`
  （SPM target `LhUITokens`）。

## 二、目录职责

```
lh-ui-ios/
├── Package.swift              # SPM 清单（LhUITokens / LhUI / LhUITests 三 target）
├── scripts/
│   ├── link-tokens.mjs        # 令牌本地连接（三级存在性守卫，D18）
│   └── gen-sim-tokens.mjs     # 文档模拟器令牌 CSS 生成（D19）
├── Sources/
│   ├── LhUITokens/            # 【生成物，gitignore】link-tokens 同步的 LhTokens/LhDarkTokens/LhShadow
│   └── LhUI/
│       ├── Theme/LhTheme.swift                    # 明/暗令牌 → Environment(\.lhColors)
│       └── Components/Button/
│           ├── LhButton.swift                     # View 手写（点击 gate 在 onTapGesture）
│           ├── LhButtonStyle.swift                # resolveAppearance 纯函数 + 图标映射
│           └── LhButtonPreviews.swift             # #Preview
├── Tests/LhUITests/LhButtonTests.swift            # XCTest（黄金用例，macOS 宿主可跑）
├── docs/                      # VitePress 文档站（内联静态 HTML 模拟器，D19）
└── package.json               # 构建期工具脚本入口（非运行时）
```

## 三、红线

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

## 四、令牌消费机制（D18）

core 的 codegen 产物是 `LhTokens`（明）与 `LhDarkTokens`（暗）两个 public enum（无实例命名空间惯用法），
外加 `LhShadow` 结构体（SwiftUI 阴影载体）。

- **暗色模型是并列对象**：`LhDarkTokens` 只含 `Color` 子枚举，尺寸类令牌暗色不覆盖
  （与 android/harmony 一致；C 端是宏重定义覆盖，docs 端是浅合并）。主题层据此设计。
- **本地连接**：`pnpm link:tokens`（脚本带三级守卫：本地 `../lh-ui-core/dist/ios` →
  npm `@lh-ui/core/dist/ios` → 报错）。禁止把生成的令牌文件提交入库。
- **回退形态**：家族布局不存在时（CI 单仓 clone），`@lh-ui/core` npm 包的 `files:["dist"]`
  含四端产物。SPM 远程依赖回退在 nM6 打通后接入。

## 五、平台 gotcha

- **单位**：尺寸/字号都是 `CGFloat`（单位 pt，无 dp/sp 之分）。暗色对象不含尺寸令牌，
  取尺寸时始终走明色对象。
- **时长单位是秒**：`Motion.Duration.base = 0.300`——**与 android/harmony/c（毫秒）不同**，
  SwiftUI 动画 API 直接消费。
- **色值表达**：归一化 RGB `SwiftUI.Color(red:green:blue:)` + `.opacity()`，非 hex。
- **关键字成员名**：生成的成员名遇 Swift 关键字会带反引号（`` `default` ``，core ios target 已处理）；
  本仓引用时同样要写 `` LhTokens.Color.Primary.`default` ``。
- **Font.Weight**：`Typography.fontWeight` 令牌是 Int（400/600），`Font.Weight` 无公开数值
  初始化器，端侧做映射（<500 → .regular，500..<650 → .semibold，其余 → .bold）。
- **圆角**：`Radius.circle` 是 0.5 分数，端侧取 `min(宽,高)/2` 换算，不能当 pt 用。
- **#Preview 即文档**：`LhButtonPreviews.swift` 是组件示例的第一现场，文档站 HTML 模拟器是第二现场。

## 六、命令速查

| 任务 | 命令 | 说明 |
| --- | --- | --- |
| 同步令牌 | `pnpm link:tokens` | 从 core dist 同步到本仓源码树（改令牌后必跑） |
| 令牌同步校验 | `pnpm link:tokens:check` | CI 门禁：检测令牌是否已同步 |
| 编译 | `swift build` | SPM 编译（含类型检查） |
| 单测 | `swift test` | 黄金用例（macOS 宿主可跑） |
| 文档 dev | `pnpm docs:dev` | 先 gen:sim 再起 VitePress（端口 5182） |
| 文档构建 | `pnpm docs:build` | 部署前跑，产物在 docs/.vitepress/dist |

## 七、Read before touching sensitive areas

- 改 `LhTheme.swift`：先读 core 的 `dist/ios/Sources/LhUITokens/LhDarkTokens.swift`，确认暗色覆盖范围
  （只 Color，不含尺寸），否则主题层取尺寸会拿到错误对象。
- 改 `LhButtonStyle.swift`：先读 `../../lh-ui-core/specs/button.json` 的 behaviors 与 tokenRefs，
  令牌绑定必须逐条对齐；黄金用例（`cases/button.json`）会断言这些映射。
- 改 `scripts/*.mjs`：守卫逻辑改动影响四仓统一机制，先读 core 的
  `scripts/resolve-local-tokens.mjs` 与总纲 D18。
- 加新组件：先在 core 仓写 `specs/<comp>.json` + `cases/<comp>.json`（codegen 不生成 UI），
  再本仓建 `Sources/LhUI/Components/<Comp>/`，翻译黄金用例为 XCTest。

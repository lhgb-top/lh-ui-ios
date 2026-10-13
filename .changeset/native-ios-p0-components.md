---
'@lh-ui/ios': minor
---

补齐总纲 D17 原生 P0 剩余 13 个组件的 iOS 端实现：Cell / Checkbox / Dialog / Icon / Input /
Loading / Navbar / Picker / Radio / Switch / Tag / Textarea / Toast。每个组件遵守三件套形态
（`Lh<Comp>.swift` = View + `Lh<Comp>Style.resolveAppearance` 纯函数 + `Lh<Comp>Appearance`
Equatable 结构体，`Lh<Comp>Previews.swift` = `#Preview`），props 枚举 rawValue 与
`lh-ui-core/specs/<comp>.json` 逐字对齐，黄金用例翻译为 `Tests/LhUITests/Lh<Comp>Tests.swift`
（断言纯函数，macOS 宿主无需模拟器即可跑），并补齐 13 个组件文档页与 `config.ts` 侧边栏登记。

本机 Windows 无 SwiftUI 模块（`swift build` / `swift test` 只能在 macOS 宿主运行），为避免
「改完无法编译」的盲区，本次在仓外手写了忠实的 SwiftUI / CoreGraphics 桩模块（API 签名对齐
SwiftUI 真实形态，不含实现），发射 `.swiftmodule` 后对全部源码做真实类型检查，挖出一批
在 macOS 上同样会编译失败 / 运行出错的真 bug，已全部修复并复验至零 error：

- 编译阻断：14 个组件的 `var body: some View { ... }` 多语句体缺少显式 `return`
  （Swift 要求末尾为成员链/后缀表达式时显式 return）；Dialog / Picker / Toast 的
  `.animation(_:value:)` 作为 `if` 块之后的独立语句是非法 Swift，需先用 `Group { }` 包裹条件分支。
- 运行时错误：`DarkLhColors.onPrimary` 引用了 `LhDarkTokens.Color.onPrimary`——core 的暗色模型是
  并列对象、只声明增量覆盖键，暗色无此键，运行时必崩溃；改为回退明色令牌 `LhTokens.Color.onPrimary`。
- 废弃 API：LhInput 的 `.accentColor` 在 iOS 15+ 已废弃，改用 `.tint`。
- 文档构建阻断：`scripts/copy-true-shots.mjs` 的块注释里写了路径 glob
  `Sources/LhUI/Components/**/*Previews.swift`，其中的 `*/` 提前闭合了注释，导致
  `pnpm docs:build` / `pnpm docs:dev` 全链路 SyntaxError 崩溃；已改写注释措辞规避。

此前静态代码审查发现并修复的一批问题（同属本轮组件落地）：

- 编译阻断：Checkbox / Radio / Switch 的 `accessibilityAddTraits(.notEnabled)` —— SwiftUI 的
  `AccessibilityTraits` 无此成员（那是 UIKit 的），改为 `[]`；LhTextarea 的
  `.scrollContentBackground(.hidden)` 是 iOS 16 / macOS 13+ API 而部署目标为 iOS 15 / macOS 12，
  用 `if #available` 包裹；LhCellPreviews（6 处）/ LhTagPreviews（1 处）的实参顺序违反
  Swift 声明顺序要求。
- 测试断言：LhToastTests 暗色默认类型断言了 success 圆点色，但默认类型 dotColor 为 nil，必挂；
  改为断言 nil 并另加 success 圆点的暗色专项。
- 逻辑：LhButton / LhDialog 的阴影把 `LhShadow.color`（已内联 opacity）又乘一次
  `.opacity(opacity)`，有效透明度降到约 0.0016，阴影几乎不可见 → 直接用 `.color`；LhPicker
  确认时发送未钳制的原始索引（越界时与 UI 显示不一致）→ 钳制后再发并顺带纠正外部值；
  LhInput / LhTextarea 的 disabled / readonly 网关从事后拦截改为 `Binding` 写入网关
  （readonly 时不禁用控件、只拒绝写入，避免 `.disabled` 混淆两语义），移除与输入控件竞争的
  容器 `onTapGesture`，补上 LhTextarea 缺失的 `.focused`；LhToast 的 `.task(id:)` 由 visible
  改为 (visible, text, duration) 组合，修复重复显示不重启倒计时，并修正 `fixedSize` 与 maxWidth
  冲突导致长文本不换行；LhLoading 的 `animating` 由 false 切 true 时补 `.onChange` 重启动画。

另修复 core 仓 ios codegen 的 `LhShadow` 括号 bug（生成的 Swift 少一个右括号，不可编译），
详见 lh-ui-core 仓 changeset。

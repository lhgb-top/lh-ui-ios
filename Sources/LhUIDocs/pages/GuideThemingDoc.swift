// 本文件由 scripts/gen-doc-pages.mjs 从 docs/guide/theming.md 生成 —— 禁手改。
// 改文档请改 md 再跑 pnpm gen:docs；真交互预览手写在 Sources/LhUIDocs/Previews/GuidePreviews.swift。
// 本文件与 DocRegistry.swift 同属 LhUIDocs 模块，无需 import 自身。

/// 主题与暗色（生成物，勿手改）
struct GuideThemingDoc {
  static let entry = DocEntry(
    id: "theming",
    title: "主题与暗色",
    lede: [],
    contract: [],
    group: .guide,
    sections: [
        DocSection(
        title: "令牌模型",
        prose: [
          "原生血脉的令牌真源在 `lh-ui-core/tokens/*.json`，codegen 生成 iOS 产物：",
          "> 这与 android / harmony / windows 一致（并列对象），与 docs 端（浅合并 JSON）形态不同。",
          "> 主题层据此设计：`LhColors` 只承载颜色，尺寸由组件直接取 `LhTokens`。",
        ],
        preview: nil,
        code: [],
        tables: [
              DocTable(
                title: "",
                headers: ["产物", "内容", "暗色形态"],
                rows: [
                  DocRow(cells: ["`LhTokens`", "明色全量：Button 尺寸、Color 色板、Motion、Radius、Shadow、Spacing、Typography、ZIndex", "—"]),
                  DocRow(cells: ["`LhDarkTokens`", "仅 `Color` 子对象（**并列对象**模型）", "暗色只覆盖颜色，尺寸/动效/圆角暗色不变"]),
                  DocRow(cells: ["`LhShadow`", "SwiftUI 阴影载体结构体（color/opacity/radius/x/y）", "—"]),
                ])
        ]
      ),
      DocSection(
        title: "LhColors",
        prose: [
          "`LightLhColors` / `DarkLhColors` 把生成的两个 enum 平铺为一份 `Equatable` 值类型：",
          "构造器公开：单测可直接构造色板做断言；应用侧应通过 `LhTheme` 消费。",
        ],
        preview: nil,
        code: [
          "public struct LhColors: Equatable {",
          "  public let primary: Color",
          "  public let onPrimary: Color",
          "  // ... 全部语义色",
          "}",
          "",
          "public let LightLhColors = LhColors(primary: LhTokens.Color.Primary.`default`, /* ... */)",
          "public let DarkLhColors = LhColors(primary: LhDarkTokens.Color.Primary.`default`, /* ... */)",
        ],
        tables: []
      ),
      DocSection(
        title: "LhTheme",
        prose: [
          "无 `LhTheme` 包裹时 Environment 键的 defaultValue 回退 `LightLhColors`（缺省即明色）。",
        ],
        preview: nil,
        code: [
          "LhTheme(isDark: true) {",
          "  // Environment(\\.lhColors) 注入 DarkLhColors，内部组件自动消费",
          "}",
        ],
        tables: []
      ),
      DocSection(
        title: "暗色预计算（重要）",
        prose: [
          "web 血脉的暗色用 CSS `color-mix()` 动态求值，原生无 CSS 级联，故 core 已把暗色表达式",
          "**预计算为字面量**（如 `rgba(61,100,158,0.25)`、`#B1C1D8`）。后果（总纲 R-n6）：",
          "> **改预设主色时，暗色预计算值不会自动跟随**，必须重新人工计算并更新",
          "> `lh-ui-core/tokens/color-dark.json`，同步刷新《设计语言基线》。",
        ],
        preview: nil,
        code: [],
        tables: []
      ),
      DocSection(
        title: "iOS 端特有约定",
        prose: [
          "- **时长单位是秒**：`LhTokens.Motion.Duration.base = 0.300`（android/harmony 是毫秒、C 是毫秒），",
          "SwiftUI 动画 API 直接消费，无需换算。",
          "- **色值表达**：生成产物用归一化 RGB（`SwiftUI.Color(red:green:blue:)` + `.opacity()`），",
          "不用 hex 字符串。",
          "- **圆角**：`Radius.circle` 是 0.5 分数，端侧取 `min(宽,高)/2` 换算，不能当 pt 用。",
          "- **阴影**：SwiftUI 不支持扩展量（spread），生成的 `LhShadow` 已忽略 spread 并注释。",
          "- **字体**：`Typography.fontFamily` 是字体栈字符串，端侧取首个可用族；国风衬线是默认调性。",
        ],
        preview: nil,
        code: [],
        tables: []
      ),
      DocSection(
        title: "令牌速查",
        prose: [
          "完整令牌表（明/暗/说明）见 core 仓 `dist/docs/tokens.md`（`pnpm codegen` 后生成）。",
          "组件级令牌映射见 [Button 令牌对照](/components/button#令牌对照)。",
        ],
        preview: nil,
        code: [],
        tables: []
      ),
    ]
  )
}

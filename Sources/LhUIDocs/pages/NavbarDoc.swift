// 本文件由 scripts/gen-doc-pages.mjs 从 docs/components/navbar.md 生成 —— 禁手改。
// 改文档请改 md 再跑 pnpm gen:docs；真交互预览手写在 Sources/LhUIDocs/Previews/NavbarPreviews.swift。
// 本文件与 DocRegistry.swift 同属 LhUIDocs 模块，无需 import 自身。

/// Navbar 导航栏（生成物，勿手改）
struct NavbarDoc {
  static let entry = DocEntry(
    id: "navbar",
    title: "Navbar 导航栏",
    lede: [
      "页面顶部导航栏。居中标题 + 两侧内容，底部分隔线，层级取 `zIndex.sticky`。",
    ],
    contract: [
      "契约源：`lh-ui-core/specs/navbar.json` ·",
      "黄金用例：`lh-ui-core/cases/navbar.json`（6 条，已翻译为 XCTest，macOS 宿主即可运行）",
    ],
    group: .navigation,
    sections: [
        DocSection(
        title: "基本形态",
        prose: [
          "`title` 居中显示（绝对定位，不与两侧内容重叠）；`leftText` / `rightText` 分别贴左右两侧。",
        ],
        preview: NavbarPreviews.basic,
        code: [
          "LhNavbar(",
          "  title: \"青花瓷\",",
          "  leftText: \"返回\",",
          "  rightText: \"更多\",",
          "  onLeftClick: { /* 返回 */ },",
          "  onRightClick: { /* 更多 */ }",
          ")",
        ],
        tables: []
      ),
      DocSection(
        title: "图标与边框",
        prose: [
          "`leftIcon` / `rightIcon` 走 `LhIconMap` 映射，与文字并排显示；`bordered = false` 去掉底部分隔线。",
        ],
        preview: NavbarPreviews.iconAndBorder,
        code: [],
        tables: []
      ),
      DocSection(
        title: "点击 gate",
        prose: [
          "未提供 `leftText` / `leftIcon` 时左侧不响应点击（黄金用例 `no-left-content-no-onleftclick`），",
          "右侧同理。悬浮定位由调用方用 `.overlay` 挂载（SwiftUI 惯例），组件自身提供 `zIndex.sticky` 层级。",
        ],
        preview: NavbarPreviews.clickGate,
        code: [
          "ZStack {",
          "  contentView",
          "    .padding(.top, LhTokens.Navbar.height)",
          "  LhNavbar(title: \"青花瓷\", leftText: \"返回\", onLeftClick: { dismiss() })",
          "    .overlay(alignment: .top) { ... }",
          "}",
        ],
        tables: []
      ),
      DocSection(
        title: "API",
        prose: [],
        preview: nil,
        code: [],
        tables: [
              DocTable(
                title: "Props",
                headers: ["属性", "说明", "类型", "默认值"],
                rows: [
                  DocRow(cells: ["`title`", "居中标题", "`String`", "`\"\"`"]),
                  DocRow(cells: ["`leftText`", "左侧文字（为空且无 leftIcon 时不响应点击）", "`String`", "`\"\"`"]),
                  DocRow(cells: ["`leftIcon`", "左侧图标逻辑名（`LhIconMap` 映射）", "`String?`", "`nil`"]),
                  DocRow(cells: ["`rightText`", "右侧文字（为空且无 rightIcon 时不响应点击）", "`String`", "`\"\"`"]),
                  DocRow(cells: ["`rightIcon`", "右侧图标逻辑名", "`String?`", "`nil`"]),
                  DocRow(cells: ["`bordered`", "是否显示底部分隔线", "`Bool`", "`true`"]),
                  DocRow(cells: ["`onLeftClick`", "左侧点击回调", "`(() -> Void)?`", "`nil`"]),
                  DocRow(cells: ["`onRightClick`", "右侧点击回调", "`(() -> Void)?`", "`nil`"]),
                ]),
              DocTable(
                title: "颜色",
                headers: ["区域", "颜色"],
                rows: [
                  DocRow(cells: ["底色", "`color.background.default`"]),
                  DocRow(cells: ["标题 / 两侧文字 / 图标", "`color.text.primary`"]),
                  DocRow(cells: ["分隔线", "`color.border.lighter`（宽度取 `navbar.borderWidth`）"]),
                ])
        ]
      ),
      DocSection(
        title: "令牌对照",
        prose: [],
        preview: nil,
        code: [],
        tables: [
              DocTable(
                title: "",
                headers: ["令牌", "用途"],
                rows: [
                  DocRow(cells: ["`navbar.height`", "导航栏高度（44pt）"]),
                  DocRow(cells: ["`navbar.paddingHorizontal`", "两侧横向内边距（12pt）"]),
                  DocRow(cells: ["`navbar.titleFontSize`", "标题与两侧文字字号（16pt）"]),
                  DocRow(cells: ["`navbar.iconSize`", "两侧图标尺寸（20pt）"]),
                  DocRow(cells: ["`navbar.borderWidth`", "底部分隔线宽度"]),
                  DocRow(cells: ["`color.border.lighter`", "分隔线颜色"]),
                  DocRow(cells: ["`color.text.primary`", "标题与两侧内容颜色"]),
                  DocRow(cells: ["`color.background.default`", "底色"]),
                  DocRow(cells: ["`zIndex.sticky`", "悬浮层级"]),
                ])
        ]
      ),
      DocSection(
        title: "黄金用例对照",
        prose: [
          "另有专项：`testContainerUsesBackgroundToken` / `testDarkColorsComeFromDarkTokens` /",
          "`testDimensionsAreIdenticalInDarkMode` / `testNavbarInitAndRender`。",
        ],
        preview: nil,
        code: [
          "swift test --filter LhNavbarTests    # macOS 宿主即可跑，无需模拟器",
        ],
        tables: [
              DocTable(
                title: "",
                headers: ["case id", "断言", "本地测试"],
                rows: [
                  DocRow(cells: ["`title-renders-text`", "标题正确渲染", "`testTitleUsesNavbarTokens`"]),
                  DocRow(cells: ["`leftclick-emits-onleftclick`", "左侧点击触发 onLeftClick", "`testLeftContentIsClickable`"]),
                  DocRow(cells: ["`rightclick-emits-onrightclick`", "右侧点击触发 onRightClick", "`testRightContentIsClickable`"]),
                  DocRow(cells: ["`no-left-content-no-onleftclick`", "无左侧内容时不触发", "`testNoLeftContentIsNotClickable`"]),
                  DocRow(cells: ["`bordered-uses-border-token`", "分隔线消费 border.lighter 令牌", "`testBorderedUsesBorderToken`"]),
                  DocRow(cells: ["`height-uses-navbar-height-token`", "高度消费 navbar.height 令牌", "`testHeightUsesNavbarHeightToken`"]),
                ])
        ]
      ),
    ]
  )
}

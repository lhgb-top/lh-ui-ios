// 本文件由 scripts/gen-doc-pages.mjs 从 docs/components/button.md 生成 —— 禁手改。
// 改文档请改 md 再跑 pnpm gen:docs；真交互预览手写在 Sources/LhUIDocs/Previews/ButtonPreviews.swift。
// 本文件与 DocRegistry.swift 同属 LhUIDocs 模块，无需 import 自身。

/// Button 按钮（生成物，勿手改）
struct ButtonDoc {
  static let entry = DocEntry(
    id: "button",
    title: "Button 按钮",
    lede: [
      "基础操作按钮。触发即时操作，支持类型、尺寸、加载、禁用、图标与国风花纹底。",
    ],
    contract: [
      "契约源：`lh-ui-core/specs/button.json` ·",
      "黄金用例：`lh-ui-core/cases/button.json`（8 条，已翻译为 XCTest，macOS 宿主即可运行）",
    ],
    group: .basic,
    sections: [
        DocSection(
        title: "类型",
        prose: [
          "六种类型决定底色与文字色。",
        ],
        preview: ButtonPreviews.types,
        code: [
          "LhButton(onClick: {}, type: .primary, text: \"主要按钮\")",
        ],
        tables: []
      ),
      DocSection(
        title: "尺寸",
        prose: [
          "三档尺寸映射到 `button.height` / `paddingHorizontal` / `fontSize` / `iconSize` 令牌。",
          "iOS 形态为胶囊圆角（`radius.round` 令牌）。",
        ],
        preview: ButtonPreviews.sizes,
        code: [],
        tables: []
      ),
      DocSection(
        title: "状态",
        prose: [
          "禁用与加载中都不触发 `onClick`；两者共存时按**禁用优先**处理（黄金用例 `disabled-precedes-loading`）。",
        ],
        preview: ButtonPreviews.states,
        code: [],
        tables: []
      ),
      DocSection(
        title: "图标与花纹底",
        prose: [
          "图标名按本地图标体系解析（`LhButtonStyle.icon(for:)` 映射 SF Symbol：search → magnifyingglass、",
          "refresh → arrow.clockwise、check → checkmark、close → xmark，未登记名不绘制）。",
          "花纹底消费 `color.decoration` 令牌，Canvas 绘制 45° 斜纹，叠在底色之下、文字之上但不影响对比度。",
        ],
        preview: ButtonPreviews.iconAndPattern,
        code: [],
        tables: []
      ),
      DocSection(
        title: "明暗主题",
        prose: [
          "切换站点右上角主题，模拟器手机框内的按钮颜色即变；真机通过 `LhTheme(isDark: true)` 切换。",
        ],
        preview: ButtonPreviews.theme,
        code: [],
        tables: []
      ),
      DocSection(
        title: "API",
        prose: [
          "禁用态覆盖：底色 `color.disabled.bg`、文字 `color.disabled.text`、描边 `color.disabled.border`。",
        ],
        preview: nil,
        code: [],
        tables: [
              DocTable(
                title: "Props",
                headers: ["属性", "说明", "类型", "默认值"],
                rows: [
                  DocRow(cells: ["`onClick`", "点击回调；`disabled` 或 `loading` 为 true 时不触发", "`() -> Void`", "—"]),
                  DocRow(cells: ["`type`", "按钮类型，决定底色与文字色", "`LhButtonType`", "`.default`"]),
                  DocRow(cells: ["`size`", "按钮尺寸，映射到尺寸令牌", "`LhButtonSize`", "`.medium`"]),
                  DocRow(cells: ["`disabled`", "是否禁用", "`Bool`", "`false`"]),
                  DocRow(cells: ["`loading`", "是否加载中（显示指示器，不触发 onClick）", "`Bool`", "`false`"]),
                  DocRow(cells: ["`icon`", "图标名（SF Symbol 映射解析）", "`String?`", "`nil`"]),
                  DocRow(cells: ["`bgPattern`", "是否绘制国风花纹底纹", "`Bool`", "`false`"]),
                  DocRow(cells: ["`label` / `text`", "按钮文字内容（spec 的 default 插槽）", "`Text` / 字符串", "—"]),
                ]),
              DocTable(
                title: "LhButtonType",
                headers: ["值", "底色", "文字色"],
                rows: [
                  DocRow(cells: ["`.default`", "`color.background.default`", "`color.text.primary`"]),
                  DocRow(cells: ["`.primary`", "`color.primary.default`", "`color.onPrimary`"]),
                  DocRow(cells: ["`.success`", "`color.success.default`", "`color.onPrimary`"]),
                  DocRow(cells: ["`.warning`", "`color.warning.default`", "`color.onPrimary`"]),
                  DocRow(cells: ["`.danger`", "`color.danger.default`", "`color.onPrimary`"]),
                  DocRow(cells: ["`.info`", "`color.info.default`", "`color.onPrimary`"]),
                ]),
              DocTable(
                title: "LhButtonSize",
                headers: ["值", "height", "paddingHorizontal", "fontSize", "iconSize"],
                rows: [
                  DocRow(cells: ["`.small`", "`button.height.small`（32pt）", "`button.paddingHorizontal.small`（16pt）", "`button.fontSize.small`（13pt）", "`button.iconSize.small`（16pt）"]),
                  DocRow(cells: ["`.medium`", "`button.height.medium`（40pt）", "`button.paddingHorizontal.medium`（20pt）", "`button.fontSize.medium`（14pt）", "`button.iconSize.medium`（18pt）"]),
                  DocRow(cells: ["`.large`", "`button.height.large`（48pt）", "`button.paddingHorizontal.large`（24pt）", "`button.fontSize.large`（16pt）", "`button.iconSize.large`（20pt）"]),
                ])
        ]
      ),
      DocSection(
        title: "令牌对照",
        prose: [
          "按钮消费的令牌（与 `specs/button.json` 的 `tokenRefs` 逐条对齐）：",
        ],
        preview: nil,
        code: [],
        tables: [
              DocTable(
                title: "",
                headers: ["令牌", "用途"],
                rows: [
                  DocRow(cells: ["`button.height.{small,medium,large}`", "三档高度"]),
                  DocRow(cells: ["`button.paddingHorizontal.{small,medium,large}`", "三档横向内边距"]),
                  DocRow(cells: ["`button.fontSize.{small,medium,large}`", "三档字号"]),
                  DocRow(cells: ["`button.iconSize.{small,medium,large}`", "三档图标尺寸"]),
                  DocRow(cells: ["`button.borderRadius` / `button.borderWidth`", "圆角（跟随 `radius.base`）与描边宽度"]),
                  DocRow(cells: ["`button.fontWeight`", "字重（跟随 `typography.fontWeight.primary`，端侧映射 Font.Weight）"]),
                  DocRow(cells: ["`color.primary.default` / `color.onPrimary`", "主色类型底/文字"]),
                  DocRow(cells: ["`color.{success,warning,danger,info}.default`", "语义类型底色"]),
                  DocRow(cells: ["`color.background.default` / `color.text.primary` / `color.border.base`", "默认类型底/文字/描边"]),
                  DocRow(cells: ["`color.disabled.{bg,text,border}`", "禁用态三色"]),
                  DocRow(cells: ["`color.decoration`", "花纹底纹色"]),
                  DocRow(cells: ["`shadow.lighter`", "默认 elevation（LhShadow 载体）"]),
                  DocRow(cells: ["`spacing.xs`", "图标与文字间距"]),
                ])
        ]
      ),
      DocSection(
        title: "黄金用例对照",
        prose: [
          "`cases/button.json` 的 8 条断言与 XCTest 的对应关系：",
          "另有暗色专项：`testDarkColorsComeFromDarkTokens` / `testDisabledInDarkUsesDarkDisabledTokens` /",
          "`testDimensionsAreIdenticalInDarkMode`。",
        ],
        preview: nil,
        code: [
          "swift test    # macOS 宿主即可跑，无需模拟器",
        ],
        tables: [
              DocTable(
                title: "",
                headers: ["case id", "断言", "本地测试"],
                rows: [
                  DocRow(cells: ["`click-emits-onclick`", "gate 放行（可交互）", "`LhButtonTests.testEnabledButtonIsInteractive`"]),
                  DocRow(cells: ["`disabled-blocks-click`", "禁用态不可交互", "`testDisabledIsNotInteractive`"]),
                  DocRow(cells: ["`loading-blocks-click`", "加载态不可交互", "`testLoadingIsNotInteractive`"]),
                  DocRow(cells: ["`disabled-precedes-loading`", "禁用优先 + 禁用样式", "`testDisabledPrecedesLoading`"]),
                  DocRow(cells: ["`default-type-renders-text`", "默认类型中性底/文字", "`testDefaultTypeUsesNeutralTokens`"]),
                  DocRow(cells: ["`primary-type-uses-primary-tokens`", "主色类型消费主色令牌", "`testPrimaryTypeUsesPrimaryTokens`"]),
                  DocRow(cells: ["`small-size-uses-small-tokens`", "小号消费 small 尺寸令牌", "`testSmallSizeUsesSmallTokens`"]),
                  DocRow(cells: ["`bgpattern-uses-decoration-token`", "花纹底消费装饰色", "`testBgPatternUsesDecorationToken`"]),
                ])
        ]
      ),
    ]
  )
}

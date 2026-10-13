// 本文件由 scripts/gen-doc-pages.mjs 从 docs/components/tag.md 生成 —— 禁手改。
// 改文档请改 md 再跑 pnpm gen:docs；真交互预览手写在 Sources/LhUIDocs/Previews/TagPreviews.swift。
// 本文件与 DocRegistry.swift 同属 LhUIDocs 模块，无需 import 自身。

/// Tag 标签（生成物，勿手改）
struct TagDoc {
  static let entry = DocEntry(
    id: "tag",
    title: "Tag 标签",
    lede: [
      "用于标记和选择的紧凑标签。比按钮更小，支持语义类型、描边、圆角胶囊与关闭按钮。",
    ],
    contract: [
      "契约源：`lh-ui-core/specs/tag.json` ·",
      "黄金用例：`lh-ui-core/cases/tag.json`（6 条，已翻译为 XCTest，macOS 宿主即可运行）",
    ],
    group: .basic,
    sections: [
        DocSection(
        title: "类型",
        prose: [
          "六种类型决定底色与文字色。`plain` 为描边浅底形态（语义浅底 + 语义描边）。",
        ],
        preview: TagPreviews.types,
        code: [
          "LhTag(text: \"主要\", type: .primary)",
          "LhTag(text: \"描边成功\", type: .success, plain: true)",
        ],
        tables: []
      ),
      DocSection(
        title: "尺寸与圆角",
        prose: [
          "三档尺寸映射到 `tag.height` / `paddingHorizontal` / `fontSize` 令牌；`round` 把圆角换成高度的一半（胶囊）。",
        ],
        preview: TagPreviews.sizesAndRadius,
        code: [],
        tables: []
      ),
      DocSection(
        title: "可关闭",
        prose: [
          "`closable` 在右侧显示关闭按钮，点击触发 `onClose`（黄金用例 `closable-tap-emits-onclose`）。",
        ],
        preview: TagPreviews.closable,
        code: [
          "LhTag(text: \"可关闭\", type: .primary, closable: true) {",
          "  // onClose",
          "}",
        ],
        tables: []
      ),
      DocSection(
        title: "API",
        prose: [
          "`plain = true` 时：底色取 `color.<type>.bg`、描边与文字取 `color.<type>.default`（`.default` 类型忽略 `plain`，黄金用例 `default-type-renders-text`）。",
        ],
        preview: nil,
        code: [],
        tables: [
              DocTable(
                title: "Props",
                headers: ["属性", "说明", "类型", "默认值"],
                rows: [
                  DocRow(cells: ["`text`", "标签文字", "`String`", "—"]),
                  DocRow(cells: ["`type`", "标签类型，决定底色与文字色", "`LhTagType`", "`.default`"]),
                  DocRow(cells: ["`size`", "标签尺寸，映射到尺寸令牌", "`LhTagSize`", "`.medium`"]),
                  DocRow(cells: ["`plain`", "是否为描边浅底形态", "`Bool`", "`false`"]),
                  DocRow(cells: ["`round`", "是否为胶囊圆角（半径 = 高度 / 2）", "`Bool`", "`false`"]),
                  DocRow(cells: ["`closable`", "是否显示关闭按钮", "`Bool`", "`false`"]),
                  DocRow(cells: ["`onClose`", "关闭按钮点击回调", "`(() -> Void)?`", "`nil`"]),
                ]),
              DocTable(
                title: "LhTagType",
                headers: ["值", "底色", "文字色"],
                rows: [
                  DocRow(cells: ["`.default`", "`color.background.default` + `color.border.base` 描边", "`color.text.primary`"]),
                  DocRow(cells: ["`.primary`", "`color.primary.default`", "`color.onPrimary`"]),
                  DocRow(cells: ["`.success`", "`color.success.default`", "`color.onPrimary`"]),
                  DocRow(cells: ["`.warning`", "`color.warning.default`", "`color.onPrimary`"]),
                  DocRow(cells: ["`.danger`", "`color.danger.default`", "`color.onPrimary`"]),
                  DocRow(cells: ["`.info`", "`color.info.default`", "`color.onPrimary`"]),
                ]),
              DocTable(
                title: "LhTagSize",
                headers: ["值", "height", "paddingHorizontal", "fontSize"],
                rows: [
                  DocRow(cells: ["`.small`", "`tag.height.small`（20pt）", "`tag.paddingHorizontal.small`（8pt）", "`tag.fontSize.small`（12pt）"]),
                  DocRow(cells: ["`.medium`", "`tag.height.medium`（24pt）", "`tag.paddingHorizontal.medium`（12pt）", "`tag.fontSize.medium`（13pt）"]),
                  DocRow(cells: ["`.large`", "`tag.height.large`（28pt）", "`tag.paddingHorizontal.large`（16pt）", "`tag.fontSize.large`（14pt）"]),
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
                  DocRow(cells: ["`tag.height.{small,medium,large}`", "三档高度"]),
                  DocRow(cells: ["`tag.paddingHorizontal.{small,medium,large}`", "三档横向内边距"]),
                  DocRow(cells: ["`tag.fontSize.{small,medium,large}`", "三档字号"]),
                  DocRow(cells: ["`tag.borderRadius` / `tag.borderWidth`", "默认圆角（跟随 `radius.small`）与描边宽度"]),
                  DocRow(cells: ["`tag.gap`", "文字与关闭按钮间距（跟随 `spacing.xs`）"]),
                  DocRow(cells: ["`color.{primary,success,warning,danger,info}.{default,bg}`", "语义类型底色与描边浅底"]),
                  DocRow(cells: ["`color.onPrimary`", "语义类型文字色"]),
                  DocRow(cells: ["`color.background.default` / `color.text.primary` / `color.border.base`", "默认类型三色"]),
                ])
        ]
      ),
      DocSection(
        title: "黄金用例对照",
        prose: [
          "另有暗色专项：`testDarkColorsComeFromDarkTokens` / `testPlainInDarkUsesDarkBgTokens` /",
          "`testDimensionsAreIdenticalInDarkMode`。",
        ],
        preview: nil,
        code: [
          "swift test --filter LhTagTests    # macOS 宿主即可跑，无需模拟器",
        ],
        tables: [
              DocTable(
                title: "",
                headers: ["case id", "断言", "本地测试"],
                rows: [
                  DocRow(cells: ["`default-type-renders-text`", "默认类型中性底/文字，忽略 plain", "`testDefaultTypeUsesNeutralTokens` / `testDefaultTypeIgnoresPlain`"]),
                  DocRow(cells: ["`primary-type-uses-primary-tokens`", "主色类型消费主色与 onPrimary", "`testPrimaryTypeUsesPrimaryTokens`"]),
                  DocRow(cells: ["`plain-uses-bg-tokens`", "plain 消费语义 bg 与语义描边", "`testPlainUsesBgTokens`"]),
                  DocRow(cells: ["`small-size-uses-small-tokens`", "小号消费 small 尺寸令牌", "`testSmallSizeUsesSmallTokens`"]),
                  DocRow(cells: ["`round-makes-radius-half-height`", "round 圆角 == 高度 / 2", "`testRoundMakesRadiusHalfHeight`"]),
                  DocRow(cells: ["`closable-tap-emits-onclose`", "关闭按钮触发 onClose", "`testClosableTagInitAndRender`（手势断言需模拟器）"]),
                ])
        ]
      ),
    ]
  )
}

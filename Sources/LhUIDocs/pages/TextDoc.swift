// 本文件由 scripts/gen-doc-pages.mjs 从 docs/components/text.md 生成 —— 禁手改。
// 改文档请改 md 再跑 pnpm gen:docs；真交互预览手写在 Sources/LhUIDocs/Previews/TextPreviews.swift。
// 本文件与 DocRegistry.swift 同属 LhUIDocs 模块，无需 import 自身。

/// Text 文本（生成物，勿手改）
struct TextDoc {
  static let entry = DocEntry(
    id: "text",
    title: "Text 文本",
    lede: [
      "文本展示原语：消费全局排版令牌，支持字号级别、字重、色调与对齐。",
    ],
    contract: [
      "契约源：`lh-ui-core/specs/text.json` ·",
      "黄金用例：`lh-ui-core/cases/text.json`（5 条，已翻译为 XCTest，macOS 宿主即可运行）",
    ],
    group: .basic,
    sections: [
        DocSection(
        title: "字号级别",
        prose: [
          "`level` 映射到 `typography.fontSize.<level>` 令牌，默认 `base`。",
        ],
        preview: TextPreviews.levels,
        code: [
          "LhText(\"标题文字\", level: .large)",
        ],
        tables: []
      ),
      DocSection(
        title: "字重",
        prose: [
          "`weight` 映射到 `typography.fontWeight.<weight>` 令牌（primary 400 / bold 600）。",
        ],
        preview: TextPreviews.weight,
        code: [],
        tables: []
      ),
      DocSection(
        title: "色调",
        prose: [
          "`tone` 映射到 `color.text.<tone>` 令牌；`selected` 取 `color.selected`。",
        ],
        preview: TextPreviews.tone,
        code: [],
        tables: []
      ),
      DocSection(
        title: "对齐与行高",
        prose: [
          "`lhAlign` 在行盒宽度内对齐；行高始终取 `typography.lineHeight.primary`（字号 × 1.8）。",
        ],
        preview: TextPreviews.align,
        code: [
          "LhText(\"居中\", lhAlign: .center)",
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
                title: "",
                headers: ["属性", "说明", "类型", "默认值"],
                rows: [
                  DocRow(cells: ["`content`", "文本内容（构造器第一个参数，spec 的 default 插槽）", "`String`", "`\"\"`"]),
                  DocRow(cells: ["`level`", "字号级别", "`LhTextLevel`", "`.base`"]),
                  DocRow(cells: ["`weight`", "字重", "`LhTextWeight`", "`.primary`"]),
                  DocRow(cells: ["`tone`", "文字色调", "`LhTextTone`", "`.primary`"]),
                  DocRow(cells: ["`lhAlign`", "水平对齐方式", "`LhTextAlign`", "`.start`"]),
                ]),
              DocTable(
                title: "LhTextLevel",
                headers: ["值", "fontSize 令牌"],
                rows: [
                  DocRow(cells: ["`.extraLarge`", "`typography.fontSize.extraLarge`（20pt）"]),
                  DocRow(cells: ["`.large`", "`typography.fontSize.large`（18pt）"]),
                  DocRow(cells: ["`.medium`", "`typography.fontSize.medium`（16pt）"]),
                  DocRow(cells: ["`.base`", "`typography.fontSize.base`（14pt，默认）"]),
                  DocRow(cells: ["`.small`", "`typography.fontSize.small`（13pt）"]),
                  DocRow(cells: ["`.extraSmall`", "`typography.fontSize.extraSmall`（12pt）"]),
                ]),
              DocTable(
                title: "LhTextTone",
                headers: ["值", "文字色令牌"],
                rows: [
                  DocRow(cells: ["`.primary`", "`color.text.primary`"]),
                  DocRow(cells: ["`.regular`", "`color.text.regular`"]),
                  DocRow(cells: ["`.secondary`", "`color.text.secondary`"]),
                  DocRow(cells: ["`.placeholder`", "`color.text.placeholder`"]),
                  DocRow(cells: ["`.disabled`", "`color.text.disabled`"]),
                  DocRow(cells: ["`.selected`", "`color.selected`"]),
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
                  DocRow(cells: ["`typography.fontSize.<level>`", "六档字号"]),
                  DocRow(cells: ["`typography.fontWeight.{primary,bold}`", "两档字重"]),
                  DocRow(cells: ["`typography.lineHeight.primary`", "行高（字号 × 1.8）"]),
                  DocRow(cells: ["`color.text.<tone>` / `color.selected`", "文字色调"]),
                ])
        ]
      ),
      DocSection(
        title: "黄金用例对照",
        prose: [],
        preview: nil,
        code: [
          "swift test --filter LhTextTests",
        ],
        tables: [
              DocTable(
                title: "",
                headers: ["case id", "断言", "本地测试"],
                rows: [
                  DocRow(cells: ["`default-level-uses-base-tokens`", "默认级别消费 base 排版令牌", "`LhTextTests.testDefaultLevelUsesBaseTokens`"]),
                  DocRow(cells: ["`large-level-uses-large-token`", "大级别消费 large 字号令牌", "`LhTextTests.testLargeLevelUsesLargeToken`"]),
                  DocRow(cells: ["`bold-weight-uses-bold-token`", "粗体消费 bold 字重令牌", "`LhTextTests.testBoldWeightUsesBoldToken`"]),
                  DocRow(cells: ["`secondary-tone-uses-text-secondary`", "次要色调取次要文字色令牌", "`LhTextTests.testSecondaryToneUsesTextSecondary`"]),
                  DocRow(cells: ["`render-emits-single-text-command`", "渲染发出一条 TEXT 指令", "`LhTextTests.testAllLevelsUseTheirTokens`（令牌映射覆盖率）"]),
                ])
        ]
      ),
    ]
  )
}

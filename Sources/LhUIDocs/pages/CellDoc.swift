// 本文件由 scripts/gen-doc-pages.mjs 从 docs/components/cell.md 生成 —— 禁手改。
// 改文档请改 md 再跑 pnpm gen:docs；真交互预览手写在 Sources/LhUIDocs/Previews/CellPreviews.swift。
// 本文件与 DocRegistry.swift 同属 LhUIDocs 模块，无需 import 自身。

/// Cell 单元格（生成物，勿手改）
struct CellDoc {
  static let entry = DocEntry(
    id: "cell",
    title: "Cell 单元格",
    lede: [
      "列表单元格。左侧图标 + 标题（含必填红星与副标题），右侧值与箭头，底部分隔线。",
    ],
    contract: [
      "契约源：`lh-ui-core/specs/cell.json` ·",
      "黄金用例：`lh-ui-core/cases/cell.json`（6 条，已翻译为 XCTest，macOS 宿主即可运行）",
    ],
    group: .basic,
    sections: [
        DocSection(
        title: "基本形态",
        prose: [
          "`title` 必填，`value` / `label` / `icon` 可选。`bordered` 控制底部分隔线（默认开）。",
        ],
        preview: CellPreviews.basic,
        code: [
          "LhCell(title: \"标题文字\", value: \"右侧值\", clickable: true) {",
          "  // onClick",
          "}",
        ],
        tables: []
      ),
      DocSection(
        title: "图标 / 必填 / 不可点击",
        prose: [
          "`icon` 走 `LhIconMap` 映射；`required` 在标题前显示红色星号；",
          "`clickable = false`（默认）时不响应点击（黄金用例 `not-clickable-no-onclick`）。",
        ],
        preview: CellPreviews.iconRequiredAndClick,
        code: [],
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
                  DocRow(cells: ["`title`", "标题（必填）", "`String`", "—"]),
                  DocRow(cells: ["`value`", "右侧值", "`String`", "`\"\"`"]),
                  DocRow(cells: ["`label`", "标题下方副标题", "`String`", "`\"\"`"]),
                  DocRow(cells: ["`icon`", "左侧图标逻辑名（`LhIconMap` 映射）", "`String?`", "`nil`"]),
                  DocRow(cells: ["`bordered`", "是否显示底部分隔线", "`Bool`", "`true`"]),
                  DocRow(cells: ["`clickable`", "是否可点击（控制箭头与点击 gate）", "`Bool`", "`false`"]),
                  DocRow(cells: ["`required`", "标题前是否显示红色必填星号", "`Bool`", "`false`"]),
                  DocRow(cells: ["`onClick`", "点击回调；`clickable = false` 时不触发", "`(() -> Void)?`", "`nil`"]),
                ]),
              DocTable(
                title: "文字层级",
                headers: ["区域", "字号", "颜色"],
                rows: [
                  DocRow(cells: ["标题", "`cell.fontSizeTitle`（14pt）", "`color.text.primary`"]),
                  DocRow(cells: ["副标题", "`cell.fontSizeLabel`（13pt）", "`color.text.secondary`"]),
                  DocRow(cells: ["右侧值", "`cell.fontSizeValue`（14pt）", "`color.text.secondary`"]),
                  DocRow(cells: ["必填星号", "`cell.fontSizeTitle`", "`color.danger.default`"]),
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
                  DocRow(cells: ["`cell.paddingHorizontal` / `cell.paddingVertical`", "内边距（跟随 `spacing.base` / `spacing.sm`）"]),
                  DocRow(cells: ["`cell.fontSizeTitle` / `cell.fontSizeLabel` / `cell.fontSizeValue`", "三级文字字号"]),
                  DocRow(cells: ["`cell.iconSize`", "左侧图标尺寸"]),
                  DocRow(cells: ["`cell.gap`", "各区块间距（跟随 `spacing.sm`）"]),
                  DocRow(cells: ["`cell.borderWidth`", "底部分隔线宽度"]),
                  DocRow(cells: ["`color.border.lighter`", "底部分隔线颜色"]),
                  DocRow(cells: ["`color.text.{primary,secondary}`", "标题与值/副标题颜色"]),
                  DocRow(cells: ["`color.danger.default`", "必填星号颜色"]),
                  DocRow(cells: ["`color.background.default`", "单元格底色"]),
                ])
        ]
      ),
      DocSection(
        title: "黄金用例对照",
        prose: [
          "另有暗色专项：`testDarkColorsComeFromDarkTokens` / `testDimensionsAreIdenticalInDarkMode` /",
          "`testCellInitAndRender` / `testLayoutUsesCellTokens`。",
        ],
        preview: nil,
        code: [
          "swift test --filter LhCellTests    # macOS 宿主即可跑，无需模拟器",
        ],
        tables: [
              DocTable(
                title: "",
                headers: ["case id", "断言", "本地测试"],
                rows: [
                  DocRow(cells: ["`title-and-value-render`", "同时绘制标题与值", "`testTitleAndValueUseFontTokens`"]),
                  DocRow(cells: ["`label-renders-secondary-tone`", "副标题取次要文字色", "`testLabelRendersSecondaryTone`"]),
                  DocRow(cells: ["`required-uses-danger-token`", "必填星号取危险色令牌", "`testRequiredUsesDangerToken`"]),
                  DocRow(cells: ["`bordered-emits-line-command`", "分隔线消费 border.lighter 令牌", "`testBorderedUsesBorderTokens`"]),
                  DocRow(cells: ["`clickable-emits-onclick`", "可点击时触发 onClick", "`testClickableIsInteractive`"]),
                  DocRow(cells: ["`not-clickable-no-onclick`", "不可点击时不触发 onClick", "`testNotClickableIsNotInteractive`"]),
                ])
        ]
      ),
    ]
  )
}

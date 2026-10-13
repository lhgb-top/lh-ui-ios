// 本文件由 scripts/gen-doc-pages.mjs 从 docs/components/radio.md 生成 —— 禁手改。
// 改文档请改 md 再跑 pnpm gen:docs；真交互预览手写在 Sources/LhUIDocs/Previews/RadioPreviews.swift。
// 本文件与 DocRegistry.swift 同属 LhUIDocs 模块，无需 import 自身。

/// Radio 单选框（生成物，勿手改）
struct RadioDoc {
  static let entry = DocEntry(
    id: "radio",
    title: "Radio 单选框",
    lede: [
      "受控单选框。`@Binding var checked` 表示「该项是否选中」，通常配合分组使用；同一组内只能有一项为 `true`。",
    ],
    contract: [
      "契约源：`lh-ui-core/specs/radio.json` ·",
      "黄金用例：`lh-ui-core/cases/radio.json`（6 条，已翻译为 XCTest，macOS 宿主即可运行）",
    ],
    group: .form,
    sections: [
        DocSection(
        title: "状态",
        prose: [
          "选中态为描边主色圆环 + 实心主色圆点；未选中为描边空环。圆点直径为尺寸乘 `radio.dotScale`（50%）。",
        ],
        preview: RadioPreviews.states,
        code: [
          "@State private var picked = \"blue\"",
          "",
          "LhRadio(checked: Binding(get: { picked == \"blue\" }, set: { _ in }), value: \"blue\", label: \"青花瓷\") { _ in",
          "  picked = \"blue\"",
          "}",
        ],
        tables: []
      ),
      DocSection(
        title: "尺寸",
        prose: [
          "三档尺寸映射到 `radio.size` 令牌；圆环描边取 `radio.ringWidth`。",
        ],
        preview: RadioPreviews.sizes,
        code: [],
        tables: []
      ),
      DocSection(
        title: "点击 gate",
        prose: [
          "已选中再点击保持选中且不触发 `onChange`（黄金用例 `tap-checked-keeps-checked`）；",
          "禁用态不触发（`disabled-blocks-change`）。分组容器留待后续版本。",
        ],
        preview: RadioPreviews.clickGate,
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
                  DocRow(cells: ["`checked`", "该项是否选中（受控双向绑定）", "`Bool`", "—"]),
                  DocRow(cells: ["`value`", "该项代表的值（与 `checked` 配合实现单选组）", "`String`", "`\"\"`"]),
                  DocRow(cells: ["`disabled`", "是否禁用（不触发 onChange）", "`Bool`", "`false`"]),
                  DocRow(cells: ["`size`", "单选框尺寸，映射到尺寸令牌", "`LhRadioSize`", "`.medium`"]),
                  DocRow(cells: ["`label`", "文字标签", "`String`", "`\"\"`"]),
                  DocRow(cells: ["`onChange`", "选中变化回调，payload 为新值", "`((Bool) -> Void)?`", "`nil`"]),
                ]),
              DocTable(
                title: "LhRadioSize",
                headers: ["值", "环尺寸", "圆点直径"],
                rows: [
                  DocRow(cells: ["`.small`", "`radio.size.small`（16pt）", "尺寸 × `radio.dotScale`（8pt）"]),
                  DocRow(cells: ["`.medium`", "`radio.size.medium`（20pt）", "尺寸 × `radio.dotScale`（10pt）"]),
                  DocRow(cells: ["`.large`", "`radio.size.large`（24pt）", "尺寸 × `radio.dotScale`（12pt）"]),
                ]),
              DocTable(
                title: "颜色",
                headers: ["状态", "环描边", "圆点"],
                rows: [
                  DocRow(cells: ["未选中", "`color.border.base`（`radio.ringWidth`）", "—"]),
                  DocRow(cells: ["选中", "`color.primary.default`", "`color.primary.default`"]),
                  DocRow(cells: ["禁用", "`color.disabled.border`", "`color.disabled.text`"]),
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
                  DocRow(cells: ["`radio.size.{small,medium,large}`", "三档环尺寸"]),
                  DocRow(cells: ["`radio.dotScale`", "圆点相对环尺寸的比例（50%）"]),
                  DocRow(cells: ["`radio.ringWidth`", "环描边宽度"]),
                  DocRow(cells: ["`radio.gap`", "环与文字间距（跟随 `spacing.sm`）"]),
                  DocRow(cells: ["`color.primary.default`", "选中态描边与圆点色"]),
                  DocRow(cells: ["`color.border.base`", "未选中描边色"]),
                  DocRow(cells: ["`color.disabled.{border,text}`", "禁用态描边与圆点色"]),
                  DocRow(cells: ["`color.text.{primary,disabled}`", "标签文字色"]),
                ])
        ]
      ),
      DocSection(
        title: "黄金用例对照",
        prose: [
          "另有专项：`testStrokeUsesRadioTokens` / `testDarkColorsComeFromDarkTokens` /",
          "`testDisabledInDarkUsesDarkDisabledTokens` / `testDimensionsAreIdenticalInDarkMode` /",
          "`testRadioViewInitAcceptsConstant`。",
        ],
        preview: nil,
        code: [
          "swift test --filter LhRadioTests    # macOS 宿主即可跑，无需模拟器",
        ],
        tables: [
              DocTable(
                title: "",
                headers: ["case id", "断言", "本地测试"],
                rows: [
                  DocRow(cells: ["`tap-unchecked-emits-onchange`", "未选中点击触发 `onChange(true)`", "`testUncheckedIsInteractive`"]),
                  DocRow(cells: ["`tap-checked-keeps-checked`", "已选中点击保持选中且不回调", "`testCheckedShowsDot`"]),
                  DocRow(cells: ["`disabled-blocks-change`", "禁用态不触发 onChange", "`testDisabledBlocksChange`"]),
                  DocRow(cells: ["`checked-uses-primary-tokens`", "选中态消费主色令牌", "`testCheckedUsesPrimaryTokens`"]),
                  DocRow(cells: ["`unchecked-uses-border-token`", "未选中消费描边令牌", "`testUncheckedUsesBorderToken`"]),
                  DocRow(cells: ["`small-size-uses-small-token`", "小号消费 small 尺寸令牌", "`testSmallSizeUsesSmallToken`"]),
                ])
        ]
      ),
    ]
  )
}

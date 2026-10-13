// 本文件由 scripts/gen-doc-pages.mjs 从 docs/components/checkbox.md 生成 —— 禁手改。
// 改文档请改 md 再跑 pnpm gen:docs；真交互预览手写在 Sources/LhUIDocs/Previews/CheckboxPreviews.swift。
// 本文件与 DocRegistry.swift 同属 LhUIDocs 模块，无需 import 自身。

/// Checkbox 复选框（生成物，勿手改）
struct CheckboxDoc {
  static let entry = DocEntry(
    id: "checkbox",
    title: "Checkbox 复选框",
    lede: [
      "受控复选框。`@Binding var checked` 双向绑定，支持三态（勾选 / 未勾选 / 不确定）。",
    ],
    contract: [
      "契约源：`lh-ui-core/specs/checkbox.json` ·",
      "黄金用例：`lh-ui-core/cases/checkbox.json`（6 条，已翻译为 XCTest，macOS 宿主即可运行）",
    ],
    group: .form,
    sections: [
        DocSection(
        title: "状态",
        prose: [
          "勾选态为实心主色方块 + 白色勾形；不确定态为实心主色方块 + 白色横杠；未勾选为描边空框。",
        ],
        preview: CheckboxPreviews.states,
        code: [
          "@State private var checked = false",
          "",
          "LhCheckbox(checked: $checked, label: \"已勾选\") { newValue in",
          "  // onChange",
          "}",
        ],
        tables: []
      ),
      DocSection(
        title: "尺寸",
        prose: [
          "三档尺寸映射到 `checkbox.size` 令牌；勾形描边宽度取 `checkbox.checkWidth`，",
          "不确定态横杠宽度为方框尺寸乘 `checkbox.dashScale`（50%）。",
        ],
        preview: CheckboxPreviews.sizes,
        code: [],
        tables: []
      ),
      DocSection(
        title: "不确定态",
        prose: [
          "`indeterminate = true` 时不显示勾形而显示横杠；点击后必定变为**勾选**（黄金用例",
          "`indeterminate-becomes-checked`），而非切换。",
        ],
        preview: CheckboxPreviews.indeterminate,
        code: [
          "@State private var checked = false",
          "",
          "LhCheckbox(checked: $checked, label: \"全选\", indeterminate: somePartial) { _ in }",
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
                  DocRow(cells: ["`checked`", "勾选状态（受控双向绑定）", "`Bool`", "—"]),
                  DocRow(cells: ["`indeterminate`", "是否不确定态（显示横杠，点击后变勾选）", "`Bool`", "`false`"]),
                  DocRow(cells: ["`disabled`", "是否禁用（不触发 onChange）", "`Bool`", "`false`"]),
                  DocRow(cells: ["`size`", "复选框尺寸，映射到尺寸令牌", "`LhCheckboxSize`", "`.medium`"]),
                  DocRow(cells: ["`label`", "文字标签", "`String`", "`\"\"`"]),
                  DocRow(cells: ["`onChange`", "状态变化回调，payload 为新值", "`((Bool) -> Void)?`", "`nil`"]),
                ]),
              DocTable(
                title: "LhCheckboxSize",
                headers: ["值", "尺寸"],
                rows: [
                  DocRow(cells: ["`.small`", "`checkbox.size.small`（16pt）"]),
                  DocRow(cells: ["`.medium`", "`checkbox.size.medium`（20pt）"]),
                  DocRow(cells: ["`.large`", "`checkbox.size.large`（24pt）"]),
                ]),
              DocTable(
                title: "颜色",
                headers: ["状态", "方块底色", "标记色"],
                rows: [
                  DocRow(cells: ["未勾选", "透明 + `color.border.base` 描边（`checkbox.borderWidth`）", "—"]),
                  DocRow(cells: ["勾选 / 不确定", "`color.primary.default`", "`color.onPrimary`"]),
                  DocRow(cells: ["禁用", "`color.disabled.bg` + `color.disabled.border` 描边", "`color.disabled.text`"]),
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
                  DocRow(cells: ["`checkbox.size.{small,medium,large}`", "三档尺寸"]),
                  DocRow(cells: ["`checkbox.borderRadius` / `checkbox.borderWidth`", "圆角（跟随 `radius.small`）与描边宽度"]),
                  DocRow(cells: ["`checkbox.checkWidth`", "勾形描边宽度"]),
                  DocRow(cells: ["`checkbox.dashScale`", "不确定态横杠相对方框的比例（50%）"]),
                  DocRow(cells: ["`checkbox.gap`", "方框与文字间距（跟随 `spacing.sm`）"]),
                  DocRow(cells: ["`color.primary.default` / `color.onPrimary`", "勾选态底/标记色"]),
                  DocRow(cells: ["`color.border.base`", "未勾选描边色"]),
                  DocRow(cells: ["`color.disabled.{bg,border,text}`", "禁用态三色"]),
                ])
        ]
      ),
      DocSection(
        title: "黄金用例对照",
        prose: [
          "另有专项：`testSizeUsesSizeTokens` / `testStrokeUsesCheckboxTokens` /",
          "`testDarkColorsComeFromDarkTokens` / `testDisabledInDarkUsesDarkDisabledTokens` /",
          "`testDimensionsAreIdenticalInDarkMode` / `testCheckboxViewInitAcceptsConstant`。",
        ],
        preview: nil,
        code: [
          "swift test --filter LhCheckboxTests    # macOS 宿主即可跑，无需模拟器",
        ],
        tables: [
              DocTable(
                title: "",
                headers: ["case id", "断言", "本地测试"],
                rows: [
                  DocRow(cells: ["`tap-toggles-and-emits-onchange`", "点击翻转并回调 `onChange(true)`", "`testTapTogglesAndEmitsOnChange`"]),
                  DocRow(cells: ["`tap-checked-unchecks`", "已勾选点击变未勾选", "`testTapCheckedUnchecks`"]),
                  DocRow(cells: ["`disabled-blocks-change`", "禁用态不触发 onChange", "`testDisabledBlocksChange`"]),
                  DocRow(cells: ["`checked-uses-primary-tokens`", "勾选态消费主色与 onPrimary", "`testCheckedUsesPrimaryTokens`"]),
                  DocRow(cells: ["`unchecked-uses-border-token`", "未勾选消费描边令牌", "`testUncheckedUsesBorderToken`"]),
                  DocRow(cells: ["`indeterminate-becomes-checked`", "不确定态点击后必为勾选", "`testIndeterminateBecomesChecked`"]),
                ])
        ]
      ),
    ]
  )
}

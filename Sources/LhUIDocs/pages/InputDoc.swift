// 本文件由 scripts/gen-doc-pages.mjs 从 docs/components/input.md 生成 —— 禁手改。
// 改文档请改 md 再跑 pnpm gen:docs；真交互预览手写在 Sources/LhUIDocs/Previews/InputPreviews.swift。
// 本文件与 DocRegistry.swift 同属 LhUIDocs 模块，无需 import 自身。

/// Input 输入框（生成物，勿手改）
struct InputDoc {
  static let entry = DocEntry(
    id: "input",
    title: "Input 输入框",
    lede: [
      "受控单行输入框。`@Binding var value` 双向绑定，支持明暗密文、清除按钮、字数上限与聚焦环。",
    ],
    contract: [
      "契约源：`lh-ui-core/specs/input.json` ·",
      "黄金用例：`lh-ui-core/cases/input.json`（8 条，已翻译为 XCTest，macOS 宿主即可运行）",
    ],
    group: .form,
    sections: [
        DocSection(
        title: "基本形态",
        prose: [
          "高度与 Button 对齐（三档 `input.height` 令牌），聚焦时描边换 `color.focus` 并加宽为聚焦环。",
        ],
        preview: InputPreviews.basic,
        code: [
          "@State private var text = \"\"",
          "",
          "LhInput(value: $text, placeholder: \"请输入内容\") { newValue in",
          "  // onValueChange",
          "}",
        ],
        tables: []
      ),
      DocSection(
        title: "尺寸",
        prose: [
          "三档尺寸映射到 `input.height` / `paddingHorizontal` / `fontSize` 令牌。",
        ],
        preview: InputPreviews.sizes,
        code: [],
        tables: []
      ),
      DocSection(
        title: "密码与清除",
        prose: [
          "`type: .password` 落地为 `SecureField`（测试 `testPasswordTypeIsSecure`）；",
          "`clearable` 在有值时显示清除按钮，点击触发 `onValueChange(\"\")`（黄金用例 `clearable-emits-empty-value`）。",
        ],
        preview: InputPreviews.passwordAndClearable,
        code: [
          "LhInput(value: $pwd, type: .password, clearable: true)",
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
                  DocRow(cells: ["`value`", "输入内容（受控双向绑定）", "`String`", "—"]),
                  DocRow(cells: ["`placeholder`", "占位提示文字", "`String`", "`\"\"`"]),
                  DocRow(cells: ["`type`", "输入类型（明文 / 密文）", "`LhInputType`", "`.text`"]),
                  DocRow(cells: ["`size`", "输入框尺寸，映射到尺寸令牌", "`LhInputSize`", "`.medium`"]),
                  DocRow(cells: ["`disabled`", "是否禁用（不触发任何回调）", "`Bool`", "`false`"]),
                  DocRow(cells: ["`readonly`", "是否只读（不触发 onValueChange，保留聚焦样式）", "`Bool`", "`false`"]),
                  DocRow(cells: ["`clearable`", "是否显示清除按钮", "`Bool`", "`false`"]),
                  DocRow(cells: ["`maxlength`", "最大字数（超出截断，黄金用例 `maxlength-truncates-input`）", "`Int?`", "`nil`"]),
                  DocRow(cells: ["`onValueChange`", "内容变化回调，payload 为新值", "`((String) -> Void)?`", "`nil`"]),
                  DocRow(cells: ["`onFocus`", "聚焦回调", "`(() -> Void)?`", "`nil`"]),
                  DocRow(cells: ["`onBlur`", "失焦回调", "`(() -> Void)?`", "`nil`"]),
                ]),
              DocTable(
                title: "LhInputSize",
                headers: ["值", "height", "paddingHorizontal", "fontSize"],
                rows: [
                  DocRow(cells: ["`.small`", "`input.height.small`（32pt）", "`input.paddingHorizontal.small`（12pt）", "`input.fontSize.small`（13pt）"]),
                  DocRow(cells: ["`.medium`", "`input.height.medium`（40pt）", "`input.paddingHorizontal.medium`（16pt）", "`input.fontSize.medium`（14pt）"]),
                  DocRow(cells: ["`.large`", "`input.height.large`（48pt）", "`input.paddingHorizontal.large`（20pt）", "`input.fontSize.large`（16pt）"]),
                ]),
              DocTable(
                title: "LhInputType",
                headers: ["值", "落地"],
                rows: [
                  DocRow(cells: ["`.text`", "`TextField`"]),
                  DocRow(cells: ["`.password`", "`SecureField`"]),
                ]),
              DocTable(
                title: "颜色",
                headers: ["状态", "描边", "文字 / 占位"],
                rows: [
                  DocRow(cells: ["默认", "`color.border.base`（`input.borderWidth`）", "`color.text.primary` / `color.text.placeholder`"]),
                  DocRow(cells: ["聚焦", "`color.focus`（`input.focusRingWidth`）", "同上"]),
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
                  DocRow(cells: ["`input.height.{small,medium,large}`", "三档高度"]),
                  DocRow(cells: ["`input.paddingHorizontal.{small,medium,large}`", "三档横向内边距"]),
                  DocRow(cells: ["`input.fontSize.{small,medium,large}`", "三档字号"]),
                  DocRow(cells: ["`input.borderRadius` / `input.borderWidth`", "圆角（跟随 `radius.small`）与描边宽度"]),
                  DocRow(cells: ["`input.focusRingWidth`", "聚焦环宽度"]),
                  DocRow(cells: ["`input.clearIconSize`", "清除按钮图标尺寸"]),
                  DocRow(cells: ["`color.focus`", "聚焦描边色"]),
                  DocRow(cells: ["`color.text.{primary,placeholder,disabled}`", "文字与占位色"]),
                  DocRow(cells: ["`color.border.base` / `color.disabled.border`", "描边色"]),
                  DocRow(cells: ["`color.background.default` / `color.disabled.bg`", "底色"]),
                ])
        ]
      ),
      DocSection(
        title: "黄金用例对照",
        prose: [
          "另有专项：`testPasswordTypeIsSecure` / `testDarkColorsComeFromDarkTokens` /",
          "`testDimensionsAreIdenticalInDarkMode` / `testInputViewInitAcceptsConstant`。",
        ],
        preview: nil,
        code: [
          "swift test --filter LhInputTests    # macOS 宿主即可跑，无需模拟器",
        ],
        tables: [
              DocTable(
                title: "",
                headers: ["case id", "断言", "本地测试"],
                rows: [
                  DocRow(cells: ["`input-emits-onvaluechange`", "输入触发 `onValueChange(\"青花瓷\")`", "`testDefaultIsEditable`"]),
                  DocRow(cells: ["`clearable-emits-empty-value`", "清除触发 `onValueChange(\"\")`", "`testClearableShowsClearButtonWhenHasValue`"]),
                  DocRow(cells: ["`disabled-blocks-input`", "禁用态不触发 onValueChange", "`testDisabledBlocksInput`"]),
                  DocRow(cells: ["`readonly-blocks-input`", "只读态不触发 onValueChange", "`testReadonlyBlocksInput`"]),
                  DocRow(cells: ["`placeholder-uses-placeholder-token`", "占位文字取占位色令牌", "`testPlaceholderUsesPlaceholderToken`"]),
                  DocRow(cells: ["`focus-uses-focus-token`", "聚焦消费 focus 令牌并触发 onFocus", "`testFocusUsesFocusToken`"]),
                  DocRow(cells: ["`small-size-uses-small-tokens`", "小号消费 small 尺寸令牌", "`testSmallSizeUsesSmallTokens`"]),
                  DocRow(cells: ["`maxlength-truncates-input`", "超出字数截断", "`testMaxlengthTruncatesInput`"]),
                ])
        ]
      ),
    ]
  )
}

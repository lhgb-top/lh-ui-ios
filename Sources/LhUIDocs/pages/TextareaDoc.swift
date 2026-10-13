// 本文件由 scripts/gen-doc-pages.mjs 从 docs/components/textarea.md 生成 —— 禁手改。
// 改文档请改 md 再跑 pnpm gen:docs；真交互预览手写在 Sources/LhUIDocs/Previews/TextareaPreviews.swift。
// 本文件与 DocRegistry.swift 同属 LhUIDocs 模块，无需 import 自身。

/// Textarea 多行输入框（生成物，勿手改）
struct TextareaDoc {
  static let entry = DocEntry(
    id: "textarea",
    title: "Textarea 多行输入框",
    lede: [
      "受控多行输入框。`@Binding var value` 双向绑定，叠加占位提示与字数计数。",
    ],
    contract: [
      "契约源：`lh-ui-core/specs/textarea.json` ·",
      "黄金用例：`lh-ui-core/cases/textarea.json`（6 条，已翻译为 XCTest，macOS 宿主即可运行）",
    ],
    group: .form,
    sections: [
        DocSection(
        title: "基本形态",
        prose: [
          "最小高度取 `textarea.minHeight`，内边距取 `textarea.paddingHorizontal` / `paddingVertical`，",
          "聚焦时描边换 `color.focus`。",
        ],
        preview: TextareaPreviews.basic,
        code: [
          "@State private var text = \"\"",
          "",
          "LhTextarea(value: $text, placeholder: \"请输入内容\") { newValue in",
          "  // onValueChange",
          "}",
        ],
        tables: []
      ),
      DocSection(
        title: "字数计数",
        prose: [
          "`showCount = true` 时右下角显示计数：设了 `maxlength` 显示 `当前/上限`（黄金用例",
          "`showcount-renders-count`），未设则只显示当前长度（`showcount-without-maxlength-renders-length-only`）。",
        ],
        preview: TextareaPreviews.count,
        code: [
          "LhTextarea(value: $text, showCount: true, maxlength: 10)",
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
                  DocRow(cells: ["`rows`", "期望行数（影响最小高度）", "`Int`", "`3`"]),
                  DocRow(cells: ["`disabled`", "是否禁用（不触发任何回调）", "`Bool`", "`false`"]),
                  DocRow(cells: ["`readonly`", "是否只读（不触发 onValueChange，保留聚焦样式）", "`Bool`", "`false`"]),
                  DocRow(cells: ["`showCount`", "是否显示字数计数", "`Bool`", "`false`"]),
                  DocRow(cells: ["`maxlength`", "最大字数（超出截断）", "`Int?`", "`nil`"]),
                  DocRow(cells: ["`onValueChange`", "内容变化回调，payload 为新值", "`((String) -> Void)?`", "`nil`"]),
                  DocRow(cells: ["`onFocus`", "聚焦回调", "`(() -> Void)?`", "`nil`"]),
                  DocRow(cells: ["`onBlur`", "失焦回调", "`(() -> Void)?`", "`nil`"]),
                ]),
              DocTable(
                title: "颜色",
                headers: ["状态", "描边", "文字 / 占位"],
                rows: [
                  DocRow(cells: ["默认", "`color.border.base`（`textarea.borderWidth`）", "`color.text.primary` / `color.text.placeholder`"]),
                  DocRow(cells: ["聚焦", "`color.focus`（`textarea.focusRingWidth`）", "同上"]),
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
                  DocRow(cells: ["`textarea.minHeight`", "最小高度"]),
                  DocRow(cells: ["`textarea.paddingHorizontal` / `textarea.paddingVertical`", "内边距"]),
                  DocRow(cells: ["`textarea.fontSize`", "字号"]),
                  DocRow(cells: ["`textarea.countFontSize`", "计数文字字号"]),
                  DocRow(cells: ["`textarea.borderRadius` / `textarea.borderWidth`", "圆角与描边宽度"]),
                  DocRow(cells: ["`textarea.focusRingWidth`", "聚焦环宽度"]),
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
          "另有专项：`testLayoutUsesTextareaTokens` / `testReadonlyBlocksInputButKeepsFocusStyle` /",
          "`testDarkColorsComeFromDarkTokens` / `testDimensionsAreIdenticalInDarkMode` /",
          "`testTextareaViewInitAcceptsConstant`。",
        ],
        preview: nil,
        code: [
          "swift test --filter LhTextareaTests    # macOS 宿主即可跑，无需模拟器",
        ],
        tables: [
              DocTable(
                title: "",
                headers: ["case id", "断言", "本地测试"],
                rows: [
                  DocRow(cells: ["`input-emits-onvaluechange`", "输入触发 `onValueChange(\"青花瓷\")`", "`testDefaultIsEditable`"]),
                  DocRow(cells: ["`disabled-blocks-input`", "禁用态不触发 onValueChange", "`testDisabledBlocksInput`"]),
                  DocRow(cells: ["`showcount-renders-count`", "计数显示 `3/10` 并消费计数字号令牌", "`testShowCountRendersCount`"]),
                  DocRow(cells: ["`showcount-without-maxlength-renders-length-only`", "无上限时只显示 `3`", "`testShowCountWithoutMaxlengthRendersLengthOnly`"]),
                  DocRow(cells: ["`focus-uses-focus-token`", "聚焦消费 focus 令牌并触发 onFocus", "`testFocusUsesFocusToken`"]),
                  DocRow(cells: ["`maxlength-truncates-input`", "超出字数截断", "`testMaxlengthTruncatesInput`"]),
                ])
        ]
      ),
    ]
  )
}

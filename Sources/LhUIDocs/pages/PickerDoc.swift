// 本文件由 scripts/gen-doc-pages.mjs 从 docs/components/picker.md 生成 —— 禁手改。
// 改文档请改 md 再跑 pnpm gen:docs；真交互预览手写在 Sources/LhUIDocs/Previews/PickerPreviews.swift。
// 本文件与 DocRegistry.swift 同属 LhUIDocs 模块，无需 import 自身。

/// Picker 选择器（生成物，勿手改）
struct PickerDoc {
  static let entry = DocEntry(
    id: "picker",
    title: "Picker 选择器",
    lede: [
      "声明式底部滚轮选择器。`@Binding var visible` 控制显隐，`@Binding var value` 是选中项索引，",
      "滚轮为自绘（`DragGesture` + 松手吸附），无系统控件依赖。",
    ],
    contract: [
      "契约源：`lh-ui-core/specs/picker.json` ·",
      "黄金用例：`lh-ui-core/cases/picker.json`（8 条，已翻译为 XCTest，macOS 宿主即可运行）",
    ],
    group: .feedback,
    sections: [
        DocSection(
        title: "基本形态",
        prose: [
          "底部弹出：顶部工具栏（取消 / 标题 / 确认），中间是滚轮与两条指示线。",
        ],
        preview: PickerPreviews.basic,
        code: [
          "@State private var visible = false",
          "@State private var index = 1",
          "let options = [\"选项一\", \"选项二\", \"选项三\"]",
          "",
          "LhPicker(",
          "  visible: $visible,",
          "  options: options,",
          "  value: $index,",
          "  title: \"选择\"",
          ")",
        ],
        tables: []
      ),
      DocSection(
        title: "滚轮交互",
        prose: [
          "- 拖动改变整体偏移；松手后吸附到最近候选项（动画时长 `motion.duration.base`），",
          "选中索引变化时触发 `onValueChange`（黄金用例 `scroll-emits-onvaluechange`）。",
          "- 指示线间距 = `picker.itemHeight`，选中项恒落在两线正中。",
        ],
        preview: PickerPreviews.wheel,
        code: [],
        tables: []
      ),
      DocSection(
        title: "回调与边界",
        prose: [
          "- 「确认」触发 `onConfirm`（payload 为当前索引）与 `onClose`（`confirm-also-emits-onclose`）。",
          "- 「取消」触发 `onCancel`。",
          "- `value` 越界时端侧 clamp：负数归零（`clamp-negative-value-to-zero`），超界归到末项",
          "（`clamp-overflow-value-to-last`）；空选项列表时索引恒为 0。",
          "- `visible = false` 时不发射任何绘制指令（`hidden-not-rendered`）。",
        ],
        preview: PickerPreviews.callbacksAndBounds,
        code: [
          "LhPicker(",
          "  visible: $visible,",
          "  options: options,",
          "  value: $index,",
          "  title: \"选择\",",
          "  confirmText: \"确认\",",
          "  cancelText: \"取消\",",
          "  onValueChange: { newIndex in",
          "    // 滚动吸附回调",
          "  },",
          "  onConfirm: { newIndex in",
          "    // 确认回调（payload 为当前索引）",
          "  },",
          "  onCancel: {",
          "    // 取消回调",
          "  }",
          ")",
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
                  DocRow(cells: ["`visible`", "是否显示（受控双向绑定）", "`Bool`", "—"]),
                  DocRow(cells: ["`options`", "候选项文字数组（单列）", "`[String]`", "—"]),
                  DocRow(cells: ["`value`", "选中项索引（受控双向绑定，越界自动 clamp）", "`Int`", "—"]),
                  DocRow(cells: ["`title`", "工具栏标题", "`String`", "`\"\"`"]),
                  DocRow(cells: ["`confirmText`", "确认按钮文字", "`String`", "`\"确认\"`"]),
                  DocRow(cells: ["`cancelText`", "取消按钮文字", "`String`", "`\"取消\"`"]),
                  DocRow(cells: ["`onValueChange`", "滚动吸附回调，payload 为新索引", "`((Int) -> Void)?`", "`nil`"]),
                  DocRow(cells: ["`onConfirm`", "确认回调，payload 为当前索引", "`((Int) -> Void)?`", "`nil`"]),
                  DocRow(cells: ["`onCancel`", "取消回调", "`(() -> Void)?`", "`nil`"]),
                  DocRow(cells: ["`onClose`", "关闭回调（确认 / 取消都会触发）", "`(() -> Void)?`", "`nil`"]),
                ]),
              DocTable(
                title: "颜色",
                headers: ["区域", "颜色"],
                rows: [
                  DocRow(cells: ["面板底", "`color.background.default`"]),
                  DocRow(cells: ["遮罩", "`color.background.overlay`"]),
                  DocRow(cells: ["取消按钮 / 候选项文字", "`color.text.primary`"]),
                  DocRow(cells: ["标题 / 确认按钮", "`color.primary.default`"]),
                  DocRow(cells: ["指示线", "`color.border.lighter`（宽度取 `cell.borderWidth`）"]),
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
                  DocRow(cells: ["`picker.height`", "面板高度（260pt）"]),
                  DocRow(cells: ["`picker.toolbarHeight`", "工具栏高度（44pt）"]),
                  DocRow(cells: ["`picker.itemHeight`", "单项高度（决定滚轮与指示线间距）"]),
                  DocRow(cells: ["`picker.itemFontSize`", "候选项与工具栏字号"]),
                  DocRow(cells: ["`picker.borderRadius`", "顶部圆角"]),
                  DocRow(cells: ["`color.background.overlay` / `color.background.default`", "遮罩与面板底色"]),
                  DocRow(cells: ["`color.border.lighter` / `cell.borderWidth`", "指示线颜色与宽度"]),
                  DocRow(cells: ["`color.primary.default`", "确认按钮与选中项文字色"]),
                  DocRow(cells: ["`zIndex.{modalBackdrop,modal}`", "遮罩与面板的层级"]),
                  DocRow(cells: ["`motion.duration.base`", "吸附动画时长（iOS 端为秒）"]),
                ])
        ]
      ),
      DocSection(
        title: "黄金用例对照",
        prose: [
          "另有专项：`testVisibleRendersAppearance` / `testClampedValueIsExposed` /",
          "`testLayoutUsesPickerTokens` / `testEmptyOptionsClampsToZero` /",
          "`testDarkColorsComeFromDarkTokens` / `testDimensionsAreIdenticalInDarkMode` /",
          "`testPickerViewInitAcceptsConstant`。",
        ],
        preview: nil,
        code: [
          "swift test --filter LhPickerTests    # macOS 宿主即可跑，无需模拟器",
        ],
        tables: [
              DocTable(
                title: "",
                headers: ["case id", "断言", "本地测试"],
                rows: [
                  DocRow(cells: ["`confirm-emits-onconfirm-with-value`", "确认触发 `onConfirm(1)`", "`testConfirmUsesPrimaryToken`"]),
                  DocRow(cells: ["`confirm-also-emits-onclose`", "确认同时触发 onClose", "`testConfirmUsesPrimaryToken`"]),
                  DocRow(cells: ["`cancel-emits-oncancel`", "取消触发 onCancel", "`testCancelUsesNeutralColor`"]),
                  DocRow(cells: ["`scroll-emits-onvaluechange`", "滚动吸附触发 `onValueChange(2)`", "View 层 `DragGesture.onEnded`（手势断言需模拟器）"]),
                  DocRow(cells: ["`clamp-negative-value-to-zero`", "负索引 clamp 到 0", "`testClampNegativeValueToZero`"]),
                  DocRow(cells: ["`clamp-overflow-value-to-last`", "超界索引 clamp 到末项", "`testClampOverflowValueToLast`"]),
                  DocRow(cells: ["`title-renders-text`", "标题正确渲染", "`testTitleAndTextsAreExposed`"]),
                  DocRow(cells: ["`hidden-not-rendered`", "隐藏时不渲染", "`testHiddenNotRendered`"]),
                ])
        ]
      ),
    ]
  )
}

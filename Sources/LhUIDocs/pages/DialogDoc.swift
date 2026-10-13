// 本文件由 scripts/gen-doc-pages.mjs 从 docs/components/dialog.md 生成 —— 禁手改。
// 改文档请改 md 再跑 pnpm gen:docs；真交互预览手写在 Sources/LhUIDocs/Previews/DialogPreviews.swift。
// 本文件与 DocRegistry.swift 同属 LhUIDocs 模块，无需 import 自身。

/// Dialog 对话框（生成物，勿手改）
struct DialogDoc {
  static let entry = DocEntry(
    id: "dialog",
    title: "Dialog 对话框",
    lede: [
      "声明式模态对话框。`@Binding var visible` 控制显隐，遮罩 + 居中面板，按钮复用 `LhButton`。",
    ],
    contract: [
      "契约源：`lh-ui-core/specs/dialog.json` ·",
      "黄金用例：`lh-ui-core/cases/dialog.json`（8 条，已翻译为 XCTest，macOS 宿主即可运行）",
    ],
    group: .feedback,
    sections: [
        DocSection(
        title: "类型",
        prose: [
          "六种类型决定确认按钮的语义色（`buttonType(for:)` 映射到 `LhButtonType`）。",
        ],
        preview: DialogPreviews.types,
        code: [
          "@State private var visible = false",
          "",
          "LhDialog(",
          "  visible: $visible,",
          "  title: \"删除确认\",",
          "  content: \"此操作将永久删除该项，是否继续？\",",
          "  type: .danger,",
          "  confirmText: \"确认\",",
          "  cancelText: \"取消\"",
          ")",
        ],
        tables: []
      ),
      DocSection(
        title: "显隐与回调",
        prose: [
          "- `visible = true` 渲染遮罩与面板；`visible = false` 不发射任何绘制指令（黄金用例 `hidden-not-rendered`）。",
          "- 点击「确认」依次触发 `onConfirm` 与 `onClose`（`confirm-also-emits-onclose`）。",
          "- 点击「取消」触发 `onCancel`；`onClose` 由组件内部负责把 `visible` 置回 `false`（包在 `withAnimation` 内）。",
          "- `closable = true` 时点击遮罩也会触发 `onClose`（`closable-overlay-emits-onclose`）；默认不关闭（`not-closable-blocks-overlay-close`）。",
        ],
        preview: DialogPreviews.visibleAndCallbacks,
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
                  DocRow(cells: ["`visible`", "是否显示（受控双向绑定）", "`Bool`", "—"]),
                  DocRow(cells: ["`title`", "标题", "`String`", "`\"\"`"]),
                  DocRow(cells: ["`content`", "正文内容", "`String`", "`\"\"`"]),
                  DocRow(cells: ["`type`", "对话框类型，决定确认按钮语义色", "`LhDialogType`", "`.default`"]),
                  DocRow(cells: ["`confirmText`", "确认按钮文字", "`String`", "`\"确认\"`"]),
                  DocRow(cells: ["`cancelText`", "取消按钮文字", "`String`", "`\"取消\"`"]),
                  DocRow(cells: ["`closable`", "点击遮罩是否可关闭", "`Bool`", "`false`"]),
                  DocRow(cells: ["`onConfirm`", "确认回调", "`(() -> Void)?`", "`nil`"]),
                  DocRow(cells: ["`onCancel`", "取消回调", "`(() -> Void)?`", "`nil`"]),
                  DocRow(cells: ["`onClose`", "关闭回调（遮罩点击 / 按钮·取消 / 按钮·确认 都会触发）", "`(() -> Void)?`", "`nil`"]),
                ]),
              DocTable(
                title: "LhDialogType",
                headers: ["值", "确认按钮类型", "底色"],
                rows: [
                  DocRow(cells: ["`.default`", "`.default`", "`color.background.default` + 描边"]),
                  DocRow(cells: ["`.primary`", "`.primary`", "`color.primary.default`"]),
                  DocRow(cells: ["`.success`", "`.success`", "`color.success.default`"]),
                  DocRow(cells: ["`.warning`", "`.warning`", "`color.warning.default`"]),
                  DocRow(cells: ["`.danger`", "`.danger`", "`color.danger.default`"]),
                  DocRow(cells: ["`.info`", "`.info`", "`color.info.default`"]),
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
                  DocRow(cells: ["`dialog.width`", "面板宽度（320pt）"]),
                  DocRow(cells: ["`dialog.paddingHorizontal` / `dialog.paddingVertical`", "面板内边距"]),
                  DocRow(cells: ["`dialog.borderRadius`", "面板圆角"]),
                  DocRow(cells: ["`dialog.titleFontSize` / `dialog.contentFontSize`", "标题与正文字号"]),
                  DocRow(cells: ["`dialog.gap`", "各区块纵向间距"]),
                  DocRow(cells: ["`color.background.overlay`", "遮罩色"]),
                  DocRow(cells: ["`color.background.default`", "面板底色"]),
                  DocRow(cells: ["`color.text.{primary,regular}`", "标题与正文颜色"]),
                  DocRow(cells: ["`shadow.base`", "面板阴影（LhShadow 载体）"]),
                  DocRow(cells: ["`zIndex.{modalBackdrop,modal}`", "遮罩与面板的层级"]),
                ])
        ]
      ),
      DocSection(
        title: "黄金用例对照",
        prose: [
          "另有专项：`testVisibleRendersAppearance` / `testLayoutUsesDialogTokens` /",
          "`testDarkColorsComeFromDarkTokens` / `testDimensionsAreIdenticalInDarkMode` /",
          "`testDialogViewInitAcceptsConstant`。",
        ],
        preview: nil,
        code: [
          "swift test --filter LhDialogTests    # macOS 宿主即可跑，无需模拟器",
        ],
        tables: [
              DocTable(
                title: "",
                headers: ["case id", "断言", "本地测试"],
                rows: [
                  DocRow(cells: ["`confirm-emits-onconfirm`", "确认触发 onConfirm", "`testConfirmUsesTypeColor`"]),
                  DocRow(cells: ["`cancel-emits-oncancel`", "取消触发 onCancel", "`testCancelUsesNeutralColor`"]),
                  DocRow(cells: ["`confirm-also-emits-onclose`", "确认同时触发 onClose", "`testConfirmUsesTypeColor`"]),
                  DocRow(cells: ["`closable-overlay-emits-onclose`", "遮罩点击触发 onClose", "`testClosableFlagIsExposed`"]),
                  DocRow(cells: ["`not-closable-blocks-overlay-close`", "默认遮罩不关闭", "`testNotClosableBlocksOverlay`"]),
                  DocRow(cells: ["`hidden-not-rendered`", "隐藏时不渲染", "`testHiddenNotRendered`"]),
                  DocRow(cells: ["`title-renders-text`", "标题正确渲染", "`testTitleUsesTitleTokens`"]),
                  DocRow(cells: ["`danger-type-uses-danger-token`", "危险类型消费危险色令牌", "`testDangerTypeUsesDangerToken`"]),
                ])
        ]
      ),
    ]
  )
}

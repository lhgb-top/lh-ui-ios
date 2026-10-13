// 本文件由 scripts/gen-doc-pages.mjs 从 docs/components/toast.md 生成 —— 禁手改。
// 改文档请改 md 再跑 pnpm gen:docs；真交互预览手写在 Sources/LhUIDocs/Previews/ToastPreviews.swift。
// 本文件与 DocRegistry.swift 同属 LhUIDocs 模块，无需 import 自身。

/// Toast 轻提示（生成物，勿手改）
struct ToastDoc {
  static let entry = DocEntry(
    id: "toast",
    title: "Toast 轻提示",
    lede: [
      "声明式轻提示。`@Binding var visible` 控制显隐，到时自动消失，深色底取 `color.ink` 令牌。",
    ],
    contract: [
      "契约源：`lh-ui-core/specs/toast.json` ·",
      "黄金用例：`lh-ui-core/cases/toast.json`（6 条，已翻译为 XCTest，macOS 宿主即可运行）",
    ],
    group: .feedback,
    sections: [
        DocSection(
        title: "类型",
        prose: [
          "默认类型无图标；其余类型在文字左侧显示一个语义色圆点。深色底 + 白字，对比度由 `color.ink` 保证。",
        ],
        preview: ToastPreviews.types,
        code: [
          "@State private var visible = false",
          "",
          "LhToast(visible: $visible, text: \"已保存\", type: .success)",
        ],
        tables: []
      ),
      DocSection(
        title: "定位",
        prose: [
          "三种定位：`top`（顶部）、`center`（居中，默认）、`bottom`（底部）。",
        ],
        preview: ToastPreviews.position,
        code: [],
        tables: []
      ),
      DocSection(
        title: "自动消失",
        prose: [
          "`visible` 变为 `true` 时启动 `.task` 计时，`duration` 毫秒后自动置回 `false` 并触发 `onClose`",
          "（黄金用例 `auto-hides-after-duration`）；计时未到时保持显示且不触发回调",
          "（`tick-before-duration-keeps-visible`）；外部手动置 `false` 不触发回调（`hide-is-silent`）。",
          "令牌 `toast.duration` 是毫秒（2000），SwiftUI 的 `Task.sleep` 需要秒，端侧做",
          "`Double(duration) / 1000` 换算（见 `LhToastStyle`）。",
        ],
        preview: ToastPreviews.autoHide,
        code: [
          "LhToast(visible: $visible, text: \"操作成功\", type: .success, duration: 2000) {",
          "  // onClose（仅自动消失时触发）",
          "}",
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
                  DocRow(cells: ["`visible`", "是否显示（受控双向绑定，到时自动置回 false）", "`Bool`", "—"]),
                  DocRow(cells: ["`text`", "提示文字", "`String`", "—"]),
                  DocRow(cells: ["`type`", "提示类型，决定是否显示圆点及圆点颜色", "`LhToastType`", "`.default`"]),
                  DocRow(cells: ["`position`", "显示位置", "`LhToastPosition`", "`.center`"]),
                  DocRow(cells: ["`duration`", "显示时长（毫秒）", "`Int`", "`2000`（取 `toast.duration` 令牌）"]),
                  DocRow(cells: ["`onClose`", "自动消失回调（外部手动隐藏不触发）", "`(() -> Void)?`", "`nil`"]),
                ]),
              DocTable(
                title: "LhToastType",
                headers: ["值", "圆点色"],
                rows: [
                  DocRow(cells: ["`.default`", "无圆点"]),
                  DocRow(cells: ["`.success`", "`color.success.default`"]),
                  DocRow(cells: ["`.warning`", "`color.warning.default`"]),
                  DocRow(cells: ["`.danger`", "`color.danger.default`"]),
                  DocRow(cells: ["`.info`", "`color.info.default`"]),
                ]),
              DocTable(
                title: "LhToastPosition",
                headers: ["值", "定位"],
                rows: [
                  DocRow(cells: ["`.top`", "顶部（边距 `spacing.xl`）"]),
                  DocRow(cells: ["`.center`", "居中"]),
                  DocRow(cells: ["`.bottom`", "底部（边距 `spacing.xl`）"]),
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
                  DocRow(cells: ["`toast.paddingHorizontal` / `toast.paddingVertical`", "内边距"]),
                  DocRow(cells: ["`toast.fontSize`", "提示文字字号"]),
                  DocRow(cells: ["`toast.borderRadius`", "圆角（跟随 `radius.small`）"]),
                  DocRow(cells: ["`toast.gap`", "圆点与文字间距"]),
                  DocRow(cells: ["`toast.duration`", "默认显示时长（毫秒）"]),
                  DocRow(cells: ["`color.ink`", "深色底（暗色下有专用覆盖，与页面底拉开层次）"]),
                  DocRow(cells: ["`color.onPrimary`", "白字"]),
                  DocRow(cells: ["`color.{success,warning,danger,info}.default`", "圆点语义色"]),
                  DocRow(cells: ["`zIndex.toast`", "层级"]),
                  DocRow(cells: ["`spacing.xl`", "顶/底定位边距"]),
                ])
        ]
      ),
      DocSection(
        title: "黄金用例对照",
        prose: [
          "另有专项：`testDefaultTypeHasNoDot` / `testLayoutUsesToastTokens` /",
          "`testDarkColorsComeFromDarkTokens` / `testDarkInkDiffersFromLightInk` /",
          "`testDimensionsAreIdenticalInDarkMode` / `testToastViewInitAcceptsConstant`。",
        ],
        preview: nil,
        code: [
          "swift test --filter LhToastTests    # macOS 宿主即可跑，无需模拟器",
        ],
        tables: [
              DocTable(
                title: "",
                headers: ["case id", "断言", "本地测试"],
                rows: [
                  DocRow(cells: ["`show-makes-visible`", "显示即渲染", "`testShowMakesVisible`"]),
                  DocRow(cells: ["`auto-hides-after-duration`", "到时自动隐藏并触发 onClose", "`testDurationConvertsToSeconds`"]),
                  DocRow(cells: ["`tick-before-duration-keeps-visible`", "计时未到保持显示", "`testVisibleDuringDuration`"]),
                  DocRow(cells: ["`hide-is-silent`", "外部手动隐藏不触发回调", "`testHideIsSilent`"]),
                  DocRow(cells: ["`success-type-uses-success-token`", "成功类型消费成功色与 ink 令牌", "`testSuccessTypeUsesSuccessToken` / `testInkBackgroundUsesInkToken`"]),
                  DocRow(cells: ["`hidden-emits-no-commands`", "隐藏时绘制指令为空", "`testHiddenNotRendered`"]),
                ])
        ]
      ),
    ]
  )
}

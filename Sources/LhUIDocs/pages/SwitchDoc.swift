// 本文件由 scripts/gen-doc-pages.mjs 从 docs/components/switch.md 生成 —— 禁手改。
// 改文档请改 md 再跑 pnpm gen:docs；真交互预览手写在 Sources/LhUIDocs/Previews/SwitchPreviews.swift。
// 本文件与 DocRegistry.swift 同属 LhUIDocs 模块，无需 import 自身。

/// Switch 开关（生成物，勿手改）
struct SwitchDoc {
  static let entry = DocEntry(
    id: "switch",
    title: "Switch 开关",
    lede: [
      "受控开关。`@Binding var checked` 双向绑定，轨道 2:1，圆点直径 = 高度 − 2 × `switch.gap`。",
    ],
    contract: [
      "契约源：`lh-ui-core/specs/switch.json` ·",
      "黄金用例：`lh-ui-core/cases/switch.json`（6 条，已翻译为 XCTest，macOS 宿主即可运行）",
    ],
    group: .form,
    sections: [
        DocSection(
        title: "状态",
        prose: [
          "开启时轨道为主色、圆点右移；关闭时轨道为描边色。`loading` 态在轨道内显示小型指示器且不响应切换。",
        ],
        preview: SwitchPreviews.states,
        code: [
          "@State private var on = true",
          "",
          "LhSwitch(checked: $on) { newValue in",
          "  // onChange",
          "}",
        ],
        tables: []
      ),
      DocSection(
        title: "尺寸",
        prose: [
          "三档尺寸映射到 `switch.width` / `switch.height` 令牌，圆角随高度自动为轨道半径。",
        ],
        preview: SwitchPreviews.sizes,
        code: [],
        tables: []
      ),
      DocSection(
        title: "加载态",
        prose: [
          "`loading = true` 时轨道内置 `LhLoading(size: .small, tone: .primary)`，且点击被 gate 拦截",
          "（黄金用例 `loading-blocks-change`）。",
        ],
        preview: SwitchPreviews.loadingState,
        code: [
          "LhSwitch(checked: $submitting, loading: submitting) { _ in }",
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
                  DocRow(cells: ["`checked`", "开关状态（受控双向绑定）", "`Bool`", "—"]),
                  DocRow(cells: ["`disabled`", "是否禁用（不触发 onChange）", "`Bool`", "`false`"]),
                  DocRow(cells: ["`loading`", "是否加载中（内置指示器，不触发 onChange）", "`Bool`", "`false`"]),
                  DocRow(cells: ["`size`", "开关尺寸，映射到尺寸令牌", "`LhSwitchSize`", "`.medium`"]),
                  DocRow(cells: ["`onChange`", "状态变化回调，payload 为新值", "`((Bool) -> Void)?`", "`nil`"]),
                ]),
              DocTable(
                title: "LhSwitchSize",
                headers: ["值", "width", "height", "圆点直径"],
                rows: [
                  DocRow(cells: ["`.small`", "`switch.width.small`（36pt）", "`switch.height.small`（20pt）", "height − 2 × `switch.gap`（16pt）"]),
                  DocRow(cells: ["`.medium`", "`switch.width.medium`（44pt）", "`switch.height.medium`（24pt）", "height − 2 × `switch.gap`（20pt）"]),
                  DocRow(cells: ["`.large`", "`switch.width.large`（52pt）", "`switch.height.large`（28pt）", "height − 2 × `switch.gap`（24pt）"]),
                ]),
              DocTable(
                title: "颜色",
                headers: ["状态", "轨道", "圆点"],
                rows: [
                  DocRow(cells: ["关闭", "`color.border.base`", "`color.onPrimary`"]),
                  DocRow(cells: ["开启", "`color.primary.default`", "`color.onPrimary`"]),
                  DocRow(cells: ["禁用", "`color.disabled.bg`", "`color.disabled.text`"]),
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
                  DocRow(cells: ["`switch.width.{small,medium,large}`", "三档轨道宽度"]),
                  DocRow(cells: ["`switch.height.{small,medium,large}`", "三档轨道高度"]),
                  DocRow(cells: ["`switch.gap`", "圆点与轨道的内间距（决定圆点直径）"]),
                  DocRow(cells: ["`color.primary.default`", "开启轨道色"]),
                  DocRow(cells: ["`color.border.base`", "关闭轨道色"]),
                  DocRow(cells: ["`color.onPrimary`", "圆点色"]),
                  DocRow(cells: ["`color.disabled.{bg,text}`", "禁用态两色"]),
                  DocRow(cells: ["`motion.duration.base`", "圆点滑动动画时长（iOS 端为秒）"]),
                ])
        ]
      ),
      DocSection(
        title: "黄金用例对照",
        prose: [
          "另有专项：`testSizeUsesSwitchTokens` / `testThumbDiameterIsHeightMinusTwoGaps` /",
          "`testDarkColorsComeFromDarkTokens` / `testDimensionsAreIdenticalInDarkMode` /",
          "`testSwitchViewInitAcceptsConstant`。",
        ],
        preview: nil,
        code: [
          "swift test --filter LhSwitchTests    # macOS 宿主即可跑，无需模拟器",
        ],
        tables: [
              DocTable(
                title: "",
                headers: ["case id", "断言", "本地测试"],
                rows: [
                  DocRow(cells: ["`tap-toggles-and-emits-onchange`", "点击开启并回调 `onChange(true)`", "`testDefaultIsInteractive`"]),
                  DocRow(cells: ["`tap-checked-turns-off`", "开启态点击变关闭", "`testCheckedUsesPrimaryTrack`"]),
                  DocRow(cells: ["`disabled-blocks-change`", "禁用态不触发 onChange", "`testDisabledBlocksChange`"]),
                  DocRow(cells: ["`loading-blocks-change`", "加载态不触发 onChange", "`testLoadingBlocksChange`"]),
                  DocRow(cells: ["`checked-uses-primary-token`", "开启消费主色令牌、不消费描边令牌", "`testCheckedUsesPrimaryToken`"]),
                  DocRow(cells: ["`unchecked-uses-border-token`", "关闭消费描边令牌", "`testUncheckedUsesBorderToken`"]),
                ])
        ]
      ),
    ]
  )
}

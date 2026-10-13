// 本文件由 scripts/gen-doc-pages.mjs 从 docs/components/icon.md 生成 —— 禁手改。
// 改文档请改 md 再跑 pnpm gen:docs；真交互预览手写在 Sources/LhUIDocs/Previews/IconPreviews.swift。
// 本文件与 DocRegistry.swift 同属 LhUIDocs 模块，无需 import 自身。

/// Icon 图标（生成物，勿手改）
struct IconDoc {
  static let entry = DocEntry(
    id: "icon",
    title: "Icon 图标",
    lede: [
      "矢量图标。通过逻辑名映射到平台的系统符号（iOS 端为 SF Symbol），尺寸与色调全部走令牌。",
    ],
    contract: [
      "契约源：`lh-ui-core/specs/icon.json` ·",
      "黄金用例：`lh-ui-core/cases/icon.json`（5 条，已翻译为 XCTest，macOS 宿主即可运行）",
    ],
    group: .basic,
    sections: [
        DocSection(
        title: "色调",
        prose: [
          "`tone` 决定图标颜色。`default` 跟随主要文字色，`regular` / `secondary` 取对应层级文字色，其余取语义色。",
        ],
        preview: IconPreviews.tone,
        code: [
          "LhIcon(name: \"star\", tone: .primary)",
        ],
        tables: []
      ),
      DocSection(
        title: "尺寸",
        prose: [
          "三档尺寸映射到 `icon.size` 令牌。",
        ],
        preview: IconPreviews.sizes,
        code: [],
        tables: []
      ),
      DocSection(
        title: "图标名映射",
        prose: [
          "`name` 是与 web 血脉对齐的逻辑名，端侧经 `LhIconMap.symbol(for:)` 映射到 SF Symbol：",
          "未登记的名称不绘制（返回 `nil`），不会崩溃。",
        ],
        preview: IconPreviews.iconNames,
        code: [
          "LhIcon(name: \"search\", size: .large, tone: .secondary) {",
          "  // onClick",
          "}",
        ],
        tables: [
              DocTable(
                title: "",
                headers: ["逻辑名", "SF Symbol"],
                rows: [
                  DocRow(cells: ["`star` / `search` / `check` / `close`", "`star` / `magnifyingglass` / `checkmark` / `xmark`"]),
                  DocRow(cells: ["`arrow-up` / `arrow-down` / `arrow-left` / `arrow-right`", "`arrow.up` / `arrow.down` / `arrow.left` / `arrow.right`"]),
                  DocRow(cells: ["`refresh` / `plus` / `minus` / `eye` / `link`", "`arrow.clockwise` / `plus` / `minus` / `eye` / `link`"]),
                ])
        ]
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
                  DocRow(cells: ["`name`", "图标逻辑名（经 `LhIconMap` 映射 SF Symbol）", "`String`", "—"]),
                  DocRow(cells: ["`size`", "图标尺寸，映射到尺寸令牌", "`LhIconSize`", "`.medium`"]),
                  DocRow(cells: ["`tone`", "图标色调，映射到文字/语义色令牌", "`LhIconTone`", "`.default`"]),
                  DocRow(cells: ["`onClick`", "点击回调；未传则不响应点击", "`(() -> Void)?`", "`nil`"]),
                ]),
              DocTable(
                title: "LhIconSize",
                headers: ["值", "尺寸"],
                rows: [
                  DocRow(cells: ["`.small`", "`icon.size.small`（16pt）"]),
                  DocRow(cells: ["`.medium`", "`icon.size.medium`（20pt）"]),
                  DocRow(cells: ["`.large`", "`icon.size.large`（24pt）"]),
                ]),
              DocTable(
                title: "LhIconTone",
                headers: ["值", "颜色"],
                rows: [
                  DocRow(cells: ["`.default`", "`color.text.primary`"]),
                  DocRow(cells: ["`.primary`", "`color.primary.default`"]),
                  DocRow(cells: ["`.success`", "`color.success.default`"]),
                  DocRow(cells: ["`.warning`", "`color.warning.default`"]),
                  DocRow(cells: ["`.danger`", "`color.danger.default`"]),
                  DocRow(cells: ["`.info`", "`color.info.default`"]),
                  DocRow(cells: ["`.regular`", "`color.text.regular`"]),
                  DocRow(cells: ["`.secondary`", "`color.text.secondary`"]),
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
                  DocRow(cells: ["`icon.size.{small,medium,large}`", "三档尺寸"]),
                  DocRow(cells: ["`color.text.{primary,regular,secondary}`", "文字色调"]),
                  DocRow(cells: ["`color.{primary,success,warning,danger,info}.default`", "语义色调"]),
                ])
        ]
      ),
      DocSection(
        title: "黄金用例对照",
        prose: [
          "另有暗色专项：`testDarkColorsComeFromDarkTokens` / `testDimensionsAreIdenticalInDarkMode`。",
        ],
        preview: nil,
        code: [
          "swift test --filter LhIconTests    # macOS 宿主即可跑，无需模拟器",
        ],
        tables: [
              DocTable(
                title: "",
                headers: ["case id", "断言", "本地测试"],
                rows: [
                  DocRow(cells: ["`click-emits-onclick`", "点击触发 `onClick` 一次", "View 层 `onTapGesture`（手势断言需模拟器，见 #Preview）"]),
                  DocRow(cells: ["`default-tone-uses-text-primary`", "默认色调取主要文字色", "`testDefaultToneUsesTextPrimary`"]),
                  DocRow(cells: ["`primary-tone-uses-primary-token`", "主色调取主色令牌", "`testPrimaryToneUsesPrimaryToken`"]),
                  DocRow(cells: ["`small-size-uses-small-token`", "小号取 small 尺寸令牌", "`testSmallSizeUsesSmallToken`"]),
                  DocRow(cells: ["`render-emits-icon-command`", "仅绘制一条图标指令", "`testRegisteredIconResolvesToSymbol` / `testUnknownIconReturnsNilSymbol`"]),
                ])
        ]
      ),
    ]
  )
}

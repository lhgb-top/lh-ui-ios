// 本文件由 scripts/gen-doc-pages.mjs 从 docs/components/loading.md 生成 —— 禁手改。
// 改文档请改 md 再跑 pnpm gen:docs；真交互预览手写在 Sources/LhUIDocs/Previews/LoadingPreviews.swift。
// 本文件与 DocRegistry.swift 同属 LhUIDocs 模块，无需 import 自身。

/// Loading 加载（生成物，勿手改）
struct LoadingDoc {
  static let entry = DocEntry(
    id: "loading",
    title: "Loading 加载",
    lede: [
      "加载指示器。SwiftUI 端为自绘圆环（`Circle().trim` + 旋转动画），时长走 `motion.duration.base`（秒）。",
    ],
    contract: [
      "契约源：`lh-ui-core/specs/loading.json` ·",
      "黄金用例：`lh-ui-core/cases/loading.json`（5 条，已翻译为 XCTest，macOS 宿主即可运行）",
    ],
    group: .basic,
    sections: [
        DocSection(
        title: "色调",
        prose: [
          "五种色调取语义色令牌，默认 `.primary`。",
        ],
        preview: LoadingPreviews.tone,
        code: [
          "LhLoading(tone: .success)",
        ],
        tables: []
      ),
      DocSection(
        title: "尺寸",
        prose: [
          "三档尺寸映射到 `loading.size` 令牌，描边宽度取 `loading.strokeWidth`。",
        ],
        preview: LoadingPreviews.sizes,
        code: [],
        tables: []
      ),
      DocSection(
        title: "静态帧",
        prose: [
          "`animating: false` 冻结旋转（黄金用例 `render-emits-ring-command` 断言静止圆环的绘制参数），",
          "用于截图测试与文档静态帧。",
        ],
        preview: LoadingPreviews.staticFrame,
        code: [
          "LhLoading(size: .large, animating: false)",
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
                  DocRow(cells: ["`size`", "圆环尺寸，映射到尺寸令牌", "`LhLoadingSize`", "`.medium`"]),
                  DocRow(cells: ["`tone`", "圆环色调，映射到语义色令牌", "`LhLoadingTone`", "`.primary`"]),
                  DocRow(cells: ["`animating`", "是否旋转（`false` 冻结为静态帧）", "`Bool`", "`true`"]),
                ]),
              DocTable(
                title: "LhLoadingSize",
                headers: ["值", "尺寸"],
                rows: [
                  DocRow(cells: ["`.small`", "`loading.size.small`（16pt）"]),
                  DocRow(cells: ["`.medium`", "`loading.size.medium`（20pt）"]),
                  DocRow(cells: ["`.large`", "`loading.size.large`（24pt）"]),
                ]),
              DocTable(
                title: "LhLoadingTone",
                headers: ["值", "颜色"],
                rows: [
                  DocRow(cells: ["`.primary`", "`color.primary.default`"]),
                  DocRow(cells: ["`.success`", "`color.success.default`"]),
                  DocRow(cells: ["`.warning`", "`color.warning.default`"]),
                  DocRow(cells: ["`.danger`", "`color.danger.default`"]),
                  DocRow(cells: ["`.info`", "`color.info.default`"]),
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
                  DocRow(cells: ["`loading.size.{small,medium,large}`", "三档尺寸"]),
                  DocRow(cells: ["`loading.strokeWidth`", "圆环描边宽度"]),
                  DocRow(cells: ["`color.{primary,success,warning,danger,info}.default`", "五种色调"]),
                  DocRow(cells: ["`motion.duration.base`", "旋转一周的动画时长（iOS 端为秒）"]),
                ])
        ]
      ),
      DocSection(
        title: "黄金用例对照",
        prose: [
          "另有暗色专项：`testDarkColorsComeFromDarkTokens` / `testDimensionsAreIdenticalInDarkMode` /",
          "`testLoadingViewInitAndRender`。",
        ],
        preview: nil,
        code: [
          "swift test --filter LhLoadingTests    # macOS 宿主即可跑，无需模拟器",
        ],
        tables: [
              DocTable(
                title: "",
                headers: ["case id", "断言", "本地测试"],
                rows: [
                  DocRow(cells: ["`medium-size-uses-medium-token`", "中号取 medium 尺寸令牌", "`testMediumSizeUsesMediumToken`"]),
                  DocRow(cells: ["`large-size-uses-large-token`", "大号取 large 尺寸令牌", "`testLargeSizeUsesLargeToken`"]),
                  DocRow(cells: ["`primary-tone-uses-primary-token`", "主色调取主色令牌", "`testPrimaryToneUsesPrimaryToken`"]),
                  DocRow(cells: ["`success-tone-uses-success-token`", "成功色调取成功色令牌", "`testSuccessToneUsesSuccessToken`"]),
                  DocRow(cells: ["`render-emits-ring-command`", "圆环描边消费 strokeWidth 令牌", "`testRingUsesStrokeWidthToken`"]),
                ])
        ]
      ),
    ]
  )
}

// 本文件由 scripts/gen-doc-pages.mjs 从 docs/guide/introduction.md 生成 —— 禁手改。
// 改文档请改 md 再跑 pnpm gen:docs；真交互预览手写在 Sources/LhUIDocs/Previews/GuidePreviews.swift。
// 本文件与 DocRegistry.swift 同属 LhUIDocs 模块，无需 import 自身。

/// 介绍（生成物，勿手改）
struct GuideIntroductionDoc {
  static let entry = DocEntry(
    id: "introduction",
    title: "介绍",
    lede: [
      "**lh-ui-ios** 是 lh-ui 家族**原生血脉**的 iOS 端实现：基于 **Swift + SwiftUI** 的 UI 组件库。",
    ],
    contract: [],
    group: .guide,
    sections: [
        DocSection(
        title: "家族中的位置",
        prose: [
          "- **构建期中心**：`lh-ui-core` 是原生血脉的令牌真源（`tokens/*.json`）、组件契约（`specs/`）、黄金用例（`cases/`）与 codegen 工具。它生成 Swift 令牌骨架（`LhTokens` / `LhDarkTokens` / `LhShadow`），**不生成任何 UI 实现**。",
          "- **本仓职责**：手写 SwiftUI View、主题接入（Environment 注入）、props 枚举与默认值绑定、把黄金用例翻译为 XCTest。",
          "- **与 web 血脉互相独立**：不依赖 `@lh-ui/share`，发版互不约束。视觉一致性靠《设计语言基线》人工对齐。",
        ],
        preview: nil,
        code: [
          "                        ┌── web 血脉：share（TS core + SCSS）→ plus / vue2 / react / uniapp",
          "lh-ui 家族（同品牌）─────┤",
          "                        └── 原生血脉：core（JSON 令牌 + 契约 + codegen）→ android / ios / harmony / windows",
          "                                                                    ↑ 本仓",
        ],
        tables: []
      ),
      DocSection(
        title: "设计语言",
        prose: [
          "国风主题：青花瓷蓝主色（`#2B4C7C`）、宣纸白底（`#FAF6F0`）、松花绿成功、藤黄警告、朱砂危险，衬线字体栈（Noto Serif SC → STSong → SimSun）。所有视觉值都是令牌，组件不出现任何字面量。",
        ],
        preview: nil,
        code: [],
        tables: []
      ),
      DocSection(
        title: "为什么是 SwiftUI",
        prose: [
          "- 平台一等公民的声明式 UI，与 Compose / ArkUI 心智同构，跨端契约容易对齐",
          "- SPM 一键接入，无 JS 运行时、无桥接层",
          "- `#Preview` 即文档，`View` 即组件，与 web 血脉的 SFC 开发体验对称",
        ],
        preview: nil,
        code: [],
        tables: []
      ),
      DocSection(
        title: "当前状态",
        prose: [
          "- **button 全链路打样已交付**（令牌消费 + resolveAppearance 外观解析 + SwiftUI View + XCTest + `#Preview` + 文档站）",
          "- P0 其余 13 个组件（icon / input / textarea / cell / checkbox / radio / switch / tag / dialog / toast / loading / picker / navbar）按同范式后续补齐",
        ],
        preview: nil,
        code: [],
        tables: []
      ),
    ]
  )
}

// 本文件由 scripts/gen-doc-pages.mjs 从 docs/guide/quickstart.md 生成 —— 禁手改。
// 改文档请改 md 再跑 pnpm gen:docs；真交互预览手写在 Sources/LhUIDocs/Previews/GuidePreviews.swift。
// 本文件与 DocRegistry.swift 同属 LhUIDocs 模块，无需 import 自身。

/// 快速开始（生成物，勿手改）
struct GuideQuickstartDoc {
  static let entry = DocEntry(
    id: "quickstart",
    title: "快速开始",
    lede: [],
    contract: [],
    group: .guide,
    sections: [
        DocSection(
        title: "最小示例",
        prose: [
          "`LhTheme` 是主题容器，内部所有 Lh 组件通过 Environment 自动消费令牌；不包裹时回退明色色板。",
        ],
        preview: nil,
        code: [
          "import SwiftUI",
          "import LhUI",
          "",
          "struct Demo: View {",
          "  var body: some View {",
          "    LhTheme {",
          "      LhButton(",
          "        lhOnClick: { /* 处理点击 */ },",
          "        type: .primary,",
          "        text: \"主要按钮\"",
          "      )",
          "    }",
          "  }",
          "}",
        ],
        tables: []
      ),
      DocSection(
        title: "类型与尺寸",
        prose: [],
        preview: nil,
        code: [
          "// 六种类型",
          "LhButton(lhOnClick: {}, text: \"默认\")                      // .default",
          "LhButton(lhOnClick: {}, type: .primary, text: \"主要\")",
          "LhButton(lhOnClick: {}, type: .success, text: \"成功\")",
          "LhButton(lhOnClick: {}, type: .warning, text: \"警告\")",
          "LhButton(lhOnClick: {}, type: .danger, text: \"危险\")",
          "LhButton(lhOnClick: {}, type: .info, text: \"信息\")",
          "",
          "// 三种尺寸",
          "LhButton(lhOnClick: {}, lhSize: .small, text: \"小型\")",
          "LhButton(lhOnClick: {}, lhSize: .medium, text: \"中型\")",
          "LhButton(lhOnClick: {}, lhSize: .large, text: \"大型\")",
        ],
        tables: []
      ),
      DocSection(
        title: "状态",
        prose: [],
        preview: nil,
        code: [
          "// 禁用：不响应点击，呈现禁用样式",
          "LhButton(lhOnClick: {}, disabled: true, text: \"禁用\")",
          "",
          "// 加载中：显示指示器，不触发 lhOnClick",
          "LhButton(lhOnClick: {}, loading: true, text: \"加载中\")",
          "",
          "// 两者共存：按禁用优先处理（黄金用例 disabled-precedes-loading）",
          "LhButton(lhOnClick: {}, disabled: true, loading: true, text: \"禁用优先\")",
        ],
        tables: []
      ),
      DocSection(
        title: "图标与花纹底",
        prose: [],
        preview: nil,
        code: [
          "// 图标名按本地图标体系解析（SF Symbol 映射见 LhButtonStyle.icon(for:)，未登记名不绘制）",
          "LhButton(lhOnClick: {}, type: .primary, icon: \"search\", text: \"搜索\")",
          "",
          "// 国风花纹底纹（消费 color.decoration 令牌）",
          "LhButton(lhOnClick: {}, type: .primary, bgPattern: true, text: \"花纹底\")",
        ],
        tables: []
      ),
      DocSection(
        title: "明暗主题",
        prose: [],
        preview: nil,
        code: [
          "LhTheme(isDark: isDark) {",
          "  // 内部所有组件自动切换暗色令牌（core 预计算值，无运行时调色）",
          "}",
        ],
        tables: []
      ),
      DocSection(
        title: "组件示例预览",
        prose: [
          "原生 UI 无法在浏览器实时渲染，本站用**内联静态 HTML 手机框模拟器**展示外观：",
          "> 模拟器的暗色与站点联动：右上角切换主题，手机框内颜色即变（暗色令牌由 core 预计算）。",
        ],
        preview: nil,
        code: [],
        tables: []
      ),
      DocSection(
        title: "嵌入原生文档界面",
        prose: [
          "本仓自带一套**真交互文档 UI**（SwiftUI 实现，对标 Android `:docsui`）：全部组件文档 +",
          "指南 + 明暗切换 + 实时可交互预览，与本文档站同源（页面由 `docs/**/*.md` 生成）。",
          "引入 `LhUIDocs` 库产物后，宿主 App 一行即可嵌入（对标 Android 的拖入即用）：",
          "UIKit 宿主用托管控制器入口（等价 Android `LhDocs.launch(context)`）：",
          "想要一个独立的「lh-ui 文档」App？仓库里的 `docsapp/` 是极薄打包壳，",
          "`open docsapp/LhUIDocsApp.xcodeproj` 即可 Run / Archive 出 IPA，",
          "详见 [仓库 docsapp/README.md](https://github.com/lhgb-top/lh-ui-ios/blob/master/docsapp/README.md)。",
        ],
        preview: nil,
        code: [
          "import SwiftUI",
          "import LhUIDocs",
          "",
          "struct DocsEntry: View {",
          "  var body: some View {",
          "    LhDocsView() // 零配置：自管返回栈 + 明暗切换 + 全局 Toast",
          "  }",
          "}",
          "import LhUIDocs",
          "",
          "present(LhDocsViewController(), animated: true)",
        ],
        tables: []
      ),
    ]
  )
}

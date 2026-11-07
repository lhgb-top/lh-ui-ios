// 本文件由 scripts/gen-doc-pages.mjs 从 docs/guide/i18n.md 生成 —— 禁手改。
// 改文档请改 md 再跑 pnpm gen:docs；真交互预览手写在 Sources/LhUIDocs/Previews/GuidePreviews.swift。
// 本文件与 DocRegistry.swift 同属 LhUIDocs 模块，无需 import 自身。

/// 多语言（i18n）（生成物，勿手改）
struct GuideI18nDoc {
  static let entry = DocEntry(
    id: "i18n",
    title: "多语言（i18n）",
    lede: [
      "组件库内置 10 种语言文案包，并支持宿主注册自定义语言。机制与 web 血脉",
      "`@lh-ui/share` 的 `LhLocale` 语义对齐，与 iOS 端的 `LhColors` 主题层同构。",
    ],
    contract: [],
    group: .guide,
    sections: [
        DocSection(
        title: "语言范围",
        prose: [
          "> 代码与 web 血脉 `lh-ui-share` 的 `LH_LANGUAGE_CONST` 逐字一致；zh-CN 的",
          "> 确认/取消取 `specs/*.json` 的 `\"确认\"` / `\"取消\"`（R-n5）。",
        ],
        preview: nil,
        code: [],
        tables: [
              DocTable(
                title: "",
                headers: ["代码", "语言", "备注"],
                rows: [
                  DocRow(cells: ["`zh-CN`", "简体中文", "缺省语言"]),
                  DocRow(cells: ["`zh-TW`", "繁體中文", ""]),
                  DocRow(cells: ["`en-US`", "English", ""]),
                  DocRow(cells: ["`ja-JP`", "日本語", ""]),
                  DocRow(cells: ["`ko-KR`", "한국어", ""]),
                  DocRow(cells: ["`de-DE`", "Deutsch", "仅运行时（文档站九语言不含德语）"]),
                  DocRow(cells: ["`fr-FR`", "Français", ""]),
                  DocRow(cells: ["`es`", "Español", ""]),
                  DocRow(cells: ["`ar`", "العربية", "RTL，由 `LhTheme` 注入 `\\.locale` 自动翻转布局"]),
                  DocRow(cells: ["`ru`", "Русский", ""]),
                ])
        ]
      ),
      DocSection(
        title: "作用范围（重要）",
        prose: [
          "`LhTexts` 只承载**组件库自身**的内置字符串：",
          "- Dialog / Picker 的确认/取消按钮默认文字（`confirmText` / `cancelText` 为 `nil` 时）",
          "- Loading / Switch 的无障碍标签，Input / Textarea 未设 placeholder 时的无障碍回退",
          "调用方传入的文本（`title` / `content` / `label` / `options` … 的本地化是**宿主 App 的职责**——",
          "这些字符串由业务产生，组件库不代管。",
        ],
        preview: nil,
        code: [],
        tables: []
      ),
      DocSection(
        title: "切换语言",
        prose: [
          "`LhTheme` 自动把当前语言包注入 `Environment(\\.lhTexts)` 并联动 `\\.locale`（ar 自动 RTL）。",
          "未注册的语言回退**简体中文包内容**（与 web 血脉一致）。",
        ],
        preview: nil,
        code: [
          "// 全局切换：LhTheme 内部以 @ObservedObject 持有单例，切换即整树重渲染",
          "LhLocale.shared.setLocale(\"en-US\")",
          "",
          "// 当前语言代码",
          "LhLocale.shared.current  // \"en-US\"",
        ],
        tables: []
      ),
      DocSection(
        title: "自定义语言",
        prose: [
          "`register` 注册的包**遮蔽内置注册表**（同语言的内置包永不被覆写）；若注册的正是当前语言则立即生效。",
        ],
        preview: nil,
        code: [
          "let vietnamese = LhTexts(",
          "  dialogConfirm: \"Xác nhận\", dialogCancel: \"Hủy\",",
          "  pickerConfirm: \"Xác nhận\", pickerCancel: \"Hủy\",",
          "  loadingLabel: \"Đang tải\", switchLabel: \"Công tắc\",",
          "  inputLabelFallback: \"Trường văn bản\",",
          "  textareaLabelFallback: \"Trường văn bản nhiều dòng\"",
          ")",
          "",
          "LhLocale.shared.register(\"vi\", pack: vietnamese)",
          "LhLocale.shared.setLocale(\"vi\")",
        ],
        tables: []
      ),
      DocSection(
        title: "LhTexts",
        prose: [
          "构造器公开：单测可直接构造文案包做断言。无 `LhTheme` 包裹时 Environment 键的",
          "defaultValue 回退 `ZhCnLhTexts`（缺省即中文，镜像主题层的「缺省即明色」）。",
        ],
        preview: nil,
        code: [
          "public struct LhTexts: Equatable, Sendable {",
          "  public let dialogConfirm: String   // \"确认\" / \"OK\" / \"確定\" …",
          "  public let dialogCancel: String",
          "  public let pickerConfirm: String",
          "  public let pickerCancel: String",
          "  public let loadingLabel: String    // 无障碍标签",
          "  public let switchLabel: String",
          "  public let inputLabelFallback: String",
          "  public let textareaLabelFallback: String",
          "}",
          "",
          "public let ZhCnLhTexts = LhTexts(dialogConfirm: \"确认\", /* … */)",
          "public let EnUsLhTexts = LhTexts(dialogConfirm: \"Confirm\", /* … */)",
          "// … ZhTw / JaJp / KoKr / DeDe / FrFr / Es / Ar / Ru",
        ],
        tables: []
      ),
      DocSection(
        title: "与主题层的关系",
        prose: [
          "`LhTheme(isDark:colors:texts:)` 的 `texts` 参数提供显式覆盖入口（预设文案包，预留扩展）。",
        ],
        preview: nil,
        code: [],
        tables: [
              DocTable(
                title: "",
                headers: ["", "颜色", "文案"],
                rows: [
                  DocRow(cells: ["值类型", "`LhColors`", "`LhTexts`"]),
                  DocRow(cells: ["预设", "`LightLhColors` / `DarkLhColors`", "`ZhCnLhTexts` / `EnUsLhTexts` …"]),
                  DocRow(cells: ["注入", "`Environment(\\.lhColors)`", "`Environment(\\.lhTexts)`"]),
                  DocRow(cells: ["容器", "`LhTheme(isDark:)`", "`LhTheme` 内部自动（`LhLocale.shared`）"]),
                  DocRow(cells: ["逐级覆盖", "`.lhColors(_)`", "`.lhTexts(_)`"]),
                ])
        ]
      ),
      DocSection(
        title: "文档 App 演示",
        prose: [
          "原生文档宿主（`LhDocsView`）侧边栏「设置」区提供主题（跟随系统 / 明色 / 暗色）",
          "与语言（10 内置 + 一个 `vi` 自定义包演示）切换，可直接验证多语言行为。",
        ],
        preview: nil,
        code: [],
        tables: []
      ),
    ]
  )
}

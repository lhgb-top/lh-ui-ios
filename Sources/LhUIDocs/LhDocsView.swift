import SwiftUI
import LhUI
import LhUITokens

// 本文件是手写真源（非生成物）—— 原生文档宿主（D21：真交互主场）。
//
// 对标 Android :docsui 的四支柱：
// ①令牌先行 —— 全部外观取 LhTokens / DocPalette，无色值/尺寸字面量
// ②内容与预览分离 —— 页面由 gen-doc-pages.mjs 从 md 生成（禁手改），预览手写
// ③宿主零依赖 —— 自管返回栈 + LhNavbar dogfood + 全局 LhToast，不依赖 NavigationStack
// ④库内交付 —— App 侧引入 LhUIDocs 产物，拖入一个 LhDocsView 即得真交互文档界面

/// 原生文档宿主：一个自包含的文档界面。
///
/// 用法：`LhDocsView()` 直接放进窗口，或 push 进 NavigationStack。
/// 侧边栏分组顺序与 `docs/.vitepress/config.ts` 对齐；页面内容是生成物，
/// 真交互预览手写在 `Sources/LhUIDocs/Previews/`。
public struct LhDocsView: View {
  /// 返回栈：栈顶即当前页 id；空栈落在首页（指南第一篇）
  @State private var stack: [String] = []
  /// 主题模式：跟随系统 / 明色 / 暗色（侧边栏「设置」区切换；右上角为明暗快捷切换）
  enum ThemeMode: String, CaseIterable {
    case system, light, dark
    var label: String {
      switch self {
      case .system: return "跟随系统"
      case .light: return "明色"
      case .dark: return "暗色"
      }
    }
  }
  @State private var themeMode: ThemeMode = .system
  /// 语言：追踪 LhLocale 单例，切换即整树重渲染
  @ObservedObject private var locale = LhLocale.shared
  /// 预览作用域：预览只通过它与宿主通信（全局 Toast），不自持浮层
  @StateObject private var scope = DocPreviewScope()
  /// 页面底色取主题色板（非字面量）
  @Environment(\.lhColors) private var colors
  /// 系统色彩模式（themeMode 为 .system 时取其值）
  @Environment(\.colorScheme) private var systemColorScheme

  /// 首页 id（空栈时展示）
  private static let homeId = "introduction"

  public init() {
    // 注册一个自定义语言包演示（对标 web 血脉 LhLocale.register）
    LhLocale.shared.register("vi", pack: Self.vietnameseDemoPack)
  }

  /// 当前是否暗色：跟随系统时取系统色彩模式
  private var isDark: Bool {
    switch themeMode {
    case .system: return systemColorScheme == .dark
    case .light: return false
    case .dark: return true
    }
  }

  /// 语言选项：10 内置语言 + 1 个自定义包演示（vi）
  private static let languages: [(code: String, label: String)] = [
    ("zh-CN", "中文（简体）"),
    ("zh-TW", "繁體中文"),
    ("en-US", "English"),
    ("ja-JP", "日本語"),
    ("ko-KR", "한국어"),
    ("de-DE", "Deutsch"),
    ("fr-FR", "Français"),
    ("es", "Español"),
    ("ar", "العربية"),
    ("ru", "Русский"),
    ("vi", "Tiếng Việt（自定义包）"),
  ]

  /// 自定义语言包演示：越南语（宿主注册，非内置）
  private static let vietnameseDemoPack = LhTexts(
    dialogConfirm: "Xác nhận",
    dialogCancel: "Hủy",
    pickerConfirm: "Xác nhận",
    pickerCancel: "Hủy",
    loadingLabel: "Đang tải",
    switchLabel: "Công tắc",
    inputLabelFallback: "Trường văn bản",
    textareaLabelFallback: "Trường văn bản nhiều dòng"
  )

  /// 当前语言的展示名（未登记时回退原始代码）
  private var currentLanguageLabel: String {
    Self.languages.first { $0.code == locale.current }?.label ?? locale.current
  }

  private var currentId: String { stack.last ?? Self.homeId }
  private var entry: DocEntry { DocRegistry.byId(currentId) ?? DocRegistry.all[0] }
  private var canBack: Bool { !stack.isEmpty }

  /// 侧边栏宽 / 正文最大宽：令牌派生，不写死
  private static let sidebarWidth = LhTokens.Spacing.xxl * 7
  private static let contentMaxWidth = LhTokens.Spacing.xxl * 32

  public var body: some View {
    LhTheme(isDark: isDark) {
      ZStack {
        VStack(spacing: 0) {
          // dogfood 自家的 LhNavbar：左侧返回出栈，右侧切换明暗
          LhNavbar(
            title: entry.title,
            leftText: canBack ? "返回" : "",
            leftIcon: canBack ? "arrow-left" : nil,
            rightText: "切换主题",
            bordered: true,
            onLeftClick: goBack,
            onRightClick: { themeMode = isDark ? .light : .dark }
          )

          HStack(spacing: 0) {
            sidebar
            Divider()
            detail
          }
        }
        .background(pageBackground)

        // 全局 Toast：预览只改 scope，宿主统一承载（对标 Android 全局 Toast 通道）
        LhToast(
          visible: $scope.toastVisible,
          text: scope.toastText,
          type: .success,
          lhPosition: scope.toastPosition
        )
      }
      // 明暗切换同时驱动系统 colorScheme，令牌色板与原生控件同步
      .environment(\.colorScheme, isDark ? .dark : .light)
    }
  }

  /// 侧边栏：分组列表，选中即入栈
  private var sidebar: some View {
    List(selection: Binding(
      get: { currentId },
      set: { newValue in
        guard let id = newValue, id != currentId else { return }
        stack.append(id)
      }
    )) {
      // 主题与语言：多语言 + 明暗主题的演示入口（组件库能力的一等公民）
      Section("设置") {
        Menu("主题：\(themeMode.label)") {
          ForEach(ThemeMode.allCases, id: \.self) { mode in
            Button(mode.label) { themeMode = mode }
          }
        }
        Menu("语言：\(currentLanguageLabel)") {
          ForEach(Self.languages, id: \.code) { language in
            Button(language.label) { locale.setLocale(language.code) }
          }
        }
      }

      ForEach(DocGroup.allCases, id: \.self) { group in
        Section(group.label) {
          ForEach(DocRegistry.entries(in: group), id: \.id) { item in
            Text(item.title).tag(item.id)
          }
        }
      }
    }
    .listStyle(.sidebar)
    .frame(minWidth: Self.sidebarWidth)
  }

  /// 正文区：页面 = 标题 + 导语 + 契约 + 分隔线 + 章节
  private var detail: some View {
    ScrollView {
      page(entry: entry)
        .padding(.horizontal, DocPalette.cardPadding)
        .padding(.vertical, DocPalette.cardPadding)
        .frame(maxWidth: Self.contentMaxWidth)
        .frame(maxWidth: .infinity, alignment: .center)
    }
    .frame(maxWidth: .infinity)
    .background(pageBackground)
  }

  /// 页面骨架
  private func page(entry: DocEntry) -> some View {
    VStack(alignment: .leading, spacing: DocPalette.cardPadding) {
      DocHeading(text: entry.title, level: 1)

      ForEach(Array(entry.lede.enumerated()), id: \.offset) { _, line in
        DocProse(text: line)
      }

      if !entry.contract.isEmpty {
        DocCard {
          VStack(alignment: .leading, spacing: DocPalette.cellPaddingY / 2) {
            ForEach(Array(entry.contract.enumerated()), id: \.offset) { _, line in
              DocProse(text: line, secondary: true)
            }
          }
        }
      }

      DocDivider()

      ForEach(Array(entry.sections.enumerated()), id: \.offset) { _, section in
        sectionView(section)
      }
    }
  }

  /// 章节：标题 + 散文 + 真交互预览 + 代码块 + 表格
  private func sectionView(_ section: DocSection) -> some View {
    VStack(alignment: .leading, spacing: DocPalette.cellPaddingY) {
      DocHeading(text: section.title, level: 2)

      ForEach(Array(section.prose.enumerated()), id: \.offset) { _, line in
        DocProse(text: line)
      }

      if let preview = section.preview {
        preview(scope)
          .frame(maxWidth: .infinity, alignment: .leading)
      }

      if !section.code.isEmpty {
        DocCodeBlock(lines: section.code)
      }

      ForEach(Array(section.tables.enumerated()), id: \.offset) { _, table in
        DocTableView(table: table)
      }
    }
  }

  private func goBack() {
    if !stack.isEmpty { stack.removeLast() }
  }

  private var pageBackground: Color {
    colors.backgroundPage
  }
}

import SwiftUI
import LhUI

// 本文件是手写真源（非生成物）—— 文档数据模型与宿主能力注入。

/// 文档分组；顺序与 `docs/.vitepress/config.ts` 的侧边栏分组对齐。
/// 注册表由 `scripts/gen-doc-pages.mjs` 生成，分组顺序是真源。
public enum DocGroup: String, CaseIterable, Sendable {
  case guide
  case basic
  case form
  case feedback
  case navigation

  /// 分组的中文标签（侧栏分组标题用）
  public var label: String {
    switch self {
    case .guide: return "指南"
    case .basic: return "基础组件"
    case .form: return "表单组件"
    case .feedback: return "反馈组件"
    case .navigation: return "导航组件"
    }
  }
}

/// 通用表格行（单元格原始文本，行内反引号由构件侧渲染为等宽字形）
public struct DocRow: Sendable {
  public let cells: [String]
  public init(cells: [String]) { self.cells = cells }
}

/// 文档表格：Props 表 / 枚举表 / 令牌表 / 用例表 / 指南内的速查表共用
public struct DocTable: Sendable {
  public let title: String
  public let headers: [String]
  public let rows: [DocRow]
  public init(title: String, headers: [String], rows: [DocRow]) {
    self.title = title
    self.headers = headers
    self.rows = rows
  }
}

/// 预览作用域：宿主能力注入。真交互预览只通过它与宿主通信（全局 Toast），
/// 不自持浮层，保持「宿主拖入即用」的零依赖。
///
/// 是 ObservableObject：预览里任意按钮改 `toastText` 即可让宿主层的 LhToast 显示；
/// LhToast 到期自动隐藏时会经 Binding 把 `toastVisible` 写回 false。
@MainActor
public final class DocPreviewScope: ObservableObject {
  /// 当前提示文案；不可见时保留上一次文案（下次显示复用）
  @Published public var toastText: String = ""
  /// 是否正在显示；LhToast 到期会经 Binding 置回 false
  @Published public var toastVisible: Bool = false
  /// 提示定位（预览可改它演示 Position 能力）
  @Published public var toastPosition: LhToastPosition = .center

  public init() {}

  /// 显示一条全局 Toast（宿主的 LhToast 承载，预览里点击/触发即给反馈）
  public func showToast(_ text: String, position: LhToastPosition? = nil) {
    if let position { toastPosition = position }
    toastText = text
    toastVisible = true
  }
}

/// 文档章节：散文行 + 可选真交互预览 + 代码片段 + 内联表格
public struct DocSection: Sendable {
  public let title: String
  public let prose: [String]
  /// 真交互预览（手写在 `Previews/`）；终止节（API / 令牌对照 / 黄金用例对照）为 nil
  public let preview: ((DocPreviewScope) -> AnyView)?
  public let code: [String]
  public let tables: [DocTable]

  public init(
    title: String,
    prose: [String],
    preview: ((DocPreviewScope) -> AnyView)? = nil,
    code: [String] = [],
    tables: [DocTable] = []
  ) {
    self.title = title
    self.prose = prose
    self.preview = preview
    self.code = code
    self.tables = tables
  }
}

/// 文档条目：一个组件或一篇指南。
///
/// 内容由 `scripts/gen-doc-pages.mjs` 从 `docs/components/*.md` 与
/// `docs/guide/*.md` 生成（**禁手改**，漂移由脚本兜底）。
/// 终止节（API / 令牌对照 / 黄金用例对照）也作为普通章节承载，其表格落在 `tables` 里。
public struct DocEntry: Sendable {
  public let id: String
  public let title: String
  public let lede: [String]
  public let contract: [String]
  public let group: DocGroup
  public let sections: [DocSection]

  public init(
    id: String,
    title: String,
    lede: [String],
    contract: [String],
    group: DocGroup,
    sections: [DocSection]
  ) {
    self.id = id
    self.title = title
    self.lede = lede
    self.contract = contract
    self.group = group
    self.sections = sections
  }
}

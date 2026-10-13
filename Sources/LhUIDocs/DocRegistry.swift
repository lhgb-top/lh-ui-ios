// 本文件由 scripts/gen-doc-pages.mjs 生成 —— 禁手改（分组顺序对齐 docs 侧边栏）。
// 本文件与 pages/*.swift 同属 LhUIDocs 模块，无需 import 自身。

/// 文档注册表：数据驱动的页面清单。顺序与 docs/.vitepress/config.ts 的侧边栏一致。
enum DocRegistry {
  /// 全部条目（侧边栏顺序）
  static let all: [DocEntry] = [
    GuideIntroductionDoc.entry,
    GuideInstallationDoc.entry,
    GuideQuickstartDoc.entry,
    GuideThemingDoc.entry,
    GuideLocalLinkingDoc.entry,
    ButtonDoc.entry,
    IconDoc.entry,
    TagDoc.entry,
    LoadingDoc.entry,
    CellDoc.entry,
    CheckboxDoc.entry,
    RadioDoc.entry,
    SwitchDoc.entry,
    InputDoc.entry,
    TextareaDoc.entry,
    DialogDoc.entry,
    ToastDoc.entry,
    PickerDoc.entry,
    NavbarDoc.entry,
  ]

  /// 按 id 取条目；宿主的返回栈与侧边栏选中都走它
  static func byId(_ id: String) -> DocEntry? {
    all.first { $0.id == id }
  }

  /// 取某分组的条目（保持 all 内顺序）
  static func entries(in group: DocGroup) -> [DocEntry] {
    all.filter { $0.group == group }
  }
}

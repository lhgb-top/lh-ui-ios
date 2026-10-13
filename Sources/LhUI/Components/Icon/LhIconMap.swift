import SwiftUI

/// 图标名 → SF Symbol 的统一映射表。
///
/// spec 的 `icon` prop 是「图标名」（各端按本地图标体系渲染，R-n5 要求五端同名）。
/// 本表与 web 血脉 `@lh-ui/share` 的内置图标名逐字对齐（star/search/check/…/link），
/// iOS 端落到 SF Symbols。未登记的图标名返回 nil，调用方不绘制，不崩溃。
///
/// 命名规范（总纲 D20）：自有类型一律 Lh 前缀。
public enum LhIconMap {
  /// 已登记图标名 → SF Symbol 名；未登记返回 nil
  public static func symbol(for name: String?) -> String? {
    guard let name else { return nil }
    symbols[name]
  }

  /// 已登记的图标名集合（用于预览与文档列举）
  public static let names: [String] = Array(symbols.keys).sorted()

  private static let symbols: [String: String] = [
    "star": "star",
    "search": "magnifyingglass",
    "check": "checkmark",
    "close": "xmark",
    "arrow-up": "arrow.up",
    "arrow-down": "arrow.down",
    "arrow-left": "arrow.left",
    "arrow-right": "arrow.right",
    "warning": "exclamationmark.triangle",
    "error": "xmark.circle",
    "info": "info.circle",
    "loading": "arrow.clockwise",
    "plus": "plus",
    "minus": "minus",
    "edit": "pencil",
    "delete": "trash",
    "setting": "gearshape",
    "user": "person",
    "home": "house",
    "menu": "line.horizontal.3",
    "more": "ellipsis",
    "download": "arrow.down.to.line",
    "upload": "arrow.up.to.line",
    "refresh": "arrow.clockwise",
    "folder": "folder",
    "file": "doc",
    "date": "calendar",
    "clock": "clock",
    "email": "envelope",
    "phone": "phone",
    "location": "location.fill",
    "image": "photo",
    "share": "square.and.arrow.up",
    "bell": "bell",
    "filter": "line.3.horizontal.decrease",
    "eye": "eye",
    "link": "link",
  ]
}

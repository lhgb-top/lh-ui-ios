import SwiftUI

/// 语言管理单例：对齐 web 血脉 `lh-ui-share` 的 `LhLocale` 语义。
///
/// - `shared` 全局单例；`current` 为当前语言代码（与 web `getLocale()` 对应）
/// - `setLocale(_:)` 仅切换语言：未注册的语言回退**简体中文包内容**
///   （与 web 一致：`getLocale()` 仍报告被请求的语言）
/// - `register(_:pack:)` 注册自定义语言包：**遮蔽内置注册表**，内置包永不被覆写
///   （复刻 web 的历史 bug 教训：早期版本直接写内置表导致内置包被永久破坏）
/// - `texts` 是 `@Published`：`LhTheme` 内部以 `@ObservedObject` 持有本单例，
///   语言切换即触发整树重渲染并重新注入 `\.lhTexts`，宿主无需任何额外接线
///
/// Swift 值类型不做 web `add()` 的深合并：宿主自定义语言直接整包提供。
public final class LhLocale: ObservableObject {
  /// 缺省语言（zh-CN，`LH_LANGUAGE_DEFAULT` 对应）
  public static let defaultLocale = "zh-CN"

  /// 全局单例
  public static let shared = LhLocale()

  /// 当前语言代码（如 "zh-CN" / "en-US" / 自定义代码）
  @Published public private(set) var current: String = defaultLocale

  /// 当前生效的文案包（语言切换 / 注册自定义包时更新）
  @Published public private(set) var texts: LhTexts = ZhCnLhTexts

  /// 用户注册的自定义包表：遮蔽内置注册表（内置包永不被覆写）
  private var userPacks: [String: LhTexts] = [:]

  /// 内置语言包注册表：10 种语言，代码与 web 血脉 LH_LANGUAGE_CONST 逐字对齐
  private static let builtInPacks: [String: LhTexts] = [
    "zh-CN": ZhCnLhTexts,
    "zh-TW": ZhTwLhTexts,
    "en-US": EnUsLhTexts,
    "ja-JP": JaJpLhTexts,
    "ko-KR": KoKrLhTexts,
    "de-DE": DeDeLhTexts,
    "fr-FR": FrFrLhTexts,
    "es": EsLhTexts,
    "ar": ArLhTexts,
    "ru": RuLhTexts,
  ]

  private init() {}

  /// 切换语言。未注册的语言回退简体中文包内容（current 仍报告被请求的语言）。
  public func setLocale(_ locale: String) {
    current = locale
    texts = Self.pack(for: locale) ?? ZhCnLhTexts
  }

  /// 注册自定义语言包：遮蔽同语言的内置包；若正是当前语言则立即生效。
  ///
  /// 用法（自定义语言）：
  /// ```swift
  /// LhLocale.shared.register("vi", pack: LhTexts(dialogConfirm: "Xác nhận", …))
  /// LhLocale.shared.setLocale("vi")
  /// ```
  public func register(_ locale: String, pack: LhTexts) {
    userPacks[locale] = pack
    if locale == current {
      texts = pack
    }
  }

  /// 解析某语言的文案包：自定义包优先于内置包（内置表只读）
  public static func pack(for locale: String) -> LhTexts? {
    shared.userPacks[locale] ?? builtInPacks[locale]
  }

  /// 当前语言对应的 Foundation Locale（供 SwiftUI `\.locale` 注入；
  /// ar 等 RTL 语言据此翻转布局方向）
  var foundationLocale: Locale {
    Locale(identifier: current)
  }
}

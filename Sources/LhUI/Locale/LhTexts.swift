import SwiftUI

/// 组件库内置文案包：与 `LhColors` 同构的语言层值类型。
///
/// 设计要点（与 `LhColors` 一一对应）：
/// - `LhColors` 平铺 core 生成的明/暗色板，`LhTexts` 平铺组件库**自身**硬编码的
///   运行时文案（Dialog/Picker 的确认/取消默认值、Loading/Switch/Input/Textarea 的
///   无障碍标签回退）。
/// - 调用方传入的文本（title / content / label / options …）**不经过本层**，其本地化
///   是宿主 App 的职责；本层只保证组件库自带的默认字符串可随语言切换。
/// - 内置 10 语言与 web 血脉 `lh-ui-share` 的 `LH_LANGUAGE_CONST` 逐字对齐
///   （zh-CN / zh-TW / en-US / ja-JP / ko-KR / de-DE / fr-FR / es / ar / ru），
///   译文取 web 语言包与家族术语表的既有共识；zh-CN 的确认/取消保持
///   `lh-ui-core/specs/*.json` 的 `"确认"` / `"取消"`（R-n5 逐字对齐）。
/// - 构造器公开是为了让单测能直接构造文案包做断言；应用侧应通过 `LhTheme` 消费。
public struct LhTexts: Equatable, Sendable {
  /// 对话框确认按钮默认文字（confirmText 为 nil 时取此值；空字符串表示隐藏按钮）
  public let dialogConfirm: String
  /// 对话框取消按钮默认文字（cancelText 为 nil 时取此值；空字符串表示隐藏按钮）
  public let dialogCancel: String
  /// 选择器工具栏确认按钮默认文字
  public let pickerConfirm: String
  /// 选择器工具栏取消按钮默认文字
  public let pickerCancel: String
  /// Loading 无障碍标签（VoiceOver 读出）
  public let loadingLabel: String
  /// Switch 无障碍标签（VoiceOver 读出）
  public let switchLabel: String
  /// Input 未设 placeholder 时的无障碍标签回退
  public let inputLabelFallback: String
  /// Textarea 未设 placeholder 时的无障碍标签回退
  public let textareaLabelFallback: String

  public init(
    dialogConfirm: String,
    dialogCancel: String,
    pickerConfirm: String,
    pickerCancel: String,
    loadingLabel: String,
    switchLabel: String,
    inputLabelFallback: String,
    textareaLabelFallback: String
  ) {
    self.dialogConfirm = dialogConfirm
    self.dialogCancel = dialogCancel
    self.pickerConfirm = pickerConfirm
    self.pickerCancel = pickerCancel
    self.loadingLabel = loadingLabel
    self.switchLabel = switchLabel
    self.inputLabelFallback = inputLabelFallback
    self.textareaLabelFallback = textareaLabelFallback
  }
}

/// 语言文案环境键：SwiftUI Environment 注入，未注入时回退简体中文（缺省即中文，
/// 镜像 `LhColorsKey` 的「缺省即明色」）。
///
/// 值由 `LhTheme` 从 `LhLocale.shared` 注入；宿主也可用 `.lhTexts(_:)` 逐级覆盖。
private struct LhTextsKey: EnvironmentKey {
  static let defaultValue: LhTexts = ZhCnLhTexts
}

public extension EnvironmentValues {
  var lhTexts: LhTexts {
    get { self[LhTextsKey.self] }
    set { self[LhTextsKey.self] = newValue }
  }
}

/// 覆盖当前文案包（与 `View.lhColors(_:)` 成对）
public extension View {
  func lhTexts(_ texts: LhTexts) -> some View {
    environment(\.lhTexts, texts)
  }
}

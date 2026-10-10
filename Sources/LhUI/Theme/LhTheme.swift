import SwiftUI
import LhUITokens

/// 主题色板：把 core 生成的 LhTokens / LhDarkTokens 平铺为一份不可变值类型。
///
/// 暗色令牌是**并列对象**模型（core codegen 的 ios target 只在 LhDarkTokens 里放
/// Color 子对象，尺寸/动效/圆角暗色不覆盖）。本结构只承载颜色，尺寸令牌由组件直接
/// 取 LhTokens（尺寸无暗色变体）。
///
/// 构造器公开是为了让单测能直接构造色板做断言；应用侧应通过 LhTheme 消费。
public struct LhColors: Equatable {
  public let primary: Color
  public let primaryHover: Color
  public let primaryActive: Color
  public let primaryBg: Color
  public let primaryBorder: Color
  public let onPrimary: Color
  public let success: Color
  public let successHover: Color
  public let successActive: Color
  public let successBg: Color
  public let warning: Color
  public let warningHover: Color
  public let warningActive: Color
  public let warningBg: Color
  public let danger: Color
  public let dangerHover: Color
  public let dangerActive: Color
  public let dangerBg: Color
  public let info: Color
  public let infoHover: Color
  public let infoActive: Color
  public let infoBg: Color
  public let textPrimary: Color
  public let textRegular: Color
  public let textSecondary: Color
  public let textPlaceholder: Color
  public let textDisabled: Color
  public let backgroundDefault: Color
  public let backgroundPage: Color
  public let backgroundDisabled: Color
  public let backgroundOverlay: Color
  public let borderBase: Color
  public let borderLight: Color
  public let borderLighter: Color
  public let borderExtraLight: Color
  public let disabledBg: Color
  public let disabledText: Color
  public let disabledBorder: Color
  public let decoration: Color
  public let hoverBg: Color
  public let selected: Color
  public let focus: Color

  public init(
    primary: Color, primaryHover: Color, primaryActive: Color, primaryBg: Color,
    primaryBorder: Color, onPrimary: Color,
    success: Color, successHover: Color, successActive: Color, successBg: Color,
    warning: Color, warningHover: Color, warningActive: Color, warningBg: Color,
    danger: Color, dangerHover: Color, dangerActive: Color, dangerBg: Color,
    info: Color, infoHover: Color, infoActive: Color, infoBg: Color,
    textPrimary: Color, textRegular: Color, textSecondary: Color, textPlaceholder: Color,
    textDisabled: Color,
    backgroundDefault: Color, backgroundPage: Color, backgroundDisabled: Color,
    backgroundOverlay: Color,
    borderBase: Color, borderLight: Color, borderLighter: Color, borderExtraLight: Color,
    disabledBg: Color, disabledText: Color, disabledBorder: Color,
    decoration: Color, hoverBg: Color, selected: Color, focus: Color
  ) {
    self.primary = primary
    self.primaryHover = primaryHover
    self.primaryActive = primaryActive
    self.primaryBg = primaryBg
    self.primaryBorder = primaryBorder
    self.onPrimary = onPrimary
    self.success = success
    self.successHover = successHover
    self.successActive = successActive
    self.successBg = successBg
    self.warning = warning
    self.warningHover = warningHover
    self.warningActive = warningActive
    self.warningBg = warningBg
    self.danger = danger
    self.dangerHover = dangerHover
    self.dangerActive = dangerActive
    self.dangerBg = dangerBg
    self.info = info
    self.infoHover = infoHover
    self.infoActive = infoActive
    self.infoBg = infoBg
    self.textPrimary = textPrimary
    self.textRegular = textRegular
    self.textSecondary = textSecondary
    self.textPlaceholder = textPlaceholder
    self.textDisabled = textDisabled
    self.backgroundDefault = backgroundDefault
    self.backgroundPage = backgroundPage
    self.backgroundDisabled = backgroundDisabled
    self.backgroundOverlay = backgroundOverlay
    self.borderBase = borderBase
    self.borderLight = borderLight
    self.borderLighter = borderLighter
    self.borderExtraLight = borderExtraLight
    self.disabledBg = disabledBg
    self.disabledText = disabledText
    self.disabledBorder = disabledBorder
    self.decoration = decoration
    self.hoverBg = hoverBg
    self.selected = selected
    self.focus = focus
  }
}

/// 明色色板：逐字段取 LhTokens.Color
public let LightLhColors = LhColors(
  primary: LhTokens.Color.Primary.`default`,
  primaryHover: LhTokens.Color.Primary.hover,
  primaryActive: LhTokens.Color.Primary.active,
  primaryBg: LhTokens.Color.Primary.bg,
  primaryBorder: LhTokens.Color.Primary.border,
  onPrimary: LhTokens.Color.onPrimary,
  success: LhTokens.Color.Success.`default`,
  successHover: LhTokens.Color.Success.hover,
  successActive: LhTokens.Color.Success.active,
  successBg: LhTokens.Color.Success.bg,
  warning: LhTokens.Color.Warning.`default`,
  warningHover: LhTokens.Color.Warning.hover,
  warningActive: LhTokens.Color.Warning.active,
  warningBg: LhTokens.Color.Warning.bg,
  danger: LhTokens.Color.Danger.`default`,
  dangerHover: LhTokens.Color.Danger.hover,
  dangerActive: LhTokens.Color.Danger.active,
  dangerBg: LhTokens.Color.Danger.bg,
  info: LhTokens.Color.Info.`default`,
  infoHover: LhTokens.Color.Info.hover,
  infoActive: LhTokens.Color.Info.active,
  infoBg: LhTokens.Color.Info.bg,
  textPrimary: LhTokens.Color.Text.primary,
  textRegular: LhTokens.Color.Text.regular,
  textSecondary: LhTokens.Color.Text.secondary,
  textPlaceholder: LhTokens.Color.Text.placeholder,
  textDisabled: LhTokens.Color.Text.disabled,
  backgroundDefault: LhTokens.Color.Background.`default`,
  backgroundPage: LhTokens.Color.Background.page,
  backgroundDisabled: LhTokens.Color.Background.disabled,
  backgroundOverlay: LhTokens.Color.Background.overlay,
  borderBase: LhTokens.Color.Border.base,
  borderLight: LhTokens.Color.Border.light,
  borderLighter: LhTokens.Color.Border.lighter,
  borderExtraLight: LhTokens.Color.Border.extraLight,
  disabledBg: LhTokens.Color.Disabled.bg,
  disabledText: LhTokens.Color.Disabled.text,
  disabledBorder: LhTokens.Color.Disabled.border,
  decoration: LhTokens.Color.decoration,
  hoverBg: LhTokens.Color.hoverBg,
  selected: LhTokens.Color.selected,
  focus: LhTokens.Color.focus
)

/// 暗色色板：逐字段取 LhDarkTokens.Color（并列对象，仅颜色覆盖）
public let DarkLhColors = LhColors(
  primary: LhDarkTokens.Color.Primary.`default`,
  primaryHover: LhDarkTokens.Color.Primary.hover,
  primaryActive: LhDarkTokens.Color.Primary.active,
  primaryBg: LhDarkTokens.Color.Primary.bg,
  primaryBorder: LhDarkTokens.Color.Primary.border,
  onPrimary: LhDarkTokens.Color.onPrimary,
  success: LhDarkTokens.Color.Success.`default`,
  successHover: LhDarkTokens.Color.Success.hover,
  successActive: LhDarkTokens.Color.Success.active,
  successBg: LhDarkTokens.Color.Success.bg,
  warning: LhDarkTokens.Color.Warning.`default`,
  warningHover: LhDarkTokens.Color.Warning.hover,
  warningActive: LhDarkTokens.Color.Warning.active,
  warningBg: LhDarkTokens.Color.Warning.bg,
  danger: LhDarkTokens.Color.Danger.`default`,
  dangerHover: LhDarkTokens.Color.Danger.hover,
  dangerActive: LhDarkTokens.Color.Danger.active,
  dangerBg: LhDarkTokens.Color.Danger.bg,
  info: LhDarkTokens.Color.Info.`default`,
  infoHover: LhDarkTokens.Color.Info.hover,
  infoActive: LhDarkTokens.Color.Info.active,
  infoBg: LhDarkTokens.Color.Info.bg,
  textPrimary: LhDarkTokens.Color.Text.primary,
  textRegular: LhDarkTokens.Color.Text.regular,
  textSecondary: LhDarkTokens.Color.Text.secondary,
  textPlaceholder: LhDarkTokens.Color.Text.placeholder,
  textDisabled: LhDarkTokens.Color.Text.disabled,
  backgroundDefault: LhDarkTokens.Color.Background.`default`,
  backgroundPage: LhDarkTokens.Color.Background.page,
  backgroundDisabled: LhDarkTokens.Color.Background.disabled,
  backgroundOverlay: LhDarkTokens.Color.Background.overlay,
  borderBase: LhDarkTokens.Color.Border.base,
  borderLight: LhDarkTokens.Color.Border.light,
  borderLighter: LhDarkTokens.Color.Border.lighter,
  borderExtraLight: LhDarkTokens.Color.Border.extraLight,
  disabledBg: LhDarkTokens.Color.Disabled.bg,
  disabledText: LhDarkTokens.Color.Disabled.text,
  disabledBorder: LhDarkTokens.Color.Disabled.border,
  decoration: LhDarkTokens.Color.decoration,
  hoverBg: LhDarkTokens.Color.hoverBg,
  selected: LhDarkTokens.Color.selected,
  focus: LhDarkTokens.Color.focus
)

/// 主题环境键：SwiftUI Environment 注入，未注入时回退明色（缺省即明色）
private struct LhColorsKey: EnvironmentKey {
  static let defaultValue: LhColors = LightLhColors
}

public extension EnvironmentValues {
  var lhColors: LhColors {
    get { self[LhColorsKey.self] }
    set { self[LhColorsKey.self] = newValue }
  }
}

/// 主题容器。一行包裹即让内部所有 Lh 组件消费正确的明/暗色板。
///
/// - Parameters:
///   - isDark: 是否暗色模式。暗色色板取 core 预计算值（无运行时调色，见总纲 R-n6）
///   - colors: 显式覆盖色板（预设主题入口，预留扩展）
public struct LhTheme<Content: View>: View {
  private let colors: LhColors
  private let content: Content

  public init(isDark: Bool = false, colors: LhColors? = nil, @ViewBuilder content: () -> Content) {
    self.colors = colors ?? (isDark ? DarkLhColors : LightLhColors)
    self.content = content()
  }

  public var body: some View {
    content.environment(\.lhColors, colors)
  }
}

/// 当前主题色板
public extension View {
  func lhColors(_ colors: LhColors) -> some View {
    environment(\.lhColors, colors)
  }
}

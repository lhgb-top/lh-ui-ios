import SwiftUI
import LhUITokens

/// 按钮类型。rawValue 与 `lh-ui-core/specs/button.json` 的 prop `type` 枚举值逐字对齐（R-n5）。
///
/// 决定底色与文字色：primary 取主色底 + onPrimary 文字；其余类型取对应语义色。
public enum LhButtonType: String, CaseIterable, Sendable {
  case `default`
  case primary
  case success
  case warning
  case danger
  case info
}

/// 按钮尺寸。rawValue 与 spec 的 prop `size` 枚举值逐字对齐。
///
/// 映射到 button.height / paddingHorizontal / fontSize / iconSize 令牌。
public enum LhButtonSize: String, CaseIterable, Sendable {
  case small
  case medium
  case large
}

/// 按钮外观解析结果：尺寸 + 颜色 + 状态。由 LhButtonStyle.resolveAppearance 纯函数产出，
/// View 只负责把它画出来。分离解析与渲染，是为了让黄金用例（cases/button.json）
/// 能在无模拟器的 XCTest 里断言「type/size/disabled → 令牌」的映射。
public struct LhButtonAppearance: Equatable {
  public let height: CGFloat
  public let paddingHorizontal: CGFloat
  public let fontSize: CGFloat
  public let iconSize: CGFloat
  public let containerColor: Color
  public let contentColor: Color
  public let borderColor: Color
  public let borderWidth: CGFloat
  public let borderRadius: CGFloat
  /// 花纹底纹色；bgPattern=false 时为 nil（不绘制底纹）
  public let patternColor: Color?
  /// 是否可交互（disabled 与 loading 任一为 true 即不可交互，disabled 优先）
  public let enabled: Bool
}

/// 按钮令牌绑定与外观解析（纯函数，无 View 依赖）。
///
/// 令牌映射严格对齐 `lh-ui-core/specs/button.json` 的 behaviors：
/// - disabled 为 true 时：呈现禁用样式（disabled.* 令牌），不触发 onClick
/// - loading 为 true 时：显示加载指示器，不触发 onClick
/// - disabled 与 loading 同时为 true 时按 disabled 优先处理
/// - size 映射：small/medium/large 分别取 button.height.<size> 等尺寸令牌
/// - type 映射：primary 取主色底 + onPrimary 文字；其余类型取对应语义色
/// - bgPattern 为 true 时以 color.decoration 绘制底纹，不影响文字对比度
public enum LhButtonStyle {
  /// 解析按钮外观（黄金用例的断言入口）
  public static func resolveAppearance(
    type: LhButtonType,
    size: LhButtonSize,
    disabled: Bool,
    loading: Bool,
    bgPattern: Bool,
    colors: LhColors
  ) -> LhButtonAppearance {
    // 状态 gate：disabled 优先于 loading（黄金用例 disabled-precedes-loading）
    let enabled = !disabled && !loading

    // type → 底色 / 文字色 / 描边色（禁用态覆盖）
    let container: Color
    let content: Color
    let border: Color
    if !enabled {
      container = colors.disabledBg
      content = colors.disabledText
      border = colors.disabledBorder
    } else {
      switch type {
      case .default:
        container = colors.backgroundDefault
        content = colors.textPrimary
        border = colors.borderBase
      case .primary:
        container = colors.primary
        content = colors.onPrimary
        border = .clear
      case .success:
        container = colors.success
        content = colors.onPrimary
        border = .clear
      case .warning:
        container = colors.warning
        content = colors.onPrimary
        border = .clear
      case .danger:
        container = colors.danger
        content = colors.onPrimary
        border = .clear
      case .info:
        container = colors.info
        content = colors.onPrimary
        border = .clear
      }
    }

    // size → 尺寸令牌（CGFloat，单位 pt）
    let height: CGFloat
    let paddingHorizontal: CGFloat
    let fontSize: CGFloat
    let iconSize: CGFloat
    switch size {
    case .small:
      height = LhTokens.Button.Height.small
      paddingHorizontal = LhTokens.Button.PaddingHorizontal.small
      fontSize = LhTokens.Button.FontSize.small
      iconSize = LhTokens.Button.IconSize.small
    case .medium:
      height = LhTokens.Button.Height.medium
      paddingHorizontal = LhTokens.Button.PaddingHorizontal.medium
      fontSize = LhTokens.Button.FontSize.medium
      iconSize = LhTokens.Button.IconSize.medium
    case .large:
      height = LhTokens.Button.Height.large
      paddingHorizontal = LhTokens.Button.PaddingHorizontal.large
      fontSize = LhTokens.Button.FontSize.large
      iconSize = LhTokens.Button.IconSize.large
    }

    return LhButtonAppearance(
      height: height,
      paddingHorizontal: paddingHorizontal,
      fontSize: fontSize,
      iconSize: iconSize,
      containerColor: container,
      contentColor: content,
      borderColor: border,
      borderWidth: LhTokens.Button.borderWidth,
      borderRadius: LhTokens.Button.borderRadius,
      patternColor: bgPattern ? colors.decoration : nil,
      enabled: enabled
    )
  }

  /// 图标名 → SF Symbol 的本地映射（spec：icon 是图标名，各端按本地图标体系渲染）。
  /// 未登记的图标名返回 nil（不绘制），不崩溃。
  public static func icon(for name: String?) -> String? {
    guard let name else { return nil }
    let symbols = [
      "search": "magnifyingglass",
      "refresh": "arrow.clockwise",
      "check": "checkmark",
      "close": "xmark",
    ]
    return symbols[name]
  }
}

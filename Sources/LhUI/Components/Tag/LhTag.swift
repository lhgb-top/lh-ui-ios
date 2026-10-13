import SwiftUI
import LhUITokens

/// 标签类型。rawValue 与 spec 的 prop `type` 枚举值逐字对齐（R-n5）。
public enum LhTagType: String, CaseIterable, Sendable {
  case `default`
  case primary
  case success
  case warning
  case danger
  case info
}

/// 标签尺寸。rawValue 与 spec 的 prop `size` 枚举值逐字对齐。
public enum LhTagSize: String, CaseIterable, Sendable {
  case small
  case medium
  case large
}

/// 标签外观解析结果。由 LhTagStyle.resolveAppearance 纯函数产出，供 XCTest 断言。
public struct LhTagAppearance: Equatable {
  public let height: CGFloat
  public let paddingHorizontal: CGFloat
  public let fontSize: CGFloat
  public let borderRadius: CGFloat
  public let borderWidth: CGFloat
  public let containerColor: Color
  public let contentColor: Color
  public let borderColor: Color
  /// 关闭符尺寸（与文字同高，视觉对齐）
  public let closeIconSize: CGFloat
  /// 关闭符与文字之间的间距（spacing.xs）
  public let closeGap: CGFloat
}

/// 标签令牌绑定与外观解析（纯函数，无 View 依赖）。
///
/// 令牌映射严格对齐 `lh-ui-core/specs/tag.json` 的 behaviors：
/// - size 映射：small/medium/large 分别取 tag.height.<size> 等尺寸令牌
/// - plain 为 false 时：default 类型取 backgroundDefault 底 + textPrimary 字 +
///   borderBase 描边；其余类型取语义色实心底 + onPrimary 字、无描边
/// - plain 为 true 时：default 类型同上；其余类型取语义 bg 浅底 + 语义 default 字 +
///   语义 default 描边
/// - round 为 true 时圆角取高度一半，否则取 tag.borderRadius
public enum LhTagStyle {
  public static func resolveAppearance(
    type: LhTagType,
    size: LhTagSize,
    plain: Bool,
    round: Bool,
    colors: LhColors
  ) -> LhTagAppearance {
    // size → 尺寸令牌（CGFloat，单位 pt）
    let height: CGFloat
    let paddingHorizontal: CGFloat
    let fontSize: CGFloat
    switch size {
    case .small:
      height = LhTokens.Tag.Height.small
      paddingHorizontal = LhTokens.Tag.PaddingHorizontal.small
      fontSize = LhTokens.Tag.FontSize.small
    case .medium:
      height = LhTokens.Tag.Height.medium
      paddingHorizontal = LhTokens.Tag.PaddingHorizontal.medium
      fontSize = LhTokens.Tag.FontSize.medium
    case .large:
      height = LhTokens.Tag.Height.large
      paddingHorizontal = LhTokens.Tag.PaddingHorizontal.large
      fontSize = LhTokens.Tag.FontSize.large
    }

    // type × plain → 底色 / 文字色 / 描边色
    let container: Color
    let content: Color
    let border: Color
    switch type {
    case .default:
      // default 类型不区分 plain：中性底 + 主要文字 + 基础描边
      container = colors.backgroundDefault
      content = colors.textPrimary
      border = colors.borderBase
    case .primary:
      if plain {
        container = colors.primaryBg
        content = colors.primary
        border = colors.primary
      } else {
        container = colors.primary
        content = colors.onPrimary
        border = .clear
      }
    case .success:
      if plain {
        container = colors.successBg
        content = colors.success
        border = colors.success
      } else {
        container = colors.success
        content = colors.onPrimary
        border = .clear
      }
    case .warning:
      if plain {
        container = colors.warningBg
        content = colors.warning
        border = colors.warning
      } else {
        container = colors.warning
        content = colors.onPrimary
        border = .clear
      }
    case .danger:
      if plain {
        container = colors.dangerBg
        content = colors.danger
        border = colors.danger
      } else {
        container = colors.danger
        content = colors.onPrimary
        border = .clear
      }
    case .info:
      if plain {
        container = colors.infoBg
        content = colors.info
        border = colors.info
      } else {
        container = colors.info
        content = colors.onPrimary
        border = .clear
      }
    }

    return LhTagAppearance(
      height: height,
      paddingHorizontal: paddingHorizontal,
      fontSize: fontSize,
      // round 态圆角为高度一半（黄金用例 round-makes-radius-half-height）
      borderRadius: round ? height / 2 : LhTokens.Tag.borderRadius,
      borderWidth: LhTokens.Tag.borderWidth,
      containerColor: container,
      contentColor: content,
      borderColor: border,
      closeIconSize: fontSize,
      closeGap: LhTokens.Spacing.xs
    )
  }
}

/// 标签组件：小体积状态标记。
///
/// props 与 `lh-ui-core/specs/tag.json` 逐字对齐；行为遵循 `cases/tag.json`
/// 的 6 条黄金用例（已翻译为 XCTest，见 Tests/LhUITests/LhTagTests.swift）。
public struct LhTag: View {
  /// 标签文字（spec 的 default 插槽）
  private let label: Text
  /// 语义类型，决定底色、文字色与描边色
  public var type: LhTagType = .default
  /// 标签尺寸，映射到 tag.height / paddingHorizontal / fontSize 令牌
  public var size: LhTagSize = .medium
  /// 是否为浅底描边形态
  public var plain: Bool = false
  /// 是否为胶囊形态（圆角取高度一半）
  public var round: Bool = false
  /// 是否显示关闭符；点击关闭符触发 onClose
  public var closable: Bool = false
  /// 点击关闭符回调
  public var onClose: (() -> Void)? = nil

  @Environment(\.lhColors) private var colors

  public init(
    type: LhTagType = .default,
    size: LhTagSize = .medium,
    plain: Bool = false,
    round: Bool = false,
    closable: Bool = false,
    onClose: (() -> Void)? = nil,
    label: Text
  ) {
    self.type = type
    self.size = size
    self.plain = plain
    self.round = round
    self.closable = closable
    self.onClose = onClose
    self.label = label
  }

  /// 便捷初始化：直接传字符串文字
  public init(
    _ text: some StringProtocol,
    type: LhTagType = .default,
    size: LhTagSize = .medium,
    plain: Bool = false,
    round: Bool = false,
    closable: Bool = false,
    onClose: (() -> Void)? = nil
  ) {
    self.init(
      type: type, size: size, plain: plain, round: round, closable: closable,
      onClose: onClose, label: Text(text)
    )
  }

  public var body: some View {
    let appearance = LhTagStyle.resolveAppearance(
      type: type, size: size, plain: plain, round: round, colors: colors
    )

    return HStack(spacing: appearance.closeGap) {
      label
        .font(.system(size: appearance.fontSize, weight: Self.fontWeight(LhTokens.Typography.FontWeight.primary)))
      if closable {
        Image(systemName: "xmark")
          .resizable()
          .scaledToFit()
          .frame(width: appearance.closeIconSize, height: appearance.closeIconSize)
          .foregroundColor(appearance.contentColor)
          .contentShape(Rectangle())
          .onTapGesture {
            // 关闭符区域命中触发 onClose（黄金用例 closable-tap-emits-onclose）
            onClose?()
          }
      }
    }
    .padding(.horizontal, appearance.paddingHorizontal)
    .frame(height: appearance.height)
    .background(
      RoundedRectangle(cornerRadius: appearance.borderRadius)
        .fill(appearance.containerColor)
    )
    .overlay(
      RoundedRectangle(cornerRadius: appearance.borderRadius)
        .stroke(appearance.borderColor, lineWidth: appearance.borderWidth)
    )
    .foregroundColor(appearance.contentColor)
    .accessibilityElement(children: .combine)
  }

  /// 字重令牌（Int）→ SwiftUI Font.Weight（与 LhButton 同一映射，端侧约定）
  private static func fontWeight(_ weight: Int) -> Font.Weight {
    switch weight {
    case ..<500: return .regular
    case 500..<650: return .semibold
    default: return .bold
    }
  }
}

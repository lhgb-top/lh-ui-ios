import SwiftUI
import LhUITokens

/// 字号级别。rawValue 与 spec 的 prop `level` 枚举值逐字对齐（R-n5）。
/// 映射到 typography.fontSize.<level> 令牌。
public enum LhTextLevel: String, CaseIterable, Sendable {
  case extraLarge
  case large
  case medium
  case base
  case small
  case extraSmall
}

/// 字重。rawValue 与 spec 的 prop `weight` 枚举值逐字对齐。
/// 映射到 typography.fontWeight.<weight> 令牌。
public enum LhTextWeight: String, CaseIterable, Sendable {
  case primary
  case bold
}

/// 文字色调。rawValue 与 spec 的 prop `tone` 枚举值逐字对齐。
/// 映射到 color.text.<tone> 令牌；selected 取 color.selected。
public enum LhTextTone: String, CaseIterable, Sendable {
  case primary
  case regular
  case secondary
  case placeholder
  case disabled
  case selected
}

/// 水平对齐方式。rawValue 与 spec 的 prop `lhAlign` 枚举值逐字对齐。
public enum LhTextAlign: String, CaseIterable, Sendable {
  case start
  case center
  case end
}

/// 文本外观解析结果。由 LhTextStyle.resolveAppearance 纯函数产出，供 XCTest 断言。
public struct LhTextAppearance: Equatable {
  /// 字号（typography.fontSize.<level> 令牌）
  public let fontSize: CGFloat
  /// 行高 = 字号 × typography.lineHeight.primary
  public let lineHeight: CGFloat
  /// 字重（typography.fontWeight.<weight> 令牌的 Int 值）
  public let fontWeight: Int
  /// 文字色（color.text.<tone> 或 color.selected 令牌）
  public let textColor: Color
}

/// 文本令牌绑定与外观解析（纯函数，无 View 依赖）。
///
/// 令牌映射严格对齐 `lh-ui-core/specs/text.json` 的 behaviors：
/// - level 映射：extraLarge/large/medium/base/small/extraSmall 分别取 typography.fontSize.<level>
/// - weight 映射：primary/bold 分别取 typography.fontWeight.<weight>
/// - tone 映射：取 color.text.<tone>；selected 取 color.selected
/// - 行高取 typography.lineHeight.primary（lineHeight = fontSize × lineHeight.primary）
public enum LhTextStyle {
  public static func resolveAppearance(
    level: LhTextLevel,
    weight: LhTextWeight,
    tone: LhTextTone,
    colors: LhColors
  ) -> LhTextAppearance {
    let fontSize: CGFloat
    switch level {
    case .extraLarge: fontSize = LhTokens.Typography.FontSize.extraLarge
    case .large: fontSize = LhTokens.Typography.FontSize.large
    case .medium: fontSize = LhTokens.Typography.FontSize.medium
    case .base: fontSize = LhTokens.Typography.FontSize.base
    case .small: fontSize = LhTokens.Typography.FontSize.small
    case .extraSmall: fontSize = LhTokens.Typography.FontSize.extraSmall
    }

    let fontWeight: Int
    switch weight {
    case .primary: fontWeight = LhTokens.Typography.FontWeight.primary
    case .bold: fontWeight = LhTokens.Typography.FontWeight.bold
    }

    let textColor: Color
    switch tone {
    case .primary: textColor = colors.textPrimary
    case .regular: textColor = colors.textRegular
    case .secondary: textColor = colors.textSecondary
    case .placeholder: textColor = colors.textPlaceholder
    case .disabled: textColor = colors.textDisabled
    case .selected: textColor = colors.selected
    }

    // 行高 = 字号 × typography.lineHeight.primary（pt × 无量纲倍数）
    let lineHeight = fontSize * CGFloat(LhTokens.Typography.LineHeight.primary)

    return LhTextAppearance(
      fontSize: fontSize,
      lineHeight: lineHeight,
      fontWeight: fontWeight,
      textColor: textColor
    )
  }
}

/// 文本组件：消费全局排版令牌的展示型原语。
///
/// props 与 `lh-ui-core/specs/text.json` 逐字对齐；行为遵循 `cases/text.json`
/// 的 5 条黄金用例（已翻译为 XCTest，见 Tests/LhUITests/LhTextTests.swift）。
public struct LhText: View {
  /// 文本内容（spec 的 default 插槽）
  private let content: String
  /// 字号级别，映射到 typography.fontSize.<level> 令牌
  public var level: LhTextLevel = .base
  /// 字重，映射到 typography.fontWeight.<weight> 令牌
  public var weight: LhTextWeight = .primary
  /// 文字色调，映射到 color.text.<tone> 或 color.selected 令牌
  public var tone: LhTextTone = .primary
  /// 水平对齐方式
  public var lhAlign: LhTextAlign = .start

  @Environment(\.lhColors) private var colors

  public init(
    _ content: String,
    level: LhTextLevel = .base,
    weight: LhTextWeight = .primary,
    tone: LhTextTone = .primary,
    lhAlign: LhTextAlign = .start
  ) {
    self.content = content
    self.level = level
    self.weight = weight
    self.tone = tone
    self.lhAlign = lhAlign
  }

  public var body: some View {
    let appearance = LhTextStyle.resolveAppearance(
      level: level, weight: weight, tone: tone, colors: colors
    )

    let alignment: TextAlignment
    switch lhAlign {
    case .start: alignment = .leading
    case .center: alignment = .center
    case .end: alignment = .trailing
    }

    // spec：layout 高度 = 字号 × 行高；frame 锁定行盒，alignment 在其内对齐
    return Text(content)
      .font(.system(size: appearance.fontSize, weight: Self.fontWeight(appearance.fontWeight)))
      .foregroundColor(appearance.textColor)
      .frame(height: appearance.lineHeight, alignment: alignment)
      .frame(maxWidth: .infinity, alignment: alignment)
      .accessibilityLabel(content)
  }

  /// 字重令牌（Int）→ SwiftUI Font.Weight（与 LhTag 同一映射，端侧约定）
  private static func fontWeight(_ weight: Int) -> Font.Weight {
    switch weight {
    case ..<500: return .regular
    case 500..<650: return .semibold
    default: return .bold
    }
  }
}

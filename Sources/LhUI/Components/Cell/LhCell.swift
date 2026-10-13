import SwiftUI
import LhUITokens

/// 单元格外观解析结果。由 LhCellStyle.resolveAppearance 纯函数产出，供 XCTest 断言。
public struct LhCellAppearance: Equatable {
  public let paddingHorizontal: CGFloat
  public let paddingVertical: CGFloat
  public let gap: CGFloat
  public let iconSize: CGFloat
  public let titleFontSize: CGFloat
  public let labelFontSize: CGFloat
  public let valueFontSize: CGFloat
  /// 行高（typography.lineHeight.primary）折算成的行间距
  public let lineSpacing: CGFloat
  public let titleColor: Color
  public let labelColor: Color
  public let valueColor: Color
  public let requiredColor: Color
  public let iconColor: Color
  public let arrowColor: Color
  public let borderColor: Color
  public let borderWidth: CGFloat
  /// 右侧指示箭头尺寸（与说明文字同高，视觉对齐）
  public let arrowSize: CGFloat
  /// 必填红星与标题的间距（spacing.xs）
  public let requiredGap: CGFloat
  /// 是否响应点击（clickable 为 true 时）
  public let clickable: Bool
}

/// 单元格令牌绑定与外观解析（纯函数，无 View 依赖）。
///
/// 令牌映射严格对齐 `lh-ui-core/specs/cell.json` 的 behaviors：
/// - 标题取 cell.fontSizeTitle + color.text.primary；说明取 cell.fontSizeLabel +
///   color.text.secondary；值取 cell.fontSizeValue + color.text.secondary 并右对齐
/// - required 为 true 时标题前置红星（color.danger.default）
/// - icon 非空时左侧绘制尺寸 icon.size.medium 的图标
/// - clickable 为 true 时右侧绘制指示箭头并响应点击
/// - bordered 为 true 时底部绘制分隔线（color.border.lighter）
public enum LhCellStyle {
  public static func resolveAppearance(
    clickable: Bool,
    colors: LhColors
  ) -> LhCellAppearance {
    let titleFontSize = LhTokens.Cell.fontSizeTitle
    let lineSpacing = titleFontSize * CGFloat(LhTokens.Typography.LineHeight.primary - 1)

    return LhCellAppearance(
      paddingHorizontal: LhTokens.Cell.paddingHorizontal,
      paddingVertical: LhTokens.Cell.paddingVertical,
      gap: LhTokens.Cell.gap,
      iconSize: LhTokens.Icon.Size.medium,
      titleFontSize: titleFontSize,
      labelFontSize: LhTokens.Cell.fontSizeLabel,
      valueFontSize: LhTokens.Cell.fontSizeValue,
      lineSpacing: lineSpacing,
      titleColor: colors.textPrimary,
      labelColor: colors.textSecondary,
      valueColor: colors.textSecondary,
      requiredColor: colors.danger,
      iconColor: colors.textPrimary,
      arrowColor: colors.textSecondary,
      borderColor: colors.borderLighter,
      borderWidth: LhTokens.Cell.borderWidth,
      arrowSize: LhTokens.Cell.fontSizeLabel,
      requiredGap: LhTokens.Spacing.xs,
      clickable: clickable
    )
  }
}

/// 单元格组件：列表行。
///
/// props 与 `lh-ui-core/specs/cell.json` 逐字对齐；行为遵循 `cases/cell.json`
/// 的 6 条黄金用例（已翻译为 XCTest，见 Tests/LhUITests/LhCellTests.swift）。
public struct LhCell: View {
  /// 标题（主文字）
  public var title: String
  /// 右侧值（次文字，右对齐）
  public var value: String = ""
  /// 标题下方的说明文字
  public var label: String = ""
  /// 是否绘制底部分隔线
  public var bordered: Bool = true
  /// 是否可点击；为 true 时显示右侧指示箭头并响应点击
  public var clickable: Bool = false
  /// 是否在标题前显示必填红星（取 color.danger.default）
  public var required: Bool = false
  /// 左侧图标名（本地图标体系，见 LhIconMap）
  public var icon: String? = nil
  /// 点击回调；clickable 为 false 时不触发
  public var onClick: (() -> Void)? = nil

  @Environment(\.lhColors) private var colors

  public init(
    title: String,
    value: String = "",
    label: String = "",
    bordered: Bool = true,
    clickable: Bool = false,
    required: Bool = false,
    icon: String? = nil,
    onClick: (() -> Void)? = nil
  ) {
    self.title = title
    self.value = value
    self.label = label
    self.bordered = bordered
    self.clickable = clickable
    self.required = required
    self.icon = icon
    self.onClick = onClick
  }

  public var body: some View {
    let appearance = LhCellStyle.resolveAppearance(clickable: clickable, colors: colors)

    return HStack(alignment: .center, spacing: appearance.gap) {
      if let iconName = icon {
        LhIcon(name: iconName, size: .medium)
          .frame(width: appearance.iconSize, height: appearance.iconSize)
          .foregroundColor(appearance.iconColor)
      }

      // 左侧：标题行（含必填红星）+ 可选说明行
      VStack(alignment: .leading, spacing: appearance.gap) {
        HStack(spacing: appearance.requiredGap) {
          if required {
            Text("*")
              .font(.system(size: appearance.titleFontSize))
              .foregroundColor(appearance.requiredColor)
          }
          Text(title)
            .font(.system(size: appearance.titleFontSize, weight: Self.fontWeight(LhTokens.Typography.FontWeight.primary)))
            .foregroundColor(appearance.titleColor)
            .lineSpacing(appearance.lineSpacing)
        }
        if !label.isEmpty {
          Text(label)
            .font(.system(size: appearance.labelFontSize))
            .foregroundColor(appearance.labelColor)
            .lineSpacing(appearance.lineSpacing)
        }
      }

      Spacer()

      if !value.isEmpty {
        Text(value)
          .font(.system(size: appearance.valueFontSize))
          .foregroundColor(appearance.valueColor)
      }

      if clickable {
        // 指示箭头（chevron，两条折线的 SwiftUI 落地）
        Image(systemName: "chevron.right")
          .resizable()
          .scaledToFit()
          .frame(width: appearance.arrowSize, height: appearance.arrowSize)
          .foregroundColor(appearance.arrowColor)
      }
    }
    .padding(.horizontal, appearance.paddingHorizontal)
    .padding(.vertical, appearance.paddingVertical)
    .background(colors.backgroundDefault)
    .overlay(alignment: .bottom) {
      // 底部分隔线（黄金用例 bordered-emits-line-command）
      if bordered {
        Rectangle()
          .fill(appearance.borderColor)
          .frame(height: appearance.borderWidth)
      }
    }
    .contentShape(Rectangle())
    .onTapGesture {
      // 状态 gate：clickable 为 false 时不触发（黄金用例 not-clickable-no-onclick）
      if appearance.clickable {
        onClick?()
      }
    }
    .accessibilityElement(children: .combine)
    .accessibilityAddTraits(clickable ? .isButton : [])
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

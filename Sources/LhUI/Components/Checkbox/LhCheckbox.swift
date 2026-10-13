import SwiftUI
import LhUITokens

/// 复选框尺寸。rawValue 与 spec 的 prop `size` 枚举值逐字对齐。
public enum LhCheckboxSize: String, CaseIterable, Sendable {
  case small
  case medium
  case large
}

/// 复选框指示符形态：勾形（选中）或横杠（不确定）。
public enum LhCheckboxMark: Equatable, Sendable {
  case none
  case checkmark
  case dash
}

/// 复选框外观解析结果。由 LhCheckboxStyle.resolveAppearance 纯函数产出，供 XCTest 断言。
public struct LhCheckboxAppearance: Equatable {
  public let size: CGFloat
  public let borderRadius: CGFloat
  public let borderWidth: CGFloat
  public let checkWidth: CGFloat
  /// 不确定态横杠相对方框的宽度比例
  public let dashScale: CGFloat
  public let gap: CGFloat
  public let boxColor: Color
  public let borderColor: Color
  public let markColor: Color
  public let textColor: Color
  /// 当前指示符形态
  public let mark: LhCheckboxMark
  /// 是否可交互（disabled 为 true 时不可交互）
  public let enabled: Bool
  /// 点击后的新选中态（外观层不持状态，这里记录「点击会变成什么」供测试断言）
  public let nextChecked: Bool
}

/// 复选框令牌绑定与外观解析（纯函数，无 View 依赖）。
///
/// 令牌映射严格对齐 `lh-ui-core/specs/checkbox.json` 的 behaviors：
/// - size 映射：small/medium/large 分别取 checkbox.size.<size> 方框尺寸令牌
/// - 未选中：只描边（color.border.base），无填充
/// - 选中/不确定：实心 primary 底 + onPrimary 指示符；选中画勾形，不确定画横杠
/// - disabled：底/边/指示符/文字全部取 disabled.* 令牌，且不响应点击
/// - 点击命中整个行：indeterminate 变为选中，否则翻转选中态，触发 onChange 携带新选中态
/// - 方框与文字间距取 checkbox.gap
public enum LhCheckboxStyle {
  public static func resolveAppearance(
    checked: Bool,
    indeterminate: Bool,
    disabled: Bool,
    size: LhCheckboxSize,
    colors: LhColors
  ) -> LhCheckboxAppearance {
    let enabled = !disabled

    // 指示符形态（未选中无指示符）
    let mark: LhCheckboxMark
    if indeterminate {
      mark = .dash
    } else if checked {
      mark = .checkmark
    } else {
      mark = .none
    }

    // 颜色（禁用态覆盖）
    let box: Color
    let border: Color
    let markColor: Color
    let text: Color
    if !enabled {
      box = colors.disabledBg
      border = colors.disabledBorder
      markColor = colors.disabledText
      text = colors.textDisabled
    } else if mark != .none {
      box = colors.primary
      border = .clear
      markColor = colors.onPrimary
      text = colors.textPrimary
    } else {
      box = .clear
      border = colors.borderBase
      markColor = .clear
      text = colors.textPrimary
    }

    // size → 尺寸令牌
    let dimension: CGFloat
    switch size {
    case .small: dimension = LhTokens.Checkbox.Size.small
    case .medium: dimension = LhTokens.Checkbox.Size.medium
    case .large: dimension = LhTokens.Checkbox.Size.large
    }

    return LhCheckboxAppearance(
      size: dimension,
      borderRadius: LhTokens.Checkbox.borderRadius,
      borderWidth: LhTokens.Checkbox.borderWidth,
      checkWidth: LhTokens.Checkbox.checkWidth,
      dashScale: CGFloat(LhTokens.Checkbox.dashScale),
      gap: LhTokens.Checkbox.gap,
      boxColor: box,
      borderColor: border,
      markColor: markColor,
      textColor: text,
      mark: mark,
      enabled: enabled,
      // 黄金用例 indeterminate-becomes-checked：不确定态点击后变为选中
      nextChecked: indeterminate ? true : !checked
    )
  }
}

/// 复选框组件：三态选中控件。
///
/// props 与 `lh-ui-core/specs/checkbox.json` 逐字对齐；行为遵循 `cases/checkbox.json`
/// 的 6 条黄金用例（已翻译为 XCTest，见 Tests/LhUITests/LhCheckboxTests.swift）。
public struct LhCheckbox: View {
  /// 是否选中（受控）
  @Binding public var checked: Bool
  /// 是否为不确定态（横杠指示）；点击后变为选中
  public var indeterminate: Bool = false
  /// 是否禁用；禁用时不响应点击且呈现禁用样式
  public var disabled: Bool = false
  /// 方框尺寸，映射到 checkbox.size.* 令牌
  public var size: LhCheckboxSize = .medium
  /// 文字标签（绘制在方框右侧）
  public var label: String = ""
  /// 选中态变化回调，携带新选中态
  public var onChange: ((Bool) -> Void)? = nil

  @Environment(\.lhColors) private var colors

  public init(
    checked: Binding<Bool>,
    indeterminate: Bool = false,
    disabled: Bool = false,
    size: LhCheckboxSize = .medium,
    label: String = "",
    onChange: ((Bool) -> Void)? = nil
  ) {
    self._checked = checked
    self.indeterminate = indeterminate
    self.disabled = disabled
    self.size = size
    self.label = label
    self.onChange = onChange
  }

  public var body: some View {
    let appearance = LhCheckboxStyle.resolveAppearance(
      checked: checked, indeterminate: indeterminate, disabled: disabled,
      size: size, colors: colors
    )

    return HStack(spacing: appearance.gap) {
      ZStack {
        RoundedRectangle(cornerRadius: appearance.borderRadius)
          .fill(appearance.boxColor)
        RoundedRectangle(cornerRadius: appearance.borderRadius)
          .stroke(appearance.borderColor, lineWidth: appearance.borderWidth)
        switch appearance.mark {
        case .none:
          EmptyView()
        case .checkmark:
          // 勾形（两条折线）
          LhCheckmarkShape()
            .stroke(appearance.markColor, style: StrokeStyle(lineWidth: appearance.checkWidth, lineCap: .round, lineJoin: .round))
        case .dash:
          // 横杠
          Capsule()
            .fill(appearance.markColor)
            // 横杠高度与勾形描边同粗，宽度按 dashScale 令牌取方框比例
            .frame(width: appearance.size * appearance.dashScale, height: appearance.checkWidth)
        }
      }
      .frame(width: appearance.size, height: appearance.size)

      if !label.isEmpty {
        Text(label)
          .font(.system(size: LhTokens.Cell.fontSizeTitle, weight: Self.fontWeight(LhTokens.Typography.FontWeight.primary)))
          .foregroundColor(appearance.textColor)
      }
    }
    .contentShape(Rectangle())
    .onTapGesture {
      // 状态 gate：禁用不触发；不确定态点击后变为选中，否则翻转（黄金用例）
      guard appearance.enabled else { return }
      checked = appearance.nextChecked
      onChange?(appearance.nextChecked)
    }
    .accessibilityElement(children: .combine)
    .accessibilityAddTraits(appearance.enabled ? .isButton : [])
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

/// 勾形：两条折线（落到方框内切区域）。
/// 命名规范（总纲 D20）：自有类型一律 Lh 前缀。
private struct LhCheckmarkShape: Shape {
  func path(in rect: CGRect) -> Path {
    var path = Path()
    // 短折：左中 → 中下；长折：中下 → 右上
    path.move(to: CGPoint(x: rect.minX + rect.width * 0.18, y: rect.minY + rect.height * 0.52))
    path.addLine(to: CGPoint(x: rect.minX + rect.width * 0.42, y: rect.minY + rect.height * 0.74))
    path.addLine(to: CGPoint(x: rect.minX + rect.width * 0.82, y: rect.minY + rect.height * 0.28))
    return path
  }
}

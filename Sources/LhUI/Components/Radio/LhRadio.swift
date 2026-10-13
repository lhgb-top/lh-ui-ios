import SwiftUI
import LhUITokens

/// 单选框尺寸。rawValue 与 spec 的 prop `size` 枚举值逐字对齐。
public enum LhRadioSize: String, CaseIterable, Sendable {
  case small
  case medium
  case large
}

/// 单选框外观解析结果。由 LhRadioStyle.resolveAppearance 纯函数产出，供 XCTest 断言。
public struct LhRadioAppearance: Equatable {
  public let size: CGFloat
  public let ringWidth: CGFloat
  /// 内圆点相对外环直径的比例（radio.dotScale 令牌）
  public let dotScale: CGFloat
  public let gap: CGFloat
  public let ringColor: Color
  public let dotColor: Color
  public let textColor: Color
  /// 是否绘制内圆点（选中时）
  public let showsDot: Bool
  /// 是否可交互（disabled 为 true 时不可交互）
  public let enabled: Bool
}

/// 单选框令牌绑定与外观解析（纯函数，无 View 依赖）。
///
/// 令牌映射严格对齐 `lh-ui-core/specs/radio.json` 的 behaviors：
/// - size 映射：small/medium/large 分别取 radio.size.<size> 圆环尺寸令牌
/// - 外环描边：未选中取 color.border.base，选中取 color.primary.default，描边宽 radio.ringWidth
/// - 选中时内部画实心圆点，直径 = 尺寸 × radio.dotScale，取 color.primary.default
/// - disabled：外环取 color.disabled.border，圆点取 color.disabled.text，文字取 color.text.disabled
/// - 圆环与文字间距取 radio.gap
public enum LhRadioStyle {
  public static func resolveAppearance(
    checked: Bool,
    disabled: Bool,
    size: LhRadioSize,
    colors: LhColors
  ) -> LhRadioAppearance {
    let enabled = !disabled

    let ring: Color
    let dot: Color
    let text: Color
    if !enabled {
      ring = colors.disabledBorder
      dot = colors.disabledText
      text = colors.textDisabled
    } else if checked {
      ring = colors.primary
      dot = colors.primary
      text = colors.textPrimary
    } else {
      ring = colors.borderBase
      dot = .clear
      text = colors.textPrimary
    }

    let dimension: CGFloat
    switch size {
    case .small: dimension = LhTokens.Radio.Size.small
    case .medium: dimension = LhTokens.Radio.Size.medium
    case .large: dimension = LhTokens.Radio.Size.large
    }

    return LhRadioAppearance(
      size: dimension,
      ringWidth: LhTokens.Radio.ringWidth,
      dotScale: CGFloat(LhTokens.Radio.dotScale),
      gap: LhTokens.Radio.gap,
      ringColor: ring,
      dotColor: dot,
      textColor: text,
      showsDot: checked,
      enabled: enabled
    )
  }
}

/// 单选框组件：圆环选中控件。
///
/// props 与 `lh-ui-core/specs/radio.json` 逐字对齐；行为遵循 `cases/radio.json`
/// 的 6 条黄金用例（已翻译为 XCTest，见 Tests/LhUITests/LhRadioTests.swift）。
/// 组件本身不含组逻辑（单选组由宿主维护，spec 的 value prop 是组内标识）。
public struct LhRadio: View {
  /// 是否选中（受控）
  @Binding public var checked: Bool
  /// 是否禁用；禁用时不响应点击且呈现禁用样式
  public var disabled: Bool = false
  /// 文字标签（绘制在圆环右侧）
  public var label: String = ""
  /// 单选值（组内标识，组件本身不含组逻辑）
  public var value: String = ""
  /// 圆环尺寸，映射到 radio.size.* 令牌
  public var size: LhRadioSize = .medium
  /// 选中态变化回调，携带新选中态（仅可能为 true）
  public var onChange: ((Bool) -> Void)? = nil

  @Environment(\.lhColors) private var colors

  public init(
    checked: Binding<Bool>,
    disabled: Bool = false,
    label: String = "",
    value: String = "",
    size: LhRadioSize = .medium,
    onChange: ((Bool) -> Void)? = nil
  ) {
    self._checked = checked
    self.disabled = disabled
    self.label = label
    self.value = value
    self.size = size
    self.onChange = onChange
  }

  public var body: some View {
    let appearance = LhRadioStyle.resolveAppearance(
      checked: checked, disabled: disabled, size: size, colors: colors
    )

    return HStack(spacing: appearance.gap) {
      ZStack {
        Circle()
          .stroke(appearance.ringColor, lineWidth: appearance.ringWidth)
        if appearance.showsDot {
          // 实心圆点，直径 = 尺寸 × radio.dotScale
          Circle()
            .fill(appearance.dotColor)
            .frame(width: appearance.size * appearance.dotScale, height: appearance.size * appearance.dotScale)
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
      // 状态 gate：已选中时点击不触发，disabled 时不触发（黄金用例前两条 + 第三条）
      guard appearance.enabled, !checked else { return }
      checked = true
      onChange?(true)
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

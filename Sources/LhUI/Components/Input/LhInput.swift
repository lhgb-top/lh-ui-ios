import SwiftUI
import LhUITokens

/// 输入框尺寸。rawValue 与 spec 的 prop `size` 枚举值逐字对齐。
public enum LhInputSize: String, CaseIterable, Sendable {
  case small
  case medium
  case large
}

/// 输入框类型。rawValue 与 spec 的 prop `type` 枚举值逐字对齐。
public enum LhInputType: String, CaseIterable, Sendable {
  case text
  case password
}

/// 输入框外观解析结果。由 LhInputStyle.resolveAppearance 纯函数产出，供 XCTest 断言。
public struct LhInputAppearance: Equatable {
  public let height: CGFloat
  public let paddingHorizontal: CGFloat
  public let fontSize: CGFloat
  public let borderRadius: CGFloat
  public let borderWidth: CGFloat
  public let focusRingWidth: CGFloat
  public let clearIconSize: CGFloat
  public let textColor: Color
  public let placeholderColor: Color
  public let containerColor: Color
  public let borderColor: Color
  /// 是否可交互（disabled 或 readonly 为 true 时不可输入）
  public let editable: Bool
  /// 是否以圆点掩码显示文本
  public let isSecure: Bool
  /// 是否显示清除按钮
  public let showsClear: Bool
}

/// 输入框令牌绑定与外观解析（纯函数，无 View 依赖）。
///
/// 令牌映射严格对齐 `lh-ui-core/specs/input.json` 的 behaviors：
/// - size 映射：small/medium/large 分别取 input.height.<size> / paddingHorizontal.<size> /
///   fontSize.<size> 令牌
/// - type 为 password 时以圆点掩码显示已有文本
/// - disabled 为 true 时取 disabled.* 令牌，不响应输入与清除
/// - readonly 为 true 时不接受输入、不触发 onValueChange（外观与可输入态一致）
/// - 聚焦时描边色取 color.focus、宽度 input.focusRingWidth；失焦回 color.border.base + input.borderWidth
/// - clearable 为 true 且 value 非空时尾部显示清除按钮
/// - maxlength 存在时，输入超出长度的字符被截断
public enum LhInputStyle {
  public static func resolveAppearance(
    type: LhInputType,
    size: LhInputSize,
    disabled: Bool,
    readonly: Bool,
    clearable: Bool,
    hasValue: Bool,
    focused: Bool,
    colors: LhColors
  ) -> LhInputAppearance {
    let editable = !disabled && !readonly

    let height: CGFloat
    let paddingHorizontal: CGFloat
    let fontSize: CGFloat
    switch size {
    case .small:
      height = LhTokens.Input.Height.small
      paddingHorizontal = LhTokens.Input.PaddingHorizontal.small
      fontSize = LhTokens.Input.FontSize.small
    case .medium:
      height = LhTokens.Input.Height.medium
      paddingHorizontal = LhTokens.Input.PaddingHorizontal.medium
      fontSize = LhTokens.Input.FontSize.medium
    case .large:
      height = LhTokens.Input.Height.large
      paddingHorizontal = LhTokens.Input.PaddingHorizontal.large
      fontSize = LhTokens.Input.FontSize.large
    }

    // 描边：聚焦环优先，其次禁用态，最后默认
    let border: Color
    let borderWidth: CGFloat
    if focused {
      border = colors.focus
      borderWidth = LhTokens.Input.focusRingWidth
    } else if disabled {
      border = colors.disabledBorder
      borderWidth = LhTokens.Input.borderWidth
    } else {
      border = colors.borderBase
      borderWidth = LhTokens.Input.borderWidth
    }

    return LhInputAppearance(
      height: height,
      paddingHorizontal: paddingHorizontal,
      fontSize: fontSize,
      borderRadius: LhTokens.Input.borderRadius,
      borderWidth: borderWidth,
      focusRingWidth: LhTokens.Input.focusRingWidth,
      clearIconSize: LhTokens.Input.clearIconSize,
      textColor: disabled ? colors.disabledText : colors.textPrimary,
      placeholderColor: disabled ? colors.disabledText : colors.textPlaceholder,
      containerColor: disabled ? colors.disabledBg : colors.backgroundDefault,
      borderColor: border,
      editable: editable,
      isSecure: type == .password,
      showsClear: clearable && hasValue && editable
    )
  }

  /// maxlength 截断（黄金用例 maxlength-truncates-input）
  public static func truncated(_ text: String, maxlength: Int?) -> String {
    guard let maxlength else { return text }
    return String(text.prefix(maxlength))
  }
}

/// 输入框组件：单行文本录入。
///
/// props 与 `lh-ui-core/specs/input.json` 逐字对齐；行为遵循 `cases/input.json`
/// 的 8 条黄金用例（已翻译为 XCTest，见 Tests/LhUITests/LhInputTests.swift）。
public struct LhInput: View {
  /// 当前文本值（受控）
  @Binding public var value: String
  /// 占位提示文字，取 color.text.placeholder 令牌
  public var placeholder: String = ""
  /// 输入类型；password 时以圆点掩码显示
  public var type: LhInputType = .text
  /// 输入框尺寸，映射到 input.height / paddingHorizontal / fontSize 令牌
  public var size: LhInputSize = .medium
  /// 是否禁用；禁用时不响应输入、不触发 onValueChange 且呈现禁用样式
  public var disabled: Bool = false
  /// 是否只读；只读时可聚焦但不接受输入、不触发 onValueChange
  public var readonly: Bool = false
  /// 是否显示清除按钮；value 非空时点击触发 onValueChange("")
  public var clearable: Bool = false
  /// 最大字符数；超出时截断新输入
  public var maxlength: Int? = nil
  /// 文本变化回调，携带变更后的文本
  public var onValueChange: ((String) -> Void)? = nil
  /// 获得焦点回调
  public var onFocus: (() -> Void)? = nil
  /// 失去焦点回调
  public var onBlur: (() -> Void)? = nil

  @Environment(\.lhColors) private var colors
  @FocusState private var focused: Bool

  public init(
    value: Binding<String>,
    placeholder: String = "",
    type: LhInputType = .text,
    size: LhInputSize = .medium,
    disabled: Bool = false,
    readonly: Bool = false,
    clearable: Bool = false,
    maxlength: Int? = nil,
    onValueChange: ((String) -> Void)? = nil,
    onFocus: (() -> Void)? = nil,
    onBlur: (() -> Void)? = nil
  ) {
    self._value = value
    self.placeholder = placeholder
    self.type = type
    self.size = size
    self.disabled = disabled
    self.readonly = readonly
    self.clearable = clearable
    self.maxlength = maxlength
    self.onValueChange = onValueChange
    self.onFocus = onFocus
    self.onBlur = onBlur
  }

  public var body: some View {
    let appearance = LhInputStyle.resolveAppearance(
      type: type, size: size, disabled: disabled, readonly: readonly,
      clearable: clearable, hasValue: !value.isEmpty, focused: focused, colors: colors
    )

    return HStack(spacing: LhTokens.Spacing.xs) {
      Group {
        if appearance.isSecure {
          SecureField(placeholder, text: fieldBinding(appearance: appearance))
        } else {
          TextField(placeholder, text: fieldBinding(appearance: appearance))
        }
      }
      .font(.system(size: appearance.fontSize, weight: Self.fontWeight(LhTokens.Typography.FontWeight.primary)))
      .foregroundColor(appearance.textColor)
      .tint(appearance.textColor)
      .focused($focused)
      .disabled(disabled)

      if appearance.showsClear {
        Button {
          value = ""
          onValueChange?("")  // 黄金用例 clearable-emits-empty-value
        } label: {
          Image(systemName: "xmark.circle.fill")
            .resizable()
            .scaledToFit()
            .frame(width: appearance.clearIconSize, height: appearance.clearIconSize)
            .foregroundColor(appearance.placeholderColor)
        }
        .buttonStyle(.plain)
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
    .onChange(of: focused) { isFocused in
      if isFocused {
        onFocus?()
      } else {
        onBlur?()
      }
    }
    .accessibilityElement(children: .combine)
    .accessibilityLabel(placeholder.isEmpty ? "输入框" : placeholder)
  }

  /// 输入写入网关：disabled / readonly 拒绝写入（控件即回滚，黄金用例
  /// disabled-blocks-input / readonly-blocks-input），并执行 maxlength 截断
  /// （黄金用例 maxlength-truncates-input，截断后仍以截断值通知 onValueChange）。
  private func fieldBinding(appearance: LhInputAppearance) -> Binding<String> {
    Binding(
      get: { value },
      set: { newValue in
        let truncated = LhInputStyle.truncated(newValue, maxlength: maxlength)
        guard appearance.editable else { return }
        value = truncated
        onValueChange?(truncated)
      }
    )
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

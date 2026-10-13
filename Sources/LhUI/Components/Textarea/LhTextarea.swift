import SwiftUI
import LhUITokens

/// 多行输入框外观解析结果。由 LhTextareaStyle.resolveAppearance 纯函数产出，供 XCTest 断言。
public struct LhTextareaAppearance: Equatable {
  public let paddingVertical: CGFloat
  public let paddingHorizontal: CGFloat
  public let fontSize: CGFloat
  public let borderRadius: CGFloat
  public let borderWidth: CGFloat
  public let focusRingWidth: CGFloat
  public let countFontSize: CGFloat
  public let minHeight: CGFloat
  public let textColor: Color
  public let placeholderColor: Color
  public let containerColor: Color
  public let borderColor: Color
  /// 是否可交互（disabled 或 readonly 为 true 时不可输入）
  public let editable: Bool
  /// 是否显示字数统计
  public let showsCount: Bool
  /// 字数统计文案（「当前/最大」或仅「当前」）
  public let countText: String
}

/// 多行输入框令牌绑定与外观解析（纯函数，无 View 依赖）。
///
/// 令牌映射严格对齐 `lh-ui-core/specs/textarea.json` 的 behaviors：
/// - 高度由 rows 决定初始可见行数，内容超出时自动增高（最小高度 textarea.minHeight）
/// - 聚焦时描边色取 color.focus、宽度 textarea.focusRingWidth；失焦回 color.border.base + textarea.borderWidth
/// - showCount 为 true 时右下角绘制字数统计，格式「当前/最大」，取 textarea.countFontSize 与
///   color.text.secondary；未声明 maxlength 时只显示当前长度
/// - 超过 maxlength 的输入被截断
/// - disabled 为 true 时取 disabled.* 令牌，不响应输入
/// - readonly 为 true 时可聚焦但不接受输入，不触发 onValueChange
public enum LhTextareaStyle {
  public static func resolveAppearance(
    value: String,
    disabled: Bool,
    readonly: Bool,
    showCount: Bool,
    maxlength: Int?,
    focused: Bool,
    colors: LhColors
  ) -> LhTextareaAppearance {
    let editable = !disabled && !readonly

    let border: Color
    let borderWidth: CGFloat
    if focused {
      border = colors.focus
      borderWidth = LhTokens.Textarea.focusRingWidth
    } else if disabled {
      border = colors.disabledBorder
      borderWidth = LhTokens.Textarea.borderWidth
    } else {
      border = colors.borderBase
      borderWidth = LhTokens.Textarea.borderWidth
    }

    // 字数统计文案（黄金用例 showcount-renders-count / showcount-without-maxlength-renders-length-only）
    let countText: String
    if let maxlength {
      countText = "\(value.count)/\(maxlength)"
    } else {
      countText = "\(value.count)"
    }

    return LhTextareaAppearance(
      paddingVertical: LhTokens.Textarea.paddingVertical,
      paddingHorizontal: LhTokens.Textarea.paddingHorizontal,
      fontSize: LhTokens.Textarea.fontSize,
      borderRadius: LhTokens.Textarea.borderRadius,
      borderWidth: borderWidth,
      focusRingWidth: LhTokens.Textarea.focusRingWidth,
      countFontSize: LhTokens.Textarea.countFontSize,
      minHeight: LhTokens.Textarea.minHeight,
      textColor: disabled ? colors.disabledText : colors.textPrimary,
      placeholderColor: disabled ? colors.disabledText : colors.textPlaceholder,
      containerColor: disabled ? colors.disabledBg : colors.backgroundDefault,
      borderColor: border,
      editable: editable,
      showsCount: showCount,
      countText: countText
    )
  }

  /// maxlength 截断（黄金用例 maxlength-truncates-input）
  public static func truncated(_ text: String, maxlength: Int?) -> String {
    guard let maxlength else { return text }
    return String(text.prefix(maxlength))
  }
}

/// 多行输入框组件：可伸缩高度的长文本录入。
///
/// props 与 `lh-ui-core/specs/textarea.json` 逐字对齐；行为遵循 `cases/textarea.json`
/// 的黄金用例（已翻译为 XCTest，见 Tests/LhUITests/LhTextareaTests.swift）。
public struct LhTextarea: View {
  /// 当前文本值（受控）
  @Binding public var value: String
  /// 占位提示文字，取 color.text.placeholder 令牌
  public var placeholder: String = ""
  /// 初始可见行数；高度随行数与内容增长
  public var rows: Int = 3
  /// 是否禁用；禁用时不响应输入、不触发 onValueChange 且呈现禁用样式
  public var disabled: Bool = false
  /// 是否只读；只读时可聚焦但不接受输入、不触发 onValueChange
  public var readonly: Bool = false
  /// 是否在右下角显示字数统计（当前长度 / 最大长度）
  public var showCount: Bool = false
  /// 最大字符数；超出时截断新输入；showCount 时作为分母
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
    rows: Int = 3,
    disabled: Bool = false,
    readonly: Bool = false,
    showCount: Bool = false,
    maxlength: Int? = nil,
    onValueChange: ((String) -> Void)? = nil,
    onFocus: (() -> Void)? = nil,
    onBlur: (() -> Void)? = nil
  ) {
    self._value = value
    self.placeholder = placeholder
    self.rows = rows
    self.disabled = disabled
    self.readonly = readonly
    self.showCount = showCount
    self.maxlength = maxlength
    self.onValueChange = onValueChange
    self.onFocus = onFocus
    self.onBlur = onBlur
  }

  public var body: some View {
    let appearance = LhTextareaStyle.resolveAppearance(
      value: value, disabled: disabled, readonly: readonly, showCount: showCount,
      maxlength: maxlength, focused: focused, colors: colors
    )

    // 高度 = 行高 × 行数 + 上下内边距，且不小于 minHeight 令牌
    let rowHeight = appearance.fontSize * CGFloat(LhTokens.Typography.LineHeight.primary)
    let contentHeight = rowHeight * CGFloat(rows) + appearance.paddingVertical * 2

    return ZStack(alignment: .bottomTrailing) {
      TextEditor(text: fieldBinding(appearance: appearance))
        .font(.system(size: appearance.fontSize, weight: Self.fontWeight(LhTokens.Typography.FontWeight.primary)))
        .foregroundColor(appearance.textColor)
        // iOS 16+ 才能隐藏 TextEditor 的默认背景；iOS 15 保持系统背景以免崩溃
        .modifier(HideScrollBackground())
        .background(appearance.containerColor)
        .disabled(disabled)
        .focused($focused)

      // 占位文字（TextEditor 无原生占位，叠加实现）
      // 偏移量对齐 TextEditor 自身的内嵌：水平内嵌与内边距同量，垂直内嵌比内边距多一行行距的一半
      if value.isEmpty && !placeholder.isEmpty {
        Text(placeholder)
          .font(.system(size: appearance.fontSize))
          .foregroundColor(appearance.placeholderColor)
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(.leading, LhTokens.Textarea.textInset)
          .padding(.top, appearance.paddingVertical + LhTokens.Textarea.textInset)
          .allowsHitTesting(false)
      }

      // 字数统计（右下角）
      if appearance.showsCount {
        Text(appearance.countText)
          .font(.system(size: appearance.countFontSize))
          .foregroundColor(appearance.placeholderColor)
          .padding(.trailing, appearance.paddingHorizontal)
          .padding(.bottom, max(appearance.paddingVertical - LhTokens.Textarea.textInset, 0))
          .allowsHitTesting(false)
      }
    }
    .frame(minHeight: max(contentHeight, appearance.minHeight))
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
    .accessibilityLabel(placeholder.isEmpty ? "多行输入框" : placeholder)
  }

  /// 输入写入网关：disabled / readonly 拒绝写入（控件即回滚，黄金用例
  /// disabled-blocks-input / readonly-blocks-input），并执行 maxlength 截断
  /// （黄金用例 maxlength-truncates-input，截断后仍以截断值通知 onValueChange）。
  private func fieldBinding(appearance: LhTextareaAppearance) -> Binding<String> {
    Binding(
      get: { value },
      set: { newValue in
        let truncated = LhTextareaStyle.truncated(newValue, maxlength: maxlength)
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

/// `.scrollContentBackground(.hidden)` 是 iOS 16 / macOS 13+ API，部署目标是 iOS 15 / macOS 12，
/// 必须按可用性包裹，否则在旧系统上编译报错。
private struct HideScrollBackground: ViewModifier {
  func body(content: Content) -> some View {
    if #available(iOS 16, macOS 13, *) {
      content.scrollContentBackground(.hidden)
    } else {
      content
    }
  }
}

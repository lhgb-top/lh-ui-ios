import SwiftUI
import LhUITokens

/// 选择器外观解析结果。由 LhPickerStyle.resolveAppearance 纯函数产出，供 XCTest 断言。
public struct LhPickerAppearance: Equatable {
  public let height: CGFloat
  public let itemHeight: CGFloat
  public let toolbarHeight: CGFloat
  public let itemFontSize: CGFloat
  public let borderRadius: CGFloat
  public let containerColor: Color
  public let overlayColor: Color
  public let titleColor: Color
  public let confirmColor: Color
  public let cancelColor: Color
  public let indicatorColor: Color
  public let itemColor: Color
  /// 是否可见
  public let visible: Bool
  /// 钳制后的选中索引（黄金用例 clamp-negative-value-to-zero / clamp-overflow-value-to-last）
  public let clampedValue: Int
  /// 工具栏标题
  public let title: String
  public let confirmText: String
  public let cancelText: String
}

/// 选择器令牌绑定与外观解析（纯函数，无 View 依赖）。
///
/// 令牌映射严格对齐 `lh-ui-core/specs/picker.json` 的 behaviors：
/// - visible 为 false 时不渲染
/// - 面板高度 picker.height，从底部弹出，顶部圆角 picker.borderRadius，底色 color.background.default
/// - 工具栏高度 picker.toolbarHeight：左取消、中标题、右确认
/// - 候选项高度 picker.itemHeight、字号 picker.itemFontSize；中央指示器为两条水平线
///   （color.border.lighter），间距 = picker.itemHeight
/// - value 越界时钳制：负数取 0，大于候选项数 - 1 取最后一项
/// - 遮罩取 color.background.overlay，层级取 zIndex.modal / zIndex.modalBackdrop
public enum LhPickerStyle {
  public static func resolveAppearance(
    visible: Bool,
    options: [String],
    value: Int,
    title: String,
    confirmText: String,
    cancelText: String,
    colors: LhColors
  ) -> LhPickerAppearance {
    // 越界钳制（黄金用例 clamp-negative-value-to-zero / clamp-overflow-value-to-last）
    let clamped: Int
    if options.isEmpty {
      clamped = 0
    } else {
      clamped = min(max(value, 0), options.count - 1)
    }

    return LhPickerAppearance(
      height: LhTokens.Picker.height,
      itemHeight: LhTokens.Picker.itemHeight,
      toolbarHeight: LhTokens.Picker.toolbarHeight,
      itemFontSize: LhTokens.Picker.itemFontSize,
      borderRadius: LhTokens.Picker.borderRadius,
      containerColor: colors.backgroundDefault,
      overlayColor: colors.backgroundOverlay,
      titleColor: colors.textPrimary,
      confirmColor: colors.primary,
      cancelColor: colors.textPrimary,
      indicatorColor: colors.borderLighter,
      itemColor: colors.textPrimary,
      visible: visible,
      clampedValue: clamped,
      title: title,
      confirmText: confirmText,
      cancelText: cancelText
    )
  }
}

/// 选择器组件：底部弹出的单列滚轮。
///
/// props 与 `lh-ui-core/specs/picker.json` 逐字对齐（`visible` 以 `@Binding` 暴露为
/// 声明式 API）；行为遵循 `cases/picker.json` 的 8 条黄金用例（已翻译为 XCTest，
/// 见 Tests/LhUITests/LhPickerTests.swift）。
public struct LhPicker: View {
  /// 是否显示；为 false 时不渲染任何内容
  @Binding public var visible: Bool
  /// 候选项文本数组（单列）
  public var options: [String]
  /// 选中项索引（0 基）；越界时钳制到候选项范围内
  @Binding public var value: Int
  /// 工具栏中间的标题
  public var title: String = ""
  /// 确认按钮文字
  public var confirmText: String = "确认"
  /// 取消按钮文字
  public var cancelText: String = "取消"
  /// 滚轮停止且选中项变化时触发，携带新索引
  public var onValueChange: ((Int) -> Void)? = nil
  /// 点击确认时触发，携带当前选中索引
  public var onConfirm: ((Int) -> Void)? = nil
  /// 点击取消时触发
  public var onCancel: (() -> Void)? = nil
  /// 确认/取消后触发，宿主据此置 visible 为 false
  public var onClose: (() -> Void)? = nil

  @Environment(\.lhColors) private var colors
  // 滚轮垂直拖动位移（松手吸附到最近候选项）
  @State private var dragOffset: CGFloat = 0

  public init(
    visible: Binding<Bool>,
    options: [String],
    value: Binding<Int>,
    title: String = "",
    confirmText: String = "确认",
    cancelText: String = "取消",
    onValueChange: ((Int) -> Void)? = nil,
    onConfirm: ((Int) -> Void)? = nil,
    onCancel: (() -> Void)? = nil,
    onClose: (() -> Void)? = nil
  ) {
    self._visible = visible
    self.options = options
    self._value = value
    self.title = title
    self.confirmText = confirmText
    self.cancelText = cancelText
    self.onValueChange = onValueChange
    self.onConfirm = onConfirm
    self.onCancel = onCancel
    self.onClose = onClose
  }

  public var body: some View {
    let appearance = LhPickerStyle.resolveAppearance(
      visible: visible, options: options, value: value, title: title,
      confirmText: confirmText, cancelText: cancelText, colors: colors
    )

    // 黄金用例 hidden-not-rendered：不可见时不渲染任何内容
    return Group {
      if appearance.visible {
        ZStack(alignment: .bottom) {
          // 遮罩（zIndex.modalBackdrop）
          Rectangle()
            .fill(appearance.overlayColor)
            .zIndex(Double(LhTokens.ZIndex.modalBackdrop))
            .contentShape(Rectangle())
            .onTapGesture { cancel() }

          // 面板（zIndex.modal，从底部弹出）
          VStack(spacing: 0) {
            toolbar(appearance)
            wheel(appearance)
          }
          .frame(height: appearance.height)
          .background(
            RoundedRectangle(cornerRadius: appearance.borderRadius)
              .fill(appearance.containerColor)
          )
          .zIndex(Double(LhTokens.ZIndex.modal))
          .transition(.move(edge: .bottom))
        }
        .ignoresSafeArea()
      }
    }
    // 挂在 if 分支外层，显隐切换才会走动画；分支内的 .animation 对整体出现/消失无效
    .animation(.easeInOut(duration: LhTokens.Motion.Duration.base), value: appearance.visible)
  }

  // MARK: 工具栏

  @ViewBuilder
  private func toolbar(_ appearance: LhPickerAppearance) -> some View {
    HStack {
      Button(action: cancel) {
        Text(appearance.cancelText)
          .font(.system(size: appearance.itemFontSize, weight: Self.fontWeight(LhTokens.Typography.FontWeight.primary)))
          .foregroundColor(appearance.cancelColor)
      }
      .buttonStyle(.plain)

      Spacer()

      Text(appearance.title)
        .font(.system(size: appearance.itemFontSize, weight: Self.fontWeight(LhTokens.Typography.FontWeight.bold)))
        .foregroundColor(appearance.titleColor)

      Spacer()

      Button(action: confirm) {
        Text(appearance.confirmText)
          .font(.system(size: appearance.itemFontSize, weight: Self.fontWeight(LhTokens.Typography.FontWeight.bold)))
          .foregroundColor(appearance.confirmColor)
      }
      .buttonStyle(.plain)
    }
    .padding(.horizontal, appearance.itemHeight)
    .frame(height: appearance.toolbarHeight)
  }

  // MARK: 滚轮

  @ViewBuilder
  private func wheel(_ appearance: LhPickerAppearance) -> some View {
    let wheelHeight = appearance.height - appearance.toolbarHeight

    ZStack {
      // 候选项列表：垂直堆叠，整体随拖动位移
      VStack(spacing: 0) {
        ForEach(Array(options.enumerated()), id: \.offset) { index, option in
          Text(option)
            .font(.system(size: appearance.itemFontSize, weight: Self.fontWeight(LhTokens.Typography.FontWeight.primary)))
            .foregroundColor(appearance.itemColor)
            .frame(height: appearance.itemHeight)
        }
      }
      .offset(y: wheelOffset(appearance, wheelHeight: wheelHeight))
      .gesture(
        DragGesture()
          .onChanged { event in
            dragOffset = event.translation.height
          }
          .onEnded { event in
            // 松手吸附到最近候选项（黄金用例 scroll-emits-onvaluechange）
            let newIndex = snappedIndex(
              from: appearance.clampedValue,
              drag: event.translation.height,
              appearance: appearance
            )
            withAnimation(.easeInOut(duration: LhTokens.Motion.Duration.base)) {
              dragOffset = 0
              value = newIndex
            }
            if newIndex != appearance.clampedValue {
              onValueChange?(newIndex)
            }
          }
      )
      .frame(height: wheelHeight)
      .clipped()

      // 中央指示器：两条水平线，间距 = picker.itemHeight
      indicatorLines(appearance, wheelHeight: wheelHeight)
        .allowsHitTesting(false)
    }
    .frame(height: wheelHeight)
  }

  /// 滚轮整体位移：让选中项落在指示器中央，再叠加拖动位移
  private func wheelOffset(_ appearance: LhPickerAppearance, wheelHeight: CGFloat) -> CGFloat {
    let centerOffset = wheelHeight / 2 - appearance.itemHeight / 2
    let selectionOffset = CGFloat(appearance.clampedValue) * appearance.itemHeight
    return centerOffset - selectionOffset + dragOffset
  }

  /// 根据拖动距离计算吸附后的选中索引
  private func snappedIndex(from current: Int, drag: CGFloat, appearance: LhPickerAppearance) -> Int {
    guard !options.isEmpty else { return 0 }
    let steps = Int(round(-drag / appearance.itemHeight))
    let newIndex = current + steps
    return min(max(newIndex, 0), options.count - 1)
  }

  /// 中央指示器（两条水平线，间距 = picker.itemHeight）
  @ViewBuilder
  private func indicatorLines(_ appearance: LhPickerAppearance, wheelHeight: CGFloat) -> some View {
    let inset = (wheelHeight - appearance.itemHeight) / 2
    ZStack {
      Rectangle()
        .fill(appearance.indicatorColor)
        .frame(height: LhTokens.Cell.borderWidth)
        .frame(maxHeight: .infinity, alignment: .top)
        .padding(.top, inset)
      Rectangle()
        .fill(appearance.indicatorColor)
        .frame(height: LhTokens.Cell.borderWidth)
        .frame(maxHeight: .infinity, alignment: .bottom)
        .padding(.bottom, inset)
    }
  }

  // MARK: 动作

  /// 确认：触发 onConfirm 携带当前索引，随后触发 onClose。
  /// 发送钳制后的索引（黄金用例 clamp-*）：外部初始值越界时，UI 显示的是末项，
  /// 回调必须与 UI 一致，并顺带把外部值纠正到合法区间。
  private func confirm() {
    let clamped = clampedValue()
    if clamped != value {
      withAnimation(.easeInOut(duration: LhTokens.Motion.Duration.base)) {
        value = clamped
      }
    }
    onConfirm?(clamped)
    close()
  }

  /// 取消：触发 onCancel，随后触发 onClose
  private func cancel() {
    onCancel?()
    close()
  }

  /// 把 value 钳制到合法区间（黄金用例 clamp-negative-value-to-zero /
  /// clamp-overflow-value-to-last）；空选项列表时恒为 0。
  private func clampedValue() -> Int {
    guard !options.isEmpty else { return 0 }
    return min(max(value, 0), options.count - 1)
  }

  /// 关闭：置 visible 为 false 并触发 onClose
  private func close() {
    withAnimation(.easeInOut(duration: LhTokens.Motion.Duration.base)) {
      visible = false
    }
    onClose?()
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

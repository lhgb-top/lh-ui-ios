import SwiftUI
import LhUITokens

/// 轻提示类型。rawValue 与 spec 的 prop `type` 枚举值逐字对齐（R-n5）。
///
/// 非 default 时在文字前绘制对应语义色圆点。
public enum LhToastType: String, CaseIterable, Sendable {
  case `default`
  case success
  case warning
  case danger
  case info
}

/// 轻提示定位。rawValue 与 spec 的 prop `position` 枚举值逐字对齐。
public enum LhToastPosition: String, CaseIterable, Sendable {
  case top
  case center
  case bottom
}

/// 轻提示外观解析结果。由 LhToastStyle.resolveAppearance 纯函数产出，供 XCTest 断言。
public struct LhToastAppearance: Equatable {
  public let fontSize: CGFloat
  public let paddingHorizontal: CGFloat
  public let paddingVertical: CGFloat
  public let borderRadius: CGFloat
  public let gap: CGFloat
  /// 上下两端留的边距（spacing.xl）
  public let edgeMargin: CGFloat
  /// 宽度封顶比例（spec：封顶可用宽度的 80%）
  public let maxWidthFraction: CGFloat
  public let containerColor: Color
  public let textColor: Color
  /// 语义色圆点颜色；default 类型为 nil（不绘制）
  public let dotColor: Color?
  /// 自动隐藏时长（秒；spec 的 duration 是毫秒，端侧换算）
  public let durationSeconds: Double
  /// 是否可见
  public let visible: Bool
}

/// 轻提示令牌绑定与外观解析（纯函数，无 View 依赖）。
///
/// 令牌映射严格对齐 `lh-ui-core/specs/toast.json` 的 behaviors：
/// - 胶囊底取 color.ink，文字取 color.onPrimary，圆角取 toast.borderRadius
/// - type 非 default 时在文字前绘制直径为字号的语义色圆点，间距取 toast.gap
/// - 宽度由文字测量得出并封顶可用宽度的 80%，按 position 定位；上下两端留 spacing.xl 边距
/// - 层级取 zIndex.toast
public enum LhToastStyle {
  public static func resolveAppearance(
    type: LhToastType,
    duration: Int,
    visible: Bool,
    colors: LhColors
  ) -> LhToastAppearance {
    let dot: Color?
    switch type {
    case .default: dot = nil
    case .success: dot = colors.success
    case .warning: dot = colors.warning
    case .danger: dot = colors.danger
    case .info: dot = colors.info
    }

    return LhToastAppearance(
      fontSize: LhTokens.Toast.fontSize,
      paddingHorizontal: LhTokens.Toast.paddingHorizontal,
      paddingVertical: LhTokens.Toast.paddingVertical,
      borderRadius: LhTokens.Toast.borderRadius,
      gap: LhTokens.Toast.gap,
      edgeMargin: LhTokens.Spacing.xl,
      // spec：layout 宽度封顶可用宽度的 80%
      maxWidthFraction: 0.8,
      containerColor: colors.ink,
      textColor: colors.onPrimary,
      dotColor: dot,
      // spec 的 duration 单位是毫秒，SwiftUI 定时器用秒
      durationSeconds: Double(duration) / 1000,
      visible: visible
    )
  }
}

/// 轻提示组件：自持可见性与计时的墨色胶囊浮层。
///
/// props 与 `lh-ui-core/specs/toast.json` 逐字对齐（命令式 show/hide/tick 在声明式
/// API 下等价为 `@Binding visible` + 自动消失计时）；行为遵循 `cases/toast.json`
/// 的 6 条黄金用例（已翻译为 XCTest，见 Tests/LhUITests/LhToastTests.swift）。
///
/// spec 将计时建模为宿主每帧 tick；SwiftUI 端用 `.task` + Task.sleep 落地同一语义
/// （duration 从毫秒换算为秒）。层级取 zIndex.toast，宿主将其最后绘制。
public struct LhToast: View {
  /// 是否可见（受控）
  @Binding public var visible: Bool
  /// 提示文字（spec 的 show(text) 入参）
  public var text: String
  /// 语义类型；非 default 时文字前绘制语义色圆点
  public var type: LhToastType = .default
  /// 自动隐藏时长（毫秒）；到期后自动隐藏并触发 onClose
  public var duration: Int = 2000
  /// 在可用区域内的定位
  public var position: LhToastPosition = .center
  /// 计时到期自动隐藏时触发（主动置 visible=false 不触发）
  public var onClose: (() -> Void)? = nil

  @Environment(\.lhColors) private var colors

  public init(
    visible: Binding<Bool>,
    text: String,
    type: LhToastType = .default,
    duration: Int = 2000,
    position: LhToastPosition = .center,
    onClose: (() -> Void)? = nil
  ) {
    self._visible = visible
    self.text = text
    self.type = type
    self.duration = duration
    self.position = position
    self.onClose = onClose
  }

  public var body: some View {
    let appearance = LhToastStyle.resolveAppearance(
      type: type, duration: duration, visible: visible, colors: colors
    )

    // 黄金用例 hidden-emits-no-commands：不可见时不渲染任何内容
    return Group {
      if appearance.visible {
        GeometryReader { proxy in
          HStack(spacing: appearance.gap) {
            if let dotColor = appearance.dotColor {
              // 语义色圆点，直径为字号
              Circle()
                .fill(dotColor)
                .frame(width: appearance.fontSize, height: appearance.fontSize)
            }
            Text(text)
              .font(.system(size: appearance.fontSize, weight: Self.fontWeight(LhTokens.Typography.FontWeight.primary)))
              .foregroundColor(appearance.textColor)
              // 不用 fixedSize：否则长文本不换行，会顶破 maxWidth 限制而非折行
              .lineLimit(nil)
              .fixedSize(horizontal: false, vertical: true)
          }
          .padding(.horizontal, appearance.paddingHorizontal)
          .padding(.vertical, appearance.paddingVertical)
          .frame(maxWidth: proxy.size.width * appearance.maxWidthFraction)
          .background(
            RoundedRectangle(cornerRadius: appearance.borderRadius)
              .fill(appearance.containerColor)
          )
          // 按 position 定位（spec：上下两端留 spacing.xl 边距）
          .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: toastAlignment)
          .padding(.top, position == .top ? appearance.edgeMargin : 0)
          .padding(.bottom, position == .bottom ? appearance.edgeMargin : 0)
          .zIndex(Double(LhTokens.ZIndex.toast))
        }
        // id 组合 visible + text + duration：宿主重复显示同一 toast（visible 已为 true）
        // 或在显示期间改了文案/时长，都会重置倒计时；仅 visible 不足以触发重启。
        .task(id: ToastTaskId(visible: visible, text: text, duration: duration)) {
          // 黄金用例 auto-hides-after-duration / tick-before-duration-keeps-visible：
          // duration 到期自动隐藏并触发 onClose；hide()（主动置 false）不触发
          guard visible else { return }
          try? await Task.sleep(nanoseconds: UInt64(appearance.durationSeconds * 1_000_000_000))
          guard visible else { return }
          withAnimation(.easeInOut(duration: LhTokens.Motion.Duration.base)) {
            visible = false
          }
          onClose?()
        }
        .allowsHitTesting(false)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(text)
      }
    }
  }

  /// position → SwiftUI Alignment
  private var toastAlignment: Alignment {
    switch position {
    case .top: return .top
    case .center: return .center
    case .bottom: return .bottom
    }
  }

  /// 自动消失计时的任务 id：任一组成变化即重启倒计时
  private struct ToastTaskId: Hashable {
    let visible: Bool
    let text: String
    let duration: Int
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

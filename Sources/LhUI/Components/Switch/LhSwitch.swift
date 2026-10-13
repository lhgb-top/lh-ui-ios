import SwiftUI
import LhUITokens

/// 开关尺寸。rawValue 与 spec 的 prop `size` 枚举值逐字对齐。
public enum LhSwitchSize: String, CaseIterable, Sendable {
  case small
  case medium
  case large
}

/// 开关外观解析结果。由 LhSwitchStyle.resolveAppearance 纯函数产出，供 XCTest 断言。
public struct LhSwitchAppearance: Equatable {
  public let width: CGFloat
  public let height: CGFloat
  /// 滑块与轨道之间的留白（switch.gap）
  public let gap: CGFloat
  /// 滑块直径 = 高度 - 2 × gap
  public let thumbSize: CGFloat
  public let trackColor: Color
  public let thumbColor: Color
  /// 是否可交互（disabled 或 loading 为 true 时不可交互）
  public let enabled: Bool
  /// 是否显示加载环替代滑块
  public let showsLoading: Bool
  /// 开启时滑块的横向位移
  public let thumbOffset: CGFloat
}

/// 开关令牌绑定与外观解析（纯函数，无 View 依赖）。
///
/// 令牌映射严格对齐 `lh-ui-core/specs/switch.json` 的 behaviors：
/// - size 映射：small/medium/large 分别取 switch.width.<size> 与 switch.height.<size> 令牌
/// - 轨道为胶囊（圆角取高度一半）：开启取 color.primary.default，关闭取 color.border.base，
///   禁用取 color.disabled.bg
/// - 滑块为圆形（直径 = 高度 - 2 × switch.gap），取 color.onPrimary；禁用取 color.text.disabled
/// - loading 为 true 时滑块位置改画加载环（主色），且不响应点击
public enum LhSwitchStyle {
  public static func resolveAppearance(
    checked: Bool,
    disabled: Bool,
    loading: Bool,
    size: LhSwitchSize,
    colors: LhColors
  ) -> LhSwitchAppearance {
    let enabled = !disabled && !loading

    let width: CGFloat
    let height: CGFloat
    switch size {
    case .small:
      width = LhTokens.Switch.Width.small
      height = LhTokens.Switch.Height.small
    case .medium:
      width = LhTokens.Switch.Width.medium
      height = LhTokens.Switch.Height.medium
    case .large:
      width = LhTokens.Switch.Width.large
      height = LhTokens.Switch.Height.large
    }

    let gap = LhTokens.Switch.gap
    let thumbSize = height - 2 * gap

    // 轨道色（禁用优先，其次开关态）
    let track: Color
    if !enabled {
      track = disabled ? colors.disabledBg : colors.primary
    } else if checked {
      track = colors.primary
    } else {
      track = colors.borderBase
    }

    // 滑块色（禁用取 disabled 文字色；loading 时轨道已为主色，滑块仍为 onPrimary）
    let thumb: Color
    if disabled {
      thumb = colors.disabledText
    } else {
      thumb = colors.onPrimary
    }

    // 开启时滑块右移到轨道末端
    let offset = checked ? (width - thumbSize) / 2 : -(width - thumbSize) / 2

    return LhSwitchAppearance(
      width: width,
      height: height,
      gap: gap,
      thumbSize: thumbSize,
      trackColor: track,
      thumbColor: thumb,
      enabled: enabled,
      showsLoading: loading,
      thumbOffset: offset
    )
  }
}

/// 开关组件：胶囊轨道 + 圆形滑块的两态切换控件。
///
/// props 与 `lh-ui-core/specs/switch.json` 逐字对齐；行为遵循 `cases/switch.json`
/// 的 6 条黄金用例（已翻译为 XCTest，见 Tests/LhUITests/LhSwitchTests.swift）。
public struct LhSwitch: View {
  /// 是否开启（受控）
  @Binding public var checked: Bool
  /// 是否禁用；禁用时不响应点击且呈现禁用样式
  public var disabled: Bool = false
  /// 是否加载中；加载中滑块位置显示加载环且不响应点击
  public var loading: Bool = false
  /// 开关尺寸，映射到 switch.width / switch.height 令牌
  public var size: LhSwitchSize = .medium
  /// 开关态变化回调，携带新开关态
  public var onChange: ((Bool) -> Void)? = nil

  @Environment(\.lhColors) private var colors

  public init(
    checked: Binding<Bool>,
    disabled: Bool = false,
    loading: Bool = false,
    size: LhSwitchSize = .medium,
    onChange: ((Bool) -> Void)? = nil
  ) {
    self._checked = checked
    self.disabled = disabled
    self.loading = loading
    self.size = size
    self.onChange = onChange
  }

  public var body: some View {
    let appearance = LhSwitchStyle.resolveAppearance(
      checked: checked, disabled: disabled, loading: loading, size: size, colors: colors
    )

    return ZStack {
      // 轨道（胶囊，圆角取高度一半）
      Capsule()
        .fill(appearance.trackColor)
        .frame(width: appearance.width, height: appearance.height)

      if appearance.showsLoading {
        // 加载环占据滑块位置（主色）
        LhLoading(size: .small, tone: .primary)
          .frame(width: appearance.thumbSize, height: appearance.thumbSize)
          .offset(x: appearance.thumbOffset)
      } else {
        Circle()
          .fill(appearance.thumbColor)
          .frame(width: appearance.thumbSize, height: appearance.thumbSize)
          .offset(x: appearance.thumbOffset)
          .animation(.easeInOut(duration: LhTokens.Motion.Duration.base), value: checked)
      }
    }
    .frame(width: appearance.width, height: appearance.height)
    .contentShape(Rectangle())
    .onTapGesture {
      // 状态 gate：disabled 与 loading 均不触发（黄金用例第三、四条）
      guard appearance.enabled else { return }
      checked.toggle()
      onChange?(checked)
    }
    .accessibilityElement(children: .ignore)
    .accessibilityLabel("开关")
    .accessibilityAddTraits(appearance.enabled ? .isButton : [])
  }
}

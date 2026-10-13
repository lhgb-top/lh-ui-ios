import SwiftUI
import LhUITokens

/// 按钮组件：触发即时操作。
///
/// props 与 `lh-ui-core/specs/button.json` 逐字对齐；行为遵循 `cases/button.json`
/// 的 8 条黄金用例（已翻译为 XCTest，见 Tests/LhUITests/LhButtonTests.swift）。
public struct LhButton: View {
  /// 点击回调；disabled 或 loading 为 true 时不触发
  public var onClick: () -> Void
  /// 按钮类型，决定底色与文字色
  public var type: LhButtonType = .default
  /// 按钮尺寸，映射到 button.height / paddingHorizontal / fontSize / iconSize 令牌
  public var size: LhButtonSize = .medium
  /// 是否禁用；禁用时不响应点击并呈现禁用样式（disabled.* 令牌）
  public var disabled: Bool = false
  /// 是否加载中；加载中显示指示器且点击不触发 onClick
  public var loading: Bool = false
  /// 图标名（本地图标体系，见 LhButtonStyle.icon(for:)），按钮内左侧绘制
  public var icon: String?
  /// 是否绘制国风花纹底纹（消费 color.decoration 令牌）
  public var bgPattern: Bool = false
  /// 按钮文字内容（spec 的 default 插槽）
  private let label: Text

  @Environment(\.lhColors) private var colors

  public init(
    onClick: @escaping () -> Void,
    type: LhButtonType = .default,
    size: LhButtonSize = .medium,
    disabled: Bool = false,
    loading: Bool = false,
    icon: String? = nil,
    bgPattern: Bool = false,
    label: Text
  ) {
    self.onClick = onClick
    self.type = type
    self.size = size
    self.disabled = disabled
    self.loading = loading
    self.icon = icon
    self.bgPattern = bgPattern
    self.label = label
  }

  /// 便捷初始化：直接传字符串文字
  public init(
    onClick: @escaping () -> Void,
    type: LhButtonType = .default,
    size: LhButtonSize = .medium,
    disabled: Bool = false,
    loading: Bool = false,
    icon: String? = nil,
    bgPattern: Bool = false,
    text: some StringProtocol
  ) {
    self.init(
      onClick: onClick, type: type, size: size, disabled: disabled, loading: loading,
      icon: icon, bgPattern: bgPattern, label: Text(text)
    )
  }

  public var body: some View {
    let appearance = LhButtonStyle.resolveAppearance(
      type: type, size: size, disabled: disabled, loading: loading, bgPattern: bgPattern,
      colors: colors
    )

    return HStack(spacing: LhTokens.Spacing.xs) {
      if loading {
        ProgressView()
          .frame(width: appearance.iconSize, height: appearance.iconSize)
          .tint(appearance.contentColor)
      } else if let symbol = LhButtonStyle.icon(for: icon) {
        Image(systemName: symbol)
          .resizable()
          .scaledToFit()
          .frame(width: appearance.iconSize, height: appearance.iconSize)
          .foregroundColor(appearance.contentColor)
      }
      label
        .font(.system(size: appearance.fontSize, weight: Self.fontWeight(LhTokens.Button.fontWeight)))
    }
    .padding(.horizontal, appearance.paddingHorizontal)
    .frame(height: appearance.height)
    .background(
      // 花纹底纹（垫在底色之下；不影响文字对比度）
      ZStack {
        if appearance.patternColor != nil {
          LhDiagonalPatternFill(patternColor: appearance.patternColor)
        }
        RoundedRectangle(cornerRadius: appearance.borderRadius)
          .fill(appearance.containerColor)
      }
    )
    .overlay(
      // 描边（默认类型才有可见描边，其余类型边色 clear）
      RoundedRectangle(cornerRadius: appearance.borderRadius)
        .stroke(appearance.borderColor, lineWidth: appearance.borderWidth)
    )
    // SwiftUI 阴影：LhShadow 载体（生成的 color 已内联 opacity，radius/x/y）
    .shadow(
      color: appearance.enabled
        ? LhTokens.Shadow.lighter.color
        : .clear,
      radius: LhTokens.Shadow.lighter.radius,
      x: LhTokens.Shadow.lighter.x,
      y: LhTokens.Shadow.lighter.y
    )
    .foregroundColor(appearance.contentColor)
    .contentShape(Rectangle())
    .onTapGesture {
      // 状态 gate：disabled 与 loading 均不触发（黄金用例前三条）
      if appearance.enabled {
        onClick()
      }
    }
    .accessibilityElement(children: .combine)
    .accessibilityAddTraits(appearance.enabled ? .isButton : [])
  }

  /// 字重令牌（Int）→ SwiftUI Font.Weight。生成令牌是 400/600 这类数值，
  /// Font.Weight 无公开数值初始化器，此处做本地映射。
  private static func fontWeight(_ weight: Int) -> Font.Weight {
    switch weight {
    case ..<500: return .regular
    case 500..<650: return .semibold
    default: return .bold
    }
  }
}

/// 国风花纹底纹：45° 斜纹叠加（消费 color.decoration 令牌）。
/// 与 web 血脉的 CSS repeating-linear-gradient 方案对齐；颜色由按钮外观解析传入，
/// 明暗主题跟随。（命名规范总纲 D20：自有类型一律 Lh 前缀）
private struct LhDiagonalPatternFill: View {
  let patternColor: Color?

  var body: some View {
    Canvas { context, size in
      guard let patternColor else { return }
      let step = CGFloat(LhTokens.Spacing.base)
      var x: CGFloat = -size.height
      while x < size.width {
        var path = Path()
        path.move(to: CGPoint(x: x, y: 0))
        path.addLine(to: CGPoint(x: x + size.height, y: size.height))
        context.stroke(path, with: .color(patternColor), lineWidth: 1)
        x += step
      }
    }
  }
}

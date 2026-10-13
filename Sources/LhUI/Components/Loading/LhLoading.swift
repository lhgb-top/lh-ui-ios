import SwiftUI
import LhUITokens

/// 加载指示器尺寸。rawValue 与 spec 的 prop `size` 枚举值逐字对齐。
public enum LhLoadingSize: String, CaseIterable, Sendable {
  case small
  case medium
  case large
}

/// 加载指示器色调。rawValue 与 spec 的 prop `tone` 枚举值逐字对齐。
public enum LhLoadingTone: String, CaseIterable, Sendable {
  case primary
  case success
  case warning
  case danger
  case info
}

/// 加载外观解析结果。由 LhLoadingStyle.resolveAppearance 纯函数产出，供 XCTest 断言。
public struct LhLoadingAppearance: Equatable {
  public let size: CGFloat
  public let strokeWidth: CGFloat
  public let color: Color
}

/// 加载指示器令牌绑定与外观解析（纯函数，无 View 依赖）。
///
/// 令牌映射严格对齐 `lh-ui-core/specs/loading.json` 的 behaviors：
/// - size 映射：small/medium/large 分别取 loading.size.<size> 直径令牌
/// - 环描边宽取 loading.strokeWidth，半径为尺寸一半
/// - tone 映射到对应语义色令牌
public enum LhLoadingStyle {
  public static func resolveAppearance(
    size: LhLoadingSize,
    tone: LhLoadingTone,
    colors: LhColors
  ) -> LhLoadingAppearance {
    let dimension: CGFloat
    switch size {
    case .small: dimension = LhTokens.Loading.Size.small
    case .medium: dimension = LhTokens.Loading.Size.medium
    case .large: dimension = LhTokens.Loading.Size.large
    }

    let color: Color
    switch tone {
    case .primary: color = colors.primary
    case .success: color = colors.success
    case .warning: color = colors.warning
    case .danger: color = colors.danger
    case .info: color = colors.info
    }

    return LhLoadingAppearance(
      size: dimension,
      strokeWidth: LhTokens.Loading.strokeWidth,
      color: color
    )
  }
}

/// 加载指示器组件：环形旋转动画。
///
/// props 与 `lh-ui-core/specs/loading.json` 逐字对齐；行为遵循 `cases/loading.json`
/// 的 5 条黄金用例（已翻译为 XCTest，见 Tests/LhUITests/LhLoadingTests.swift）。
///
/// spec 将旋转描述为「后端驱动」（嵌入式朴素调性）；SwiftUI 端用令牌时长
/// （motion.duration.base，单位秒）驱动的循环旋转落地同一视觉。
public struct LhLoading: View {
  /// 指示器直径，映射到 loading.size.* 令牌
  public var size: LhLoadingSize = .medium
  /// 环色，取对应语义色令牌
  public var tone: LhLoadingTone = .primary
  /// 是否旋转（默认开启；预览静态帧时可关闭）
  public var animating: Bool = true

  @State private var rotation: Double = 0
  @Environment(\.lhColors) private var colors

  public init(size: LhLoadingSize = .medium, tone: LhLoadingTone = .primary, animating: Bool = true) {
    self.size = size
    self.tone = tone
    self.animating = animating
  }

  public var body: some View {
    let appearance = LhLoadingStyle.resolveAppearance(size: size, tone: tone, colors: colors)

    return Circle()
      // 四分之一弧（缺口环），旋转时形成加载视觉
      .trim(from: 0, to: 0.25)
      .stroke(appearance.color, lineWidth: appearance.strokeWidth)
      .frame(width: appearance.size, height: appearance.size)
      .rotationEffect(.degrees(-90))
      .rotationEffect(.degrees(rotation))
      .onAppear { startRotationIfNeeded() }
      // animating 由 false 切 true 时 onAppear 不会再触发，需显式监听重启
      .onChange(of: animating) { _ in startRotationIfNeeded() }
      .accessibilityElement(children: .ignore)
      .accessibilityLabel("加载中")
      .accessibilityAddTraits(.updatesFrequently)
  }

  /// 启动/停止旋转：animating 为 false 时复位为静态帧
  private func startRotationIfNeeded() {
    guard animating else {
      // 停在静态帧（黄金用例 render-emits-ring-command 的静止圆环）
      withAnimation(.linear(duration: LhTokens.Motion.Duration.base)) {
        rotation = 0
      }
      return
    }
    withAnimation(.linear(duration: LhTokens.Motion.Duration.base).repeatForever(autoreverses: false)) {
      rotation = 360
    }
  }
}

import SwiftUI
import LhUITokens

/// 图标尺寸。rawValue 与 spec 的 prop `size` 枚举值逐字对齐。
public enum LhIconSize: String, CaseIterable, Sendable {
  case small
  case medium
  case large
}

/// 图标色调。rawValue 与 spec 的 prop `tone` 枚举值逐字对齐（R-n5）。
///
/// default 取主要文字色；regular/secondary 取对应文字色；其余取语义色。
public enum LhIconTone: String, CaseIterable, Sendable {
  case `default`
  case primary
  case success
  case warning
  case danger
  case info
  case regular
  case secondary
}

/// 图标外观解析结果。由 LhIconStyle.resolveAppearance 纯函数产出，供 XCTest 断言。
public struct LhIconAppearance: Equatable {
  public let size: CGFloat
  public let color: Color
}

/// 图标令牌绑定与外观解析（纯函数，无 View 依赖）。
///
/// 令牌映射严格对齐 `lh-ui-core/specs/icon.json` 的 behaviors：
/// - size 映射：small/medium/large 分别取 icon.size.<size> 尺寸令牌
/// - tone 映射：default 取 color.text.primary；primary/success/warning/danger/info
///   取对应语义色；regular/secondary 取对应文字色
public enum LhIconStyle {
  public static func resolveAppearance(
    size: LhIconSize,
    tone: LhIconTone,
    colors: LhColors
  ) -> LhIconAppearance {
    let dimension: CGFloat
    switch size {
    case .small: dimension = LhTokens.Icon.Size.small
    case .medium: dimension = LhTokens.Icon.Size.medium
    case .large: dimension = LhTokens.Icon.Size.large
    }

    let color: Color
    switch tone {
    case .default: color = colors.textPrimary
    case .primary: color = colors.primary
    case .success: color = colors.success
    case .warning: color = colors.warning
    case .danger: color = colors.danger
    case .info: color = colors.info
    case .regular: color = colors.textRegular
    case .secondary: color = colors.textSecondary
    }

    return LhIconAppearance(size: dimension, color: color)
  }
}

/// 图标组件：按名称渲染矢量符号，支持尺寸与语义色调，可点击。
///
/// props 与 `lh-ui-core/specs/icon.json` 逐字对齐；行为遵循 `cases/icon.json`
/// 的 5 条黄金用例（已翻译为 XCTest，见 Tests/LhUITests/LhIconTests.swift）。
public struct LhIcon: View {
  /// 图标名（本地图标体系，见 LhIconMap）
  public var name: String
  /// 图标尺寸，映射到 icon.size.* 令牌
  public var size: LhIconSize = .medium
  /// 语义色调
  public var tone: LhIconTone = .default
  /// 点击回调
  public var onClick: (() -> Void)? = nil

  @Environment(\.lhColors) private var colors

  public init(
    name: String,
    size: LhIconSize = .medium,
    tone: LhIconTone = .default,
    onClick: (() -> Void)? = nil
  ) {
    self.name = name
    self.size = size
    self.tone = tone
    self.onClick = onClick
  }

  public var body: some View {
    let appearance = LhIconStyle.resolveAppearance(size: size, tone: tone, colors: colors)

    return Group {
      if let symbol = LhIconMap.symbol(for: name) {
        Image(systemName: symbol)
          .resizable()
          .scaledToFit()
      } else {
        // 未登记的图标名不绘制，保留占位尺寸以稳定布局
        Color.clear
      }
    }
    .frame(width: appearance.size, height: appearance.size)
    .foregroundColor(appearance.color)
    .contentShape(Rectangle())
    .onTapGesture {
      onClick?()
    }
    .accessibilityElement(children: .ignore)
    .accessibilityLabel(name)
    .accessibilityAddTraits(onClick != nil ? .isButton : [])
  }
}

import SwiftUI
import LhUITokens

/// 导航栏外观解析结果。由 LhNavbarStyle.resolveAppearance 纯函数产出，供 XCTest 断言。
public struct LhNavbarAppearance: Equatable {
  public let height: CGFloat
  public let paddingHorizontal: CGFloat
  public let titleFontSize: CGFloat
  public let iconSize: CGFloat
  public let borderWidth: CGFloat
  public let containerColor: Color
  public let titleColor: Color
  public let sideColor: Color
  public let borderColor: Color
  /// 是否绘制底部分隔线
  public let bordered: Bool
  /// 左侧是否有内容（决定是否响应点击）
  public let hasLeft: Bool
  /// 右侧是否有内容（决定是否响应点击）
  public let hasRight: Bool
}

/// 导航栏令牌绑定与外观解析（纯函数，无 View 依赖）。
///
/// 令牌映射严格对齐 `lh-ui-core/specs/navbar.json` 的 behaviors：
/// - 高度 navbar.height，左右内边距 navbar.paddingHorizontal，底色 color.background.default
/// - 标题取 navbar.titleFontSize + color.text.primary，水平居中于可用宽度
/// - 左侧文字取 color.text.primary，图标尺寸 navbar.iconSize；右侧同之
/// - bordered 为 true 时在底部绘制分隔线（color.border.lighter，宽 navbar.borderWidth）
/// - 左/右区域存在内容时可点击；无内容时不响应点击
/// - 层级取 zIndex.sticky
public enum LhNavbarStyle {
  public static func resolveAppearance(
    bordered: Bool,
    hasLeft: Bool,
    hasRight: Bool,
    colors: LhColors
  ) -> LhNavbarAppearance {
    LhNavbarAppearance(
      height: LhTokens.Navbar.height,
      paddingHorizontal: LhTokens.Navbar.paddingHorizontal,
      titleFontSize: LhTokens.Navbar.titleFontSize,
      iconSize: LhTokens.Navbar.iconSize,
      borderWidth: LhTokens.Navbar.borderWidth,
      containerColor: colors.backgroundDefault,
      titleColor: colors.textPrimary,
      sideColor: colors.textPrimary,
      borderColor: colors.borderLighter,
      bordered: bordered,
      hasLeft: hasLeft,
      hasRight: hasRight
    )
  }
}

/// 导航栏组件：页面顶部标题栏。
///
/// props 与 `lh-ui-core/specs/navbar.json` 逐字对齐；行为遵循 `cases/navbar.json`
/// 的 6 条黄金用例（已翻译为 XCTest，见 Tests/LhUITests/LhNavbarTests.swift）。
///
/// 层级取 zIndex.sticky；悬浮定位由调用方用 `.overlay` 挂载（SwiftUI 惯例，
/// 文档示例展示两种用法）。
public struct LhNavbar: View {
  /// 中间标题
  public var title: String = ""
  /// 左侧按钮文字；与 leftIcon 二者非空时都显示
  public var leftText: String = ""
  /// 左侧图标名（本地图标体系，见 LhIconMap）
  public var leftIcon: String? = nil
  /// 右侧按钮文字；与 rightIcon 二者非空时都显示
  public var rightText: String = ""
  /// 右侧图标名（本地图标体系，见 LhIconMap）
  public var rightIcon: String? = nil
  /// 是否绘制底部分隔线
  public var bordered: Bool = true
  /// 点击左侧区域时触发
  public var onLeftClick: (() -> Void)? = nil
  /// 点击右侧区域时触发
  public var onRightClick: (() -> Void)? = nil

  @Environment(\.lhColors) private var colors

  public init(
    title: String = "",
    leftText: String = "",
    leftIcon: String? = nil,
    rightText: String = "",
    rightIcon: String? = nil,
    bordered: Bool = true,
    onLeftClick: (() -> Void)? = nil,
    onRightClick: (() -> Void)? = nil
  ) {
    self.title = title
    self.leftText = leftText
    self.leftIcon = leftIcon
    self.rightText = rightText
    self.rightIcon = rightIcon
    self.bordered = bordered
    self.onLeftClick = onLeftClick
    self.onRightClick = onRightClick
  }

  public var body: some View {
    let appearance = LhNavbarStyle.resolveAppearance(
      bordered: bordered,
      hasLeft: !leftText.isEmpty || leftIcon != nil,
      hasRight: !rightText.isEmpty || rightIcon != nil,
      colors: colors
    )

    return ZStack {
      // 居中标题（水平居中于可用宽度）
      Text(title)
        .font(.system(size: appearance.titleFontSize, weight: Self.fontWeight(LhTokens.Typography.FontWeight.bold)))
        .foregroundColor(appearance.titleColor)
        .lineLimit(1)
        .truncationMode(.middle)

      HStack {
        sideContent(
          text: leftText, icon: leftIcon, appearance: appearance,
          // 黄金用例 no-left-content-no-onleftclick：无内容时不响应点击
          hasContent: appearance.hasLeft, action: onLeftClick
        )
        Spacer()
        sideContent(
          text: rightText, icon: rightIcon, appearance: appearance,
          hasContent: appearance.hasRight, action: onRightClick
        )
      }
    }
    .padding(.horizontal, appearance.paddingHorizontal)
    .frame(height: appearance.height)
    .frame(maxWidth: .infinity)
    .background(appearance.containerColor)
    .overlay(alignment: .bottom) {
      // 黄金用例 bordered-uses-border-token：底部绘制分隔线
      if appearance.bordered {
        Rectangle()
          .fill(appearance.borderColor)
          .frame(height: appearance.borderWidth)
      }
    }
    .zIndex(Double(LhTokens.ZIndex.sticky))
  }

  /// 左/右两侧内容（文字 + 图标），有内容时可点击
  @ViewBuilder
  private func sideContent(
    text: String,
    icon: String?,
    appearance: LhNavbarAppearance,
    hasContent: Bool,
    action: (() -> Void)?
  ) -> some View {
    if hasContent {
      HStack(spacing: LhTokens.Spacing.xs) {
        if let iconName = icon {
          LhIcon(name: iconName)
            .frame(width: appearance.iconSize, height: appearance.iconSize)
            .foregroundColor(appearance.sideColor)
        }
        if !text.isEmpty {
          Text(text)
            .font(.system(size: appearance.titleFontSize, weight: Self.fontWeight(LhTokens.Typography.FontWeight.primary)))
            .foregroundColor(appearance.sideColor)
        }
      }
      .contentShape(Rectangle())
      .onTapGesture {
        action?()
      }
    } else {
      // 无内容时占位，保持标题居中
      Color.clear.frame(width: 0, height: 0)
    }
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

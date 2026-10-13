import SwiftUI
import LhUITokens

/// 对话框类型。rawValue 与 spec 的 prop `type` 枚举值逐字对齐（R-n5）。
///
/// 决定确认按钮的语义色；取消按钮固定 default 类型。
public enum LhDialogType: String, CaseIterable, Sendable {
  case `default`
  case primary
  case success
  case warning
  case danger
  case info
}

/// 对话框外观解析结果。由 LhDialogStyle.resolveAppearance 纯函数产出，供 XCTest 断言。
public struct LhDialogAppearance: Equatable {
  public let width: CGFloat
  public let borderRadius: CGFloat
  public let paddingHorizontal: CGFloat
  public let paddingVertical: CGFloat
  public let titleFontSize: CGFloat
  public let contentFontSize: CGFloat
  public let gap: CGFloat
  public let containerColor: Color
  public let overlayColor: Color
  public let titleColor: Color
  public let contentColor: Color
  public let confirmColor: Color
  public let confirmTextColor: Color
  public let cancelTextColor: Color
  /// 是否可见（visible 为 false 时 View 不渲染）
  public let visible: Bool
  /// 是否允许点击遮罩关闭
  public let closable: Bool
}

/// 对话框令牌绑定与外观解析（纯函数，无 View 依赖）。
///
/// 令牌映射严格对齐 `lh-ui-core/specs/dialog.json` 的 behaviors：
/// - visible 为 false 时不渲染
/// - 内容卡宽度 dialog.width、圆角 dialog.borderRadius、内边距 dialog.padding*，
///   底色 color.background.default，投影 shadow.base
/// - 遮罩取 color.background.overlay
/// - 标题取 dialog.titleFontSize + color.text.primary，内容取 dialog.contentFontSize + color.text.regular
/// - 确认按钮按 type 映射语义色；取消按钮固定 default 类型
public enum LhDialogStyle {
  public static func resolveAppearance(
    visible: Bool,
    type: LhDialogType,
    closable: Bool,
    colors: LhColors
  ) -> LhDialogAppearance {
    let confirm: Color
    switch type {
    case .default: confirm = colors.primary
    case .primary: confirm = colors.primary
    case .success: confirm = colors.success
    case .warning: confirm = colors.warning
    case .danger: confirm = colors.danger
    case .info: confirm = colors.info
    }

    return LhDialogAppearance(
      width: LhTokens.Dialog.width,
      borderRadius: LhTokens.Dialog.borderRadius,
      paddingHorizontal: LhTokens.Dialog.paddingHorizontal,
      paddingVertical: LhTokens.Dialog.paddingVertical,
      titleFontSize: LhTokens.Dialog.titleFontSize,
      contentFontSize: LhTokens.Dialog.contentFontSize,
      gap: LhTokens.Dialog.gap,
      containerColor: colors.backgroundDefault,
      overlayColor: colors.backgroundOverlay,
      titleColor: colors.textPrimary,
      contentColor: colors.textRegular,
      confirmColor: confirm,
      confirmTextColor: colors.onPrimary,
      cancelTextColor: colors.textPrimary,
      visible: visible,
      closable: closable
    )
  }

  /// 令牌驱动的入场/出场动画时长（motion.duration.base，单位秒）
  public static let animationDuration = LhTokens.Motion.Duration.base
}

/// 对话框组件：声明式绑定的模态浮层。
///
/// props 与 `lh-ui-core/specs/dialog.json` 逐字对齐（`visible` 以 `@Binding` 暴露为
/// 声明式 API）；行为遵循 `cases/dialog.json` 的 8 条黄金用例（已翻译为 XCTest，
/// 见 Tests/LhUITests/LhDialogTests.swift）。
///
/// 层级取 zIndex.modal（遮罩 zIndex.modalBackdrop）；宿主将其叠加在内容之后。
public struct LhDialog: View {
  /// 是否可见（受控）
  @Binding public var visible: Bool
  /// 标题
  public var title: String = ""
  /// 内容
  public var content: String = ""
  /// 语义类型，决定确认按钮颜色
  public var type: LhDialogType = .default
  /// 确认按钮文字
  public var confirmText: String = "确认"
  /// 取消按钮文字
  public var cancelText: String = "取消"
  /// 是否允许点击遮罩关闭
  public var closable: Bool = false
  /// 确认回调；触发后随后触发 onClose（宿主据此置 visible 为 false）
  public var onConfirm: (() -> Void)? = nil
  /// 取消回调；触发后随后触发 onClose
  public var onCancel: (() -> Void)? = nil
  /// 关闭回调（确认/取消/遮罩点击后触发）
  public var onClose: (() -> Void)? = nil

  @Environment(\.lhColors) private var colors

  public init(
    visible: Binding<Bool>,
    title: String = "",
    content: String = "",
    type: LhDialogType = .default,
    confirmText: String = "确认",
    cancelText: String = "取消",
    closable: Bool = false,
    onConfirm: (() -> Void)? = nil,
    onCancel: (() -> Void)? = nil,
    onClose: (() -> Void)? = nil
  ) {
    self._visible = visible
    self.title = title
    self.content = content
    self.type = type
    self.confirmText = confirmText
    self.cancelText = cancelText
    self.closable = closable
    self.onConfirm = onConfirm
    self.onCancel = onCancel
    self.onClose = onClose
  }

  public var body: some View {
    let appearance = LhDialogStyle.resolveAppearance(
      visible: visible, type: type, closable: closable, colors: colors
    )

    // 黄金用例 hidden-not-rendered：不可见时不渲染任何内容
    return Group {
      if appearance.visible {
        ZStack {
          // 遮罩（zIndex.modalBackdrop）
          Rectangle()
            .fill(appearance.overlayColor)
            .zIndex(Double(LhTokens.ZIndex.modalBackdrop))
            .contentShape(Rectangle())
            .onTapGesture {
              // 黄金用例 closable-overlay-emits-onclose / not-closable-blocks-overlay-close
              guard appearance.closable else { return }
              close()
            }

          // 内容卡（zIndex.modal）
          VStack(spacing: appearance.gap) {
            if !title.isEmpty {
              Text(title)
                .font(.system(size: appearance.titleFontSize, weight: Self.fontWeight(LhTokens.Typography.FontWeight.bold)))
                .foregroundColor(appearance.titleColor)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            if !content.isEmpty {
              Text(content)
                .font(.system(size: appearance.contentFontSize, weight: Self.fontWeight(LhTokens.Typography.FontWeight.primary)))
                .foregroundColor(appearance.contentColor)
                .frame(maxWidth: .infinity, alignment: .leading)
                .fixedSize(horizontal: false, vertical: true)
            }

            HStack(spacing: appearance.gap) {
              // 取消按钮固定 default 类型
              LhButton(
                onClick: {
                  onCancel?()
                  close()  // 黄金用例 cancel-emits-oncancel
                },
                text: cancelText
              )
              .frame(maxWidth: .infinity)

              // 确认按钮按 type 映射语义色
              LhButton(
                onClick: {
                  onConfirm?()
                  close()  // 黄金用例 confirm-emits-onconfirm + confirm-also-emits-onclose
                },
                type: Self.buttonType(for: type),
                text: confirmText
              )
              .frame(maxWidth: .infinity)
            }
            .padding(.top, appearance.gap)
          }
          .padding(.horizontal, appearance.paddingHorizontal)
          .padding(.vertical, appearance.paddingVertical)
          .frame(width: appearance.width)
          .background(
            RoundedRectangle(cornerRadius: appearance.borderRadius)
              .fill(appearance.containerColor)
          )
          .shadow(
            color: LhTokens.Shadow.base.color,
            radius: LhTokens.Shadow.base.radius,
            x: LhTokens.Shadow.base.x,
            y: LhTokens.Shadow.base.y
          )
          .zIndex(Double(LhTokens.ZIndex.modal))
        }
      }
    }
    // 挂在 if 分支外层，显隐切换才会走动画；分支内的 .animation 对整体出现/消失无效
    .animation(.easeInOut(duration: LhDialogStyle.animationDuration), value: appearance.visible)
  }

  /// 关闭：置 visible 为 false 并触发 onClose
  private func close() {
    withAnimation(.easeInOut(duration: LhDialogStyle.animationDuration)) {
      visible = false
    }
    onClose?()
  }

  /// 对话框 type → 按钮类型（确认按钮的语义色映射）
  private static func buttonType(for type: LhDialogType) -> LhButtonType {
    switch type {
    case .default: return .primary
    case .primary: return .primary
    case .success: return .success
    case .warning: return .warning
    case .danger: return .danger
    case .info: return .info
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

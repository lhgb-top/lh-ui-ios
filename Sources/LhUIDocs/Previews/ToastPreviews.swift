import SwiftUI
import LhUI
import LhUITokens

// 本文件是手写真源（非生成物）—— Toast 文档的真交互预览。
// SCENE_MAP：类型→types、定位→position、自动消失→autoHide。
// 预览框内自挂一个真 LhToast（组件自身 dogfood），类型/定位/时长都能真改。

enum ToastPreviews {
  static func label(_ type: LhToastType) -> String {
    switch type {
    case .default: return "默认"
    case .success: return "成功"
    case .warning: return "警告"
    case .danger: return "危险"
    case .info: return "信息"
    }
  }

  static func positionLabel(_ position: LhToastPosition) -> String {
    switch position {
    case .top: return "顶部"
    case .center: return "居中"
    case .bottom: return "底部"
    }
  }

  static func types(_ scope: DocPreviewScope) -> AnyView {
    AnyView(DocPreviewFrame(title: "五种语义类型（圆点配色随 type）") {
      StatefulPreview(initial: (false, LhToastType.default)) { state in
        ZStack {
          PreviewLayout.row {
            ForEach(LhToastType.allCases, id: \.self) { type in
              LhButton(
                onClick: {
                  state.wrappedValue.1 = type
                  state.wrappedValue.0 = true
                },
                type: buttonType(type),
                text: label(type)
              )
            }
          }
          LhToast(
            visible: visibleBinding(state),
            text: "\(label(state.wrappedValue.1))提示",
            type: state.wrappedValue.1
          )
        }
      }
    })
  }

  static func position(_ scope: DocPreviewScope) -> AnyView {
    AnyView(DocPreviewFrame(title: "top / center / bottom 三种定位") {
      StatefulPreview(initial: (false, LhToastPosition.center)) { state in
        ZStack {
          PreviewLayout.row {
            ForEach(LhToastPosition.allCases, id: \.self) { position in
              LhButton(
                onClick: {
                  state.wrappedValue.1 = position
                  state.wrappedValue.0 = true
                },
                type: .primary,
                text: positionLabel(position)
              )
            }
          }
          LhToast(
            visible: visibleBinding(state),
            text: "\(positionLabel(state.wrappedValue.1))提示",
            position: state.wrappedValue.1
          )
        }
      }
    })
  }

  static func autoHide(_ scope: DocPreviewScope) -> AnyView {
    AnyView(DocPreviewFrame(title: "duration 到期自动隐藏并触发 onClose；手动置 false 不触发") {
      StatefulPreview(initial: false) { $visible in
        ZStack {
          PreviewLayout.column {
            PreviewLayout.row {
              LhButton(onClick: { visible.wrappedValue = true }, type: .primary, text: "显示 2 秒提示")
            }
            PreviewCaption(text: "onClose 只在自动消失时触发（hide-is-silent）")
          }
          LhToast(
            visible: $visible,
            text: "2 秒后自动消失",
            type: .success,
            duration: 2000,
            position: .bottom
          ) {
            scope.showToast("onClose：提示已自动消失")
          }
        }
      }
    })
  }

  /// Toast 类型无 primary，触发按钮配色按同语义取（default → 默认色）
  static func buttonType(_ type: LhToastType) -> LhButtonType {
    switch type {
    case .default: return .default
    case .success: return .success
    case .warning: return .warning
    case .danger: return .danger
    case .info: return .info
    }
  }

  /// 从「显隐 + 类型」组合状态拆出 visible 绑定
  private static func visibleBinding(_ state: Binding<(Bool, LhToastType)>) -> Binding<Bool> {
    Binding(get: { state.wrappedValue.0 }, set: { state.wrappedValue.0 = $0 })
  }

  private static func visibleBinding(_ state: Binding<(Bool, LhToastPosition)>) -> Binding<Bool> {
    Binding(get: { state.wrappedValue.0 }, set: { state.wrappedValue.0 = $0 })
  }
}

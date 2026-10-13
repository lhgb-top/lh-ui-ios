import SwiftUI
import LhUI
import LhUITokens

// 本文件是手写真源（非生成物）—— Dialog 文档的真交互预览。
// SCENE_MAP：类型→types、显隐与回调→visibleAndCallbacks。
// Dialog 是浮层，挂在预览框内的 ZStack 上（预览自包含，不依赖宿主开浮层）。

enum DialogPreviews {
  static func label(_ type: LhDialogType) -> String {
    switch type {
    case .default: return "默认"
    case .primary: return "主要"
    case .success: return "成功"
    case .warning: return "警告"
    case .danger: return "危险"
    case .info: return "信息"
    }
  }

  /// 对话框类型 → 同语义的按钮类型（触发按钮配色与对话框一致）
  static func buttonType(_ type: LhDialogType) -> LhButtonType {
    switch type {
    case .default: return .default
    case .primary: return .primary
    case .success: return .success
    case .warning: return .warning
    case .danger: return .danger
    case .info: return .info
    }
  }

  /// 从「显隐 + 类型」组合状态拆出 visible 绑定
  private static func visibleBinding(_ state: Binding<(Bool, LhDialogType)>) -> Binding<Bool> {
    Binding(get: { state.wrappedValue.0 }, set: { state.wrappedValue.0 = $0 })
  }

  static func types(_ scope: DocPreviewScope) -> AnyView {
    AnyView(DocPreviewFrame(title: "六种语义类型（确认按钮配色随 type）") {
      StatefulPreview(initial: (false, LhDialogType.default)) { state in
        ZStack {
          PreviewLayout.row {
            ForEach(LhDialogType.allCases, id: \.self) { type in
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
          LhDialog(
            visible: visibleBinding(state),
            title: "\(label(state.wrappedValue.1)) 对话框",
            content: "确认按钮取 type 的语义色；标题与正文由 title / content 承载。",
            type: state.wrappedValue.1
          )
        }
      }
    })
  }

  static func visibleAndCallbacks(_ scope: DocPreviewScope) -> AnyView {
    AnyView(DocPreviewFrame(title: "确认 → onConfirm + onClose；取消 → onCancel；遮罩（closable）→ onClose") {
      StatefulPreview(initial: false) { $visible in
        ZStack {
          PreviewLayout.row {
            LhButton(onClick: { visible.wrappedValue = true }, type: .primary, text: "弹出对话框")
          }
          LhDialog(
            visible: $visible,
            title: "回调演示",
            content: "点击遮罩也可关闭（closable = true）；关闭即触发 onClose。",
            type: .warning,
            closable: true,
            onConfirm: { scope.showToast("onConfirm：点击了确认") },
            onCancel: { scope.showToast("onCancel：点击了取消") },
            onClose: { scope.showToast("onClose：对话框已关闭") }
          )
        }
      }
    })
  }
}

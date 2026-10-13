import SwiftUI
import LhUI
import LhUITokens

// 本文件是手写真源（非生成物）—— Picker 文档的真交互预览。
// SCENE_MAP：基本形态→basic、滚轮交互→wheel、回调与边界→callbacksAndBounds。
// Picker 是底部浮层，挂在预览框内的 ZStack 上（预览自包含）。

enum PickerPreviews {
  static let options = ["选项一", "选项二", "选项三", "选项四", "选项五"]

  static func basic(_ scope: DocPreviewScope) -> AnyView {
    AnyView(DocPreviewFrame(title: "点击触发，底部弹出滚轮选择器") {
      StatefulPreview(initial: (false, 0)) { state in
        ZStack {
          PreviewLayout.row {
            LhButton(onClick: { state.wrappedValue.0 = true }, type: .primary, text: "选择一项")
          }
          LhPicker(
            visible: visibleBinding(state),
            options: options,
            value: valueBinding(state),
            title: "请选择",
            onConfirm: { index in
              scope.showToast("确认了：\(options[index])")
            }
          )
        }
      }
    })
  }

  static func wheel(_ scope: DocPreviewScope) -> AnyView {
    AnyView(DocPreviewFrame(title: "拖动滚轮，松手吸附最近项并触发 onValueChange") {
      StatefulPreview(initial: (false, 2)) { state in
        ZStack {
          PreviewLayout.row {
            LhButton(onClick: { state.wrappedValue.0 = true }, type: .primary, text: "拖动滚轮")
            PreviewCaption(text: "吸附后当前值：\(options[state.wrappedValue.1])")
          }
          LhPicker(
            visible: visibleBinding(state),
            options: options,
            value: valueBinding(state),
            title: "拖动并松手",
            onValueChange: { index in
              scope.showToast("onValueChange：\(options[index])")
            }
          )
        }
      }
    })
  }

  static func callbacksAndBounds(_ scope: DocPreviewScope) -> AnyView {
    AnyView(DocPreviewFrame(title: "onConfirm 带 payload；value 越界由端侧 clamp") {
      StatefulPreview(initial: (false, 99)) { state in
        ZStack {
          PreviewLayout.column {
            PreviewLayout.row {
              LhButton(onClick: { state.wrappedValue.0 = true }, type: .primary, text: "初值 99（越界）")
            }
            PreviewCaption(text: "越界值 clamp 到末项；确认 payload 是 clamp 后的索引")
          }
          LhPicker(
            visible: visibleBinding(state),
            options: options,
            value: valueBinding(state),
            title: "回调与边界",
            onValueChange: { index in
              scope.showToast("onValueChange：第 \(index) 项")
            },
            onConfirm: { index in
              scope.showToast("onConfirm：\(options[index])（第 \(index) 项）")
            },
            onCancel: {
              scope.showToast("onCancel：取消了选择")
            }
          )
        }
      }
    })
  }

  /// 从「显隐 + 索引」组合状态拆出 visible 绑定
  private static func visibleBinding(_ state: Binding<(Bool, Int)>) -> Binding<Bool> {
    Binding(get: { state.wrappedValue.0 }, set: { state.wrappedValue.0 = $0 })
  }

  /// 从「显隐 + 索引」组合状态拆出 value 绑定
  private static func valueBinding(_ state: Binding<(Bool, Int)>) -> Binding<Int> {
    Binding(get: { state.wrappedValue.1 }, set: { state.wrappedValue.1 = $0 })
  }
}

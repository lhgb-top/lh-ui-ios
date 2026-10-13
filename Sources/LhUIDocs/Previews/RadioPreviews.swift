import SwiftUI
import LhUI
import LhUITokens

// 本文件是手写真源（非生成物）—— Radio 文档的真交互预览。
// SCENE_MAP：状态→states、尺寸→sizes、点击 gate→clickGate。

enum RadioPreviews {
  /// 单选互斥封装：binding 持的是「当前选中值」，勾选符按「值相等」推导
  static func option(
    _ value: String,
    label: String,
    current: Binding<String>,
    disabled: Bool = false,
    scope: DocPreviewScope
  ) -> some View {
    LhRadio(
      checked: Binding(
        get: { current.wrappedValue == value },
        set: { if $0 { current.wrappedValue = value } }
      ),
      disabled: disabled,
      label: label,
      value: value
    ) { checked in
      if checked { scope.showToast("选中了 \(label)") }
    }
  }

  static func states(_ scope: DocPreviewScope) -> AnyView {
    AnyView(DocPreviewFrame(title: "单选组（同一绑定互斥）") {
      StatefulPreview(initial: "a") { $current in
        PreviewLayout.column {
          option("a", label: "选项 A", current: $current, scope: scope)
          option("b", label: "选项 B", current: $current, scope: scope)
          option("c", label: "选项 C", current: $current, scope: scope)
          PreviewCaption(text: "onChange 只在「变为选中」时才是 true，取消选中由改选另一项带出")
        }
      }
    })
  }

  static func sizes(_ scope: DocPreviewScope) -> AnyView {
    AnyView(DocPreviewFrame(title: "三种尺寸（每组各自互斥）") {
      StatefulPreview(initial: ["a", "a", "a"]) { $current in
        PreviewLayout.columnGroup {
          ForEach(Array(LhRadioSize.allCases.enumerated()), id: \.offset) { index, size in
            PreviewLayout.column {
              option("a", label: "\(size.rawValue) · 选项一", current: $current.element(index), scope: scope)
              option("b", label: "\(size.rawValue) · 选项二", current: $current.element(index), scope: scope)
            }
          }
        }
      }
    })
  }

  static func clickGate(_ scope: DocPreviewScope) -> AnyView {
    AnyView(DocPreviewFrame(title: "disabled 为 true 时点击不触发 onChange") {
      PreviewLayout.column {
        LhRadio(checked: .constant(false), disabled: true, label: "禁用态（未选中）") { _ in
          scope.showToast("禁用态不该响应")
        }
        LhRadio(checked: .constant(true), disabled: true, label: "禁用态（选中）") { _ in
          scope.showToast("禁用态不该响应")
        }
        PreviewCaption(text: "与黄金用例 disabled-no-onchange 对齐：禁用时既不切状态也不发回调")
      }
    })
  }
}

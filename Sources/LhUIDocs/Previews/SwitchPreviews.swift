import SwiftUI
import LhUI
import LhUITokens

// 本文件是手写真源（非生成物）—— Switch 文档的真交互预览。
// SCENE_MAP：状态→states、尺寸→sizes、加载态→loadingState。

enum SwitchPreviews {
  static func states(_ scope: DocPreviewScope) -> AnyView {
    AnyView(DocPreviewFrame(title: "开 / 关 / 禁用（onChange 报状态）") {
      StatefulPreview(initial: true) { $on in
        PreviewLayout.column {
          LhSwitch(checked: $on) { value in
            scope.showToast(value ? "打开了开关" : "关闭了开关")
          }
          LhSwitch(checked: .constant(true), disabled: true)
          LhSwitch(checked: .constant(false), disabled: true)
        }
      }
    })
  }

  static func sizes(_ scope: DocPreviewScope) -> AnyView {
    AnyView(DocPreviewFrame(title: "三种尺寸（联动演示）") {
      StatefulPreview(initial: [true, false, true]) { $on in
        PreviewLayout.column {
          ForEach(Array(LhSwitchSize.allCases.enumerated()), id: \.offset) { index, size in
            LhSwitch(checked: $on.element(index), size: size) { value in
              scope.showToast("\(size.rawValue) 号：\(value ? "打开" : "关闭")")
            }
          }
        }
      }
    })
  }

  static func loadingState(_ scope: DocPreviewScope) -> AnyView {
    AnyView(DocPreviewFrame(title: "loading 为 true 时显示指示器且不响应点击") {
      PreviewLayout.column {
        LhSwitch(checked: .constant(true), loading: true)
        LhSwitch(checked: .constant(false), loading: true)
        PreviewCaption(text: "异步操作期间置 loading，避免用户在请求进行中反复切换")
      }
    })
  }
}

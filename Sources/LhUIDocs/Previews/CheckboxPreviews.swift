import SwiftUI
import LhUI
import LhUITokens

// 本文件是手写真源（非生成物）—— Checkbox 文档的真交互预览。
// SCENE_MAP：状态→states、尺寸→sizes、不确定态→indeterminate。

enum CheckboxPreviews {
  static func states(_ scope: DocPreviewScope) -> AnyView {
    AnyView(DocPreviewFrame(title: "选中 / 未选中 / 禁用（onChange 报状态）") {
      StatefulPreview(initial: true) { $checked in
        PreviewLayout.column {
          LhCheckbox(checked: $checked, label: "受控复选框") { value in
            scope.showToast(value ? "勾选了" : "取消了勾选")
          }
          LhCheckbox(checked: .constant(false), disabled: true, label: "禁用态（未选中）")
          LhCheckbox(checked: .constant(true), disabled: true, label: "禁用态（选中）")
        }
      }
    })
  }

  static func sizes(_ scope: DocPreviewScope) -> AnyView {
    AnyView(DocPreviewFrame(title: "三种尺寸（各自独立勾选）") {
      StatefulPreview(initial: [true, false, true]) { $checked in
        PreviewLayout.column {
          ForEach(Array(LhCheckboxSize.allCases.enumerated()), id: \.offset) { index, size in
            LhCheckbox(checked: $checked.element(index), size: size, label: "\(size.rawValue) 号") { value in
              scope.showToast("\(size.rawValue) 号：\(value ? "勾选了" : "取消了勾选")")
            }
          }
        }
      }
    })
  }

  static func indeterminate(_ scope: DocPreviewScope) -> AnyView {
    AnyView(DocPreviewFrame(title: "indeterminate 优先于 checked，勾选符为横杠") {
      StatefulPreview(initial: false) { $checked in
        PreviewLayout.column {
          LhCheckbox(checked: $checked, indeterminate: true, label: "不确定态（点击看 onChange）") { value in
            scope.showToast("不确定态点击后：\(value ? "选中" : "未选中")")
          }
          PreviewCaption(text: "常用于「全选」的中间态：子项部分选中时由宿主置 indeterminate")
        }
      }
    })
  }
}

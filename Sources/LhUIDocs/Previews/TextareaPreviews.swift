import SwiftUI
import LhUI
import LhUITokens

// 本文件是手写真源（非生成物）—— Textarea 文档的真交互预览。
// SCENE_MAP：基本形态→basic、字数计数→count。

enum TextareaPreviews {
  static func basic(_ scope: DocPreviewScope) -> AnyView {
    AnyView(DocPreviewFrame(title: "多行输入 / rows 行数 / 禁用") {
      StatefulPreview(initial: "") { $value in
        PreviewLayout.column {
          TextareaWrapper(value: $value, placeholder: "请输入多行内容", scope: scope)
          LhTextarea(value: .constant("只读多行内容\n第二行"), placeholder: "占位", rows: 4, readonly: true)
          LhTextarea(value: .constant(""), placeholder: "禁用态", rows: 3, disabled: true)
        }
      }
    })
  }

  static func count(_ scope: DocPreviewScope) -> AnyView {
    AnyView(DocPreviewFrame(title: "showCount 显示计数，maxlength 限长（到顶不再输入）") {
      StatefulPreview(initial: "") { $value in
        LhTextarea(
          value: $value,
          placeholder: "最多 20 个字",
          rows: 3,
          showCount: true,
          maxlength: 20,
          onValueChange: { newValue in
            scope.showToast("当前 \(newValue.count) / 20 个字")
          }
        )
      }
    })
  }
}

/// Textarea 的 onChange 包一层：长文本里换行符较多，用「字符数」报反馈更直观
private struct TextareaWrapper: View {
  @Binding var value: String
  let placeholder: String
  let scope: DocPreviewScope

  var body: some View {
    LhTextarea(value: $value, placeholder: placeholder, rows: 3, onValueChange: { newValue in
      scope.showToast("输入了 \(newValue.count) 个字")
    })
  }
}

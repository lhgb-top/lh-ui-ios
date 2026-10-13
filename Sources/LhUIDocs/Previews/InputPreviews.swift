import SwiftUI
import LhUI
import LhUITokens

// 本文件是手写真源（非生成物）—— Input 文档的真交互预览。
// SCENE_MAP：基本形态→basic、尺寸→sizes、密码与清除→passwordAndClearable。

enum InputPreviews {
  static func basic(_ scope: DocPreviewScope) -> AnyView {
    AnyView(DocPreviewFrame(title: "placeholder / 受控值 / 禁用 / 只读") {
      StatefulPreview(initial: "") { $value in
        PreviewLayout.column {
          LhInput(value: $value, placeholder: "请输入内容", onValueChange: { newValue in
            scope.showToast("值变为：\(newValue)")
          })
          LhInput(value: .constant("只读内容"), placeholder: "占位文字", readonly: true)
          LhInput(value: .constant(""), placeholder: "禁用态", disabled: true)
        }
      }
    })
  }

  static func sizes(_ scope: DocPreviewScope) -> AnyView {
    AnyView(DocPreviewFrame(title: "三种尺寸（字号与高度随令牌映射）") {
      StatefulPreview(initial: ["", "", ""]) { $values in
        PreviewLayout.column {
          ForEach(Array(LhInputSize.allCases.enumerated()), id: \.offset) { index, size in
            LhInput(value: $values.element(index), placeholder: "\(size.rawValue) 号输入框", size: size)
          }
        }
      }
    })
  }

  static func passwordAndClearable(_ scope: DocPreviewScope) -> AnyView {
    AnyView(DocPreviewFrame(title: "password 密文 + clearable 一键清除（maxlength 限长）") {
      StatefulPreview(initial: ["secret123", ""]) { $values in
        PreviewLayout.column {
          LhInput(value: $values.element(0), placeholder: "密码", type: .password, clearable: true)
          LhInput(
            value: $values.element(1),
            placeholder: "最多 8 个字",
            clearable: true,
            maxlength: 8,
            onValueChange: { newValue in
              scope.showToast("当前 \(newValue.count) / 8 个字")
            }
          )
        }
      }
    })
  }
}

import SwiftUI
import LhUI
import LhUITokens

struct TextareaDemo: View {
  @State private var text = ""
  @State private var counted = "青花"

  var body: some View {
    VStack(spacing: LhTokens.Spacing.base) {
      LhTextarea(value: $text, placeholder: "请输入长文本…", rows: 3) { _ in }
      LhTextarea(value: $counted, placeholder: "字数统计", rows: 3, showCount: true, maxlength: 10) { _ in }
      LhTextarea(value: $counted, placeholder: "无最大长度", rows: 2, showCount: true) { _ in }
      LhTextarea(value: .constant("禁用态内容"), placeholder: "禁用", rows: 2, disabled: true)
      LhTextarea(value: .constant("只读态内容"), placeholder: "只读", rows: 2, readonly: true)
    }
  }
}

#Preview("多行输入框") {
  LhTheme {
    TextareaDemo()
      .padding(LhTokens.Spacing.base)
  }
}

#Preview("暗色主题") {
  LhTheme(isDark: true) {
    TextareaDemo()
      .padding(LhTokens.Spacing.base)
      .background(Color.black)
  }
}

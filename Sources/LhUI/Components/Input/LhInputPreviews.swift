import SwiftUI
import LhUI
import LhUITokens

struct InputDemo: View {
  @State private var text = ""
  @State private var password = ""
  @State private var withValue = "青花瓷"

  var body: some View {
    VStack(spacing: LhTokens.Spacing.base) {
      LhInput(value: $text, placeholder: "请输入关键词") { _ in }
      LhInput(value: $withValue, placeholder: "可清除", clearable: true) { _ in }
      LhInput(value: $password, placeholder: "密码", type: .password) { _ in }
      LhInput(value: .constant("禁用态"), placeholder: "禁用", disabled: true)
      LhInput(value: .constant("只读态"), placeholder: "只读", readonly: true)
      LhInput(value: $text, placeholder: "最大 6 字", maxlength: 6) { _ in }
      VStack(alignment: .leading, spacing: LhTokens.Spacing.sm) {
        Text("small / medium / large").font(.caption).foregroundColor(.secondary)
        HStack {
          LhInput(value: $text, placeholder: "小", size: .small) { _ in }
          LhInput(value: $text, placeholder: "中", size: .medium) { _ in }
          LhInput(value: $text, placeholder: "大", size: .large) { _ in }
        }
      }
    }
  }
}

#Preview("输入框") {
  LhTheme {
    InputDemo()
      .padding(LhTokens.Spacing.base)
  }
}

#Preview("暗色主题") {
  LhTheme(isDark: true) {
    InputDemo()
      .padding(LhTokens.Spacing.base)
      .background(Color.black)
  }
}

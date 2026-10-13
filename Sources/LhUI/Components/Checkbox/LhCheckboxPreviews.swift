import SwiftUI
import LhUI
import LhUITokens

struct CheckboxDemo: View {
  @State private var checked = false
  @State private var indeterminate = true
  @State private var disabled = true

  var body: some View {
    VStack(alignment: .leading, spacing: LhTokens.Spacing.md) {
      LhCheckbox(checked: $checked, label: "同意用户协议") { _ in }
      LhCheckbox(checked: .constant(true), label: "已选中")
      LhCheckbox(checked: .constant(false), indeterminate: true, label: "不确定态")
      LhCheckbox(checked: $disabled, disabled: true, label: "禁用态")
      LhCheckbox(checked: .constant(true), size: .small, label: "小号")
      LhCheckbox(checked: .constant(true), size: .large, label: "大号")
    }
  }
}

#Preview("复选框") {
  LhTheme {
    CheckboxDemo()
      .padding(LhTokens.Spacing.base)
  }
}

#Preview("暗色主题") {
  LhTheme(isDark: true) {
    CheckboxDemo()
      .padding(LhTokens.Spacing.base)
      .background(Color.black)
  }
}

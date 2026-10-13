import SwiftUI
import LhUI
import LhUITokens

struct RadioDemo: View {
  @State private var selected = "青花"

  var body: some View {
    VStack(alignment: .leading, spacing: LhTokens.Spacing.md) {
      LhRadio(checked: Binding(get: { selected == "青花" }, set: { if $0 { selected = "青花" } }),
              label: "青花", value: "青花") { _ in }
      LhRadio(checked: Binding(get: { selected == "玲珑" }, set: { if $0 { selected = "玲珑" } }),
              label: "玲珑", value: "玲珑") { _ in }
      LhRadio(checked: .constant(false), label: "未选中")
      LhRadio(checked: .constant(true), disabled: true, label: "禁用选中")
      LhRadio(checked: .constant(false), disabled: true, label: "禁用未选中")
      HStack(spacing: LhTokens.Spacing.base) {
        LhRadio(checked: .constant(true), size: .small)
        LhRadio(checked: .constant(true), size: .medium)
        LhRadio(checked: .constant(true), size: .large)
      }
    }
  }
}

#Preview("单选框") {
  LhTheme {
    RadioDemo()
      .padding(LhTokens.Spacing.base)
  }
}

#Preview("暗色主题") {
  LhTheme(isDark: true) {
    RadioDemo()
      .padding(LhTokens.Spacing.base)
      .background(Color.black)
  }
}

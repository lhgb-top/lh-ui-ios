import SwiftUI
import LhUI
import LhUITokens

struct SwitchDemo: View {
  @State private var on = true
  @State private var off = false
  @State private var loading = true

  var body: some View {
    VStack(alignment: .leading, spacing: LhTokens.Spacing.base) {
      HStack {
        LhSwitch(checked: $on) { _ in }
        LhSwitch(checked: $off) { _ in }
      }
      HStack {
        LhSwitch(checked: .constant(true), disabled: true)
        LhSwitch(checked: .constant(false), disabled: true)
        LhSwitch(checked: .constant(true), loading: true)
      }
      HStack(spacing: LhTokens.Spacing.lg) {
        LhSwitch(checked: .constant(true), size: .small)
        LhSwitch(checked: .constant(true), size: .medium)
        LhSwitch(checked: .constant(true), size: .large)
      }
    }
  }
}

#Preview("开关") {
  LhTheme {
    SwitchDemo()
      .padding(LhTokens.Spacing.base)
  }
}

#Preview("暗色主题") {
  LhTheme(isDark: true) {
    SwitchDemo()
      .padding(LhTokens.Spacing.base)
      .background(Color.black)
  }
}

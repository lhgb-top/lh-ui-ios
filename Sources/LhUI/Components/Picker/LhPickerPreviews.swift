import SwiftUI
import LhUI
import LhUITokens

struct PickerDemo: View {
  @State private var visible = false
  @State private var value = 1
  let options = ["青花瓷", "玲珑瓷", "粉彩瓷", "颜色釉", "珐琅彩"]

  var body: some View {
    ZStack {
      VStack(spacing: LhTokens.Spacing.base) {
        Text("当前选择：\(options[value])")
        LhButton(onClick: { visible = true }, type: .primary, text: "打开选择器")
      }
      .padding(LhTokens.Spacing.base)

      LhPicker(
        visible: $visible,
        options: options,
        value: $value,
        title: "选择瓷器品类",
        onValueChange: { print("scrolled to \($0)") },
        onConfirm: { print("confirmed \($0)") },
        onCancel: { print("cancelled") },
        onClose: { print("closed") }
      )
    }
  }
}

#Preview("选择器") {
  LhTheme {
    PickerDemo()
  }
}

#Preview("暗色主题") {
  LhTheme(isDark: true) {
    PickerDemo()
      .background(Color.black)
  }
}

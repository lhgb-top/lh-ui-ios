import SwiftUI
import LhUI
import LhUITokens

struct DialogDemo: View {
  @State private var visible = false
  @State private var dangerVisible = false

  var body: some View {
    ZStack {
      VStack(spacing: LhTokens.Spacing.base) {
        LhButton(onClick: { visible = true }, type: .primary, text: "打开对话框")
        LhButton(onClick: { dangerVisible = true }, type: .danger, text: "危险确认")
      }
      .padding(LhTokens.Spacing.base)

      LhDialog(
        visible: $visible,
        title: "青花瓷",
        content: "确认将这件青花瓷加入购物车？",
        onConfirm: { print("confirmed") },
        onCancel: { print("cancelled") },
        onClose: { print("closed") }
      )

      LhDialog(
        visible: $dangerVisible,
        title: "删除确认",
        content: "删除后不可恢复，确认删除？",
        type: .danger,
        confirmText: "删除",
        onConfirm: { print("deleted") },
        onClose: { print("closed") }
      )
    }
  }
}

#Preview("对话框") {
  LhTheme {
    DialogDemo()
  }
}

#Preview("可点击遮罩关闭") {
  LhTheme {
    ZStack {
      Color.gray.opacity(0.2).ignoresSafeArea()
      Text("背后的内容").padding()
      LhDialog(
        visible: .constant(true),
        title: "点击遮罩可关闭",
        content: "closable 为 true 时点击遮罩触发 onClose",
        closable: true,
        onClose: { print("overlay closed") }
      )
    }
  }
}

#Preview("暗色主题") {
  LhTheme(isDark: true) {
    DialogDemo()
    .background(Color.black)
  }
}

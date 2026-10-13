import SwiftUI
import LhUI
import LhUITokens

struct ToastDemo: View {
  @State private var visible = false

  var body: some View {
    ZStack {
      VStack(spacing: LhTokens.Spacing.base) {
        LhButton(onClick: { visible = true }, type: .primary, text: "显示轻提示")
      }
      .padding(LhTokens.Spacing.base)

      LhToast(visible: $visible, text: "已加入购物车", type: .success) {
        print("toast auto hidden")
      }
    }
  }
}

#Preview("轻提示") {
  LhTheme {
    ToastDemo()
  }
}

#Preview("类型与定位") {
  LhTheme {
    ZStack {
      LhToast(visible: .constant(true), text: "默认提示（顶部）", position: .top)
      LhToast(visible: .constant(true), text: "成功", type: .success, position: .center)
      LhToast(visible: .constant(true), text: "操作有误，请重试", type: .danger, position: .bottom)
    }
  }
}

#Preview("暗色主题") {
  LhTheme(isDark: true) {
    ZStack {
      Text("背后的内容").padding()
      LhToast(visible: .constant(true), text: "暗色墨底提示", type: .info)
    }
    .background(Color.black)
  }
}

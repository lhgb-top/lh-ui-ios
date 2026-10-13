import SwiftUI
import LhUI

#Preview("基础用法") {
  LhTheme {
    VStack(spacing: 0) {
      LhNavbar(title: "青花瓷")
      LhNavbar(
        title: "带两侧按钮",
        leftText: "返回",
        rightText: "编辑",
        onLeftClick: { print("left") },
        onRightClick: { print("right") }
      )
      LhNavbar(
        title: "图标按钮",
        leftIcon: "arrow-left",
        rightIcon: "more",
        onLeftClick: { print("left") },
        onRightClick: { print("right") }
      )
      LhNavbar(title: "无边框", bordered: false)
      Spacer()
    }
  }
}

#Preview("仅左侧 / 仅右侧") {
  LhTheme {
    VStack(spacing: 0) {
      LhNavbar(title: "仅左侧", leftText: "返回", onLeftClick: { print("left") })
      LhNavbar(title: "仅右侧", rightText: "完成", onRightClick: { print("right") })
      LhNavbar(title: "两侧文字 + 图标", leftText: "返回", leftIcon: "arrow-left", rightText: "分享", rightIcon: "share")
      Spacer()
    }
  }
}

#Preview("暗色主题") {
  LhTheme(isDark: true) {
    VStack(spacing: 0) {
      LhNavbar(title: "青花瓷", leftText: "返回", rightIcon: "more")
      Spacer()
    }
    .background(Color.black)
  }
}

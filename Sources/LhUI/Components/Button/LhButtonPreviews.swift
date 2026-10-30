import SwiftUI
import LhUI
import LhUITokens

/// 组件预览（等价于文档示例的第一现场）。#Preview 在 Xcode 中实时渲染，无需运行设备。
/// 覆盖 spec 中全部 type × size 组合 + 状态变体。
#Preview("类型：全部") {
  LhTheme {
    VStack(spacing: LhTokens.Spacing.sm) {
      LhButton(lhOnClick: {}, text: "默认按钮")
      LhButton(lhOnClick: {}, type: .primary, text: "主要按钮")
      LhButton(lhOnClick: {}, type: .success, text: "成功按钮")
      LhButton(lhOnClick: {}, type: .warning, text: "警告按钮")
      LhButton(lhOnClick: {}, type: .danger, text: "危险按钮")
      LhButton(lhOnClick: {}, type: .info, text: "信息按钮")
    }
    .padding(LhTokens.Spacing.base)
  }
}

#Preview("尺寸：small / medium / large") {
  LhTheme {
    VStack(spacing: LhTokens.Spacing.sm) {
      LhButton(lhOnClick: {}, lhSize: .small, text: "小型按钮")
      LhButton(lhOnClick: {}, lhSize: .medium, text: "中型按钮")
      LhButton(lhOnClick: {}, lhSize: .large, text: "大型按钮")
    }
    .padding(LhTokens.Spacing.base)
  }
}

#Preview("状态：禁用 / 加载中") {
  LhTheme {
    VStack(spacing: LhTokens.Spacing.sm) {
      LhButton(lhOnClick: {}, type: .primary, disabled: true, text: "禁用按钮")
      LhButton(lhOnClick: {}, type: .primary, loading: true, text: "加载中")
      LhButton(lhOnClick: {}, type: .primary, disabled: true, loading: true, text: "禁用优先")
    }
    .padding(LhTokens.Spacing.base)
  }
}

#Preview("图标与花纹底") {
  LhTheme {
    VStack(spacing: LhTokens.Spacing.sm) {
      LhButton(lhOnClick: {}, type: .primary, icon: "search", text: "搜索")
      LhButton(lhOnClick: {}, type: .primary, bgPattern: true, text: "花纹底")
    }
    .padding(LhTokens.Spacing.base)
  }
}

#Preview("暗色主题") {
  LhTheme(isDark: true) {
    VStack(spacing: LhTokens.Spacing.sm) {
      LhButton(lhOnClick: {}, type: .primary, text: "主要按钮")
      LhButton(lhOnClick: {}, text: "默认按钮")
      LhButton(lhOnClick: {}, type: .primary, disabled: true, text: "禁用")
    }
    .padding(LhTokens.Spacing.base)
    .background(Color.black)
  }
}

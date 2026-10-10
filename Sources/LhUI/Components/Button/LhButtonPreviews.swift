import SwiftUI
import LhUI

/// 组件预览（等价于文档示例的第一现场）。#Preview 在 Xcode 中实时渲染，无需运行设备。
/// 覆盖 spec 中全部 type × size 组合 + 状态变体。
#Preview("类型：全部") {
  LhTheme {
    VStack(spacing: 8) {
      LhButton(onClick: {}, text: "默认按钮")
      LhButton(onClick: {}, type: .primary, text: "主要按钮")
      LhButton(onClick: {}, type: .success, text: "成功按钮")
      LhButton(onClick: {}, type: .warning, text: "警告按钮")
      LhButton(onClick: {}, type: .danger, text: "危险按钮")
      LhButton(onClick: {}, type: .info, text: "信息按钮")
    }
    .padding(16)
  }
}

#Preview("尺寸：small / medium / large") {
  LhTheme {
    VStack(spacing: 8) {
      LhButton(onClick: {}, size: .small, text: "小型按钮")
      LhButton(onClick: {}, size: .medium, text: "中型按钮")
      LhButton(onClick: {}, size: .large, text: "大型按钮")
    }
    .padding(16)
  }
}

#Preview("状态：禁用 / 加载中") {
  LhTheme {
    VStack(spacing: 8) {
      LhButton(onClick: {}, type: .primary, disabled: true, text: "禁用按钮")
      LhButton(onClick: {}, type: .primary, loading: true, text: "加载中")
      LhButton(onClick: {}, type: .primary, disabled: true, loading: true, text: "禁用优先")
    }
    .padding(16)
  }
}

#Preview("图标与花纹底") {
  LhTheme {
    VStack(spacing: 8) {
      LhButton(onClick: {}, type: .primary, icon: "search", text: "搜索")
      LhButton(onClick: {}, type: .primary, bgPattern: true, text: "花纹底")
    }
    .padding(16)
  }
}

#Preview("暗色主题") {
  LhTheme(isDark: true) {
    VStack(spacing: 8) {
      LhButton(onClick: {}, type: .primary, text: "主要按钮")
      LhButton(onClick: {}, text: "默认按钮")
      LhButton(onClick: {}, type: .primary, disabled: true, text: "禁用")
    }
    .padding(16)
    .background(Color.black)
  }
}

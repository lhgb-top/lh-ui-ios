import SwiftUI
import LhUI
import LhUITokens

/// 图标组件预览。#Preview 即文档（第一现场）。
#Preview("全部图标") {
  LhTheme {
    let icons = LhIconMap.names
    ScrollView {
      LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 6), spacing: LhTokens.Spacing.base) {
        ForEach(icons, id: \.self) { name in
          VStack(spacing: LhTokens.Spacing.xs) {
            LhIcon(name: name)
            Text(name)
              .font(.system(size: LhTokens.Typography.FontSize.extraSmall))
              .foregroundColor(.secondary)
          }
        }
      }
      .padding(LhTokens.Spacing.base)
    }
  }
}

#Preview("尺寸：small / medium / large") {
  LhTheme {
    HStack(spacing: LhTokens.Spacing.xl) {
      LhIcon(name: "star", size: .small)
      LhIcon(name: "star", size: .medium)
      LhIcon(name: "star", size: .large)
    }
    .padding(LhTokens.Spacing.base)
  }
}

#Preview("色调") {
  LhTheme {
    HStack(spacing: LhTokens.Spacing.base) {
      LhIcon(name: "star", tone: .default)
      LhIcon(name: "star", tone: .primary)
      LhIcon(name: "star", tone: .success)
      LhIcon(name: "star", tone: .warning)
      LhIcon(name: "star", tone: .danger)
      LhIcon(name: "star", tone: .info)
    }
    .padding(LhTokens.Spacing.base)
  }
}

#Preview("可点击") {
  LhTheme {
    LhIcon(name: "search", tone: .primary) {
      print("icon tapped")
    }
    .padding(LhTokens.Spacing.base)
  }
}

#Preview("暗色主题") {
  LhTheme(isDark: true) {
    HStack(spacing: LhTokens.Spacing.base) {
      LhIcon(name: "star")
      LhIcon(name: "star", tone: .primary)
      LhIcon(name: "star", tone: .secondary)
    }
    .padding(LhTokens.Spacing.base)
    .background(Color.black)
  }
}

import SwiftUI
import LhUI
import LhUITokens

/// 加载指示器预览。#Preview 即文档（第一现场）。
#Preview("尺寸：small / medium / large") {
  LhTheme {
    HStack(spacing: LhTokens.Spacing.xl) {
      LhLoading(size: .small)
      LhLoading(size: .medium)
      LhLoading(size: .large)
    }
    .padding(LhTokens.Spacing.base)
  }
}

#Preview("色调") {
  LhTheme {
    HStack(spacing: LhTokens.Spacing.lg) {
      LhLoading(tone: .primary)
      LhLoading(tone: .success)
      LhLoading(tone: .warning)
      LhLoading(tone: .danger)
      LhLoading(tone: .info)
    }
    .padding(LhTokens.Spacing.base)
  }
}

#Preview("静态帧（预览与文档截图）") {
  LhTheme {
    LhLoading(animating: false)
      .padding(LhTokens.Spacing.base)
  }
}

#Preview("暗色主题") {
  LhTheme(isDark: true) {
    HStack(spacing: LhTokens.Spacing.lg) {
      LhLoading(tone: .primary)
      LhLoading(tone: .success)
      LhLoading(tone: .warning)
    }
    .padding(LhTokens.Spacing.base)
    .background(Color.black)
  }
}

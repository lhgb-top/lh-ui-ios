import SwiftUI
import LhUI
import LhUITokens

/// 标签组件预览。#Preview 即文档（第一现场）。
#Preview("类型：全部") {
  LhTheme {
    VStack(spacing: LhTokens.Spacing.sm) {
      HStack(spacing: LhTokens.Spacing.sm) {
        LhTag("默认")
        LhTag("主色", type: .primary)
        LhTag("成功", type: .success)
      }
      HStack(spacing: LhTokens.Spacing.sm) {
        LhTag("警告", type: .warning)
        LhTag("危险", type: .danger)
        LhTag("信息", type: .info)
      }
    }
    .padding(LhTokens.Spacing.base)
  }
}

#Preview("浅底形态（plain）") {
  LhTheme {
    HStack(spacing: LhTokens.Spacing.sm) {
      LhTag("主色", type: .primary, plain: true)
      LhTag("成功", type: .success, plain: true)
      LhTag("危险", type: .danger, plain: true)
    }
    .padding(LhTokens.Spacing.base)
  }
}

#Preview("尺寸与胶囊") {
  LhTheme {
    VStack(spacing: LhTokens.Spacing.sm) {
      HStack(spacing: LhTokens.Spacing.sm) {
        LhTag("小", size: .small)
        LhTag("中", size: .medium)
        LhTag("大", size: .large)
      }
      HStack(spacing: LhTokens.Spacing.sm) {
        LhTag("胶囊", round: true)
        LhTag("主色胶囊", type: .primary, round: true)
      }
    }
    .padding(LhTokens.Spacing.base)
  }
}

#Preview("可关闭") {
  LhTheme {
    HStack(spacing: LhTokens.Spacing.sm) {
      LhTag("可关闭", closable: true) {
        print("tag closed")
      }
      LhTag("主色可关闭", type: .primary, round: true, closable: true) {
        print("tag closed")
      }
    }
    .padding(LhTokens.Spacing.base)
  }
}

#Preview("暗色主题") {
  LhTheme(isDark: true) {
    VStack(spacing: LhTokens.Spacing.sm) {
      HStack(spacing: LhTokens.Spacing.sm) {
        LhTag("默认")
        LhTag("主色", type: .primary)
        LhTag("危险", type: .danger)
      }
      HStack(spacing: LhTokens.Spacing.sm) {
        LhTag("主色浅底", type: .primary, plain: true)
        LhTag("胶囊", round: true)
      }
    }
    .padding(LhTokens.Spacing.base)
    .background(Color.black)
  }
}

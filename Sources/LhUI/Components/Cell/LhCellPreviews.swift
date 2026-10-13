import SwiftUI
import LhUI
import LhUITokens

/// 单元格预览。#Preview 即文档（第一现场）。
#Preview("基础用法") {
  LhTheme {
    VStack(spacing: 0) {
      LhCell(title: "行标题", value: "行内容")
      LhCell(title: "带说明", value: "内容", label: "说明文字用于补充标题")
      LhCell(title: "纯标题")
    }
    .padding(LhTokens.Spacing.base)
  }
}

#Preview("必填与图标") {
  LhTheme {
    VStack(spacing: 0) {
      LhCell(title: "必填项", value: "请填写", required: true)
      LhCell(title: "带图标", value: "张三", icon: "user")
      LhCell(title: "图标 + 说明", value: "已开启", label: "说明文字", icon: "bell")
    }
    .padding(LhTokens.Spacing.base)
  }
}

#Preview("可点击") {
  LhTheme {
    VStack(spacing: 0) {
      LhCell(title: "可点击行", clickable: true) {
        print("cell clicked")
      }
      LhCell(title: "不可点击行")
    }
    .padding(LhTokens.Spacing.base)
  }
}

#Preview("无边框") {
  LhTheme {
    VStack(spacing: 0) {
      LhCell(title: "无边框行", value: "内容", bordered: false)
      LhCell(title: "无边框行", bordered: false, clickable: true)
    }
    .padding(LhTokens.Spacing.base)
  }
}

#Preview("暗色主题") {
  LhTheme(isDark: true) {
    VStack(spacing: 0) {
      LhCell(title: "行标题", value: "行内容")
      LhCell(title: "必填项", label: "说明文字", clickable: true, required: true)
    }
    .padding(LhTokens.Spacing.base)
    .background(Color.black)
  }
}

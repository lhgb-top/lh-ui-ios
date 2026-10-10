# 快速开始

## 最小示例

```swift
import SwiftUI
import LhUI

struct Demo: View {
  var body: some View {
    LhTheme {
      LhButton(
        onClick: { /* 处理点击 */ },
        type: .primary,
        text: "主要按钮"
      )
    }
  }
}
```

`LhTheme` 是主题容器，内部所有 Lh 组件通过 Environment 自动消费令牌；不包裹时回退明色色板。

## 类型与尺寸

```swift
// 六种类型
LhButton(onClick: {}, text: "默认")                      // .default
LhButton(onClick: {}, type: .primary, text: "主要")
LhButton(onClick: {}, type: .success, text: "成功")
LhButton(onClick: {}, type: .warning, text: "警告")
LhButton(onClick: {}, type: .danger, text: "危险")
LhButton(onClick: {}, type: .info, text: "信息")

// 三种尺寸
LhButton(onClick: {}, size: .small, text: "小型")
LhButton(onClick: {}, size: .medium, text: "中型")
LhButton(onClick: {}, size: .large, text: "大型")
```

## 状态

```swift
// 禁用：不响应点击，呈现禁用样式
LhButton(onClick: {}, disabled: true, text: "禁用")

// 加载中：显示指示器，不触发 onClick
LhButton(onClick: {}, loading: true, text: "加载中")

// 两者共存：按禁用优先处理（黄金用例 disabled-precedes-loading）
LhButton(onClick: {}, disabled: true, loading: true, text: "禁用优先")
```

## 图标与花纹底

```swift
// 图标名按本地图标体系解析（SF Symbol 映射见 LhButtonStyle.icon(for:)，未登记名不绘制）
LhButton(onClick: {}, type: .primary, icon: "search", text: "搜索")

// 国风花纹底纹（消费 color.decoration 令牌）
LhButton(onClick: {}, type: .primary, bgPattern: true, text: "花纹底")
```

## 明暗主题

```swift
LhTheme(isDark: isDark) {
  // 内部所有组件自动切换暗色令牌（core 预计算值，无运行时调色）
}
```

## 组件示例预览

原生 UI 无法在浏览器实时渲染，本站用**内联静态 HTML 手机框模拟器**展示外观：

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>lh-ui-ios</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <button class="sim-btn">默认按钮</button>
      <button class="sim-btn sim-btn--primary">主要按钮</button>
      <button class="sim-btn sim-btn--success">成功</button>
      <button class="sim-btn sim-btn--warning">警告</button>
      <button class="sim-btn sim-btn--danger">危险</button>
      <button class="sim-btn sim-btn--info">信息</button>
    </div>
    <div class="sim-row">
      <button class="sim-btn sim-btn--small">小型</button>
      <button class="sim-btn sim-btn--primary sim-btn--large">大型</button>
      <button class="sim-btn sim-btn--primary sim-btn--disabled">禁用</button>
      <button class="sim-btn sim-btn--primary sim-btn--loading">
        <span class="sim-btn__spinner"></span>加载中
      </button>
    </div>
    <div class="sim-row">
      <button class="sim-btn sim-btn--primary"><span class="sim-btn__icon"></span>搜索</button>
      <button class="sim-btn sim-btn--primary sim-btn--pattern">花纹底</button>
    </div>
  </div>
</div>
<p class="sim-note">iOS（SwiftUI）外观的 HTML 模拟预览，非真机渲染；样式值全部取自 core 令牌快照，与真机同源同值。真机外观以 <code>#Preview</code> 与设备截图为准。</p>

> 模拟器的暗色与站点联动：右上角切换主题，手机框内颜色即变（暗色令牌由 core 预计算）。

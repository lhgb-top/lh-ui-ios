# 快速開始

## 最小範例

```swift
import SwiftUI
import LhUI

struct Demo: View {
  var body: some View {
    LhTheme {
      LhButton(
        lhOnClick: { /* 處理點選 */ },
        type: .primary,
        text: "主要按鈕"
      )
    }
  }
}
```

`LhTheme` 是主題容器，內部所有 Lh 元件透過 Environment 自動消費令牌；不包裹時回退明色色板。

## 類型與尺寸

```swift
// 六種類型
LhButton(lhOnClick: {}, text: "預設")                      // .default
LhButton(lhOnClick: {}, type: .primary, text: "主要")
LhButton(lhOnClick: {}, type: .success, text: "成功")
LhButton(lhOnClick: {}, type: .warning, text: "警告")
LhButton(lhOnClick: {}, type: .danger, text: "危險")
LhButton(lhOnClick: {}, type: .info, text: "資訊")

// 三種尺寸
LhButton(lhOnClick: {}, lhSize: .small, text: "小型")
LhButton(lhOnClick: {}, lhSize: .medium, text: "中型")
LhButton(lhOnClick: {}, lhSize: .large, text: "大型")
```

## 狀態

```swift
// 停用：不回應點選，呈現停用樣式
LhButton(lhOnClick: {}, disabled: true, text: "停用")

// 載入中：顯示指示器，不觸發 lhOnClick
LhButton(lhOnClick: {}, loading: true, text: "載入中")

// 兩者共存：按停用優先處理（黃金用例 disabled-precedes-loading）
LhButton(lhOnClick: {}, disabled: true, loading: true, text: "停用優先")
```

## 圖示與花紋底

```swift
// 圖示名按本機圖示體系解析（SF Symbol 對應見 LhButtonStyle.icon(for:)，未登入名不繪製）
LhButton(lhOnClick: {}, type: .primary, icon: "search", text: "搜尋")

// 國風花紋底紋（消費 color.decoration 令牌）
LhButton(lhOnClick: {}, type: .primary, bgPattern: true, text: "花紋底")
```

## 明暗主題

```swift
LhTheme(isDark: isDark) {
  // 內部所有元件自動切換暗色令牌（core 預計算值，無執行時調色）
}
```

## 元件範例預覽

原生 UI 無法在瀏覽器即時渲染，本站用**內聯靜態 HTML 手機框模擬器**展示外觀：

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>lh-ui-ios</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <button class="sim-btn">預設按鈕</button>
      <button class="sim-btn sim-btn--primary">主要按鈕</button>
      <button class="sim-btn sim-btn--success">成功</button>
      <button class="sim-btn sim-btn--warning">警告</button>
      <button class="sim-btn sim-btn--danger">危險</button>
      <button class="sim-btn sim-btn--info">資訊</button>
    </div>
    <div class="sim-row">
      <button class="sim-btn sim-btn--small">小型</button>
      <button class="sim-btn sim-btn--primary sim-btn--large">大型</button>
      <button class="sim-btn sim-btn--primary sim-btn--disabled">停用</button>
      <button class="sim-btn sim-btn--primary sim-btn--loading">
        <span class="sim-btn__spinner"></span>載入中
      </button>
    </div>
    <div class="sim-row">
      <button class="sim-btn sim-btn--primary"><span class="sim-btn__icon"></span>搜尋</button>
      <button class="sim-btn sim-btn--primary sim-btn--pattern">花紋底</button>
    </div>
  </div>
</div>
<p class="sim-note">iOS（SwiftUI）外觀的 HTML 模擬預覽，非真機渲染；樣式值全部取自 core 令牌快照，與真機同源同值。真機外觀以 <code>#Preview</code> 與裝置截圖為準。</p>

> 模擬器的暗色與站點聯動：右上角切換主題，手機框內顏色即變（暗色令牌由 core 預計算）。

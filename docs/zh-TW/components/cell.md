# Cell 儲存格

列表儲存格。左側圖示 + 標題（含必填紅星與副標題），右側值與箭頭，底部分隔線。

> 契約源：`lh-ui-core/specs/cell.json` ·
> 黃金用例：`lh-ui-core/cases/cell.json`（6 條，已翻譯為 XCTest，macOS 宿主即可執行）

## 基本形態

`title` 必填，`value` / `label` / `icon` 可選。`bordered` 控制底部分隔線（預設開）。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Cell 基本</span></div>
  <div class="sim-screen" style="padding: 0;">
    <div class="sim-cell">
      <div class="sim-cell__main"><div class="sim-cell__title">標題文字</div></div>
      <div class="sim-cell__value">右側值</div>
      <div class="sim-cell__arrow">›</div>
    </div>
    <div class="sim-cell">
      <div class="sim-cell__main">
        <div class="sim-cell__title">帶副標題</div>
        <div class="sim-cell__label">這是副標題說明文字</div>
      </div>
      <div class="sim-cell__arrow">›</div>
    </div>
    <div class="sim-cell">
      <div class="sim-cell__main"><div class="sim-cell__title">無分隔線</div></div>
      <div class="sim-cell__value">值</div>
    </div>
  </div>
</div>
<p class="sim-note">HTML 模擬預覽（iOS / SwiftUI 外觀），非真機渲染</p>

```swift
LhCell(title: "標題文字", value: "右側值", clickable: true) {
  // lhOnClick
}
```

## 圖示 / 必填 / 不可點選

`icon` 走 `LhIconMap` 對應；`required` 在標題前顯示紅色星號；
`clickable = false`（預設）時不回應點選（黃金用例 `not-clickable-no-onclick`）。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Cell 擴充</span></div>
  <div class="sim-screen" style="padding: 0;">
    <div class="sim-cell">
      <span class="sim-cell__icon"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" style="width:100%;height:100%"><circle cx="11" cy="11" r="7"/><path d="M21 21l-4.3-4.3"/></svg></span>
      <div class="sim-cell__main"><div class="sim-cell__title">左側圖示</div></div>
      <div class="sim-cell__arrow">›</div>
    </div>
    <div class="sim-cell">
      <div class="sim-cell__main"><div class="sim-cell__title"><span class="sim-cell__required">*</span>必填項</div></div>
      <div class="sim-cell__value">請選擇</div>
      <div class="sim-cell__arrow">›</div>
    </div>
  </div>
</div>
<p class="sim-note">HTML 模擬預覽（iOS / SwiftUI 外觀），非真機渲染</p>

## API

### Props

| 屬性 | 說明 | 類型 | 預設值 |
| --- | --- | --- | --- |
| `title` | 標題（必填） | `String` | — |
| `value` | 右側值 | `String` | `""` |
| `label` | 標題下方副標題 | `String` | `""` |
| `icon` | 左側圖示邏輯名（`LhIconMap` 對應） | `String?` | `nil` |
| `bordered` | 是否顯示底部分隔線 | `Bool` | `true` |
| `clickable` | 是否可點選（控制箭頭與點選 gate） | `Bool` | `false` |
| `required` | 標題前是否顯示紅色必填星號 | `Bool` | `false` |
| `lhOnClick` | 點選回呼；`clickable = false` 時不觸發 | `(() -> Void)?` | `nil` |

### 文字層級

| 區域 | 字號 | 顏色 |
| --- | --- | --- |
| 標題 | `cell.fontSizeTitle`（14pt） | `color.text.primary` |
| 副標題 | `cell.fontSizeLabel`（13pt） | `color.text.secondary` |
| 右側值 | `cell.fontSizeValue`（14pt） | `color.text.secondary` |
| 必填星號 | `cell.fontSizeTitle` | `color.danger.default` |

## 令牌對照

| 令牌 | 用途 |
| --- | --- |
| `cell.paddingHorizontal` / `cell.paddingVertical` | 內邊距（跟隨 `spacing.base` / `spacing.sm`） |
| `cell.fontSizeTitle` / `cell.fontSizeLabel` / `cell.fontSizeValue` | 三級文字字號 |
| `cell.iconSize` | 左側圖示尺寸 |
| `cell.gap` | 各區塊間距（跟隨 `spacing.sm`） |
| `cell.borderWidth` | 底部分隔線寬度 |
| `color.border.lighter` | 底部分隔線顏色 |
| `color.text.{primary,secondary}` | 標題與值/副標題顏色 |
| `color.danger.default` | 必填星號顏色 |
| `color.background.default` | 儲存格底色 |

## 黃金用例對照

| case id | 斷言 | 本地測試 |
| --- | --- | --- |
| `title-and-value-render` | 同時繪製標題與值 | `testTitleAndValueUseFontTokens` |
| `label-renders-secondary-tone` | 副標題取次要文字色 | `testLabelRendersSecondaryTone` |
| `required-uses-danger-token` | 必填星號取危險色令牌 | `testRequiredUsesDangerToken` |
| `bordered-emits-line-command` | 分隔線消費 border.lighter 令牌 | `testBorderedUsesBorderTokens` |
| `clickable-emits-onclick` | 可點選時觸發 lhOnClick | `testClickableIsInteractive` |
| `not-clickable-no-onclick` | 不可點選時不觸發 lhOnClick | `testNotClickableIsNotInteractive` |

另有暗色專項：`testDarkColorsComeFromDarkTokens` / `testDimensionsAreIdenticalInDarkMode` /
`testCellInitAndRender` / `testLayoutUsesCellTokens`。

```bash
swift test --filter LhCellTests    # macOS 宿主即可執行，無需模擬器
```

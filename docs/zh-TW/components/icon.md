# Icon 圖示

矢量圖示。透過邏輯名對應到平台的系統符號（iOS 端為 SF Symbol），尺寸與色調全部走令牌。

> 契約源：`lh-ui-core/specs/icon.json` ·
> 黃金用例：`lh-ui-core/cases/icon.json`（5 條，已翻譯為 XCTest，macOS 宿主即可執行）

## 色調

`tone` 決定圖示顏色。`default` 跟隨主要文字色，`regular` / `secondary` 取對應層級文字色，其餘取語義色。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Icon 色調</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-icon"><svg viewBox="0 0 24 24" fill="currentColor"><path d="M12 2l2.9 6.3 6.9.8-5.1 4.7 1.4 6.8L12 17.3 5.9 20.6l1.4-6.8L2.2 9.1l6.9-.8z"/></svg></span>
      <span class="sim-icon sim-icon--primary"><svg viewBox="0 0 24 24" fill="currentColor"><path d="M12 2l2.9 6.3 6.9.8-5.1 4.7 1.4 6.8L12 17.3 5.9 20.6l1.4-6.8L2.2 9.1l6.9-.8z"/></svg></span>
      <span class="sim-icon sim-icon--success"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M4 12.5l5 5L20 6.5"/></svg></span>
    </div>
    <div class="sim-row">
      <span class="sim-icon sim-icon--warning"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 3l10 18H2z"/><path d="M12 10v5"/></svg></span>
      <span class="sim-icon sim-icon--danger"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="9"/><path d="M12 8v5M12 16.5v.5"/></svg></span>
      <span class="sim-icon sim-icon--regular"><svg viewBox="0 0 24 24" fill="currentColor"><circle cx="12" cy="12" r="8"/></svg></span>
      <span class="sim-icon sim-icon--secondary"><svg viewBox="0 0 24 24" fill="currentColor"><circle cx="12" cy="12" r="8"/></svg></span>
    </div>
  </div>
</div>
<p class="sim-note">HTML 模擬預覽（iOS / SwiftUI 外觀），非真機渲染；真機繪製的是 SF Symbol 矢量</p>

```swift
LhIcon(name: "star", tone: .primary)
```

## 尺寸

三檔尺寸對應到 `icon.size` 令牌。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Icon 尺寸</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-icon sim-icon--small sim-icon--primary"><svg viewBox="0 0 24 24" fill="currentColor"><path d="M12 2l2.9 6.3 6.9.8-5.1 4.7 1.4 6.8L12 17.3 5.9 20.6l1.4-6.8L2.2 9.1l6.9-.8z"/></svg></span>
      <span class="sim-icon sim-icon--primary"><svg viewBox="0 0 24 24" fill="currentColor"><path d="M12 2l2.9 6.3 6.9.8-5.1 4.7 1.4 6.8L12 17.3 5.9 20.6l1.4-6.8L2.2 9.1l6.9-.8z"/></svg></span>
      <span class="sim-icon sim-icon--large sim-icon--primary"><svg viewBox="0 0 24 24" fill="currentColor"><path d="M12 2l2.9 6.3 6.9.8-5.1 4.7 1.4 6.8L12 17.3 5.9 20.6l1.4-6.8L2.2 9.1l6.9-.8z"/></svg></span>
    </div>
  </div>
</div>
<p class="sim-note">HTML 模擬預覽（iOS / SwiftUI 外觀），非真機渲染</p>

## 圖示名對應

`name` 是與 web 血脈對齊的邏輯名，端側經 `LhIconMap.symbol(for:)` 對應到 SF Symbol：

| 邏輯名 | SF Symbol |
| --- | --- |
| `star` / `search` / `check` / `close` | `star` / `magnifyingglass` / `checkmark` / `xmark` |
| `arrow-up` / `arrow-down` / `arrow-left` / `arrow-right` | `arrow.up` / `arrow.down` / `arrow.left` / `arrow.right` |
| `refresh` / `plus` / `minus` / `eye` / `link` | `arrow.clockwise` / `plus` / `minus` / `eye` / `link` |

未登入的名稱不繪製（回傳 `nil`），不會崩潰。

```swift
LhIcon(name: "search", lhSize: .large, tone: .secondary) {
  // lhOnClick
}
```

## API

### Props

| 屬性 | 說明 | 類型 | 預設值 |
| --- | --- | --- | --- |
| `name` | 圖示邏輯名（經 `LhIconMap` 對應 SF Symbol） | `String` | — |
| `lhSize` | 圖示尺寸，對應到尺寸令牌 | `LhIconSize` | `.medium` |
| `tone` | 圖示色調，對應到文字/語義色令牌 | `LhIconTone` | `.default` |
| `lhOnClick` | 點選回呼；未傳則不回應點選 | `(() -> Void)?` | `nil` |

### LhIconSize

| 值 | 尺寸 |
| --- | --- |
| `.small` | `icon.size.small`（16pt） |
| `.medium` | `icon.size.medium`（20pt） |
| `.large` | `icon.size.large`（24pt） |

### LhIconTone

| 值 | 顏色 |
| --- | --- |
| `.default` | `color.text.primary` |
| `.primary` | `color.primary.default` |
| `.success` | `color.success.default` |
| `.warning` | `color.warning.default` |
| `.danger` | `color.danger.default` |
| `.info` | `color.info.default` |
| `.regular` | `color.text.regular` |
| `.secondary` | `color.text.secondary` |

## 令牌對照

| 令牌 | 用途 |
| --- | --- |
| `icon.size.{small,medium,large}` | 三檔尺寸 |
| `color.text.{primary,regular,secondary}` | 文字色調 |
| `color.{primary,success,warning,danger,info}.default` | 語義色調 |

## 黃金用例對照

| case id | 斷言 | 本地測試 |
| --- | --- | --- |
| `click-emits-onclick` | 點選觸發 `lhOnClick` 一次 | View 層 `onTapGesture`（手勢斷言需模擬器，見 #Preview） |
| `default-tone-uses-text-primary` | 預設色調取主要文字色 | `testDefaultToneUsesTextPrimary` |
| `primary-tone-uses-primary-token` | 主色調取主色令牌 | `testPrimaryToneUsesPrimaryToken` |
| `small-size-uses-small-token` | 小號取 small 尺寸令牌 | `testSmallSizeUsesSmallToken` |
| `render-emits-icon-command` | 僅繪製一條圖示指令 | `testRegisteredIconResolvesToSymbol` / `testUnknownIconReturnsNilSymbol` |

另有暗色專項：`testDarkColorsComeFromDarkTokens` / `testDimensionsAreIdenticalInDarkMode`。

```bash
swift test --filter LhIconTests    # macOS 宿主即可執行，無需模擬器
```

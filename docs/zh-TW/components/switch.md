# Switch 開關

受控開關。`@Binding var checked` 雙向綁定，軌道 2:1，圓點直徑 = 高度 − 2 × `switch.gap`。

> 契約源：`lh-ui-core/specs/switch.json` ·
> 黃金用例：`lh-ui-core/cases/switch.json`（6 條，已翻譯為 XCTest，macOS 宿主即可執行）

## 狀態

開啟時軌道為主色、圓點右移；關閉時軌道為描邊色。`loading` 態在軌道內顯示小型指示器且不回應切換。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Switch 狀態</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-switch"><span class="sim-switch__thumb"></span></span>
      <span class="sim-switch sim-switch--on"><span class="sim-switch__thumb"></span></span>
    </div>
    <div class="sim-row">
      <span class="sim-switch sim-switch--on sim-switch--disabled"><span class="sim-switch__thumb"></span></span>
      <span class="sim-switch sim-switch--disabled"><span class="sim-switch__thumb"></span></span>
    </div>
  </div>
</div>
<p class="sim-note">HTML 模擬預覽（iOS / SwiftUI 外觀），非真機渲染</p>

```swift
@State private var on = true

LhSwitch(checked: $on) { newValue in
  // onChange
}
```

## 尺寸

三檔尺寸對應到 `switch.width` / `switch.height` 令牌，圓角隨高度自動為軌道半徑。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Switch 尺寸</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-switch sim-switch--small sim-switch--on"><span class="sim-switch__thumb"></span></span>
      <span class="sim-switch sim-switch--on"><span class="sim-switch__thumb"></span></span>
      <span class="sim-switch sim-switch--large sim-switch--on"><span class="sim-switch__thumb"></span></span>
    </div>
  </div>
</div>
<p class="sim-note">HTML 模擬預覽（iOS / SwiftUI 外觀），非真機渲染</p>

## 載入態

`loading = true` 時軌道內建 `LhLoading(lhSize: .small, tone: .primary)`，且點選被 gate 攔截
（黃金用例 `loading-blocks-change`）。

```swift
LhSwitch(checked: $submitting, loading: submitting) { _ in }
```

## API

### Props

| 屬性 | 說明 | 類型 | 預設值 |
| --- | --- | --- | --- |
| `checked` | 開關狀態（受控雙向綁定） | `Bool` | — |
| `disabled` | 是否停用（不觸發 onChange） | `Bool` | `false` |
| `loading` | 是否載入中（內建指示器，不觸發 onChange） | `Bool` | `false` |
| `lhSize` | 開關尺寸，對應到尺寸令牌 | `LhSwitchSize` | `.medium` |
| `onChange` | 狀態變化回呼，payload 為新值 | `((Bool) -> Void)?` | `nil` |

### LhSwitchSize

| 值 | width | height | 圓點直徑 |
| --- | --- | --- | --- |
| `.small` | `switch.width.small`（36pt） | `switch.height.small`（20pt） | height − 2 × `switch.gap`（16pt） |
| `.medium` | `switch.width.medium`（44pt） | `switch.height.medium`（24pt） | height − 2 × `switch.gap`（20pt） |
| `.large` | `switch.width.large`（52pt） | `switch.height.large`（28pt） | height − 2 × `switch.gap`（24pt） |

### 顏色

| 狀態 | 軌道 | 圓點 |
| --- | --- | --- |
| 關閉 | `color.border.base` | `color.onPrimary` |
| 開啟 | `color.primary.default` | `color.onPrimary` |
| 停用 | `color.disabled.bg` | `color.disabled.text` |

## 令牌對照

| 令牌 | 用途 |
| --- | --- |
| `switch.width.{small,medium,large}` | 三檔軌道寬度 |
| `switch.height.{small,medium,large}` | 三檔軌道高度 |
| `switch.gap` | 圓點與軌道的內間距（決定圓點直徑） |
| `color.primary.default` | 開啟軌道色 |
| `color.border.base` | 關閉軌道色 |
| `color.onPrimary` | 圓點色 |
| `color.disabled.{bg,text}` | 停用態兩色 |
| `motion.duration.base` | 圓點滑動動畫時長（iOS 端為秒） |

## 黃金用例對照

| case id | 斷言 | 本地測試 |
| --- | --- | --- |
| `tap-toggles-and-emits-onchange` | 點選開啟並回呼 `onChange(true)` | `testDefaultIsInteractive` |
| `tap-checked-turns-off` | 開啟態點選變關閉 | `testCheckedUsesPrimaryTrack` |
| `disabled-blocks-change` | 停用態不觸發 onChange | `testDisabledBlocksChange` |
| `loading-blocks-change` | 載入態不觸發 onChange | `testLoadingBlocksChange` |
| `checked-uses-primary-token` | 開啟消費主色令牌、不消費描邊令牌 | `testCheckedUsesPrimaryToken` |
| `unchecked-uses-border-token` | 關閉消費描邊令牌 | `testUncheckedUsesBorderToken` |

另有專項：`testSizeUsesSwitchTokens` / `testThumbDiameterIsHeightMinusTwoGaps` /
`testDarkColorsComeFromDarkTokens` / `testDimensionsAreIdenticalInDarkMode` /
`testSwitchViewInitAcceptsConstant`。

```bash
swift test --filter LhSwitchTests    # macOS 宿主即可執行，無需模擬器
```

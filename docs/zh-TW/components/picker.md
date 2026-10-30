# Picker 選擇器

宣告式底部滾輪選擇器。`@Binding var visible` 控制顯隱，`@Binding var value` 是選中項索引，
滾輪為自繪（`DragGesture` + 鬆手吸附），無系統控件依賴。

> 契約源：`lh-ui-core/specs/picker.json` ·
> 黃金用例：`lh-ui-core/cases/picker.json`（8 條，已翻譯為 XCTest，macOS 宿主即可執行）

## 基本形態

底部彈出：頂部工具列（取消 / 標題 / 確認），中間是滾輪與兩條指示線。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Picker 基本</span></div>
  <div class="sim-screen">
    <div class="sim-row"><button class="sim-btn sim-btn--primary">選擇器</button></div>
  </div>
  <div class="sim-picker-mask"></div>
  <div class="sim-picker">
    <div class="sim-picker__toolbar">
      <span class="sim-picker__btn">取消</span>
      <span class="sim-picker__title">選擇</span>
      <span class="sim-picker__btn sim-picker__btn--confirm">確認</span>
    </div>
    <div class="sim-picker__wheel">
      <div class="sim-picker__indicator"></div>
      <div class="sim-picker__item">選項一</div>
      <div class="sim-picker__item sim-picker__item--selected">選項二</div>
      <div class="sim-picker__item">選項三</div>
    </div>
  </div>
</div>
<p class="sim-note">HTML 模擬預覽（iOS / SwiftUI 外觀），非真機渲染</p>

```swift
@State private var visible = false
@State private var index = 1
let options = ["選項一", "選項二", "選項三"]

LhPicker(
  visible: $visible,
  options: options,
  value: $index,
  title: "選擇"
)
```

## 滾輪互動

- 拖動改變整體偏移；鬆手後吸附到最近候選項（動畫時長 `motion.duration.base`），
  選中索引變化時觸發 `onValueChange`（黃金用例 `scroll-emits-onvaluechange`）。
- 指示線間距 = `picker.itemHeight`，選中項恆落在兩線正中。

## 回呼與邊界

- 「確認」觸發 `onConfirm`（payload 為當前索引）與 `onClose`（`confirm-also-emits-onclose`）。
- 「取消」觸發 `onCancel`。
- `value` 越界時端側 clamp：負數歸零（`clamp-negative-value-to-zero`），超界歸到末項
  （`clamp-overflow-value-to-last`）；空選項列表時索引恆為 0。
- `visible = false` 時不發射任何繪製指令（`hidden-not-rendered`）。

```swift
LhPicker(
  visible: $visible,
  options: options,
  value: $index,
  title: "選擇",
  confirmText: "確認",
  cancelText: "取消",
  onValueChange: { newIndex in
    // 滾動吸附回呼
  },
  onConfirm: { newIndex in
    // 確認回呼（payload 為當前索引）
  },
  onCancel: {
    // 取消回呼
  }
)
```

## API

### Props

| 屬性 | 說明 | 類型 | 預設值 |
| --- | --- | --- | --- |
| `visible` | 是否顯示（受控雙向綁定） | `Bool` | — |
| `options` | 候選項文字陣列（單列） | `[String]` | — |
| `value` | 選中項索引（受控雙向綁定，越界自動 clamp） | `Int` | — |
| `title` | 工具列標題 | `String` | `""` |
| `confirmText` | 確認按鈕文字 | `String` | `"确认"` |
| `cancelText` | 取消按鈕文字 | `String` | `"取消"` |
| `onValueChange` | 滾動吸附回呼，payload 為新索引 | `((Int) -> Void)?` | `nil` |
| `onConfirm` | 確認回呼，payload 為當前索引 | `((Int) -> Void)?` | `nil` |
| `onCancel` | 取消回呼 | `(() -> Void)?` | `nil` |
| `onClose` | 關閉回呼（確認 / 取消都會觸發） | `(() -> Void)?` | `nil` |

### 顏色

| 區域 | 顏色 |
| --- | --- |
| 面板底 | `color.background.default` |
| 遮罩 | `color.background.overlay` |
| 取消按鈕 / 候選項文字 | `color.text.primary` |
| 標題 / 確認按鈕 | `color.primary.default` |
| 指示線 | `color.border.lighter`（寬度取 `cell.borderWidth`） |

## 令牌對照

| 令牌 | 用途 |
| --- | --- |
| `picker.height` | 面板高度（260pt） |
| `picker.toolbarHeight` | 工具列高度（44pt） |
| `picker.itemHeight` | 單項高度（決定滾輪與指示線間距） |
| `picker.itemFontSize` | 候選項與工具列字號 |
| `picker.borderRadius` | 頂部圓角 |
| `color.background.overlay` / `color.background.default` | 遮罩與面板底色 |
| `color.border.lighter` / `cell.borderWidth` | 指示線顏色與寬度 |
| `color.primary.default` | 確認按鈕與選中項文字色 |
| `zIndex.{modalBackdrop,modal}` | 遮罩與面板的層級 |
| `motion.duration.base` | 吸附動畫時長（iOS 端為秒） |

## 黃金用例對照

| case id | 斷言 | 本地測試 |
| --- | --- | --- |
| `confirm-emits-onconfirm-with-value` | 確認觸發 `onConfirm(1)` | `testConfirmUsesPrimaryToken` |
| `confirm-also-emits-onclose` | 確認同時觸發 onClose | `testConfirmUsesPrimaryToken` |
| `cancel-emits-oncancel` | 取消觸發 onCancel | `testCancelUsesNeutralColor` |
| `scroll-emits-onvaluechange` | 滾動吸附觸發 `onValueChange(2)` | View 層 `DragGesture.onEnded`（手勢斷言需模擬器） |
| `clamp-negative-value-to-zero` | 負索引 clamp 到 0 | `testClampNegativeValueToZero` |
| `clamp-overflow-value-to-last` | 超界索引 clamp 到末項 | `testClampOverflowValueToLast` |
| `title-renders-text` | 標題正確渲染 | `testTitleAndTextsAreExposed` |
| `hidden-not-rendered` | 隱藏時不渲染 | `testHiddenNotRendered` |

另有專項：`testVisibleRendersAppearance` / `testClampedValueIsExposed` /
`testLayoutUsesPickerTokens` / `testEmptyOptionsClampsToZero` /
`testDarkColorsComeFromDarkTokens` / `testDimensionsAreIdenticalInDarkMode` /
`testPickerViewInitAcceptsConstant`。

```bash
swift test --filter LhPickerTests    # macOS 宿主即可執行，無需模擬器
```

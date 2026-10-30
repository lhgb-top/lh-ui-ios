# Toast 輕提示

宣告式輕提示。`@Binding var visible` 控制顯隱，到時自動消失，深色底取 `color.ink` 令牌。

> 契約源：`lh-ui-core/specs/toast.json` ·
> 黃金用例：`lh-ui-core/cases/toast.json`（6 條，已翻譯為 XCTest，macOS 宿主即可執行）

## 類型

預設類型無圖示；其餘類型在文字左側顯示一個語義色圓點。深色底 + 白字，對比度由 `color.ink` 保證。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Toast 類型</span></div>
  <div class="sim-screen">
    <div class="sim-row"><button class="sim-btn sim-btn--primary">預設</button></div>
  </div>
  <div class="sim-toast">已儲存</div>
</div>
<p class="sim-note">HTML 模擬預覽（iOS / SwiftUI 外觀），非真機渲染</p>

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Toast 語義</span></div>
  <div class="sim-screen">
    <div class="sim-row"><button class="sim-btn sim-btn--success">成功</button></div>
  </div>
  <div class="sim-toast"><span class="sim-toast__dot sim-toast__dot--success"></span>操作成功</div>
</div>
<p class="sim-note">HTML 模擬預覽（iOS / SwiftUI 外觀），非真機渲染</p>

```swift
@State private var visible = false

LhToast(visible: $visible, text: "已儲存", type: .success)
```

## 定位

三種定位：`top`（頂部）、`center`（置中，預設）、`bottom`（底部）。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Toast 定位</span></div>
  <div class="sim-screen">
    <div class="sim-row"><button class="sim-btn sim-btn--primary">bottom 定位</button></div>
  </div>
  <div class="sim-toast sim-toast--bottom"><span class="sim-toast__dot sim-toast__dot--warning"></span>底部提示</div>
</div>
<p class="sim-note">HTML 模擬預覽（iOS / SwiftUI 外觀），非真機渲染</p>

## 自動消失

`visible` 變為 `true` 時啟動 `.task` 計時，`duration` 毫秒後自動置回 `false` 並觸發 `onClose`
（黃金用例 `auto-hides-after-duration`）；計時未到時保持顯示且不觸發回呼
（`tick-before-duration-keeps-visible`）；外部手動置 `false` 不觸發回呼（`hide-is-silent`）。

::: tip 時長單位
令牌 `toast.duration` 是毫秒（2000），SwiftUI 的 `Task.sleep` 需要秒，端側做
`Double(duration) / 1000` 換算（見 `LhToastStyle`）。
:::

```swift
LhToast(visible: $visible, text: "操作成功", type: .success, duration: 2000) {
  // onClose（僅自動消失時觸發）
}
```

## API

### Props

| 屬性 | 說明 | 類型 | 預設值 |
| --- | --- | --- | --- |
| `visible` | 是否顯示（受控雙向綁定，到時自動置回 false） | `Bool` | — |
| `text` | 提示文字 | `String` | — |
| `type` | 提示類型，決定是否顯示圓點及圓點顏色 | `LhToastType` | `.default` |
| `lhPosition` | 顯示位置 | `LhToastPosition` | `.center` |
| `duration` | 顯示時長（毫秒） | `Int` | `2000`（取 `toast.duration` 令牌） |
| `onClose` | 自動消失回呼（外部手動隱藏不觸發） | `(() -> Void)?` | `nil` |

### LhToastType

| 值 | 圓點色 |
| --- | --- |
| `.default` | 無圓點 |
| `.success` | `color.success.default` |
| `.warning` | `color.warning.default` |
| `.danger` | `color.danger.default` |
| `.info` | `color.info.default` |

### LhToastPosition

| 值 | 定位 |
| --- | --- |
| `.top` | 頂部（邊距 `spacing.xl`） |
| `.center` | 置中 |
| `.bottom` | 底部（邊距 `spacing.xl`） |

## 令牌對照

| 令牌 | 用途 |
| --- | --- |
| `toast.paddingHorizontal` / `toast.paddingVertical` | 內邊距 |
| `toast.fontSize` | 提示文字字號 |
| `toast.borderRadius` | 圓角（跟隨 `radius.small`） |
| `toast.gap` | 圓點與文字間距 |
| `toast.duration` | 預設顯示時長（毫秒） |
| `color.ink` | 深色底（暗色下有專用覆蓋，與頁面底拉開層次） |
| `color.onPrimary` | 白字 |
| `color.{success,warning,danger,info}.default` | 圓點語義色 |
| `zIndex.toast` | 層級 |
| `spacing.xl` | 頂/底定位邊距 |

## 黃金用例對照

| case id | 斷言 | 本地測試 |
| --- | --- | --- |
| `show-makes-visible` | 顯示即渲染 | `testShowMakesVisible` |
| `auto-hides-after-duration` | 到時自動隱藏並觸發 onClose | `testDurationConvertsToSeconds` |
| `tick-before-duration-keeps-visible` | 計時未到保持顯示 | `testVisibleDuringDuration` |
| `hide-is-silent` | 外部手動隱藏不觸發回呼 | `testHideIsSilent` |
| `success-type-uses-success-token` | 成功類型消費成功色與 ink 令牌 | `testSuccessTypeUsesSuccessToken` / `testInkBackgroundUsesInkToken` |
| `hidden-emits-no-commands` | 隱藏時繪製指令為空 | `testHiddenNotRendered` |

另有專項：`testDefaultTypeHasNoDot` / `testLayoutUsesToastTokens` /
`testDarkColorsComeFromDarkTokens` / `testDarkInkDiffersFromLightInk` /
`testDimensionsAreIdenticalInDarkMode` / `testToastViewInitAcceptsConstant`。

```bash
swift test --filter LhToastTests    # macOS 宿主即可執行，無需模擬器
```

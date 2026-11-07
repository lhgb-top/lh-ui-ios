# Dialog 對話框

宣告式模態對話框。`@Binding var visible` 控制顯隱，遮罩 + 置中面板，按鈕復用 `LhButton`。

> 契約源：`lh-ui-core/specs/dialog.json` ·
> 黃金用例：`lh-ui-core/cases/dialog.json`（8 條，已翻譯為 XCTest，macOS 宿主即可執行）

## 類型

六種類型決定確認按鈕的語義色（`buttonType(for:)` 對應到 `LhButtonType`）。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Dialog 類型</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <button class="sim-btn sim-btn--primary">預設對話框</button>
      <button class="sim-btn sim-btn--danger">危險對話框</button>
    </div>
  </div>
  <div class="sim-dialog-mask"></div>
  <div class="sim-dialog">
    <div class="sim-dialog__title">刪除確認</div>
    <div class="sim-dialog__content">此操作將永久刪除該項，是否繼續？</div>
    <div class="sim-dialog__actions">
      <button class="sim-btn">取消</button>
      <button class="sim-btn sim-btn--danger">確認</button>
    </div>
  </div>
</div>
<p class="sim-note">HTML 模擬預覽（iOS / SwiftUI 外觀），非真機渲染</p>

```swift
@State private var visible = false

LhDialog(
  visible: $visible,
  title: "刪除確認",
  content: "此操作將永久刪除該項，是否繼續？",
  type: .danger,
  confirmText: "確認",
  cancelText: "取消"
)
```

## 顯隱與回呼

- `visible = true` 渲染遮罩與面板；`visible = false` 不發射任何繪製指令（黃金用例 `hidden-not-rendered`）。
- 點選「確認」依次觸發 `onConfirm` 與 `onClose`（`confirm-also-emits-onclose`）。
- 點選「取消」觸發 `onCancel`；`onClose` 由元件內部負責把 `visible` 置回 `false`（包在 `withAnimation` 內）。
- `closable = true` 時點選遮罩也會觸發 `onClose`（`closable-overlay-emits-onclose`）；預設不關閉（`not-closable-blocks-overlay-close`）。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Dialog 遮罩可關閉</span></div>
  <div class="sim-screen">
    <div class="sim-row"><button class="sim-btn sim-btn--primary">closable = true</button></div>
  </div>
  <div class="sim-dialog-mask"></div>
  <div class="sim-dialog">
    <div class="sim-dialog__title">提示</div>
    <div class="sim-dialog__content">點選遮罩即可關閉</div>
    <div class="sim-dialog__actions">
      <button class="sim-btn">取消</button>
      <button class="sim-btn sim-btn--primary">確認</button>
    </div>
  </div>
</div>
<p class="sim-note">HTML 模擬預覽（iOS / SwiftUI 外觀），非真機渲染</p>

## API

### Props

| 屬性 | 說明 | 類型 | 預設值 |
| --- | --- | --- | --- |
| `visible` | 是否顯示（受控雙向綁定） | `Bool` | — |
| `title` | 標題 | `String` | `""` |
| `content` | 正文內容 | `String` | `""` |
| `type` | 對話框類型，決定確認按鈕語義色 | `LhDialogType` | `.default` |
| `confirmText` | 確認按鈕文字；`nil`（缺省）取當前語言包，`""` 不顯示該按鈕 | `String?` | 語言包（簡體中文 `"确认"`） |
| `cancelText` | 取消按鈕文字；`nil`（缺省）取當前語言包，`""` 不顯示該按鈕 | `String?` | 語言包（簡體中文 `"取消"`）|
| `closable` | 點選遮罩是否可關閉 | `Bool` | `false` |
| `onConfirm` | 確認回呼 | `(() -> Void)?` | `nil` |
| `onCancel` | 取消回呼 | `(() -> Void)?` | `nil` |
| `onClose` | 關閉回呼（遮罩點選 / 按鈕·取消 / 按鈕·確認 都會觸發） | `(() -> Void)?` | `nil` |

### LhDialogType

| 值 | 確認按鈕類型 | 底色 |
| --- | --- | --- |
| `.default` | `.default` | `color.background.default` + 描邊 |
| `.primary` | `.primary` | `color.primary.default` |
| `.success` | `.success` | `color.success.default` |
| `.warning` | `.warning` | `color.warning.default` |
| `.danger` | `.danger` | `color.danger.default` |
| `.info` | `.info` | `color.info.default` |

## 令牌對照

| 令牌 | 用途 |
| --- | --- |
| `dialog.width` | 面板寬度（320pt） |
| `dialog.paddingHorizontal` / `dialog.paddingVertical` | 面板內邊距 |
| `dialog.borderRadius` | 面板圓角 |
| `dialog.titleFontSize` / `dialog.contentFontSize` | 標題與正文字號 |
| `dialog.gap` | 各區塊縱向間距 |
| `color.background.overlay` | 遮罩色 |
| `color.background.default` | 面板底色 |
| `color.text.{primary,regular}` | 標題與正文顏色 |
| `shadow.base` | 面板陰影（LhShadow 載體） |
| `zIndex.{modalBackdrop,modal}` | 遮罩與面板的層級 |

## 黃金用例對照

| case id | 斷言 | 本地測試 |
| --- | --- | --- |
| `confirm-emits-onconfirm` | 確認觸發 onConfirm | `testConfirmUsesTypeColor` |
| `cancel-emits-oncancel` | 取消觸發 onCancel | `testCancelUsesNeutralColor` |
| `confirm-also-emits-onclose` | 確認同時觸發 onClose | `testConfirmUsesTypeColor` |
| `closable-overlay-emits-onclose` | 遮罩點選觸發 onClose | `testClosableFlagIsExposed` |
| `not-closable-blocks-overlay-close` | 預設遮罩不關閉 | `testNotClosableBlocksOverlay` |
| `hidden-not-rendered` | 隱藏時不渲染 | `testHiddenNotRendered` |
| `title-renders-text` | 標題正確渲染 | `testTitleUsesTitleTokens` |
| `danger-type-uses-danger-token` | 危險類型消費危險色令牌 | `testDangerTypeUsesDangerToken` |

另有專項：`testVisibleRendersAppearance` / `testLayoutUsesDialogTokens` /
`testDarkColorsComeFromDarkTokens` / `testDimensionsAreIdenticalInDarkMode` /
`testDialogViewInitAcceptsConstant`。

```bash
swift test --filter LhDialogTests    # macOS 宿主即可執行，無需模擬器
```

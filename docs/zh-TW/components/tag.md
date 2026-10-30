# Tag 標籤

用於標記和選擇的緊湊標籤。比按鈕更小，支援語義類型、描邊、圓角膠囊與關閉按鈕。

> 契約源：`lh-ui-core/specs/tag.json` ·
> 黃金用例：`lh-ui-core/cases/tag.json`（6 條，已翻譯為 XCTest，macOS 宿主即可執行）

## 類型

六種類型決定底色與文字色。`plain` 為描邊淺底形態（語義淺底 + 語義描邊）。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Tag 類型</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-tag">預設</span>
      <span class="sim-tag sim-tag--primary">主要</span>
      <span class="sim-tag sim-tag--success">成功</span>
    </div>
    <div class="sim-row">
      <span class="sim-tag sim-tag--warning">警告</span>
      <span class="sim-tag sim-tag--danger">危險</span>
      <span class="sim-tag sim-tag--info">資訊</span>
    </div>
    <div class="sim-row">
      <span class="sim-tag sim-tag--plain sim-tag--primary">描邊主要</span>
      <span class="sim-tag sim-tag--plain sim-tag--success">描邊成功</span>
    </div>
  </div>
</div>
<p class="sim-note">HTML 模擬預覽（iOS / SwiftUI 外觀），非真機渲染</p>

```swift
LhTag(text: "主要", type: .primary)
LhTag(text: "描邊成功", type: .success, plain: true)
```

## 尺寸與圓角

三檔尺寸對應到 `tag.height` / `paddingHorizontal` / `fontSize` 令牌；`round` 把圓角換成高度的一半（膠囊）。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Tag 尺寸</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-tag sim-tag--small sim-tag--primary">小號</span>
      <span class="sim-tag sim-tag--primary">中號</span>
      <span class="sim-tag sim-tag--large sim-tag--primary">大號</span>
    </div>
    <div class="sim-row">
      <span class="sim-tag sim-tag--primary">方角</span>
      <span class="sim-tag sim-tag--primary sim-tag--round">圓角</span>
    </div>
  </div>
</div>
<p class="sim-note">HTML 模擬預覽（iOS / SwiftUI 外觀），非真機渲染</p>

## 可關閉

`closable` 在右側顯示關閉按鈕，點選觸發 `onClose`（黃金用例 `closable-tap-emits-onclose`）。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Tag 關閉</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-tag sim-tag--primary">可關閉<svg class="sim-tag__close" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.4"><path d="M6 6l12 12M18 6L6 18"/></svg></span>
      <span class="sim-tag">可關閉<svg class="sim-tag__close" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.4"><path d="M6 6l12 12M18 6L6 18"/></svg></span>
    </div>
  </div>
</div>
<p class="sim-note">HTML 模擬預覽（iOS / SwiftUI 外觀），非真機渲染</p>

```swift
LhTag(text: "可關閉", type: .primary, closable: true) {
  // onClose
}
```

## API

### Props

| 屬性 | 說明 | 類型 | 預設值 |
| --- | --- | --- | --- |
| `text` | 標籤文字 | `String` | — |
| `type` | 標籤類型，決定底色與文字色 | `LhTagType` | `.default` |
| `lhSize` | 標籤尺寸，對應到尺寸令牌 | `LhTagSize` | `.medium` |
| `plain` | 是否為描邊淺底形態 | `Bool` | `false` |
| `round` | 是否為膠囊圓角（半徑 = 高度 / 2） | `Bool` | `false` |
| `closable` | 是否顯示關閉按鈕 | `Bool` | `false` |
| `onClose` | 關閉按鈕點選回呼 | `(() -> Void)?` | `nil` |

### LhTagType

| 值 | 底色 | 文字色 |
| --- | --- | --- |
| `.default` | `color.background.default` + `color.border.base` 描邊 | `color.text.primary` |
| `.primary` | `color.primary.default` | `color.onPrimary` |
| `.success` | `color.success.default` | `color.onPrimary` |
| `.warning` | `color.warning.default` | `color.onPrimary` |
| `.danger` | `color.danger.default` | `color.onPrimary` |
| `.info` | `color.info.default` | `color.onPrimary` |

`plain = true` 時：底色取 `color.<type>.bg`、描邊與文字取 `color.<type>.default`（`.default` 類型忽略 `plain`，黃金用例 `default-type-renders-text`）。

### LhTagSize

| 值 | height | paddingHorizontal | fontSize |
| --- | --- | --- | --- |
| `.small` | `tag.height.small`（20pt） | `tag.paddingHorizontal.small`（8pt） | `tag.fontSize.small`（12pt） |
| `.medium` | `tag.height.medium`（24pt） | `tag.paddingHorizontal.medium`（12pt） | `tag.fontSize.medium`（13pt） |
| `.large` | `tag.height.large`（28pt） | `tag.paddingHorizontal.large`（16pt） | `tag.fontSize.large`（14pt） |

## 令牌對照

| 令牌 | 用途 |
| --- | --- |
| `tag.height.{small,medium,large}` | 三檔高度 |
| `tag.paddingHorizontal.{small,medium,large}` | 三檔橫向內邊距 |
| `tag.fontSize.{small,medium,large}` | 三檔字號 |
| `tag.borderRadius` / `tag.borderWidth` | 預設圓角（跟隨 `radius.small`）與描邊寬度 |
| `tag.gap` | 文字與關閉按鈕間距（跟隨 `spacing.xs`） |
| `color.{primary,success,warning,danger,info}.{default,bg}` | 語義類型底色與描邊淺底 |
| `color.onPrimary` | 語義類型文字色 |
| `color.background.default` / `color.text.primary` / `color.border.base` | 預設類型三色 |

## 黃金用例對照

| case id | 斷言 | 本地測試 |
| --- | --- | --- |
| `default-type-renders-text` | 預設類型中性底/文字，忽略 plain | `testDefaultTypeUsesNeutralTokens` / `testDefaultTypeIgnoresPlain` |
| `primary-type-uses-primary-tokens` | 主色類型消費主色與 onPrimary | `testPrimaryTypeUsesPrimaryTokens` |
| `plain-uses-bg-tokens` | plain 消費語義 bg 與語義描邊 | `testPlainUsesBgTokens` |
| `small-size-uses-small-tokens` | 小號消費 small 尺寸令牌 | `testSmallSizeUsesSmallTokens` |
| `round-makes-radius-half-height` | round 圓角 == 高度 / 2 | `testRoundMakesRadiusHalfHeight` |
| `closable-tap-emits-onclose` | 關閉按鈕觸發 onClose | `testClosableTagInitAndRender`（手勢斷言需模擬器） |

另有暗色專項：`testDarkColorsComeFromDarkTokens` / `testPlainInDarkUsesDarkBgTokens` /
`testDimensionsAreIdenticalInDarkMode`。

```bash
swift test --filter LhTagTests    # macOS 宿主即可執行，無需模擬器
```

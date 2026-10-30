# Button 按鈕

基礎操作按鈕。觸發即時操作，支援類型、尺寸、載入、停用、圖示與國風花紋底。

> 契約源：`lh-ui-core/specs/button.json` ·
> 黃金用例：`lh-ui-core/cases/button.json`（8 條，已翻譯為 XCTest，macOS 宿主即可執行）

## 類型

六種類型決定底色與文字色。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Button 類型</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <button class="sim-btn">預設按鈕</button>
      <button class="sim-btn sim-btn--primary">主要按鈕</button>
    </div>
    <div class="sim-row">
      <button class="sim-btn sim-btn--success">成功按鈕</button>
      <button class="sim-btn sim-btn--warning">警告按鈕</button>
    </div>
    <div class="sim-row">
      <button class="sim-btn sim-btn--danger">危險按鈕</button>
      <button class="sim-btn sim-btn--info">資訊按鈕</button>
    </div>
  </div>
</div>
<p class="sim-note">HTML 模擬預覽（iOS / SwiftUI 外觀），非真機渲染</p>

```swift
LhButton(lhOnClick: {}, type: .primary, text: "主要按鈕")
```

## 尺寸

三檔尺寸對應到 `button.height` / `paddingHorizontal` / `fontSize` / `iconSize` 令牌。
iOS 形態為膠囊圓角（`radius.round` 令牌）。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Button 尺寸</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <button class="sim-btn sim-btn--small">小型按鈕</button>
      <button class="sim-btn">中型按鈕</button>
      <button class="sim-btn sim-btn--large">大型按鈕</button>
    </div>
  </div>
</div>
<p class="sim-note">HTML 模擬預覽（iOS / SwiftUI 外觀），非真機渲染</p>

## 狀態

停用與載入中都不觸發 `lhOnClick`；兩者共存時按**停用優先**處理（黃金用例 `disabled-precedes-loading`）。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Button 狀態</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <button class="sim-btn sim-btn--primary">正常</button>
      <button class="sim-btn sim-btn--primary sim-btn--disabled">停用</button>
    </div>
    <div class="sim-row">
      <button class="sim-btn sim-btn--primary sim-btn--loading">
        <span class="sim-btn__spinner"></span>載入中
      </button>
      <button class="sim-btn sim-btn--primary sim-btn--disabled">停用優先</button>
    </div>
  </div>
</div>
<p class="sim-note">HTML 模擬預覽（iOS / SwiftUI 外觀），非真機渲染</p>

## 圖示與花紋底

圖示名按本機圖示體系解析（`LhButtonStyle.icon(for:)` 對應 SF Symbol：search → magnifyingglass、
refresh → arrow.clockwise、check → checkmark、close → xmark，未登入名不繪製）。
花紋底消費 `color.decoration` 令牌，Canvas 繪製 45° 斜紋，疊在底色之下、文字之上但不影響對比度。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>圖示與花紋</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <button class="sim-btn sim-btn--primary"><span class="sim-btn__icon"></span>搜尋</button>
      <button class="sim-btn"><span class="sim-btn__icon"></span>預設</button>
    </div>
    <div class="sim-row">
      <button class="sim-btn sim-btn--primary sim-btn--pattern">主要花紋底</button>
      <button class="sim-btn sim-btn--pattern">預設花紋底</button>
    </div>
  </div>
</div>
<p class="sim-note">HTML 模擬預覽（iOS / SwiftUI 外觀），非真機渲染</p>

## 明暗主題

切換站點右上角主題，模擬器手機框內的按鈕顏色即變；真機透過 `LhTheme(isDark: true)` 切換。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>暗色按鈕</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <button class="sim-btn sim-btn--primary">主要按鈕</button>
      <button class="sim-btn">預設按鈕</button>
    </div>
    <div class="sim-row">
      <button class="sim-btn sim-btn--primary sim-btn--disabled">停用</button>
      <button class="sim-btn sim-btn--success">成功</button>
    </div>
  </div>
</div>
<p class="sim-note">HTML 模擬預覽（iOS / SwiftUI 外觀），非真機渲染；明/暗值全部取自 core 令牌快照</p>

## API

### Props

| 屬性 | 說明 | 類型 | 預設值 |
| --- | --- | --- | --- |
| `lhOnClick` | 點選回呼；`disabled` 或 `loading` 為 true 時不觸發 | `() -> Void` | — |
| `type` | 按鈕類型，決定底色與文字色 | `LhButtonType` | `.default` |
| `lhSize` | 按鈕尺寸，對應到尺寸令牌 | `LhButtonSize` | `.medium` |
| `disabled` | 是否停用 | `Bool` | `false` |
| `loading` | 是否載入中（顯示指示器，不觸發 lhOnClick） | `Bool` | `false` |
| `icon` | 圖示名（SF Symbol 對應解析） | `String?` | `nil` |
| `bgPattern` | 是否繪製國風花紋底紋 | `Bool` | `false` |
| `label` / `text` | 按鈕文字內容（spec 的 default 插槽） | `Text` / 字串 | — |

### LhButtonType

| 值 | 底色 | 文字色 |
| --- | --- | --- |
| `.default` | `color.background.default` | `color.text.primary` |
| `.primary` | `color.primary.default` | `color.onPrimary` |
| `.success` | `color.success.default` | `color.onPrimary` |
| `.warning` | `color.warning.default` | `color.onPrimary` |
| `.danger` | `color.danger.default` | `color.onPrimary` |
| `.info` | `color.info.default` | `color.onPrimary` |

### LhButtonSize

| 值 | height | paddingHorizontal | fontSize | iconSize |
| --- | --- | --- | --- | --- |
| `.small` | `button.height.small`（32pt） | `button.paddingHorizontal.small`（16pt） | `button.fontSize.small`（13pt） | `button.iconSize.small`（16pt） |
| `.medium` | `button.height.medium`（40pt） | `button.paddingHorizontal.medium`（20pt） | `button.fontSize.medium`（14pt） | `button.iconSize.medium`（18pt） |
| `.large` | `button.height.large`（48pt） | `button.paddingHorizontal.large`（24pt） | `button.fontSize.large`（16pt） | `button.iconSize.large`（20pt） |

停用態覆蓋：底色 `color.disabled.bg`、文字 `color.disabled.text`、描邊 `color.disabled.border`。

## 令牌對照

按鈕消費的令牌（與 `specs/button.json` 的 `tokenRefs` 逐條對齊）：

| 令牌 | 用途 |
| --- | --- |
| `button.height.{small,medium,large}` | 三檔高度 |
| `button.paddingHorizontal.{small,medium,large}` | 三檔橫向內邊距 |
| `button.fontSize.{small,medium,large}` | 三檔字號 |
| `button.iconSize.{small,medium,large}` | 三檔圖示尺寸 |
| `button.borderRadius` / `button.borderWidth` | 圓角（跟隨 `radius.base`）與描邊寬度 |
| `button.fontWeight` | 字重（跟隨 `typography.fontWeight.primary`，端側對應 Font.Weight） |
| `color.primary.default` / `color.onPrimary` | 主色類型底/文字 |
| `color.{success,warning,danger,info}.default` | 語義類型底色 |
| `color.background.default` / `color.text.primary` / `color.border.base` | 預設類型底/文字/描邊 |
| `color.disabled.{bg,text,border}` | 停用態三色 |
| `color.decoration` | 花紋底紋色 |
| `shadow.lighter` | 預設 elevation（LhShadow 載體） |
| `spacing.xs` | 圖示與文字間距 |

## 黃金用例對照

`cases/button.json` 的 8 條斷言與 XCTest 的對應關係：

| case id | 斷言 | 本地測試 |
| --- | --- | --- |
| `click-emits-onclick` | gate 放行（可互動） | `LhButtonTests.testEnabledButtonIsInteractive` |
| `disabled-blocks-click` | 停用態不可互動 | `testDisabledIsNotInteractive` |
| `loading-blocks-click` | 載入態不可互動 | `testLoadingIsNotInteractive` |
| `disabled-precedes-loading` | 停用優先 + 停用樣式 | `testDisabledPrecedesLoading` |
| `default-type-renders-text` | 預設類型中性底/文字 | `testDefaultTypeUsesNeutralTokens` |
| `primary-type-uses-primary-tokens` | 主色類型消費主色令牌 | `testPrimaryTypeUsesPrimaryTokens` |
| `small-size-uses-small-tokens` | 小號消費 small 尺寸令牌 | `testSmallSizeUsesSmallTokens` |
| `bgpattern-uses-decoration-token` | 花紋底消費裝飾色 | `testBgPatternUsesDecorationToken` |

另有暗色專項：`testDarkColorsComeFromDarkTokens` / `testDisabledInDarkUsesDarkDisabledTokens` /
`testDimensionsAreIdenticalInDarkMode`。

```bash
swift test    # macOS 宿主即可執行，無需模擬器
```

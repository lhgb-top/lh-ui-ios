# Navbar 導覽列

頁面頂部導覽列。置中標題 + 兩側內容，底部分隔線，層級取 `zIndex.sticky`。

> 契約源：`lh-ui-core/specs/navbar.json` ·
> 黃金用例：`lh-ui-core/cases/navbar.json`（6 條，已翻譯為 XCTest，macOS 宿主即可執行）

## 基本形態

`title` 置中顯示（絕對定位，不與兩側內容重疊）；`leftText` / `rightText` 分別貼左右兩側。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Navbar 基本</span></div>
  <div class="sim-navbar sim-navbar--bordered">
    <span class="sim-navbar__side">返回</span>
    <span class="sim-navbar__title">青花瓷</span>
    <span class="sim-navbar__side">更多</span>
  </div>
  <div class="sim-screen">
    <div class="sim-row"><span class="sim-tag sim-tag--primary">頁面內容</span></div>
  </div>
</div>
<p class="sim-note">HTML 模擬預覽（iOS / SwiftUI 外觀），非真機渲染</p>

```swift
LhNavbar(
  title: "青花瓷",
  leftText: "返回",
  rightText: "更多",
  onLeftClick: { /* 返回 */ },
  onRightClick: { /* 更多 */ }
)
```

## 圖示與邊框

`leftIcon` / `rightIcon` 走 `LhIconMap` 對應，與文字並排顯示；`bordered = false` 移除底部分隔線。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Navbar 圖示</span></div>
  <div class="sim-navbar">
    <span class="sim-navbar__side">
      <span class="sim-navbar__icon"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M15 5l-7 7 7 7"/></svg></span>
      <span>返回</span>
    </span>
    <span class="sim-navbar__title">標題</span>
    <span class="sim-navbar__side">
      <span>設定</span>
      <span class="sim-navbar__icon"><svg viewBox="0 0 24 24" fill="currentColor"><circle cx="12" cy="12" r="8"/></svg></span>
    </span>
  </div>
  <div class="sim-screen">
    <div class="sim-row"><span class="sim-tag">無邊框導覽列</span></div>
  </div>
</div>
<p class="sim-note">HTML 模擬預覽（iOS / SwiftUI 外觀），非真機渲染</p>

## 點選 gate

未提供 `leftText` / `leftIcon` 時左側不回應點選（黃金用例 `no-left-content-no-onleftclick`），
右側同理。懸浮定位由呼叫方用 `.overlay` 掛載（SwiftUI 慣例），元件自身提供 `zIndex.sticky` 層級。

```swift
ZStack {
  contentView
    .padding(.top, LhTokens.Navbar.height)
  LhNavbar(title: "青花瓷", leftText: "返回", onLeftClick: { dismiss() })
    .overlay(alignment: .top) { ... }
}
```

## API

### Props

| 屬性 | 說明 | 類型 | 預設值 |
| --- | --- | --- | --- |
| `title` | 置中標題 | `String` | `""` |
| `leftText` | 左側文字（為空且無 leftIcon 時不回應點選） | `String` | `""` |
| `leftIcon` | 左側圖示邏輯名（`LhIconMap` 對應） | `String?` | `nil` |
| `rightText` | 右側文字（為空且無 rightIcon 時不回應點選） | `String` | `""` |
| `rightIcon` | 右側圖示邏輯名 | `String?` | `nil` |
| `bordered` | 是否顯示底部分隔線 | `Bool` | `true` |
| `onLeftClick` | 左側點選回呼 | `(() -> Void)?` | `nil` |
| `onRightClick` | 右側點選回呼 | `(() -> Void)?` | `nil` |

### 顏色

| 區域 | 顏色 |
| --- | --- |
| 底色 | `color.background.default` |
| 標題 / 兩側文字 / 圖示 | `color.text.primary` |
| 分隔線 | `color.border.lighter`（寬度取 `navbar.borderWidth`） |

## 令牌對照

| 令牌 | 用途 |
| --- | --- |
| `navbar.height` | 導覽列高度（44pt） |
| `navbar.paddingHorizontal` | 兩側橫向內邊距（12pt） |
| `navbar.titleFontSize` | 標題與兩側文字字號（16pt） |
| `navbar.iconSize` | 兩側圖示尺寸（20pt） |
| `navbar.borderWidth` | 底部分隔線寬度 |
| `color.border.lighter` | 分隔線顏色 |
| `color.text.primary` | 標題與兩側內容顏色 |
| `color.background.default` | 底色 |
| `zIndex.sticky` | 懸浮層級 |

## 黃金用例對照

| case id | 斷言 | 本地測試 |
| --- | --- | --- |
| `title-renders-text` | 標題正確渲染 | `testTitleUsesNavbarTokens` |
| `leftclick-emits-onleftclick` | 左側點選觸發 onLeftClick | `testLeftContentIsClickable` |
| `rightclick-emits-onrightclick` | 右側點選觸發 onRightClick | `testRightContentIsClickable` |
| `no-left-content-no-onleftclick` | 無左側內容時不觸發 | `testNoLeftContentIsNotClickable` |
| `bordered-uses-border-token` | 分隔線消費 border.lighter 令牌 | `testBorderedUsesBorderToken` |
| `height-uses-navbar-height-token` | 高度消費 navbar.height 令牌 | `testHeightUsesNavbarHeightToken` |

另有專項：`testContainerUsesBackgroundToken` / `testDarkColorsComeFromDarkTokens` /
`testDimensionsAreIdenticalInDarkMode` / `testNavbarInitAndRender`。

```bash
swift test --filter LhNavbarTests    # macOS 宿主即可執行，無需模擬器
```

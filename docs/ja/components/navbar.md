# Navbar ナビゲーションバー

ページ上部のナビゲーションバー。中央にタイトル、両側にコンテンツ、底部に区切り線を配置し、重ね順は `zIndex.sticky` です。

> 契約ソース：`lh-ui-core/specs/navbar.json` ·
> ゴールデンケース：`lh-ui-core/cases/navbar.json`（6 件、XCTest に翻訳済み、macOS ホストだけで実行可能）

## 基本形

`title` は中央に表示されます（絶対配置で、両側のコンテンツと重なりません）。`leftText` / `rightText` はそれぞれ左右に寄せられます。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Navbar 基本</span></div>
  <div class="sim-navbar sim-navbar--bordered">
    <span class="sim-navbar__side">戻る</span>
    <span class="sim-navbar__title">青花瓷</span>
    <span class="sim-navbar__side">もっと見る</span>
  </div>
  <div class="sim-screen">
    <div class="sim-row"><span class="sim-tag sim-tag--primary">ページの内容</span></div>
  </div>
</div>
<p class="sim-note">HTML シミュレーションプレビュー（iOS / SwiftUI の外観）であり、実機でのレンダリングではありません</p>

```swift
LhNavbar(
  title: "青花瓷",
  leftText: "戻る",
  rightText: "もっと見る",
  onLeftClick: { /* 戻る */ },
  onRightClick: { /* もっと見る */ }
)
```

## アイコンと枠線

`leftIcon` / `rightIcon` は `LhIconMap` でマッピングされ、文字と並んで表示されます。`bordered = false` で底部の区切り線を取り除きます。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Navbar アイコン</span></div>
  <div class="sim-navbar">
    <span class="sim-navbar__side">
      <span class="sim-navbar__icon"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M15 5l-7 7 7 7"/></svg></span>
      <span>戻る</span>
    </span>
    <span class="sim-navbar__title">タイトル</span>
    <span class="sim-navbar__side">
      <span>設定</span>
      <span class="sim-navbar__icon"><svg viewBox="0 0 24 24" fill="currentColor"><circle cx="12" cy="12" r="8"/></svg></span>
    </span>
  </div>
  <div class="sim-screen">
    <div class="sim-row"><span class="sim-tag">枠線なしナビゲーションバー</span></div>
  </div>
</div>
<p class="sim-note">HTML シミュレーションプレビュー（iOS / SwiftUI の外観）であり、実機でのレンダリングではありません</p>

## タップゲート

`leftText` / `leftIcon` を指定しない場合、左側はタップに反応しません（ゴールデンケース `no-left-content-no-onleftclick`）。
右側も同様です。オーバーレイによる配置は呼び出し側が `.overlay` でマウントします（SwiftUI の慣例）。コンポーネント自身は `zIndex.sticky` の重ね順を提供します。

```swift
ZStack {
  contentView
    .padding(.top, LhTokens.Navbar.height)
  LhNavbar(title: "青花瓷", leftText: "戻る", onLeftClick: { dismiss() })
    .overlay(alignment: .top) { ... }
}
```

## API

### プロパティ

| プロパティ | 説明 | 型 | デフォルト値 |
| --- | --- | --- | --- |
| `title` | 中央のタイトル | `String` | `""` |
| `leftText` | 左側の文字（空かつ leftIcon もない場合はタップに反応しない） | `String` | `""` |
| `leftIcon` | 左側のアイコン論理名（`LhIconMap` でマッピング） | `String?` | `nil` |
| `rightText` | 右側の文字（空かつ rightIcon もない場合はタップに反応しない） | `String` | `""` |
| `rightIcon` | 右側のアイコン論理名 | `String?` | `nil` |
| `bordered` | 底部の区切り線を表示するかどうか | `Bool` | `true` |
| `onLeftClick` | 左側タップのコールバック | `(() -> Void)?` | `nil` |
| `onRightClick` | 右側タップのコールバック | `(() -> Void)?` | `nil` |

### 色

| 領域 | 色 |
| --- | --- |
| 底色 | `color.background.default` |
| タイトル / 両側の文字 / アイコン | `color.text.primary` |
| 区切り線 | `color.border.lighter`（幅は `navbar.borderWidth`） |

## トークン対応表

| トークン | 用途 |
| --- | --- |
| `navbar.height` | ナビゲーションバーの高さ（44pt） |
| `navbar.paddingHorizontal` | 両側の水平方向パディング（12pt） |
| `navbar.titleFontSize` | タイトルと両側の文字のフォントサイズ（16pt） |
| `navbar.iconSize` | 両側のアイコンサイズ（20pt） |
| `navbar.borderWidth` | 底部の区切り線の幅 |
| `color.border.lighter` | 区切り線の色 |
| `color.text.primary` | タイトルと両側コンテンツの色 |
| `color.background.default` | 底色 |
| `zIndex.sticky` | オーバーレイ時の重ね順 |

## ゴールデンケース対応表

| case id | アサーション | ローカルテスト |
| --- | --- | --- |
| `title-renders-text` | タイトルが正しく描画される | `testTitleUsesNavbarTokens` |
| `leftclick-emits-onleftclick` | 左側タップで onLeftClick を発火 | `testLeftContentIsClickable` |
| `rightclick-emits-onrightclick` | 右側タップで onRightClick を発火 | `testRightContentIsClickable` |
| `no-left-content-no-onleftclick` | 左側コンテンツがない場合は発火しない | `testNoLeftContentIsNotClickable` |
| `bordered-uses-border-token` | 区切り線が border.lighter トークンを消費 | `testBorderedUsesBorderToken` |
| `height-uses-navbar-height-token` | 高さが navbar.height トークンを消費 | `testHeightUsesNavbarHeightToken` |

さらに関連テスト：`testContainerUsesBackgroundToken` / `testDarkColorsComeFromDarkTokens` /
`testDimensionsAreIdenticalInDarkMode` / `testNavbarInitAndRender`。

```bash
swift test --filter LhNavbarTests    # macOS ホストだけで実行可能、シミュレーター不要
```

# Button ボタン

基本的な操作ボタンです。即時アクションを起こし、タイプ、サイズ、読み込み、無効、アイコン、中華風の柄に対応します。

> 契約ソース：`lh-ui-core/specs/button.json` ·
> ゴールデンケース：`lh-ui-core/cases/button.json`（8 件、XCTest に翻訳済み、macOS ホストだけで実行可能）

## タイプ

6 種類のタイプが背景色と文字色を決定します。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Button タイプ</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <button class="sim-btn">デフォルトボタン</button>
      <button class="sim-btn sim-btn--primary">メインボタン</button>
    </div>
    <div class="sim-row">
      <button class="sim-btn sim-btn--success">成功ボタン</button>
      <button class="sim-btn sim-btn--warning">警告ボタン</button>
    </div>
    <div class="sim-row">
      <button class="sim-btn sim-btn--danger">危険ボタン</button>
      <button class="sim-btn sim-btn--info">情報ボタン</button>
    </div>
  </div>
</div>
<p class="sim-note">HTML シミュレーションプレビュー（iOS / SwiftUI の外観）であり、実機でのレンダリングではありません</p>

```swift
LhButton(lhOnClick: {}, type: .primary, text: "メインボタン")
```

## サイズ

3 段階のサイズは `button.height` / `paddingHorizontal` / `fontSize` / `iconSize` トークンに対応付けられます。
iOS ではカプセル型の角丸です（`radius.round` トークン）。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Button サイズ</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <button class="sim-btn sim-btn--small">小型ボタン</button>
      <button class="sim-btn">中型ボタン</button>
      <button class="sim-btn sim-btn--large">大型ボタン</button>
    </div>
  </div>
</div>
<p class="sim-note">HTML シミュレーションプレビュー（iOS / SwiftUI の外観）であり、実機でのレンダリングではありません</p>

## 状態

無効と読み込み中はどちらも `lhOnClick` を発火しません。両方指定された場合は**無効を優先**します（ゴールデンケース `disabled-precedes-loading`）。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Button 状態</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <button class="sim-btn sim-btn--primary">通常</button>
      <button class="sim-btn sim-btn--primary sim-btn--disabled">無効</button>
    </div>
    <div class="sim-row">
      <button class="sim-btn sim-btn--primary sim-btn--loading">
        <span class="sim-btn__spinner"></span>読み込み中
      </button>
      <button class="sim-btn sim-btn--primary sim-btn--disabled">無効優先</button>
    </div>
  </div>
</div>
<p class="sim-note">HTML シミュレーションプレビュー（iOS / SwiftUI の外観）であり、実機でのレンダリングではありません</p>

## アイコンと柄背景

アイコン名はローカルのアイコン体系で解決されます（`LhButtonStyle.icon(for:)` が SF Symbol にマッピング：search → magnifyingglass、
refresh → arrow.clockwise、check → checkmark、close → xmark。未登録の名前は描画されません）。
柄は `color.decoration` トークンを消費し、Canvas で 45° の斜線を描画します。背景色の上、文字の下に重なりますが、コントラストには影響しません。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>アイコンと柄</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <button class="sim-btn sim-btn--primary"><span class="sim-btn__icon"></span>検索</button>
      <button class="sim-btn"><span class="sim-btn__icon"></span>デフォルト</button>
    </div>
    <div class="sim-row">
      <button class="sim-btn sim-btn--primary sim-btn--pattern">メイン柄背景</button>
      <button class="sim-btn sim-btn--pattern">デフォルト柄背景</button>
    </div>
  </div>
</div>
<p class="sim-note">HTML シミュレーションプレビュー（iOS / SwiftUI の外観）であり、実機でのレンダリングではありません</p>

## ライト・ダークテーマ

サイト右上のテーマを切り替えると、シミュレーターのスマートフォンフレーム内のボタンの色も変わります。実機では `LhTheme(isDark: true)` で切り替えます。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>ダークボタン</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <button class="sim-btn sim-btn--primary">メインボタン</button>
      <button class="sim-btn">デフォルトボタン</button>
    </div>
    <div class="sim-row">
      <button class="sim-btn sim-btn--primary sim-btn--disabled">無効</button>
      <button class="sim-btn sim-btn--success">成功</button>
    </div>
  </div>
</div>
<p class="sim-note">HTML シミュレーションプレビュー（iOS / SwiftUI の外観）であり、実機でのレンダリングではありません。ライト/ダークの値はすべて core のトークンスナップショットから取得しています</p>

## API

### プロパティ

| プロパティ | 説明 | 型 | デフォルト値 |
| --- | --- | --- | --- |
| `lhOnClick` | タップ時のコールバック。`disabled` または `loading` が true の場合は発火しない | `() -> Void` | — |
| `type` | ボタンのタイプ。背景色と文字色を決定 | `LhButtonType` | `.default` |
| `lhSize` | ボタンのサイズ。サイズトークンに対応付け | `LhButtonSize` | `.medium` |
| `disabled` | 無効にするかどうか | `Bool` | `false` |
| `loading` | 読み込み中かどうか（インジケーターを表示し、lhOnClick は発火しない） | `Bool` | `false` |
| `icon` | アイコン名（SF Symbol へのマッピングで解決） | `String?` | `nil` |
| `bgPattern` | 中華風の柄を描画するかどうか | `Bool` | `false` |
| `label` / `text` | ボタンのテキスト（spec の default スロット） | `Text` / 文字列 | — |

### LhButtonType

| 値 | 背景色 | 文字色 |
| --- | --- | --- |
| `.default` | `color.background.default` | `color.text.primary` |
| `.primary` | `color.primary.default` | `color.onPrimary` |
| `.success` | `color.success.default` | `color.onPrimary` |
| `.warning` | `color.warning.default` | `color.onPrimary` |
| `.danger` | `color.danger.default` | `color.onPrimary` |
| `.info` | `color.info.default` | `color.onPrimary` |

### LhButtonSize

| 値 | height | paddingHorizontal | fontSize | iconSize |
| --- | --- | --- | --- | --- |
| `.small` | `button.height.small`（32pt） | `button.paddingHorizontal.small`（16pt） | `button.fontSize.small`（13pt） | `button.iconSize.small`（16pt） |
| `.medium` | `button.height.medium`（40pt） | `button.paddingHorizontal.medium`（20pt） | `button.fontSize.medium`（14pt） | `button.iconSize.medium`（18pt） |
| `.large` | `button.height.large`（48pt） | `button.paddingHorizontal.large`（24pt） | `button.fontSize.large`（16pt） | `button.iconSize.large`（20pt） |

無効状態の上書き：背景色 `color.disabled.bg`、文字 `color.disabled.text`、枠線 `color.disabled.border`。

## トークン対応表

ボタンが消費するトークン（`specs/button.json` の `tokenRefs` と 1 件ずつ対応）：

| トークン | 用途 |
| --- | --- |
| `button.height.{small,medium,large}` | 3 段階の高さ |
| `button.paddingHorizontal.{small,medium,large}` | 3 段階の水平方向パディング |
| `button.fontSize.{small,medium,large}` | 3 段階のフォントサイズ |
| `button.iconSize.{small,medium,large}` | 3 段階のアイコンサイズ |
| `button.borderRadius` / `button.borderWidth` | 角丸（`radius.base` に追従）と枠線の太さ |
| `button.fontWeight` | フォントの太さ（`typography.fontWeight.primary` に追従、端側で Font.Weight にマッピング） |
| `color.primary.default` / `color.onPrimary` | メインタイプの背景/文字 |
| `color.{success,warning,danger,info}.default` | セマンティックタイプの背景色 |
| `color.background.default` / `color.text.primary` / `color.border.base` | デフォルトタイプの背景/文字/枠線 |
| `color.disabled.{bg,text,border}` | 無効状態の 3 色 |
| `color.decoration` | 柄の色 |
| `shadow.lighter` | デフォルトの elevation（LhShadow 構造体） |
| `spacing.xs` | アイコンとテキストの間隔 |

## ゴールデンケース対応表

`cases/button.json` の 8 件のアサーションと XCTest の対応関係：

| case id | アサーション | ローカルテスト |
| --- | --- | --- |
| `click-emits-onclick` | ゲートが許可（インタラクティブ） | `LhButtonTests.testEnabledButtonIsInteractive` |
| `disabled-blocks-click` | 無効状態はインタラクティブでない | `testDisabledIsNotInteractive` |
| `loading-blocks-click` | 読み込み中はインタラクティブでない | `testLoadingIsNotInteractive` |
| `disabled-precedes-loading` | 無効を優先 ＋ 無効スタイル | `testDisabledPrecedesLoading` |
| `default-type-renders-text` | デフォルトタイプは中性的な背景/文字 | `testDefaultTypeUsesNeutralTokens` |
| `primary-type-uses-primary-tokens` | メインタイプがメインカラートークンを消費 | `testPrimaryTypeUsesPrimaryTokens` |
| `small-size-uses-small-tokens` | 小サイズが small サイズトークンを消費 | `testSmallSizeUsesSmallTokens` |
| `bgpattern-uses-decoration-token` | 柄が装飾色を消費 | `testBgPatternUsesDecorationToken` |

さらにダーク関連：`testDarkColorsComeFromDarkTokens` / `testDisabledInDarkUsesDarkDisabledTokens` /
`testDimensionsAreIdenticalInDarkMode`。

```bash
swift test    # macOS ホストだけで実行可能、シミュレーター不要
```

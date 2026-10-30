# Cell セル

リストのセルです。左側にアイコン ＋ タイトル（必須の赤いアスタリスクとサブタイトルを含む）、右側に値と矢印、下部に区切り線を持ちます。

> 契約ソース：`lh-ui-core/specs/cell.json` ·
> ゴールデンケース：`lh-ui-core/cases/cell.json`（6 件、XCTest に翻訳済み、macOS ホストだけで実行可能）

## 基本形

`title` は必須、`value` / `label` / `icon` は任意です。`bordered` で下部の区切り線を制御します（デフォルトは表示）。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Cell 基本</span></div>
  <div class="sim-screen" style="padding: 0;">
    <div class="sim-cell">
      <div class="sim-cell__main"><div class="sim-cell__title">タイトルテキスト</div></div>
      <div class="sim-cell__value">右側の値</div>
      <div class="sim-cell__arrow">›</div>
    </div>
    <div class="sim-cell">
      <div class="sim-cell__main">
        <div class="sim-cell__title">サブタイトル付き</div>
        <div class="sim-cell__label">これはサブタイトルの説明テキストです</div>
      </div>
      <div class="sim-cell__arrow">›</div>
    </div>
    <div class="sim-cell">
      <div class="sim-cell__main"><div class="sim-cell__title">区切り線なし</div></div>
      <div class="sim-cell__value">値</div>
    </div>
  </div>
</div>
<p class="sim-note">HTML シミュレーションプレビュー（iOS / SwiftUI の外観）であり、実機でのレンダリングではありません</p>

```swift
LhCell(title: "タイトルテキスト", value: "右側の値", clickable: true) {
  // lhOnClick
}
```

## アイコン / 必須 / タップ不可

`icon` は `LhIconMap` のマッピングを使用します。`required` はタイトルの前に赤いアスタリスクを表示します。
`clickable = false`（デフォルト）のときはタップに応答しません（ゴールデンケース `not-clickable-no-onclick`）。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Cell 拡張</span></div>
  <div class="sim-screen" style="padding: 0;">
    <div class="sim-cell">
      <span class="sim-cell__icon"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" style="width:100%;height:100%"><circle cx="11" cy="11" r="7"/><path d="M21 21l-4.3-4.3"/></svg></span>
      <div class="sim-cell__main"><div class="sim-cell__title">左側アイコン</div></div>
      <div class="sim-cell__arrow">›</div>
    </div>
    <div class="sim-cell">
      <div class="sim-cell__main"><div class="sim-cell__title"><span class="sim-cell__required">*</span>必須項目</div></div>
      <div class="sim-cell__value">選択してください</div>
      <div class="sim-cell__arrow">›</div>
    </div>
  </div>
</div>
<p class="sim-note">HTML シミュレーションプレビュー（iOS / SwiftUI の外観）であり、実機でのレンダリングではありません</p>

## API

### プロパティ

| プロパティ | 説明 | 型 | デフォルト値 |
| --- | --- | --- | --- |
| `title` | タイトル（必須） | `String` | — |
| `value` | 右側の値 | `String` | `""` |
| `label` | タイトル下のサブタイトル | `String` | `""` |
| `icon` | 左側アイコンの論理名（`LhIconMap` がマッピング） | `String?` | `nil` |
| `bordered` | 下部の区切り線を表示するかどうか | `Bool` | `true` |
| `clickable` | タップ可能かどうか（矢印とタップゲートを制御） | `Bool` | `false` |
| `required` | タイトルの前に赤い必須アスタリスクを表示するかどうか | `Bool` | `false` |
| `lhOnClick` | タップ時のコールバック。`clickable = false` の場合は発火しない | `(() -> Void)?` | `nil` |

### テキストの階層

| 領域 | フォントサイズ | 色 |
| --- | --- | --- |
| タイトル | `cell.fontSizeTitle`（14pt） | `color.text.primary` |
| サブタイトル | `cell.fontSizeLabel`（13pt） | `color.text.secondary` |
| 右側の値 | `cell.fontSizeValue`（14pt） | `color.text.secondary` |
| 必須アスタリスク | `cell.fontSizeTitle` | `color.danger.default` |

## トークン対応表

| トークン | 用途 |
| --- | --- |
| `cell.paddingHorizontal` / `cell.paddingVertical` | パディング（`spacing.base` / `spacing.sm` に追従） |
| `cell.fontSizeTitle` / `cell.fontSizeLabel` / `cell.fontSizeValue` | 3 段階のテキストフォントサイズ |
| `cell.iconSize` | 左側アイコンのサイズ |
| `cell.gap` | 各領域の間隔（`spacing.sm` に追従） |
| `cell.borderWidth` | 下部区切り線の太さ |
| `color.border.lighter` | 下部区切り線の色 |
| `color.text.{primary,secondary}` | タイトルと値/サブタイトルの色 |
| `color.danger.default` | 必須アスタリスクの色 |
| `color.background.default` | セルの背景色 |

## ゴールデンケース対応表

| case id | アサーション | ローカルテスト |
| --- | --- | --- |
| `title-and-value-render` | タイトルと値を同時に描画 | `testTitleAndValueUseFontTokens` |
| `label-renders-secondary-tone` | サブタイトルはセカンダリの文字色 | `testLabelRendersSecondaryTone` |
| `required-uses-danger-token` | 必須アスタリスクは危険色トークンを使用 | `testRequiredUsesDangerToken` |
| `bordered-emits-line-command` | 区切り線が border.lighter トークンを消費 | `testBorderedUsesBorderTokens` |
| `clickable-emits-onclick` | タップ可能なとき lhOnClick を発火 | `testClickableIsInteractive` |
| `not-clickable-no-onclick` | タップ不可のとき lhOnClick を発火しない | `testNotClickableIsNotInteractive` |

さらに関連テスト：`testDarkColorsComeFromDarkTokens` / `testDimensionsAreIdenticalInDarkMode` /
`testCellInitAndRender` / `testLayoutUsesCellTokens`。

```bash
swift test --filter LhCellTests    # macOS ホストだけで実行可能、シミュレーター不要
```

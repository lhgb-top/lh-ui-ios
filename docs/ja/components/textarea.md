# Textarea テキストエリア

コントロールドな複数行入力フィールド。`@Binding var value` で双方向バインディングし、プレースホルダーテキストと文字数カウントを重ねて表示します。

> 契約ソース：`lh-ui-core/specs/textarea.json` ·
> ゴールデンケース：`lh-ui-core/cases/textarea.json`（6 件、XCTest に翻訳済み、macOS ホストだけで実行可能）

## 基本形

最小の高さは `textarea.minHeight`、パディングは `textarea.paddingHorizontal` / `paddingVertical` を取ります。
フォーカス時に枠線を `color.focus` に切り替えます。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Textarea 基本</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-textarea"><textarea class="sim-textarea__field" placeholder="内容を入力してください"></textarea></span>
    </div>
    <div class="sim-row">
      <span class="sim-textarea sim-textarea--focus"><textarea class="sim-textarea__field">青花瓷</textarea></span>
    </div>
  </div>
</div>
<p class="sim-note">HTML シミュレーションプレビュー（iOS / SwiftUI の外観）であり、実機でのレンダリングではありません</p>

```swift
@State private var text = ""

LhTextarea(value: $text, placeholder: "内容を入力してください") { newValue in
  // onValueChange
}
```

## 文字数カウント

`showCount = true` のとき右下にカウントを表示します。`maxlength` を設定すると `現在/上限` という形式になります（ゴールデンケース
`showcount-renders-count`）。未設定なら現在の長さのみを表示します（`showcount-without-maxlength-renders-length-only`）。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Textarea カウント</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-textarea">
        <textarea class="sim-textarea__field">青花瓷</textarea>
        <span class="sim-textarea__count">3/10</span>
      </span>
    </div>
    <div class="sim-row">
      <span class="sim-textarea sim-textarea--disabled">
        <textarea class="sim-textarea__field" disabled>無効</textarea>
      </span>
    </div>
  </div>
</div>
<p class="sim-note">HTML シミュレーションプレビュー（iOS / SwiftUI の外観）であり、実機でのレンダリングではありません</p>

```swift
LhTextarea(value: $text, showCount: true, maxlength: 10)
```

## API

### プロパティ

| プロパティ | 説明 | 型 | デフォルト値 |
| --- | --- | --- | --- |
| `value` | 入力内容（コントロールドな双方向バインディング） | `String` | — |
| `placeholder` | プレースホルダーテキスト | `String` | `""` |
| `rows` | 期待する行数（最小の高さに影響） | `Int` | `3` |
| `disabled` | 無効にするかどうか（コールバックを発火しない） | `Bool` | `false` |
| `readonly` | 読み取り専用かどうか（onValueChange を発火しない、フォーカススタイルは保持） | `Bool` | `false` |
| `showCount` | 文字数カウントを表示するかどうか | `Bool` | `false` |
| `maxlength` | 最大字数（超過すると切り詰め） | `Int?` | `nil` |
| `onValueChange` | 内容変化のコールバック。payload は新しい値 | `((String) -> Void)?` | `nil` |
| `lhOnFocus` | フォーカス時のコールバック | `(() -> Void)?` | `nil` |
| `lhOnBlur` | フォーカス外れのコールバック | `(() -> Void)?` | `nil` |

### 色

| 状態 | 枠線 | 文字 / プレースホルダー |
| --- | --- | --- |
| デフォルト | `color.border.base`（`textarea.borderWidth`） | `color.text.primary` / `color.text.placeholder` |
| フォーカス | `color.focus`（`textarea.focusRingWidth`） | 同上 |
| 無効 | `color.disabled.border` | `color.disabled.text` |

## トークン対応表

| トークン | 用途 |
| --- | --- |
| `textarea.minHeight` | 最小の高さ |
| `textarea.paddingHorizontal` / `textarea.paddingVertical` | パディング |
| `textarea.fontSize` | フォントサイズ |
| `textarea.countFontSize` | カウント文字のフォントサイズ |
| `textarea.borderRadius` / `textarea.borderWidth` | 角丸と枠線の太さ |
| `textarea.focusRingWidth` | フォーカスリングの幅 |
| `color.focus` | フォーカス時の枠線色 |
| `color.text.{primary,placeholder,disabled}` | 文字とプレースホルダーの色 |
| `color.border.base` / `color.disabled.border` | 枠線色 |
| `color.background.default` / `color.disabled.bg` | 底色 |

## ゴールデンケース対応表

| case id | アサーション | ローカルテスト |
| --- | --- | --- |
| `input-emits-onvaluechange` | 入力で `onValueChange("青花瓷")` を発火 | `testDefaultIsEditable` |
| `disabled-blocks-input` | 無効状態は onValueChange を発火しない | `testDisabledBlocksInput` |
| `showcount-renders-count` | カウントが `3/10` を表示しカウントフォントサイズトークンを消費 | `testShowCountRendersCount` |
| `showcount-without-maxlength-renders-length-only` | 上限なしだと `3` のみ表示 | `testShowCountWithoutMaxlengthRendersLengthOnly` |
| `focus-uses-focus-token` | フォーカスは focus トークンを消費し lhOnFocus を発火 | `testFocusUsesFocusToken` |
| `maxlength-truncates-input` | 字数超過で切り詰め | `testMaxlengthTruncatesInput` |

さらに関連テスト：`testLayoutUsesTextareaTokens` / `testReadonlyBlocksInputButKeepsFocusStyle` /
`testDarkColorsComeFromDarkTokens` / `testDimensionsAreIdenticalInDarkMode` /
`testTextareaViewInitAcceptsConstant`。

```bash
swift test --filter LhTextareaTests    # macOS ホストだけで実行可能、シミュレーター不要
```

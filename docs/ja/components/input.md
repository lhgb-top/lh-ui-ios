# Input 入力フィールド

コントロールドな単一行入力フィールド。`@Binding var value` で双方向バインディングし、平文 / パスワード、クリアボタン、字数上限、フォーカスリングに対応します。

> 契約ソース：`lh-ui-core/specs/input.json` ·
> ゴールデンケース：`lh-ui-core/cases/input.json`（8 件、XCTest に翻訳済み、macOS ホストだけで実行可能）

## 基本形

高さは Button に揃えます（3 段階の `input.height` トークン）。フォーカス時に枠線を `color.focus` に切り替え、フォーカスリングとして太くします。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Input 基本</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-input"><input class="sim-input__field" placeholder="内容を入力してください" /></span>
    </div>
    <div class="sim-row">
      <span class="sim-input sim-input--focus"><input class="sim-input__field" value="青花瓷" /></span>
    </div>
  </div>
</div>
<p class="sim-note">HTML シミュレーションプレビュー（iOS / SwiftUI の外観）であり、実機でのレンダリングではありません</p>

```swift
@State private var text = ""

LhInput(value: $text, placeholder: "内容を入力してください") { newValue in
  // onValueChange
}
```

## サイズ

3 段階のサイズは `input.height` / `paddingHorizontal` / `fontSize` トークンに対応付けられます。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Input サイズ</span></div>
  <div class="sim-screen">
    <div class="sim-row"><span class="sim-input sim-input--small"><input class="sim-input__field" placeholder="小" /></span></div>
    <div class="sim-row"><span class="sim-input"><input class="sim-input__field" placeholder="中" /></span></div>
    <div class="sim-row"><span class="sim-input sim-input--large"><input class="sim-input__field" placeholder="大" /></span></div>
  </div>
</div>
<p class="sim-note">HTML シミュレーションプレビュー（iOS / SwiftUI の外観）であり、実機でのレンダリングではありません</p>

## パスワードとクリア

`type: .password` は `SecureField` として実装されます（テスト `testPasswordTypeIsSecure`）。
`clearable` は値があるときクリアボタンを表示し、タップで `onValueChange("")` を発火します（ゴールデンケース `clearable-emits-empty-value`）。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Input 拡張</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-input"><input class="sim-input__field" type="password" value="secret" /><svg class="sim-input__clear" viewBox="0 0 24 24" fill="currentColor"><path d="M12 2a10 10 0 100 20 10 10 0 000-20zm1 15h-2v-2h2zm0-4h-2V7h2z"/></svg></span>
    </div>
    <div class="sim-row">
      <span class="sim-input sim-input--disabled"><input class="sim-input__field" value="無効" disabled /></span>
    </div>
  </div>
</div>
<p class="sim-note">HTML シミュレーションプレビュー（iOS / SwiftUI の外観）であり、実機でのレンダリングではありません</p>

```swift
LhInput(value: $pwd, type: .password, clearable: true)
```

## API

### プロパティ

| プロパティ | 説明 | 型 | デフォルト値 |
| --- | --- | --- | --- |
| `value` | 入力内容（コントロールドな双方向バインディング） | `String` | — |
| `placeholder` | プレースホルダーテキスト | `String` | `""` |
| `type` | 入力タイプ（平文 / パスワード） | `LhInputType` | `.text` |
| `lhSize` | 入力フィールドのサイズ。サイズトークンに対応付け | `LhInputSize` | `.medium` |
| `disabled` | 無効にするかどうか（コールバックを発火しない） | `Bool` | `false` |
| `readonly` | 読み取り専用かどうか（onValueChange を発火しない、フォーカススタイルは保持） | `Bool` | `false` |
| `clearable` | クリアボタンを表示するかどうか | `Bool` | `false` |
| `maxlength` | 最大字数（超過すると切り詰め、ゴールデンケース `maxlength-truncates-input`） | `Int?` | `nil` |
| `onValueChange` | 内容変化のコールバック。payload は新しい値 | `((String) -> Void)?` | `nil` |
| `lhOnFocus` | フォーカス時のコールバック | `(() -> Void)?` | `nil` |
| `lhOnBlur` | フォーカス外れのコールバック | `(() -> Void)?` | `nil` |

### LhInputSize

| 値 | height | paddingHorizontal | fontSize |
| --- | --- | --- | --- |
| `.small` | `input.height.small`（32pt） | `input.paddingHorizontal.small`（12pt） | `input.fontSize.small`（13pt） |
| `.medium` | `input.height.medium`（40pt） | `input.paddingHorizontal.medium`（16pt） | `input.fontSize.medium`（14pt） |
| `.large` | `input.height.large`（48pt） | `input.paddingHorizontal.large`（20pt） | `input.fontSize.large`（16pt） |

### LhInputType

| 値 | 実装 |
| --- | --- |
| `.text` | `TextField` |
| `.password` | `SecureField` |

### 色

| 状態 | 枠線 | 文字 / プレースホルダー |
| --- | --- | --- |
| デフォルト | `color.border.base`（`input.borderWidth`） | `color.text.primary` / `color.text.placeholder` |
| フォーカス | `color.focus`（`input.focusRingWidth`） | 同上 |
| 無効 | `color.disabled.border` | `color.disabled.text` |

## トークン対応表

| トークン | 用途 |
| --- | --- |
| `input.height.{small,medium,large}` | 3 段階の高さ |
| `input.paddingHorizontal.{small,medium,large}` | 3 段階の水平方向パディング |
| `input.fontSize.{small,medium,large}` | 3 段階のフォントサイズ |
| `input.borderRadius` / `input.borderWidth` | 角丸（`radius.small` に追従）と枠線の太さ |
| `input.focusRingWidth` | フォーカスリングの幅 |
| `input.clearIconSize` | クリアボタンアイコンのサイズ |
| `color.focus` | フォーカス時の枠線色 |
| `color.text.{primary,placeholder,disabled}` | 文字とプレースホルダーの色 |
| `color.border.base` / `color.disabled.border` | 枠線色 |
| `color.background.default` / `color.disabled.bg` | 底色 |

## ゴールデンケース対応表

| case id | アサーション | ローカルテスト |
| --- | --- | --- |
| `input-emits-onvaluechange` | 入力で `onValueChange("青花瓷")` を発火 | `testDefaultIsEditable` |
| `clearable-emits-empty-value` | クリアで `onValueChange("")` を発火 | `testClearableShowsClearButtonWhenHasValue` |
| `disabled-blocks-input` | 無効状態は onValueChange を発火しない | `testDisabledBlocksInput` |
| `readonly-blocks-input` | 読み取り専用は onValueChange を発火しない | `testReadonlyBlocksInput` |
| `placeholder-uses-placeholder-token` | プレースホルダー文字はプレースホルダー色トークンを取る | `testPlaceholderUsesPlaceholderToken` |
| `focus-uses-focus-token` | フォーカスは focus トークンを消費し lhOnFocus を発火 | `testFocusUsesFocusToken` |
| `small-size-uses-small-tokens` | 小サイズは small サイズトークンを消費 | `testSmallSizeUsesSmallTokens` |
| `maxlength-truncates-input` | 字数超過で切り詰め | `testMaxlengthTruncatesInput` |

さらに関連テスト：`testPasswordTypeIsSecure` / `testDarkColorsComeFromDarkTokens` /
`testDimensionsAreIdenticalInDarkMode` / `testInputViewInitAcceptsConstant`。

```bash
swift test --filter LhInputTests    # macOS ホストだけで実行可能、シミュレーター不要
```

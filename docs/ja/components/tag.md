# Tag タグ

マークと選択用のコンパクトなタグ。ボタンより小さく、セマンティックタイプ、枠線、角丸カプセル、クローズボタンに対応します。

> 契約ソース：`lh-ui-core/specs/tag.json` ·
> ゴールデンケース：`lh-ui-core/cases/tag.json`（6 件、XCTest に翻訳済み、macOS ホストだけで実行可能）

## タイプ

6 種類のタイプが底色と文字色を決定します。`plain` は枠線付きの薄底フォーム（セマンティック薄底 ＋ セマンティック枠線）です。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Tag タイプ</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-tag">デフォルト</span>
      <span class="sim-tag sim-tag--primary">メイン</span>
      <span class="sim-tag sim-tag--success">成功</span>
    </div>
    <div class="sim-row">
      <span class="sim-tag sim-tag--warning">警告</span>
      <span class="sim-tag sim-tag--danger">危険</span>
      <span class="sim-tag sim-tag--info">情報</span>
    </div>
    <div class="sim-row">
      <span class="sim-tag sim-tag--plain sim-tag--primary">枠線メイン</span>
      <span class="sim-tag sim-tag--plain sim-tag--success">枠線成功</span>
    </div>
  </div>
</div>
<p class="sim-note">HTML シミュレーションプレビュー（iOS / SwiftUI の外観）であり、実機でのレンダリングではありません</p>

```swift
LhTag(text: "メイン", type: .primary)
LhTag(text: "枠線成功", type: .success, plain: true)
```

## サイズと角丸

3 段階のサイズは `tag.height` / `paddingHorizontal` / `fontSize` トークンに対応付けられます。`round` は角丸を高さの半分（カプセル）に切り替えます。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Tag サイズ</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-tag sim-tag--small sim-tag--primary">小</span>
      <span class="sim-tag sim-tag--primary">中</span>
      <span class="sim-tag sim-tag--large sim-tag--primary">大</span>
    </div>
    <div class="sim-row">
      <span class="sim-tag sim-tag--primary">角丸なし</span>
      <span class="sim-tag sim-tag--primary sim-tag--round">角丸</span>
    </div>
  </div>
</div>
<p class="sim-note">HTML シミュレーションプレビュー（iOS / SwiftUI の外観）であり、実機でのレンダリングではありません</p>

## クローズ可能

`closable` は右側にクローズボタンを表示し、タップで `onClose` を発火します（ゴールデンケース `closable-tap-emits-onclose`）。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Tag クローズ</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-tag sim-tag--primary">クローズ可能<svg class="sim-tag__close" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.4"><path d="M6 6l12 12M18 6L6 18"/></svg></span>
      <span class="sim-tag">クローズ可能<svg class="sim-tag__close" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.4"><path d="M6 6l12 12M18 6L6 18"/></svg></span>
    </div>
  </div>
</div>
<p class="sim-note">HTML シミュレーションプレビュー（iOS / SwiftUI の外観）であり、実機でのレンダリングではありません</p>

```swift
LhTag(text: "クローズ可能", type: .primary, closable: true) {
  // onClose
}
```

## API

### プロパティ

| プロパティ | 説明 | 型 | デフォルト値 |
| --- | --- | --- | --- |
| `text` | タグの文字 | `String` | — |
| `type` | タグのタイプ。底色と文字色を決定 | `LhTagType` | `.default` |
| `lhSize` | タグのサイズ。サイズトークンに対応付け | `LhTagSize` | `.medium` |
| `plain` | 枠線付き薄底フォームにするかどうか | `Bool` | `false` |
| `round` | カプセル角丸にするかどうか（半径 = 高さ / 2） | `Bool` | `false` |
| `closable` | クローズボタンを表示するかどうか | `Bool` | `false` |
| `onClose` | クローズボタンタップのコールバック | `(() -> Void)?` | `nil` |

### LhTagType

| 値 | 底色 | 文字色 |
| --- | --- | --- |
| `.default` | `color.background.default` ＋ `color.border.base` の枠線 | `color.text.primary` |
| `.primary` | `color.primary.default` | `color.onPrimary` |
| `.success` | `color.success.default` | `color.onPrimary` |
| `.warning` | `color.warning.default` | `color.onPrimary` |
| `.danger` | `color.danger.default` | `color.onPrimary` |
| `.info` | `color.info.default` | `color.onPrimary` |

`plain = true` のとき：底色は `color.<type>.bg`、枠線と文字は `color.<type>.default` を取ります（`.default` タイプは `plain` を無視、ゴールデンケース `default-type-renders-text`）。

### LhTagSize

| 値 | height | paddingHorizontal | fontSize |
| --- | --- | --- | --- |
| `.small` | `tag.height.small`（20pt） | `tag.paddingHorizontal.small`（8pt） | `tag.fontSize.small`（12pt） |
| `.medium` | `tag.height.medium`（24pt） | `tag.paddingHorizontal.medium`（12pt） | `tag.fontSize.medium`（13pt） |
| `.large` | `tag.height.large`（28pt） | `tag.paddingHorizontal.large`（16pt） | `tag.fontSize.large`（14pt） |

## トークン対応表

| トークン | 用途 |
| --- | --- |
| `tag.height.{small,medium,large}` | 3 段階の高さ |
| `tag.paddingHorizontal.{small,medium,large}` | 3 段階の水平方向パディング |
| `tag.fontSize.{small,medium,large}` | 3 段階のフォントサイズ |
| `tag.borderRadius` / `tag.borderWidth` | デフォルトの角丸（`radius.small` に追従）と枠線の太さ |
| `tag.gap` | 文字とクローズボタンの間隔（`spacing.xs` に追従） |
| `color.{primary,success,warning,danger,info}.{default,bg}` | セマンティックタイプの底色と枠線薄底 |
| `color.onPrimary` | セマンティックタイプの文字色 |
| `color.background.default` / `color.text.primary` / `color.border.base` | デフォルトタイプの 3 色 |

## ゴールデンケース対応表

| case id | アサーション | ローカルテスト |
| --- | --- | --- |
| `default-type-renders-text` | デフォルトタイプは中性的な底/文字で plain を無視 | `testDefaultTypeUsesNeutralTokens` / `testDefaultTypeIgnoresPlain` |
| `primary-type-uses-primary-tokens` | primary タイプが primary と onPrimary を消費 | `testPrimaryTypeUsesPrimaryTokens` |
| `plain-uses-bg-tokens` | plain がセマンティック bg とセマンティック枠線を消費 | `testPlainUsesBgTokens` |
| `small-size-uses-small-tokens` | 小サイズが small サイズトークンを消費 | `testSmallSizeUsesSmallTokens` |
| `round-makes-radius-half-height` | round の角丸 == 高さ / 2 | `testRoundMakesRadiusHalfHeight` |
| `closable-tap-emits-onclose` | クローズボタンが onClose を発火 | `testClosableTagInitAndRender`（ジェスチャのアサーションにはシミュレーターが必要） |

さらにダーク関連：`testDarkColorsComeFromDarkTokens` / `testPlainInDarkUsesDarkBgTokens` /
`testDimensionsAreIdenticalInDarkMode`。

```bash
swift test --filter LhTagTests    # macOS ホストだけで実行可能、シミュレーター不要
```

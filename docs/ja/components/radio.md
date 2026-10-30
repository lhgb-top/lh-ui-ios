# Radio ラジオボタン

コントロールドなラジオボタン。`@Binding var checked` は「この項目が選択されているか」を表し、通常はグループと組み合わせて使います。同一グループ内で `true` になれるのは 1 項目だけです。

> 契約ソース：`lh-ui-core/specs/radio.json` ·
> ゴールデンケース：`lh-ui-core/cases/radio.json`（6 件、XCTest に翻訳済み、macOS ホストだけで実行可能）

## 状態

選択中は primary 色の枠線リング ＋ 塗りつぶされた primary 色の円点、未選択は枠線のみの空リングです。円点の直径はサイズに `radio.dotScale`（50%）を掛けたものです。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Radio 状態</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-radio"><span class="sim-radio__ring"></span>未選択</span>
      <span class="sim-radio sim-radio--checked"><span class="sim-radio__ring"><span class="sim-radio__dot"></span></span>選択済み</span>
    </div>
    <div class="sim-row">
      <span class="sim-radio sim-radio--checked sim-radio--disabled"><span class="sim-radio__ring"><span class="sim-radio__dot"></span></span>無効（選択済み）</span>
      <span class="sim-radio sim-radio--disabled"><span class="sim-radio__ring"></span>無効（未選択）</span>
    </div>
  </div>
</div>
<p class="sim-note">HTML シミュレーションプレビュー（iOS / SwiftUI の外観）であり、実機でのレンダリングではありません</p>

```swift
@State private var picked = "blue"

LhRadio(checked: Binding(get: { picked == "blue" }, set: { _ in }), value: "blue", label: "青花瓷") { _ in
  picked = "blue"
}
```

## サイズ

3 段階のサイズは `radio.size` トークンに対応付けられ、リングの枠線は `radio.ringWidth` を取ります。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Radio サイズ</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-radio sim-radio--checked"><span class="sim-radio__ring sim-radio__ring--small"><span class="sim-radio__dot sim-radio__dot--small"></span></span>小</span>
      <span class="sim-radio sim-radio--checked"><span class="sim-radio__ring"><span class="sim-radio__dot"></span></span>中</span>
      <span class="sim-radio sim-radio--checked"><span class="sim-radio__ring sim-radio__ring--large"><span class="sim-radio__dot sim-radio__dot--large"></span></span>大</span>
    </div>
  </div>
</div>
<p class="sim-note">HTML シミュレーションプレビュー（iOS / SwiftUI の外観）であり、実機でのレンダリングではありません</p>

## タップゲート

選択済みの項目をタップしても選択は維持され、`onChange` は発火しません（ゴールデンケース `tap-checked-keeps-checked`）。
無効状態も発火しません（`disabled-blocks-change`）。グループコンテナは今後のバージョンで提供予定です。

## API

### プロパティ

| プロパティ | 説明 | 型 | デフォルト値 |
| --- | --- | --- | --- |
| `checked` | この項目が選択されているか（コントロールドな双方向バインディング） | `Bool` | — |
| `value` | この項目が表す値（`checked` と組み合わせてラジオグループを実現） | `String` | `""` |
| `disabled` | 無効にするかどうか（onChange を発火しない） | `Bool` | `false` |
| `lhSize` | ラジオボタンのサイズ。サイズトークンに対応付け | `LhRadioSize` | `.medium` |
| `label` | 文字ラベル | `String` | `""` |
| `onChange` | 選択変化のコールバック。payload は新しい値 | `((Bool) -> Void)?` | `nil` |

### LhRadioSize

| 値 | リングサイズ | 円点の直径 |
| --- | --- | --- |
| `.small` | `radio.size.small`（16pt） | サイズ × `radio.dotScale`（8pt） |
| `.medium` | `radio.size.medium`（20pt） | サイズ × `radio.dotScale`（10pt） |
| `.large` | `radio.size.large`（24pt） | サイズ × `radio.dotScale`（12pt） |

### 色

| 状態 | リングの枠線 | 円点 |
| --- | --- | --- |
| 未選択 | `color.border.base`（`radio.ringWidth`） | — |
| 選択 | `color.primary.default` | `color.primary.default` |
| 無効 | `color.disabled.border` | `color.disabled.text` |

## トークン対応表

| トークン | 用途 |
| --- | --- |
| `radio.size.{small,medium,large}` | 3 段階のリングサイズ |
| `radio.dotScale` | 円点のリングサイズに対する割合（50%） |
| `radio.ringWidth` | リングの枠線の太さ |
| `radio.gap` | リングと文字の間隔（`spacing.sm` に追従） |
| `color.primary.default` | 選択状態の枠線と円点の色 |
| `color.border.base` | 未選択の枠線色 |
| `color.disabled.{border,text}` | 無効状態の枠線と円点の色 |
| `color.text.{primary,disabled}` | ラベル文字の色 |

## ゴールデンケース対応表

| case id | アサーション | ローカルテスト |
| --- | --- | --- |
| `tap-unchecked-emits-onchange` | 未選択のタップで `onChange(true)` を発火 | `testUncheckedIsInteractive` |
| `tap-checked-keeps-checked` | 選択済みのタップは選択を維持しコールバックしない | `testCheckedShowsDot` |
| `disabled-blocks-change` | 無効状態は onChange を発火しない | `testDisabledBlocksChange` |
| `checked-uses-primary-tokens` | 選択状態が primary カラートークンを消費 | `testCheckedUsesPrimaryTokens` |
| `unchecked-uses-border-token` | 未選択が枠線トークンを消費 | `testUncheckedUsesBorderToken` |
| `small-size-uses-small-token` | 小サイズが small サイズトークンを消費 | `testSmallSizeUsesSmallToken` |

さらに関連テスト：`testStrokeUsesRadioTokens` / `testDarkColorsComeFromDarkTokens` /
`testDisabledInDarkUsesDarkDisabledTokens` / `testDimensionsAreIdenticalInDarkMode` /
`testRadioViewInitAcceptsConstant`。

```bash
swift test --filter LhRadioTests    # macOS ホストだけで実行可能、シミュレーター不要
```

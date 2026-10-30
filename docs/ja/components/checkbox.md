# Checkbox チェックボックス

コントロールドなチェックボックスです。`@Binding var checked` で双方向バインディングし、3 つの状態（チェック済み / 未チェック / 不確定）をサポートします。

> 契約ソース：`lh-ui-core/specs/checkbox.json` ·
> ゴールデンケース：`lh-ui-core/cases/checkbox.json`（6 件、XCTest に翻訳済み、macOS ホストだけで実行可能）

## 状態

チェック済みは塗りつぶされたメインカラーの四角 ＋ 白いチェックマーク、不確定は塗りつぶされたメインカラーの四角 ＋ 白い横棒、未チェックは枠線のみの空枠です。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Checkbox 状態</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-checkbox"><span class="sim-checkbox__box"></span>未チェック</span>
      <span class="sim-checkbox sim-checkbox--checked"><span class="sim-checkbox__box"><svg class="sim-checkbox__check" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.8"><path d="M4 12.5l5 5L20 6.5"/></svg></span>チェック済み</span>
    </div>
    <div class="sim-row">
      <span class="sim-checkbox sim-checkbox--indeterminate"><span class="sim-checkbox__box"><span class="sim-checkbox__dash"></span></span>不確定</span>
      <span class="sim-checkbox sim-checkbox--checked sim-checkbox--disabled"><span class="sim-checkbox__box"><svg class="sim-checkbox__check" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.8"><path d="M4 12.5l5 5L20 6.5"/></svg></span>無効</span>
    </div>
  </div>
</div>
<p class="sim-note">HTML シミュレーションプレビュー（iOS / SwiftUI の外観）であり、実機でのレンダリングではありません</p>

```swift
@State private var checked = false

LhCheckbox(checked: $checked, label: "チェック済み") { newValue in
  // onChange
}
```

## サイズ

3 段階のサイズは `checkbox.size` トークンに対応付けられます。チェックマークの枠線の太さは `checkbox.checkWidth`、
不確定状態の横棒の太さは四角のサイズに `checkbox.dashScale`（50%）を掛けたものです。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Checkbox サイズ</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-checkbox sim-checkbox--checked"><span class="sim-checkbox__box sim-checkbox__box--small"><svg class="sim-checkbox__check" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.8"><path d="M4 12.5l5 5L20 6.5"/></svg></span>小</span>
      <span class="sim-checkbox sim-checkbox--checked"><span class="sim-checkbox__box"><svg class="sim-checkbox__check" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.8"><path d="M4 12.5l5 5L20 6.5"/></svg></span>中</span>
      <span class="sim-checkbox sim-checkbox--checked"><span class="sim-checkbox__box sim-checkbox__box--large"><svg class="sim-checkbox__check" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.8"><path d="M4 12.5l5 5L20 6.5"/></svg></span>大</span>
    </div>
  </div>
</div>
<p class="sim-note">HTML シミュレーションプレビュー（iOS / SwiftUI の外観）であり、実機でのレンダリングではありません</p>

## 不確定状態

`indeterminate = true` のとき、チェックマークではなく横棒を表示します。タップすると必ず**チェック済み**になります（ゴールデンケース
`indeterminate-becomes-checked`）。単なるトグルではありません。

```swift
@State private var checked = false

LhCheckbox(checked: $checked, label: "すべて選択", indeterminate: somePartial) { _ in }
```

## API

### プロパティ

| プロパティ | 説明 | 型 | デフォルト値 |
| --- | --- | --- | --- |
| `checked` | チェック状態（コントロールドな双方向バインディング） | `Bool` | — |
| `indeterminate` | 不確定状態かどうか（横棒を表示、タップするとチェック済みに） | `Bool` | `false` |
| `disabled` | 無効にするかどうか（onChange を発火しない） | `Bool` | `false` |
| `lhSize` | チェックボックスのサイズ。サイズトークンに対応付け | `LhCheckboxSize` | `.medium` |
| `label` | テキストラベル | `String` | `""` |
| `onChange` | 状態変化のコールバック。payload は新しい値 | `((Bool) -> Void)?` | `nil` |

### LhCheckboxSize

| 値 | サイズ |
| --- | --- |
| `.small` | `checkbox.size.small`（16pt） |
| `.medium` | `checkbox.size.medium`（20pt） |
| `.large` | `checkbox.size.large`（24pt） |

### 色

| 状態 | 四角の背景色 | マークの色 |
| --- | --- | --- |
| 未チェック | 透明 ＋ `color.border.base` の枠線（`checkbox.borderWidth`） | — |
| チェック済み / 不確定 | `color.primary.default` | `color.onPrimary` |
| 無効 | `color.disabled.bg` ＋ `color.disabled.border` の枠線 | `color.disabled.text` |

## トークン対応表

| トークン | 用途 |
| --- | --- |
| `checkbox.size.{small,medium,large}` | 3 段階のサイズ |
| `checkbox.borderRadius` / `checkbox.borderWidth` | 角丸（`radius.small` に追従）と枠線の太さ |
| `checkbox.checkWidth` | チェックマークの枠線の太さ |
| `checkbox.dashScale` | 不確定状態の横棒の四角に対する割合（50%） |
| `checkbox.gap` | 四角とテキストの間隔（`spacing.sm` に追従） |
| `color.primary.default` / `color.onPrimary` | チェック済みの背景/マークの色 |
| `color.border.base` | 未チェックの枠線の色 |
| `color.disabled.{bg,border,text}` | 無効状態の 3 色 |

## ゴールデンケース対応表

| case id | アサーション | ローカルテスト |
| --- | --- | --- |
| `tap-toggles-and-emits-onchange` | タップで切り替わり、`onChange(true)` をコールバック | `testTapTogglesAndEmitsOnChange` |
| `tap-checked-unchecks` | チェック済みのタップで未チェックに | `testTapCheckedUnchecks` |
| `disabled-blocks-change` | 無効状態は onChange を発火しない | `testDisabledBlocksChange` |
| `checked-uses-primary-tokens` | チェック済みがメインカラーと onPrimary を消費 | `testCheckedUsesPrimaryTokens` |
| `unchecked-uses-border-token` | 未チェックが枠線トークンを消費 | `testUncheckedUsesBorderToken` |
| `indeterminate-becomes-checked` | 不確定状態のタップ後は必ずチェック済み | `testIndeterminateBecomesChecked` |

さらに関連テスト：`testSizeUsesSizeTokens` / `testStrokeUsesCheckboxTokens` /
`testDarkColorsComeFromDarkTokens` / `testDisabledInDarkUsesDarkDisabledTokens` /
`testDimensionsAreIdenticalInDarkMode` / `testCheckboxViewInitAcceptsConstant`。

```bash
swift test --filter LhCheckboxTests    # macOS ホストだけで実行可能、シミュレーター不要
```

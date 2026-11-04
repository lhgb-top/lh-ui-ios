# Text テキスト

テキスト表示プリミティブ：グローバル組版トークンを消費し、サイズレベル・字重・色調・整列をサポート。

> 契約元：`lh-ui-core/specs/text.json` · 黄金ケース：`lh-ui-core/cases/text.json`（5 件、XCTest に翻訳済み、macOS ホストで実行可能）

## サイズレベル

`level` は `typography.fontSize.<level>` トークンにマッピング（デフォルト `base`）。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Text</span></div>
  <div class="sim-screen">
    <p class="sim-text sim-text--extraLarge">extraLarge</p>
    <p class="sim-text sim-text--large">large</p>
    <p class="sim-text sim-text--medium">medium</p>
    <p class="sim-text">base</p>
    <p class="sim-text sim-text--small">small</p>
    <p class="sim-text sim-text--extraSmall">extraSmall</p>
  </div>
</div>
<p class="sim-note">HTML シミュレータプレビュー（iOS / SwiftUI の見た目）、実機レンダリングではありません</p>

```swift
LhText("Title text", level: .large)
```

## 字重

`weight` は `typography.fontWeight.<weight>` トークンにマッピング（primary 400 / bold 600）。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Text</span></div>
  <div class="sim-screen">
    <p class="sim-text">primary</p>
    <p class="sim-text sim-text--bold">bold</p>
  </div>
</div>
<p class="sim-note">HTML シミュレータプレビュー（iOS / SwiftUI の見た目）、実機レンダリングではありません</p>

## 色調

`tone` は `color.text.<tone>` トークンにマッピング。`selected` は `color.selected` を使用。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Text</span></div>
  <div class="sim-screen">
    <p class="sim-text">primary</p>
    <p class="sim-text sim-text--regular">regular</p>
    <p class="sim-text sim-text--secondary">secondary</p>
    <p class="sim-text sim-text--placeholder">placeholder</p>
    <p class="sim-text sim-text--disabled">disabled</p>
    <p class="sim-text sim-text--selected">selected</p>
  </div>
</div>
<p class="sim-note">HTML シミュレータプレビュー（iOS / SwiftUI の見た目）、実機レンダリングではありません</p>

## 整列と行高

`lhAlign` は行ボックス内で整列。行高は常に `typography.lineHeight.primary`（サイズ × 1.8）。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Text</span></div>
  <div class="sim-screen">
    <p class="sim-text sim-text--align-center">center</p>
    <p class="sim-text sim-text--align-end">end</p>
  </div>
</div>
<p class="sim-note">HTML シミュレータプレビュー（iOS / SwiftUI の見た目）、実機レンダリングではありません</p>

```swift
LhText("Centered", lhAlign: .center)
```

## API

| プロパティ | 説明 | 型 | デフォルト |
| --- | --- | --- | --- |
| `content` | テキスト内容（イニシャライザの第 1 引数、spec の default スロット） | `String` | `""` |
| `level` | サイズレベル | `LhTextLevel` | `.base` |
| `weight` | 字重 | `LhTextWeight` | `.primary` |
| `tone` | 色調 | `LhTextTone` | `.primary` |
| `lhAlign` | 整列と行高 | `LhTextAlign` | `.start` |

### LhTextLevel

| プロパティ | fontSize token |
| --- | --- |
| `.extraLarge` | `typography.fontSize.extraLarge` (20pt) |
| `.large` | `typography.fontSize.large` (18pt) |
| `.medium` | `typography.fontSize.medium` (16pt) |
| `.base` | `typography.fontSize.base` (14pt, default) |
| `.small` | `typography.fontSize.small` (13pt) |
| `.extraSmall` | `typography.fontSize.extraSmall` (12pt) |

### LhTextTone

| プロパティ | text color token |
| --- | --- |
| `.primary` | `color.text.primary` |
| `.regular` | `color.text.regular` |
| `.secondary` | `color.text.secondary` |
| `.placeholder` | `color.text.placeholder` |
| `.disabled` | `color.text.disabled` |
| `.selected` | `color.selected` |

## トークン对照

| Token | Usage |
| --- | --- |
| `typography.fontSize.<level>` | six size levels |
| `typography.fontWeight.{primary,bold}` | two weights |
| `typography.lineHeight.primary` | line height (font size × 1.8) |
| `color.text.<tone>` / `color.selected` | text tones |

## 黄金ケース对照

| case id | アサーション | ローカルテスト |
| --- | --- | --- |
| `default-level-uses-base-tokens` | default level consumes the base typography tokens | `LhTextTests.testDefaultLevelUsesBaseTokens` |
| `large-level-uses-large-token` | large level consumes the large size token | `LhTextTests.testLargeLevelUsesLargeToken` |
| `bold-weight-uses-bold-token` | bold consumes the bold weight token | `LhTextTests.testBoldWeightUsesBoldToken` |
| `secondary-tone-uses-text-secondary` | secondary tone takes the secondary text color token | `LhTextTests.testSecondaryToneUsesTextSecondary` |
| `render-emits-single-text-command` | render emits a single TEXT command | `LhTextTests.testAllLevelsUseTheirTokens` |

```bash
swift test --filter LhTextTests
```

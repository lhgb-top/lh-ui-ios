# Text 文字

文字展示原語：消費全局排版令牌，支援字號級別、字重、色調與對齊。

> 契約源：`lh-ui-core/specs/text.json` · 黃金用例：`lh-ui-core/cases/text.json`（5 條，已翻譯為 XCTest，macOS 宿主即可運行）

## 字號級別

`level` 映射到 `typography.fontSize.<level>` 令牌，預設 `base`。

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
<p class="sim-note">HTML 模擬預覽（iOS / SwiftUI 外觀），非真機渲染</p>

```swift
LhText("Title text", level: .large)
```

## 字重

`weight` 映射到 `typography.fontWeight.<weight>` 令牌（primary 400 / bold 600）。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Text</span></div>
  <div class="sim-screen">
    <p class="sim-text">primary</p>
    <p class="sim-text sim-text--bold">bold</p>
  </div>
</div>
<p class="sim-note">HTML 模擬預覽（iOS / SwiftUI 外觀），非真機渲染</p>

## 色調

`tone` 映射到 `color.text.<tone>` 令牌；`selected` 取 `color.selected`。

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
<p class="sim-note">HTML 模擬預覽（iOS / SwiftUI 外觀），非真機渲染</p>

## 對齊與行高

`lhAlign` 在行盒寬度內對齊；行高始終取 `typography.lineHeight.primary`（字號 × 1.8）。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Text</span></div>
  <div class="sim-screen">
    <p class="sim-text sim-text--align-center">center</p>
    <p class="sim-text sim-text--align-end">end</p>
  </div>
</div>
<p class="sim-note">HTML 模擬預覽（iOS / SwiftUI 外觀），非真機渲染</p>

```swift
LhText("Centered", lhAlign: .center)
```

## API

| 屬性 | 說明 | 類型 | 預設值 |
| --- | --- | --- | --- |
| `content` | 文字內容（建構器第一個參數，spec 的 default 插槽） | `String` | `""` |
| `level` | 字號級別 | `LhTextLevel` | `.base` |
| `weight` | 字重 | `LhTextWeight` | `.primary` |
| `tone` | 色調 | `LhTextTone` | `.primary` |
| `lhAlign` | 對齊與行高 | `LhTextAlign` | `.start` |

### LhTextLevel

| 屬性 | fontSize token |
| --- | --- |
| `.extraLarge` | `typography.fontSize.extraLarge` (20pt) |
| `.large` | `typography.fontSize.large` (18pt) |
| `.medium` | `typography.fontSize.medium` (16pt) |
| `.base` | `typography.fontSize.base` (14pt, default) |
| `.small` | `typography.fontSize.small` (13pt) |
| `.extraSmall` | `typography.fontSize.extraSmall` (12pt) |

### LhTextTone

| 屬性 | text color token |
| --- | --- |
| `.primary` | `color.text.primary` |
| `.regular` | `color.text.regular` |
| `.secondary` | `color.text.secondary` |
| `.placeholder` | `color.text.placeholder` |
| `.disabled` | `color.text.disabled` |
| `.selected` | `color.selected` |

## 令牌對照

| Token | Usage |
| --- | --- |
| `typography.fontSize.<level>` | six size levels |
| `typography.fontWeight.{primary,bold}` | two weights |
| `typography.lineHeight.primary` | line height (font size × 1.8) |
| `color.text.<tone>` / `color.selected` | text tones |

## 黃金用例對照

| case id | 斷言 | 本地測試 |
| --- | --- | --- |
| `default-level-uses-base-tokens` | default level consumes the base typography tokens | `LhTextTests.testDefaultLevelUsesBaseTokens` |
| `large-level-uses-large-token` | large level consumes the large size token | `LhTextTests.testLargeLevelUsesLargeToken` |
| `bold-weight-uses-bold-token` | bold consumes the bold weight token | `LhTextTests.testBoldWeightUsesBoldToken` |
| `secondary-tone-uses-text-secondary` | secondary tone takes the secondary text color token | `LhTextTests.testSecondaryToneUsesTextSecondary` |
| `render-emits-single-text-command` | render emits a single TEXT command | `LhTextTests.testAllLevelsUseTheirTokens` |

```bash
swift test --filter LhTextTests
```

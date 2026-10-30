# Cell

A list cell. On the left an icon + title (with an optional required asterisk and a subtitle), on the right a value and an arrow, with a bottom divider.

> Spec source: `lh-ui-core/specs/cell.json` ·
> Golden cases: `lh-ui-core/cases/cell.json` (6 entries, translated into XCTest, runnable on the macOS host)

## Basic usage

`title` is required; `value` / `label` / `icon` are optional. `bordered` controls the bottom divider (on by default).

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Cell basic</span></div>
  <div class="sim-screen" style="padding: 0;">
    <div class="sim-cell">
      <div class="sim-cell__main"><div class="sim-cell__title">Title text</div></div>
      <div class="sim-cell__value">Right value</div>
      <div class="sim-cell__arrow">›</div>
    </div>
    <div class="sim-cell">
      <div class="sim-cell__main">
        <div class="sim-cell__title">With subtitle</div>
        <div class="sim-cell__label">This is the subtitle description text</div>
      </div>
      <div class="sim-cell__arrow">›</div>
    </div>
    <div class="sim-cell">
      <div class="sim-cell__main"><div class="sim-cell__title">No divider</div></div>
      <div class="sim-cell__value">Value</div>
    </div>
  </div>
</div>
<p class="sim-note">HTML mock preview (iOS / SwiftUI appearance), not an on-device render</p>

```swift
LhCell(title: "Title text", value: "Right value", clickable: true) {
  // lhOnClick
}
```

## Icon / required / not clickable

`icon` goes through the `LhIconMap` mapping; `required` shows a red asterisk before the title;
when `clickable = false` (the default) taps are not handled (golden case `not-clickable-no-onclick`).

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Cell extras</span></div>
  <div class="sim-screen" style="padding: 0;">
    <div class="sim-cell">
      <span class="sim-cell__icon"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" style="width:100%;height:100%"><circle cx="11" cy="11" r="7"/><path d="M21 21l-4.3-4.3"/></svg></span>
      <div class="sim-cell__main"><div class="sim-cell__title">Left icon</div></div>
      <div class="sim-cell__arrow">›</div>
    </div>
    <div class="sim-cell">
      <div class="sim-cell__main"><div class="sim-cell__title"><span class="sim-cell__required">*</span>Required field</div></div>
      <div class="sim-cell__value">Please select</div>
      <div class="sim-cell__arrow">›</div>
    </div>
  </div>
</div>
<p class="sim-note">HTML mock preview (iOS / SwiftUI appearance), not an on-device render</p>

## API

### Props

| Prop | Description | Type | Default |
| --- | --- | --- | --- |
| `title` | Title (required) | `String` | — |
| `value` | Right-side value | `String` | `""` |
| `label` | Subtitle under the title | `String` | `""` |
| `icon` | Logical name of the left icon (mapped via `LhIconMap`) | `String?` | `nil` |
| `bordered` | Whether to show the bottom divider | `Bool` | `true` |
| `clickable` | Whether clickable (controls the arrow and the tap gate) | `Bool` | `false` |
| `required` | Whether to show a red required asterisk before the title | `Bool` | `false` |
| `lhOnClick` | Tap callback; not fired when `clickable = false` | `(() -> Void)?` | `nil` |

### Text hierarchy

| Area | Font size | Color |
| --- | --- | --- |
| Title | `cell.fontSizeTitle` (14pt) | `color.text.primary` |
| Subtitle | `cell.fontSizeLabel` (13pt) | `color.text.secondary` |
| Right value | `cell.fontSizeValue` (14pt) | `color.text.secondary` |
| Required asterisk | `cell.fontSizeTitle` | `color.danger.default` |

## Token Reference

| Token | Purpose |
| --- | --- |
| `cell.paddingHorizontal` / `cell.paddingVertical` | Padding (follows `spacing.base` / `spacing.sm`) |
| `cell.fontSizeTitle` / `cell.fontSizeLabel` / `cell.fontSizeValue` | The three text font sizes |
| `cell.iconSize` | Left icon size |
| `cell.gap` | Gap between sections (follows `spacing.sm`) |
| `cell.borderWidth` | Bottom divider width |
| `color.border.lighter` | Bottom divider color |
| `color.text.{primary,secondary}` | Title and value / subtitle colors |
| `color.danger.default` | Required asterisk color |
| `color.background.default` | Cell background |

## Golden Case Mapping

| case id | Assertion | Local test |
| --- | --- | --- |
| `title-and-value-render` | Both the title and the value are drawn | `testTitleAndValueUseFontTokens` |
| `label-renders-secondary-tone` | The subtitle takes the secondary text color | `testLabelRendersSecondaryTone` |
| `required-uses-danger-token` | The required asterisk takes the danger token | `testRequiredUsesDangerToken` |
| `bordered-emits-line-command` | The divider consumes the border.lighter token | `testBorderedUsesBorderTokens` |
| `clickable-emits-onclick` | When clickable, the tap fires lhOnClick | `testClickableIsInteractive` |
| `not-clickable-no-onclick` | When not clickable, the tap does not fire lhOnClick | `testNotClickableIsNotInteractive` |

Plus dedicated dark-mode tests: `testDarkColorsComeFromDarkTokens` / `testDimensionsAreIdenticalInDarkMode` /
`testCellInitAndRender` / `testLayoutUsesCellTokens`.

```bash
swift test --filter LhCellTests    # Runs on the macOS host, no simulator required
```

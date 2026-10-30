# Tag

A compact tag for marking and selection. Smaller than a button; supports semantic types, borders, a capsule radius, and a close button.

> Spec source: `lh-ui-core/specs/tag.json` ·
> Golden cases: `lh-ui-core/cases/tag.json` (6 entries, translated into XCTest, runnable on the macOS host)

## Types

Six types determine the background and text colors. `plain` is the outlined light-background form (semantic light background + semantic border).

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Tag types</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-tag">Default</span>
      <span class="sim-tag sim-tag--primary">Primary</span>
      <span class="sim-tag sim-tag--success">Success</span>
    </div>
    <div class="sim-row">
      <span class="sim-tag sim-tag--warning">Warning</span>
      <span class="sim-tag sim-tag--danger">Danger</span>
      <span class="sim-tag sim-tag--info">Info</span>
    </div>
    <div class="sim-row">
      <span class="sim-tag sim-tag--plain sim-tag--primary">Plain primary</span>
      <span class="sim-tag sim-tag--plain sim-tag--success">Plain success</span>
    </div>
  </div>
</div>
<p class="sim-note">HTML mock preview (iOS / SwiftUI appearance), not an on-device render</p>

```swift
LhTag(text: "Primary", type: .primary)
LhTag(text: "Plain success", type: .success, plain: true)
```

## Size and radius

Three sizes map to the `tag.height` / `paddingHorizontal` / `fontSize` tokens; `round` swaps the corner radius for half the height (a capsule).

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Tag sizes</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-tag sim-tag--small sim-tag--primary">Small</span>
      <span class="sim-tag sim-tag--primary">Medium</span>
      <span class="sim-tag sim-tag--large sim-tag--primary">Large</span>
    </div>
    <div class="sim-row">
      <span class="sim-tag sim-tag--primary">Square</span>
      <span class="sim-tag sim-tag--primary sim-tag--round">Round</span>
    </div>
  </div>
</div>
<p class="sim-note">HTML mock preview (iOS / SwiftUI appearance), not an on-device render</p>

## Closable

`closable` shows a close button on the right whose tap fires `onClose` (golden case `closable-tap-emits-onclose`).

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Tag close</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-tag sim-tag--primary">Closable<svg class="sim-tag__close" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.4"><path d="M6 6l12 12M18 6L6 18"/></svg></span>
      <span class="sim-tag">Closable<svg class="sim-tag__close" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.4"><path d="M6 6l12 12M18 6L6 18"/></svg></span>
    </div>
  </div>
</div>
<p class="sim-note">HTML mock preview (iOS / SwiftUI appearance), not an on-device render</p>

```swift
LhTag(text: "Closable", type: .primary, closable: true) {
  // onClose
}
```

## API

### Props

| Prop | Description | Type | Default |
| --- | --- | --- | --- |
| `text` | Tag text | `String` | — |
| `type` | Tag type, determines the background and text colors | `LhTagType` | `.default` |
| `lhSize` | Tag size, mapped to the size tokens | `LhTagSize` | `.medium` |
| `plain` | Whether to use the outlined light-background form | `Bool` | `false` |
| `round` | Whether to use a capsule radius (radius = height / 2) | `Bool` | `false` |
| `closable` | Whether to show a close button | `Bool` | `false` |
| `onClose` | Close-button tap callback | `(() -> Void)?` | `nil` |

### LhTagType

| Value | Background | Text color |
| --- | --- | --- |
| `.default` | `color.background.default` + `color.border.base` border | `color.text.primary` |
| `.primary` | `color.primary.default` | `color.onPrimary` |
| `.success` | `color.success.default` | `color.onPrimary` |
| `.warning` | `color.warning.default` | `color.onPrimary` |
| `.danger` | `color.danger.default` | `color.onPrimary` |
| `.info` | `color.info.default` | `color.onPrimary` |

When `plain = true`: the background takes `color.<type>.bg`, while the border and text take `color.<type>.default` (the `.default` type ignores `plain` — golden case `default-type-renders-text`).

### LhTagSize

| Value | height | paddingHorizontal | fontSize |
| --- | --- | --- | --- |
| `.small` | `tag.height.small` (20pt) | `tag.paddingHorizontal.small` (8pt) | `tag.fontSize.small` (12pt) |
| `.medium` | `tag.height.medium` (24pt) | `tag.paddingHorizontal.medium` (12pt) | `tag.fontSize.medium` (13pt) |
| `.large` | `tag.height.large` (28pt) | `tag.paddingHorizontal.large` (16pt) | `tag.fontSize.large` (14pt) |

## Token Reference

| Token | Purpose |
| --- | --- |
| `tag.height.{small,medium,large}` | Three heights |
| `tag.paddingHorizontal.{small,medium,large}` | Three horizontal paddings |
| `tag.fontSize.{small,medium,large}` | Three font sizes |
| `tag.borderRadius` / `tag.borderWidth` | Default radius (follows `radius.small`) and border width |
| `tag.gap` | Gap between the text and the close button (follows `spacing.xs`) |
| `color.{primary,success,warning,danger,info}.{default,bg}` | Semantic-type backgrounds and outlined light backgrounds |
| `color.onPrimary` | Semantic-type text color |
| `color.background.default` / `color.text.primary` / `color.border.base` | The three default-type colors |

## Golden Case Mapping

| case id | Assertion | Local test |
| --- | --- | --- |
| `default-type-renders-text` | The default type uses a neutral background / text and ignores plain | `testDefaultTypeUsesNeutralTokens` / `testDefaultTypeIgnoresPlain` |
| `primary-type-uses-primary-tokens` | The primary type consumes primary and onPrimary | `testPrimaryTypeUsesPrimaryTokens` |
| `plain-uses-bg-tokens` | plain consumes the semantic bg and the semantic border | `testPlainUsesBgTokens` |
| `small-size-uses-small-tokens` | The small size consumes the small size tokens | `testSmallSizeUsesSmallTokens` |
| `round-makes-radius-half-height` | The round radius == height / 2 | `testRoundMakesRadiusHalfHeight` |
| `closable-tap-emits-onclose` | The close button fires onClose | `testClosableTagInitAndRender` (gesture assertions need a simulator) |

Plus dedicated dark-mode tests: `testDarkColorsComeFromDarkTokens` / `testPlainInDarkUsesDarkBgTokens` /
`testDimensionsAreIdenticalInDarkMode`.

```bash
swift test --filter LhTagTests    # Runs on the macOS host, no simulator required
```

# Icon

A vector icon. A logical name maps to the platform's system symbol (SF Symbols on iOS); both its size and tone come from tokens.

> Spec source: `lh-ui-core/specs/icon.json` ·
> Golden cases: `lh-ui-core/cases/icon.json` (5 entries, translated into XCTest, runnable on the macOS host)

## Tone

`tone` decides the icon color. `default` follows the primary text color, `regular` / `secondary` take the corresponding text tiers, and the rest take semantic colors.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Icon tones</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-icon"><svg viewBox="0 0 24 24" fill="currentColor"><path d="M12 2l2.9 6.3 6.9.8-5.1 4.7 1.4 6.8L12 17.3 5.9 20.6l1.4-6.8L2.2 9.1l6.9-.8z"/></svg></span>
      <span class="sim-icon sim-icon--primary"><svg viewBox="0 0 24 24" fill="currentColor"><path d="M12 2l2.9 6.3 6.9.8-5.1 4.7 1.4 6.8L12 17.3 5.9 20.6l1.4-6.8L2.2 9.1l6.9-.8z"/></svg></span>
      <span class="sim-icon sim-icon--success"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M4 12.5l5 5L20 6.5"/></svg></span>
    </div>
    <div class="sim-row">
      <span class="sim-icon sim-icon--warning"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 3l10 18H2z"/><path d="M12 10v5"/></svg></span>
      <span class="sim-icon sim-icon--danger"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="9"/><path d="M12 8v5M12 16.5v.5"/></svg></span>
      <span class="sim-icon sim-icon--regular"><svg viewBox="0 0 24 24" fill="currentColor"><circle cx="12" cy="12" r="8"/></svg></span>
      <span class="sim-icon sim-icon--secondary"><svg viewBox="0 0 24 24" fill="currentColor"><circle cx="12" cy="12" r="8"/></svg></span>
    </div>
  </div>
</div>
<p class="sim-note">HTML mock preview (iOS / SwiftUI appearance), not an on-device render; on a device an SF Symbol vector is drawn</p>

```swift
LhIcon(name: "star", tone: .primary)
```

## Sizes

Three sizes map to the `icon.size` tokens.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Icon sizes</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-icon sim-icon--small sim-icon--primary"><svg viewBox="0 0 24 24" fill="currentColor"><path d="M12 2l2.9 6.3 6.9.8-5.1 4.7 1.4 6.8L12 17.3 5.9 20.6l1.4-6.8L2.2 9.1l6.9-.8z"/></svg></span>
      <span class="sim-icon sim-icon--primary"><svg viewBox="0 0 24 24" fill="currentColor"><path d="M12 2l2.9 6.3 6.9.8-5.1 4.7 1.4 6.8L12 17.3 5.9 20.6l1.4-6.8L2.2 9.1l6.9-.8z"/></svg></span>
      <span class="sim-icon sim-icon--large sim-icon--primary"><svg viewBox="0 0 24 24" fill="currentColor"><path d="M12 2l2.9 6.3 6.9.8-5.1 4.7 1.4 6.8L12 17.3 5.9 20.6l1.4-6.8L2.2 9.1l6.9-.8z"/></svg></span>
    </div>
  </div>
</div>
<p class="sim-note">HTML mock preview (iOS / SwiftUI appearance), not an on-device render</p>

## Name mapping

`name` is a logical name aligned with the web bloodline; on the end it is mapped to an SF Symbol by `LhIconMap.symbol(for:)`:

| Logical name | SF Symbol |
| --- | --- |
| `star` / `search` / `check` / `close` | `star` / `magnifyingglass` / `checkmark` / `xmark` |
| `arrow-up` / `arrow-down` / `arrow-left` / `arrow-right` | `arrow.up` / `arrow.down` / `arrow.left` / `arrow.right` |
| `refresh` / `plus` / `minus` / `eye` / `link` | `arrow.clockwise` / `plus` / `minus` / `eye` / `link` |

Unregistered names are not drawn (returns `nil`) and never crash.

```swift
LhIcon(name: "search", lhSize: .large, tone: .secondary) {
  // lhOnClick
}
```

## API

### Props

| Prop | Description | Type | Default |
| --- | --- | --- | --- |
| `name` | Logical icon name (mapped to an SF Symbol via `LhIconMap`) | `String` | — |
| `lhSize` | Icon size, mapped to the size tokens | `LhIconSize` | `.medium` |
| `tone` | Icon tone, mapped to the text / semantic color tokens | `LhIconTone` | `.default` |
| `lhOnClick` | Tap callback; when omitted, taps are not handled | `(() -> Void)?` | `nil` |

### LhIconSize

| Value | Size |
| --- | --- |
| `.small` | `icon.size.small` (16pt) |
| `.medium` | `icon.size.medium` (20pt) |
| `.large` | `icon.size.large` (24pt) |

### LhIconTone

| Value | Color |
| --- | --- |
| `.default` | `color.text.primary` |
| `.primary` | `color.primary.default` |
| `.success` | `color.success.default` |
| `.warning` | `color.warning.default` |
| `.danger` | `color.danger.default` |
| `.info` | `color.info.default` |
| `.regular` | `color.text.regular` |
| `.secondary` | `color.text.secondary` |

## Token Reference

| Token | Purpose |
| --- | --- |
| `icon.size.{small,medium,large}` | Three sizes |
| `color.text.{primary,regular,secondary}` | Text tones |
| `color.{primary,success,warning,danger,info}.default` | Semantic tones |

## Golden Case Mapping

| case id | Assertion | Local test |
| --- | --- | --- |
| `click-emits-onclick` | A tap fires `lhOnClick` exactly once | View layer `onTapGesture` (gesture assertions need a simulator, see #Preview) |
| `default-tone-uses-text-primary` | The default tone takes the primary text color | `testDefaultToneUsesTextPrimary` |
| `primary-tone-uses-primary-token` | The primary tone takes the primary token | `testPrimaryToneUsesPrimaryToken` |
| `small-size-uses-small-token` | The small size takes the small size token | `testSmallSizeUsesSmallToken` |
| `render-emits-icon-command` | Only a single icon draw command is emitted | `testRegisteredIconResolvesToSymbol` / `testUnknownIconReturnsNilSymbol` |

Plus dedicated dark-mode tests: `testDarkColorsComeFromDarkTokens` / `testDimensionsAreIdenticalInDarkMode`.

```bash
swift test --filter LhIconTests    # Runs on the macOS host, no simulator required
```

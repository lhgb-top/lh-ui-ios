# Button

A basic action button. It triggers an immediate action and supports types, sizes, loading, disabled, icons, and a Chinese-style pattern background.

> Spec source: `lh-ui-core/specs/button.json` ·
> Golden cases: `lh-ui-core/cases/button.json` (8 entries, translated into XCTest, runnable on the macOS host)

## Types

Six types determine the background and text colors.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Button types</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <button class="sim-btn">Default</button>
      <button class="sim-btn sim-btn--primary">Primary</button>
    </div>
    <div class="sim-row">
      <button class="sim-btn sim-btn--success">Success</button>
      <button class="sim-btn sim-btn--warning">Warning</button>
    </div>
    <div class="sim-row">
      <button class="sim-btn sim-btn--danger">Danger</button>
      <button class="sim-btn sim-btn--info">Info</button>
    </div>
  </div>
</div>
<p class="sim-note">HTML mock preview (iOS / SwiftUI appearance), not an on-device render</p>

```swift
LhButton(lhOnClick: {}, type: .primary, text: "Primary")
```

## Sizes

Three sizes map to the `button.height` / `paddingHorizontal` / `fontSize` / `iconSize` tokens.
The iOS shape uses a capsule corner radius (the `radius.round` token).

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Button sizes</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <button class="sim-btn sim-btn--small">Small</button>
      <button class="sim-btn">Medium</button>
      <button class="sim-btn sim-btn--large">Large</button>
    </div>
  </div>
</div>
<p class="sim-note">HTML mock preview (iOS / SwiftUI appearance), not an on-device render</p>

## States

Neither the disabled nor the loading state fires `lhOnClick`; when both are present, **disabled wins** (golden case `disabled-precedes-loading`).

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Button states</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <button class="sim-btn sim-btn--primary">Normal</button>
      <button class="sim-btn sim-btn--primary sim-btn--disabled">Disabled</button>
    </div>
    <div class="sim-row">
      <button class="sim-btn sim-btn--primary sim-btn--loading">
        <span class="sim-btn__spinner"></span>Loading
      </button>
      <button class="sim-btn sim-btn--primary sim-btn--disabled">Disabled wins</button>
    </div>
  </div>
</div>
<p class="sim-note">HTML mock preview (iOS / SwiftUI appearance), not an on-device render</p>

## Icon and pattern background

Icon names resolve against the local icon system (`LhButtonStyle.icon(for:)` maps to SF Symbols: search → magnifyingglass,
refresh → arrow.clockwise, check → checkmark, close → xmark; unregistered names are not drawn).
The pattern background consumes the `color.decoration` token and Canvas-draws 45° diagonal lines, layered under the background color and over the text without affecting contrast.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Icon & pattern</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <button class="sim-btn sim-btn--primary"><span class="sim-btn__icon"></span>Search</button>
      <button class="sim-btn"><span class="sim-btn__icon"></span>Default</button>
    </div>
    <div class="sim-row">
      <button class="sim-btn sim-btn--primary sim-btn--pattern">Primary pattern</button>
      <button class="sim-btn sim-btn--pattern">Default pattern</button>
    </div>
  </div>
</div>
<p class="sim-note">HTML mock preview (iOS / SwiftUI appearance), not an on-device render</p>

## Light and dark themes

Toggle the site theme in the top-right corner and the button colors inside the simulator phone frame change; on a device, switch with `LhTheme(isDark: true)`.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Dark buttons</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <button class="sim-btn sim-btn--primary">Primary</button>
      <button class="sim-btn">Default</button>
    </div>
    <div class="sim-row">
      <button class="sim-btn sim-btn--primary sim-btn--disabled">Disabled</button>
      <button class="sim-btn sim-btn--success">Success</button>
    </div>
  </div>
</div>
<p class="sim-note">HTML mock preview (iOS / SwiftUI appearance), not an on-device render; light/dark values are all taken from the core token snapshot</p>

## API

### Props

| Prop | Description | Type | Default |
| --- | --- | --- | --- |
| `lhOnClick` | Tap callback; not fired when `disabled` or `loading` is true | `() -> Void` | — |
| `type` | Button type, determines the background and text colors | `LhButtonType` | `.default` |
| `lhSize` | Button size, mapped to the size tokens | `LhButtonSize` | `.medium` |
| `disabled` | Whether disabled | `Bool` | `false` |
| `loading` | Whether loading (shows an indicator, does not fire lhOnClick) | `Bool` | `false` |
| `icon` | Icon name (resolved through the SF Symbol mapping) | `String?` | `nil` |
| `bgPattern` | Whether to draw the Chinese-style decorative pattern | `Bool` | `false` |
| `label` / `text` | Button text content (the spec's default slot) | `Text` / string | — |

### LhButtonType

| Value | Background | Text color |
| --- | --- | --- |
| `.default` | `color.background.default` | `color.text.primary` |
| `.primary` | `color.primary.default` | `color.onPrimary` |
| `.success` | `color.success.default` | `color.onPrimary` |
| `.warning` | `color.warning.default` | `color.onPrimary` |
| `.danger` | `color.danger.default` | `color.onPrimary` |
| `.info` | `color.info.default` | `color.onPrimary` |

### LhButtonSize

| Value | height | paddingHorizontal | fontSize | iconSize |
| --- | --- | --- | --- | --- |
| `.small` | `button.height.small` (32pt) | `button.paddingHorizontal.small` (16pt) | `button.fontSize.small` (13pt) | `button.iconSize.small` (16pt) |
| `.medium` | `button.height.medium` (40pt) | `button.paddingHorizontal.medium` (20pt) | `button.fontSize.medium` (14pt) | `button.iconSize.medium` (18pt) |
| `.large` | `button.height.large` (48pt) | `button.paddingHorizontal.large` (24pt) | `button.fontSize.large` (16pt) | `button.iconSize.large` (20pt) |

Disabled-state overrides: background `color.disabled.bg`, text `color.disabled.text`, border `color.disabled.border`.

## Token Reference

Tokens consumed by the button (aligned entry by entry with `tokenRefs` in `specs/button.json`):

| Token | Purpose |
| --- | --- |
| `button.height.{small,medium,large}` | Three heights |
| `button.paddingHorizontal.{small,medium,large}` | Three horizontal paddings |
| `button.fontSize.{small,medium,large}` | Three font sizes |
| `button.iconSize.{small,medium,large}` | Three icon sizes |
| `button.borderRadius` / `button.borderWidth` | Corner radius (follows `radius.base`) and border width |
| `button.fontWeight` | Font weight (follows `typography.fontWeight.primary`, mapped to Font.Weight on the end) |
| `color.primary.default` / `color.onPrimary` | Primary-type background / text |
| `color.{success,warning,danger,info}.default` | Semantic-type backgrounds |
| `color.background.default` / `color.text.primary` / `color.border.base` | Default-type background / text / border |
| `color.disabled.{bg,text,border}` | Three disabled colors |
| `color.decoration` | Pattern color |
| `shadow.lighter` | Default elevation (LhShadow carrier) |
| `spacing.xs` | Gap between icon and text |

## Golden Case Mapping

How the 8 assertions in `cases/button.json` map to XCTest:

| case id | Assertion | Local test |
| --- | --- | --- |
| `click-emits-onclick` | The gate passes it through (interactive) | `LhButtonTests.testEnabledButtonIsInteractive` |
| `disabled-blocks-click` | The disabled state is not interactive | `testDisabledIsNotInteractive` |
| `loading-blocks-click` | The loading state is not interactive | `testLoadingIsNotInteractive` |
| `disabled-precedes-loading` | Disabled wins, with the disabled style | `testDisabledPrecedesLoading` |
| `default-type-renders-text` | The default type uses a neutral background / text | `testDefaultTypeUsesNeutralTokens` |
| `primary-type-uses-primary-tokens` | The primary type consumes the primary tokens | `testPrimaryTypeUsesPrimaryTokens` |
| `small-size-uses-small-tokens` | The small size consumes the small size tokens | `testSmallSizeUsesSmallTokens` |
| `bgpattern-uses-decoration-token` | The pattern background consumes the decoration color | `testBgPatternUsesDecorationToken` |

Plus dedicated dark-mode tests: `testDarkColorsComeFromDarkTokens` / `testDisabledInDarkUsesDarkDisabledTokens` /
`testDimensionsAreIdenticalInDarkMode`.

```bash
swift test    # Runs on the macOS host, no simulator required
```

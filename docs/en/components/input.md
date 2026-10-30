# Input

A controlled single-line input. `@Binding var value` provides two-way binding; it supports plain and secure text, a clear button, a character limit, and a focus ring.

> Spec source: `lh-ui-core/specs/input.json` ·
> Golden cases: `lh-ui-core/cases/input.json` (8 entries, translated into XCTest, runnable on the macOS host)

## Basic usage

The height aligns with Button (three `input.height` tokens); on focus the border switches to `color.focus` and widens into a focus ring.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Input basic</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-input"><input class="sim-input__field" placeholder="Please enter content" /></span>
    </div>
    <div class="sim-row">
      <span class="sim-input sim-input--focus"><input class="sim-input__field" value="青花瓷 (ceramic blue)" /></span>
    </div>
  </div>
</div>
<p class="sim-note">HTML mock preview (iOS / SwiftUI appearance), not an on-device render</p>

```swift
@State private var text = ""

LhInput(value: $text, placeholder: "Please enter content") { newValue in
  // onValueChange
}
```

## Sizes

Three sizes map to the `input.height` / `paddingHorizontal` / `fontSize` tokens.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Input sizes</span></div>
  <div class="sim-screen">
    <div class="sim-row"><span class="sim-input sim-input--small"><input class="sim-input__field" placeholder="Small" /></span></div>
    <div class="sim-row"><span class="sim-input"><input class="sim-input__field" placeholder="Medium" /></span></div>
    <div class="sim-row"><span class="sim-input sim-input--large"><input class="sim-input__field" placeholder="Large" /></span></div>
  </div>
</div>
<p class="sim-note">HTML mock preview (iOS / SwiftUI appearance), not an on-device render</p>

## Password and clear

`type: .password` lands as a `SecureField` (tested by `testPasswordTypeIsSecure`);
`clearable` shows a clear button when there is a value, whose tap fires `onValueChange("")` (golden case `clearable-emits-empty-value`).

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Input extras</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-input"><input class="sim-input__field" type="password" value="secret" /><svg class="sim-input__clear" viewBox="0 0 24 24" fill="currentColor"><path d="M12 2a10 10 0 100 20 10 10 0 000-20zm1 15h-2v-2h2zm0-4h-2V7h2z"/></svg></span>
    </div>
    <div class="sim-row">
      <span class="sim-input sim-input--disabled"><input class="sim-input__field" value="Disabled" disabled /></span>
    </div>
  </div>
</div>
<p class="sim-note">HTML mock preview (iOS / SwiftUI appearance), not an on-device render</p>

```swift
LhInput(value: $pwd, type: .password, clearable: true)
```

## API

### Props

| Prop | Description | Type | Default |
| --- | --- | --- | --- |
| `value` | Input content (controlled two-way binding) | `String` | — |
| `placeholder` | Placeholder hint text | `String` | `""` |
| `type` | Input type (plain text / secure text) | `LhInputType` | `.text` |
| `lhSize` | Input size, mapped to the size tokens | `LhInputSize` | `.medium` |
| `disabled` | Whether disabled (fires no callbacks) | `Bool` | `false` |
| `readonly` | Whether read-only (does not fire onValueChange, keeps the focus style) | `Bool` | `false` |
| `clearable` | Whether to show a clear button | `Bool` | `false` |
| `maxlength` | Maximum character count (excess is truncated; golden case `maxlength-truncates-input`) | `Int?` | `nil` |
| `onValueChange` | Content-change callback; the payload is the new value | `((String) -> Void)?` | `nil` |
| `lhOnFocus` | Focus callback | `(() -> Void)?` | `nil` |
| `lhOnBlur` | Blur callback | `(() -> Void)?` | `nil` |

### LhInputSize

| Value | height | paddingHorizontal | fontSize |
| --- | --- | --- | --- |
| `.small` | `input.height.small` (32pt) | `input.paddingHorizontal.small` (12pt) | `input.fontSize.small` (13pt) |
| `.medium` | `input.height.medium` (40pt) | `input.paddingHorizontal.medium` (16pt) | `input.fontSize.medium` (14pt) |
| `.large` | `input.height.large` (48pt) | `input.paddingHorizontal.large` (20pt) | `input.fontSize.large` (16pt) |

### LhInputType

| Value | Lands as |
| --- | --- |
| `.text` | `TextField` |
| `.password` | `SecureField` |

### Colors

| State | Border | Text / placeholder |
| --- | --- | --- |
| Default | `color.border.base` (`input.borderWidth`) | `color.text.primary` / `color.text.placeholder` |
| Focused | `color.focus` (`input.focusRingWidth`) | Same as above |
| Disabled | `color.disabled.border` | `color.disabled.text` |

## Token Reference

| Token | Purpose |
| --- | --- |
| `input.height.{small,medium,large}` | Three heights |
| `input.paddingHorizontal.{small,medium,large}` | Three horizontal paddings |
| `input.fontSize.{small,medium,large}` | Three font sizes |
| `input.borderRadius` / `input.borderWidth` | Corner radius (follows `radius.small`) and border width |
| `input.focusRingWidth` | Focus ring width |
| `input.clearIconSize` | Clear button icon size |
| `color.focus` | Focus border color |
| `color.text.{primary,placeholder,disabled}` | Text and placeholder colors |
| `color.border.base` / `color.disabled.border` | Border colors |
| `color.background.default` / `color.disabled.bg` | Background colors |

## Golden Case Mapping

| case id | Assertion | Local test |
| --- | --- | --- |
| `input-emits-onvaluechange` | Typing fires `onValueChange("青花瓷 (ceramic blue)")` | `testDefaultIsEditable` |
| `clearable-emits-empty-value` | Clearing fires `onValueChange("")` | `testClearableShowsClearButtonWhenHasValue` |
| `disabled-blocks-input` | The disabled state does not fire onValueChange | `testDisabledBlocksInput` |
| `readonly-blocks-input` | The read-only state does not fire onValueChange | `testReadonlyBlocksInput` |
| `placeholder-uses-placeholder-token` | The placeholder text takes the placeholder color token | `testPlaceholderUsesPlaceholderToken` |
| `focus-uses-focus-token` | Focus consumes the focus token and fires lhOnFocus | `testFocusUsesFocusToken` |
| `small-size-uses-small-tokens` | The small size consumes the small size tokens | `testSmallSizeUsesSmallTokens` |
| `maxlength-truncates-input` | Excess characters are truncated | `testMaxlengthTruncatesInput` |

Plus dedicated tests: `testPasswordTypeIsSecure` / `testDarkColorsComeFromDarkTokens` /
`testDimensionsAreIdenticalInDarkMode` / `testInputViewInitAcceptsConstant`.

```bash
swift test --filter LhInputTests    # Runs on the macOS host, no simulator required
```

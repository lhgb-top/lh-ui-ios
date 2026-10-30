# Textarea

A controlled multi-line input. `@Binding var value` provides two-way binding, plus a placeholder hint and a character counter.

> Spec source: `lh-ui-core/specs/textarea.json` ·
> Golden cases: `lh-ui-core/cases/textarea.json` (6 entries, translated into XCTest, runnable on the macOS host)

## Basic usage

The minimum height comes from `textarea.minHeight`, the padding from `textarea.paddingHorizontal` / `paddingVertical`,
and on focus the border switches to `color.focus`.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Textarea basic</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-textarea"><textarea class="sim-textarea__field" placeholder="Please enter content"></textarea></span>
    </div>
    <div class="sim-row">
      <span class="sim-textarea sim-textarea--focus"><textarea class="sim-textarea__field">青花瓷 (ceramic blue)</textarea></span>
    </div>
  </div>
</div>
<p class="sim-note">HTML mock preview (iOS / SwiftUI appearance), not an on-device render</p>

```swift
@State private var text = ""

LhTextarea(value: $text, placeholder: "Please enter content") { newValue in
  // onValueChange
}
```

## Character counter

When `showCount = true`, a counter is shown in the bottom-right corner: if `maxlength` is set it shows `current/limit` (golden case
`showcount-renders-count`); without it, only the current length is shown (`showcount-without-maxlength-renders-length-only`).

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Textarea counter</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-textarea">
        <textarea class="sim-textarea__field">青花瓷 (ceramic blue)</textarea>
        <span class="sim-textarea__count">3/10</span>
      </span>
    </div>
    <div class="sim-row">
      <span class="sim-textarea sim-textarea--disabled">
        <textarea class="sim-textarea__field" disabled>Disabled</textarea>
      </span>
    </div>
  </div>
</div>
<p class="sim-note">HTML mock preview (iOS / SwiftUI appearance), not an on-device render</p>

```swift
LhTextarea(value: $text, showCount: true, maxlength: 10)
```

## API

### Props

| Prop | Description | Type | Default |
| --- | --- | --- | --- |
| `value` | Input content (controlled two-way binding) | `String` | — |
| `placeholder` | Placeholder hint text | `String` | `""` |
| `rows` | Expected number of rows (affects the minimum height) | `Int` | `3` |
| `disabled` | Whether disabled (fires no callbacks) | `Bool` | `false` |
| `readonly` | Whether read-only (does not fire onValueChange, keeps the focus style) | `Bool` | `false` |
| `showCount` | Whether to show the character counter | `Bool` | `false` |
| `maxlength` | Maximum character count (excess is truncated) | `Int?` | `nil` |
| `onValueChange` | Content-change callback; the payload is the new value | `((String) -> Void)?` | `nil` |
| `lhOnFocus` | Focus callback | `(() -> Void)?` | `nil` |
| `lhOnBlur` | Blur callback | `(() -> Void)?` | `nil` |

### Colors

| State | Border | Text / placeholder |
| --- | --- | --- |
| Default | `color.border.base` (`textarea.borderWidth`) | `color.text.primary` / `color.text.placeholder` |
| Focused | `color.focus` (`textarea.focusRingWidth`) | Same as above |
| Disabled | `color.disabled.border` | `color.disabled.text` |

## Token Reference

| Token | Purpose |
| --- | --- |
| `textarea.minHeight` | Minimum height |
| `textarea.paddingHorizontal` / `textarea.paddingVertical` | Padding |
| `textarea.fontSize` | Font size |
| `textarea.countFontSize` | Counter text font size |
| `textarea.borderRadius` / `textarea.borderWidth` | Corner radius and border width |
| `textarea.focusRingWidth` | Focus ring width |
| `color.focus` | Focus border color |
| `color.text.{primary,placeholder,disabled}` | Text and placeholder colors |
| `color.border.base` / `color.disabled.border` | Border colors |
| `color.background.default` / `color.disabled.bg` | Background colors |

## Golden Case Mapping

| case id | Assertion | Local test |
| --- | --- | --- |
| `input-emits-onvaluechange` | Typing fires `onValueChange("青花瓷 (ceramic blue)")` | `testDefaultIsEditable` |
| `disabled-blocks-input` | The disabled state does not fire onValueChange | `testDisabledBlocksInput` |
| `showcount-renders-count` | The counter shows `3/10` and consumes the counter font-size token | `testShowCountRendersCount` |
| `showcount-without-maxlength-renders-length-only` | Without a limit, only `3` is shown | `testShowCountWithoutMaxlengthRendersLengthOnly` |
| `focus-uses-focus-token` | Focus consumes the focus token and fires lhOnFocus | `testFocusUsesFocusToken` |
| `maxlength-truncates-input` | Excess characters are truncated | `testMaxlengthTruncatesInput` |

Plus dedicated tests: `testLayoutUsesTextareaTokens` / `testReadonlyBlocksInputButKeepsFocusStyle` /
`testDarkColorsComeFromDarkTokens` / `testDimensionsAreIdenticalInDarkMode` /
`testTextareaViewInitAcceptsConstant`.

```bash
swift test --filter LhTextareaTests    # Runs on the macOS host, no simulator required
```

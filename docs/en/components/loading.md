# Loading

A loading indicator. On the SwiftUI end it is a self-drawn ring (`Circle().trim` + a rotation animation); the duration comes from `motion.duration.base` (seconds).

> Spec source: `lh-ui-core/specs/loading.json` ·
> Golden cases: `lh-ui-core/cases/loading.json` (5 entries, translated into XCTest, runnable on the macOS host)

## Tone

Five tones take the semantic color tokens; the default is `.primary`.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Loading tones</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-loading"></span>
      <span class="sim-loading sim-loading--success"></span>
      <span class="sim-loading sim-loading--warning"></span>
    </div>
    <div class="sim-row">
      <span class="sim-loading sim-loading--danger"></span>
      <span class="sim-loading sim-loading--info"></span>
    </div>
  </div>
</div>
<p class="sim-note">HTML mock preview (iOS / SwiftUI appearance), not an on-device render</p>

```swift
LhLoading(tone: .success)
```

## Sizes

Three sizes map to the `loading.size` tokens; the stroke width comes from `loading.strokeWidth`.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Loading sizes</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-loading sim-loading--small"></span>
      <span class="sim-loading"></span>
      <span class="sim-loading sim-loading--large"></span>
    </div>
  </div>
</div>
<p class="sim-note">HTML mock preview (iOS / SwiftUI appearance), not an on-device render</p>

## Static frame

`animating: false` freezes the rotation (the golden case `render-emits-ring-command` asserts the draw parameters of the static ring),
which is useful for screenshot tests and static documentation frames.

```swift
LhLoading(lhSize: .large, animating: false)
```

## API

### Props

| Prop | Description | Type | Default |
| --- | --- | --- | --- |
| `lhSize` | Ring size, mapped to the size tokens | `LhLoadingSize` | `.medium` |
| `tone` | Ring tone, mapped to the semantic color tokens | `LhLoadingTone` | `.primary` |
| `animating` | Whether to rotate (`false` freezes it into a static frame) | `Bool` | `true` |

### LhLoadingSize

| Value | Size |
| --- | --- |
| `.small` | `loading.size.small` (16pt) |
| `.medium` | `loading.size.medium` (20pt) |
| `.large` | `loading.size.large` (24pt) |

### LhLoadingTone

| Value | Color |
| --- | --- |
| `.primary` | `color.primary.default` |
| `.success` | `color.success.default` |
| `.warning` | `color.warning.default` |
| `.danger` | `color.danger.default` |
| `.info` | `color.info.default` |

## Token Reference

| Token | Purpose |
| --- | --- |
| `loading.size.{small,medium,large}` | Three sizes |
| `loading.strokeWidth` | Ring stroke width |
| `color.{primary,success,warning,danger,info}.default` | Five tones |
| `motion.duration.base` | Duration of one rotation (seconds on the iOS end) |

## Golden Case Mapping

| case id | Assertion | Local test |
| --- | --- | --- |
| `medium-size-uses-medium-token` | The medium size takes the medium size token | `testMediumSizeUsesMediumToken` |
| `large-size-uses-large-token` | The large size takes the large size token | `testLargeSizeUsesLargeToken` |
| `primary-tone-uses-primary-token` | The primary tone takes the primary token | `testPrimaryToneUsesPrimaryToken` |
| `success-tone-uses-success-token` | The success tone takes the success token | `testSuccessToneUsesSuccessToken` |
| `render-emits-ring-command` | The ring stroke consumes the strokeWidth token | `testRingUsesStrokeWidthToken` |

Plus dedicated dark-mode tests: `testDarkColorsComeFromDarkTokens` / `testDimensionsAreIdenticalInDarkMode` /
`testLoadingViewInitAndRender`.

```bash
swift test --filter LhLoadingTests    # Runs on the macOS host, no simulator required
```

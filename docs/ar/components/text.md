# نص (Text)

أصل عرض النص: يستهلك رموز التنسيق العامة مع مستويات الحجم والسماكة والدرجة والمحاذاة.

> المصدر التعاقدي: `lh-ui-core/specs/text.json` · الحالات الذهبية: `lh-ui-core/cases/text.json` (5، تُرجمت إلى XCTest، قابلة للتشغيل على مضيف macOS)

## مستويات الحجم

`level` يُ mapa إلى رمز `typography.fontSize.<level>` والافتراضي `base`.

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
<p class="sim-note">معاينة محاكي HTML (مظهر iOS / SwiftUI)، وليست رسمًا حقيقيًا على الجهاز</p>

```swift
LhText("Title text", level: .large)
```

## السماكة

`weight` يُ mapa إلى رمز `typography.fontWeight.<weight>` (primary 400 / bold 600).

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Text</span></div>
  <div class="sim-screen">
    <p class="sim-text">primary</p>
    <p class="sim-text sim-text--bold">bold</p>
  </div>
</div>
<p class="sim-note">معاينة محاكي HTML (مظهر iOS / SwiftUI)، وليست رسمًا حقيقيًا على الجهاز</p>

## الدرجة

`tone` يُ mapa إلى رمز `color.text.<tone>`؛ و`selected` يأخذ `color.selected`.

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
<p class="sim-note">معاينة محاكي HTML (مظهر iOS / SwiftUI)، وليست رسمًا حقيقيًا على الجهاز</p>

## المحاذاة وارتفاع السطر

`lhAlign` يحاذي داخل صندوق السطر؛ ويأخذ ارتفاع السطر دائمًا `typography.lineHeight.primary` (الحجم × 1.8).

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Text</span></div>
  <div class="sim-screen">
    <p class="sim-text sim-text--align-center">center</p>
    <p class="sim-text sim-text--align-end">end</p>
  </div>
</div>
<p class="sim-note">معاينة محاكي HTML (مظهر iOS / SwiftUI)، وليست رسمًا حقيقيًا على الجهاز</p>

```swift
LhText("Centered", lhAlign: .center)
```

## API

| الخاصية | الوصف | النوع | الافتراضي |
| --- | --- | --- | --- |
| `content` | محتوى النص (الوسيط الأول للمُهيئ، فتحة default في المواصفة) | `String` | `""` |
| `level` | مستويات الحجم | `LhTextLevel` | `.base` |
| `weight` | السماكة | `LhTextWeight` | `.primary` |
| `tone` | الدرجة | `LhTextTone` | `.primary` |
| `lhAlign` | المحاذاة وارتفاع السطر | `LhTextAlign` | `.start` |

### LhTextLevel

| الخاصية | fontSize token |
| --- | --- |
| `.extraLarge` | `typography.fontSize.extraLarge` (20pt) |
| `.large` | `typography.fontSize.large` (18pt) |
| `.medium` | `typography.fontSize.medium` (16pt) |
| `.base` | `typography.fontSize.base` (14pt, default) |
| `.small` | `typography.fontSize.small` (13pt) |
| `.extraSmall` | `typography.fontSize.extraSmall` (12pt) |

### LhTextTone

| الخاصية | text color token |
| --- | --- |
| `.primary` | `color.text.primary` |
| `.regular` | `color.text.regular` |
| `.secondary` | `color.text.secondary` |
| `.placeholder` | `color.text.placeholder` |
| `.disabled` | `color.text.disabled` |
| `.selected` | `color.selected` |

## مرجع الرموز

| Token | Usage |
| --- | --- |
| `typography.fontSize.<level>` | six size levels |
| `typography.fontWeight.{primary,bold}` | two weights |
| `typography.lineHeight.primary` | line height (font size × 1.8) |
| `color.text.<tone>` / `color.selected` | text tones |

## مرجع الحالات الذهبية

| case id | التأكيد | الاختبار المحلي |
| --- | --- | --- |
| `default-level-uses-base-tokens` | default level consumes the base typography tokens | `LhTextTests.testDefaultLevelUsesBaseTokens` |
| `large-level-uses-large-token` | large level consumes the large size token | `LhTextTests.testLargeLevelUsesLargeToken` |
| `bold-weight-uses-bold-token` | bold consumes the bold weight token | `LhTextTests.testBoldWeightUsesBoldToken` |
| `secondary-tone-uses-text-secondary` | secondary tone takes the secondary text color token | `LhTextTests.testSecondaryToneUsesTextSecondary` |
| `render-emits-single-text-command` | render emits a single TEXT command | `LhTextTests.testAllLevelsUseTheirTokens` |

```bash
swift test --filter LhTextTests
```

# مفتاح Switch

مفتاح مُتحكَّم فيه. ربط ثنائي الاتجاه عبر `@Binding var checked`، والمسار بنسبة 2:1، وقطر المقبض = الارتفاع − 2 × `switch.gap`.

> مصدر العقد: `lh-ui-core/specs/switch.json` ·
> الحالات الذهبية: `lh-ui-core/cases/switch.json` (6 حالات، مُترجمة إلى XCTest، قابلة للتشغيل على مضيف macOS)

## الحالات

عند التشغيل يكون المسار باللون الرئيسي ويتحرك المقبض إلى الجانب الآخر؛ وعند الإيقاف يكون المسار بلون الحد. وتعرض حالة `loading` مؤشرًا صغيرًا داخل المسار ولا تستجيب للتبديل.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>حالات Switch</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-switch"><span class="sim-switch__thumb"></span></span>
      <span class="sim-switch sim-switch--on"><span class="sim-switch__thumb"></span></span>
    </div>
    <div class="sim-row">
      <span class="sim-switch sim-switch--on sim-switch--disabled"><span class="sim-switch__thumb"></span></span>
      <span class="sim-switch sim-switch--disabled"><span class="sim-switch__thumb"></span></span>
    </div>
  </div>
</div>
<p class="sim-note">معاينة محاكاة HTML (مظهر iOS / SwiftUI)، ليست تصييرًا على جهاز حقيقي</p>

```swift
@State private var on = true

LhSwitch(checked: $on) { newValue in
  // onChange
}
```

## الحجم

ثلاثة أحجام تُربط بالرموز `switch.width` / `switch.height`، وتتكيّف زاوية الانحناء تلقائيًا مع الارتفاع لتصبح نصف قطر المسار.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>أحجام Switch</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-switch sim-switch--small sim-switch--on"><span class="sim-switch__thumb"></span></span>
      <span class="sim-switch sim-switch--on"><span class="sim-switch__thumb"></span></span>
      <span class="sim-switch sim-switch--large sim-switch--on"><span class="sim-switch__thumb"></span></span>
    </div>
  </div>
</div>
<p class="sim-note">معاينة محاكاة HTML (مظهر iOS / SwiftUI)، ليست تصييرًا على جهاز حقيقي</p>

## حالة التحميل

عند `loading = true` يُدمج `LhLoading(lhSize: .small, tone: .primary)` داخل المسار، ويعترض النقرَ بوابةٌ
(حالة ذهبية `loading-blocks-change`).

```swift
LhSwitch(checked: $submitting, loading: submitting) { _ in }
```

## API

### Props

| Prop | الوصف | النوع | الافتراضي |
| --- | --- | --- | --- |
| `checked` | حالة المفتاح (ربط ثنائي الاتجاه مُتحكَّم فيه) | `Bool` | — |
| `disabled` | معطّل أم لا (لا يُطلق onChange) | `Bool` | `false` |
| `loading` | في حالة التحميل أم لا (مؤشر مدمج، لا يُطلق onChange) | `Bool` | `false` |
| `lhSize` | حجم المفتاح، مرتبط برموز الأحجام | `LhSwitchSize` | `.medium` |
| `onChange` | رد تغيير الحالة، يستقبل القيمة الجديدة | `((Bool) -> Void)?` | `nil` |

### LhSwitchSize

| القيمة | width | height | قطر المقبض |
| --- | --- | --- | --- |
| `.small` | `switch.width.small` (36pt) | `switch.height.small` (20pt) | height − 2 × `switch.gap` (16pt) |
| `.medium` | `switch.width.medium` (44pt) | `switch.height.medium` (24pt) | height − 2 × `switch.gap` (20pt) |
| `.large` | `switch.width.large` (52pt) | `switch.height.large` (28pt) | height − 2 × `switch.gap` (24pt) |

### الألوان

| الحالة | المسار | المقبض |
| --- | --- | --- |
| إيقاف | `color.border.base` | `color.onPrimary` |
| تشغيل | `color.primary.default` | `color.onPrimary` |
| معطّل | `color.disabled.bg` | `color.disabled.text` |

## مرجع الرموز

| الرمز | الغرض |
| --- | --- |
| `switch.width.{small,medium,large}` | ثلاثة عروض للمسار |
| `switch.height.{small,medium,large}` | ثلاثة ارتفاعات للمسار |
| `switch.gap` | الفراغ الداخلي بين المقبض والمسار (يحدد قطر المقبض) |
| `color.primary.default` | لون المسار عند التشغيل |
| `color.border.base` | لون المسار عند الإيقاف |
| `color.onPrimary` | لون المقبض |
| `color.disabled.{bg,text}` | لونا التعطيل |
| `motion.duration.base` | مدة حركة انزلاق المقبض (بالثواني على طرف iOS) |

## مرجع الحالات الذهبية

| case id | التأكيد | الاختبار المحلي |
| --- | --- | --- |
| `tap-toggles-and-emits-onchange` | النقر يُشغّل المفتاح ويُطلق `onChange(true)` | `testDefaultIsInteractive` |
| `tap-checked-turns-off` | النقر على المُشغَّل يجعله مُيقَفًا | `testCheckedUsesPrimaryTrack` |
| `disabled-blocks-change` | الحالة المعطّلة لا تُطلق onChange | `testDisabledBlocksChange` |
| `loading-blocks-change` | حالة التحميل لا تُطلق onChange | `testLoadingBlocksChange` |
| `checked-uses-primary-token` | التشغيل يستهلك رمز اللون الرئيسي ولا يستهلك رمز الحد | `testCheckedUsesPrimaryToken` |
| `unchecked-uses-border-token` | الإيقاف يستهلك رمز الحد | `testUncheckedUsesBorderToken` |

بالإضافة إلى اختبارات مخصّصة: `testSizeUsesSwitchTokens` / `testThumbDiameterIsHeightMinusTwoGaps` /
`testDarkColorsComeFromDarkTokens` / `testDimensionsAreIdenticalInDarkMode` /
`testSwitchViewInitAcceptsConstant`.

```bash
swift test --filter LhSwitchTests    # يعمل على مضيف macOS، دون الحاجة إلى محاكي
```

# تحميل Loading

مؤشر التحميل. على طرف SwiftUI حلقة مرسومة يدويًا (`Circle().trim` + حركة الدوران)، وتُؤخذ المدة من `motion.duration.base` (بالثواني).

> مصدر العقد: `lh-ui-core/specs/loading.json` ·
> الحالات الذهبية: `lh-ui-core/cases/loading.json` (5 حالات، مُترجمة إلى XCTest، قابلة للتشغيل على مضيف macOS)

## اللون

خمسة ألوان تأخذ رموز الألوان الدلالية، والافتراضي هو `.primary`.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>ألوان Loading</span></div>
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
<p class="sim-note">معاينة محاكاة HTML (مظهر iOS / SwiftUI)، ليست تصييرًا على جهاز حقيقي</p>

```swift
LhLoading(tone: .success)
```

## الحجم

ثلاثة أحجام تُربط بالرمز `loading.size`، ويُؤخذ عرض الحلقة من `loading.strokeWidth`.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>أحجام Loading</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-loading sim-loading--small"></span>
      <span class="sim-loading"></span>
      <span class="sim-loading sim-loading--large"></span>
    </div>
  </div>
</div>
<p class="sim-note">معاينة محاكاة HTML (مظهر iOS / SwiftUI)، ليست تصييرًا على جهاز حقيقي</p>

## الإطار الثابت

 يجمّد `animating: false` حركة الدوران (تؤكد الحالة الذهبية `render-emits-ring-command` معاملات رسم الحلقة الثابتة)،
ويُستخدم في اختبارات لقطات الشاشة والإطارات الثابتة في التوثيق.

```swift
LhLoading(lhSize: .large, animating: false)
```

## API

### Props

| Prop | الوصف | النوع | الافتراضي |
| --- | --- | --- | --- |
| `lhSize` | حجم الحلقة، مرتبط برموز الأحجام | `LhLoadingSize` | `.medium` |
| `tone` | لون الحلقة، مرتبط برموز الألوان الدلالية | `LhLoadingTone` | `.primary` |
| `animating` | يدور أم لا (`false` يجمّده كإطار ثابت) | `Bool` | `true` |

### LhLoadingSize

| القيمة | الحجم |
| --- | --- |
| `.small` | `loading.size.small` (16pt) |
| `.medium` | `loading.size.medium` (20pt) |
| `.large` | `loading.size.large` (24pt) |

### LhLoadingTone

| القيمة | اللون |
| --- | --- |
| `.primary` | `color.primary.default` |
| `.success` | `color.success.default` |
| `.warning` | `color.warning.default` |
| `.danger` | `color.danger.default` |
| `.info` | `color.info.default` |

## مرجع الرموز

| الرمز | الغرض |
| --- | --- |
| `loading.size.{small,medium,large}` | ثلاثة أحجام |
| `loading.strokeWidth` | عرض حد الحلقة |
| `color.{primary,success,warning,danger,info}.default` | خمسة ألوان |
| `motion.duration.base` | مدة حركة دورة واحدة (بالثواني على طرف iOS) |

## مرجع الحالات الذهبية

| case id | التأكيد | الاختبار المحلي |
| --- | --- | --- |
| `medium-size-uses-medium-token` | الحجم المتوسط يأخذ رمز الحجم medium | `testMediumSizeUsesMediumToken` |
| `large-size-uses-large-token` | الحجم الكبير يأخذ رمز الحجم large | `testLargeSizeUsesLargeToken` |
| `primary-tone-uses-primary-token` | اللون الرئيسي يأخذ رمز اللون الرئيسي | `testPrimaryToneUsesPrimaryToken` |
| `success-tone-uses-success-token` | لون النجاح يأخذ رمز لون النجاح | `testSuccessToneUsesSuccessToken` |
| `render-emits-ring-command` | حد الحلقة يستهلك الرمز strokeWidth | `testRingUsesStrokeWidthToken` |

بالإضافة إلى اختبارات مخصّصة للوضع الداكن: `testDarkColorsComeFromDarkTokens` / `testDimensionsAreIdenticalInDarkMode` /
`testLoadingViewInitAndRender`.

```bash
swift test --filter LhLoadingTests    # يعمل على مضيف macOS، دون الحاجة إلى محاكي
```

# خلية Cell

خلية قائمة. على الجانب أيقونة + عنوان (يتضمن نجمة الحقل الإلزامي والعنوان الفرعي)، وعلى الجانب الآخر قيمة وسهم، مع خط فصل سفلي.

> مصدر العقد: `lh-ui-core/specs/cell.json` ·
> الحالات الذهبية: `lh-ui-core/cases/cell.json` (6 حالات، مُترجمة إلى XCTest، قابلة للتشغيل على مضيف macOS)

## الشكل الأساسي

`title` إلزامي، و`value` / `label` / `icon` اختيارية. ويتحكم `bordered` في خط الفصل السفلي (مفعّل افتراضيًا).

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Cell الأساسية</span></div>
  <div class="sim-screen" style="padding: 0;">
    <div class="sim-cell">
      <div class="sim-cell__main"><div class="sim-cell__title">نص العنوان</div></div>
      <div class="sim-cell__value">القيمة الجانبية</div>
      <div class="sim-cell__arrow">›</div>
    </div>
    <div class="sim-cell">
      <div class="sim-cell__main">
        <div class="sim-cell__title">مع عنوان فرعي</div>
        <div class="sim-cell__label">هذا نص توضيحي للعنوان الفرعي</div>
      </div>
      <div class="sim-cell__arrow">›</div>
    </div>
    <div class="sim-cell">
      <div class="sim-cell__main"><div class="sim-cell__title">بلا خط فصل</div></div>
      <div class="sim-cell__value">قيمة</div>
    </div>
  </div>
</div>
<p class="sim-note">معاينة محاكاة HTML (مظهر iOS / SwiftUI)، ليست تصييرًا على جهاز حقيقي</p>

```swift
LhCell(title: "نص العنوان", value: "القيمة الجانبية", clickable: true) {
  // lhOnClick
}
```

## الأيقونة / الحقل الإلزامي / غير قابل للنقر

يُربط `icon` عبر `LhIconMap`؛ ويعرض `required` نجمة حمراء قبل العنوان؛
وعند `clickable = false` (افتراضي) لا تستجيب الخلية للنقر (حالة ذهبية `not-clickable-no-onclick`).

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Cell موسّعة</span></div>
  <div class="sim-screen" style="padding: 0;">
    <div class="sim-cell">
      <span class="sim-cell__icon"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" style="width:100%;height:100%"><circle cx="11" cy="11" r="7"/><path d="M21 21l-4.3-4.3"/></svg></span>
      <div class="sim-cell__main"><div class="sim-cell__title">أيقونة جانبية</div></div>
      <div class="sim-cell__arrow">›</div>
    </div>
    <div class="sim-cell">
      <div class="sim-cell__main"><div class="sim-cell__title"><span class="sim-cell__required">*</span>حقل إلزامي</div></div>
      <div class="sim-cell__value">يرجى الاختيار</div>
      <div class="sim-cell__arrow">›</div>
    </div>
  </div>
</div>
<p class="sim-note">معاينة محاكاة HTML (مظهر iOS / SwiftUI)، ليست تصييرًا على جهاز حقيقي</p>

## API

### Props

| Prop | الوصف | النوع | الافتراضي |
| --- | --- | --- | --- |
| `title` | العنوان (إلزامي) | `String` | — |
| `value` | القيمة الجانبية | `String` | `""` |
| `label` | العنوان الفرعي تحت العنوان | `String` | `""` |
| `icon` | الاسم المنطقي للأيقونة الجانبية (ربط `LhIconMap`) | `String?` | `nil` |
| `bordered` | عرض خط الفصل السفلي أم لا | `Bool` | `true` |
| `clickable` | قابل للنقر أم لا (يتحكم في السهم وبوابة النقر) | `Bool` | `false` |
| `required` | عرض نجمة حمراء للحقل الإلزامي قبل العنوان أم لا | `Bool` | `false` |
| `lhOnClick` | رد النقر؛ لا يُطلق عندما يكون `clickable = false` | `(() -> Void)?` | `nil` |

### التسلسل الهرمي للنص

| المنطقة | حجم الخط | اللون |
| --- | --- | --- |
| العنوان | `cell.fontSizeTitle` (14pt) | `color.text.primary` |
| العنوان الفرعي | `cell.fontSizeLabel` (13pt) | `color.text.secondary` |
| القيمة الجانبية | `cell.fontSizeValue` (14pt) | `color.text.secondary` |
| نجمة الحقل الإلزامي | `cell.fontSizeTitle` | `color.danger.default` |

## مرجع الرموز

| الرمز | الغرض |
| --- | --- |
| `cell.paddingHorizontal` / `cell.paddingVertical` | الحشو الداخلي (يتبع `spacing.base` / `spacing.sm`) |
| `cell.fontSizeTitle` / `cell.fontSizeLabel` / `cell.fontSizeValue` | ثلاثة مستويات لحجم الخط |
| `cell.iconSize` | حجم الأيقونة الجانبية |
| `cell.gap` | الفراغ بين الكتل (يتبع `spacing.sm`) |
| `cell.borderWidth` | عرض خط الفصل السفلي |
| `color.border.lighter` | لون خط الفصل السفلي |
| `color.text.{primary,secondary}` | لونا العنوان والقيمة/العنوان الفرعي |
| `color.danger.default` | لون نجمة الحقل الإلزامي |
| `color.background.default` | لون خلفية الخلية |

## مرجع الحالات الذهبية

| case id | التأكيد | الاختبار المحلي |
| --- | --- | --- |
| `title-and-value-render` | رسم العنوان والقيمة معًا | `testTitleAndValueUseFontTokens` |
| `label-renders-secondary-tone` | العنوان الفرعي يأخذ لون النص الثانوي | `testLabelRendersSecondaryTone` |
| `required-uses-danger-token` | نجمة الحقل الإلزامي تأخذ رمز لون الخطر | `testRequiredUsesDangerToken` |
| `bordered-emits-line-command` | خط الفصل يستهلك الرمز border.lighter | `testBorderedUsesBorderTokens` |
| `clickable-emits-onclick` | عند الإمكان يُطلق lhOnClick | `testClickableIsInteractive` |
| `not-clickable-no-onclick` | عند عدم الإمكان لا يُطلق lhOnClick | `testNotClickableIsNotInteractive` |

بالإضافة إلى اختبارات مخصّصة للوضع الداكن: `testDarkColorsComeFromDarkTokens` / `testDimensionsAreIdenticalInDarkMode` /
`testCellInitAndRender` / `testLayoutUsesCellTokens`.

```bash
swift test --filter LhCellTests    # يعمل على مضيف macOS، دون الحاجة إلى محاكي
```

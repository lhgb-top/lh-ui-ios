# وسم Tag

وسم مدمج للوسم والاختيار. أصغر من الزر، ويدعم الأنواع الدلالية والحد وزاوية الكبسولة وزر الإغلاق.

> مصدر العقد: `lh-ui-core/specs/tag.json` ·
> الحالات الذهبية: `lh-ui-core/cases/tag.json` (6 حالات، مُترجمة إلى XCTest، قابلة للتشغيل على مضيف macOS)

## الأنواع

ستة أنواع تحدد لون الخلفية ولون النص. `plain` هو شكل الخلفية الفاتحة المحدودة (خلفية دلالية فاتحة + حد دلالي).

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>أنواع Tag</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-tag">افتراضي</span>
      <span class="sim-tag sim-tag--primary">رئيسي</span>
      <span class="sim-tag sim-tag--success">نجاح</span>
    </div>
    <div class="sim-row">
      <span class="sim-tag sim-tag--warning">تحذير</span>
      <span class="sim-tag sim-tag--danger">خطر</span>
      <span class="sim-tag sim-tag--info">معلومات</span>
    </div>
    <div class="sim-row">
      <span class="sim-tag sim-tag--plain sim-tag--primary">رئيسي محدود</span>
      <span class="sim-tag sim-tag--plain sim-tag--success">نجاح محدود</span>
    </div>
  </div>
</div>
<p class="sim-note">معاينة محاكاة HTML (مظهر iOS / SwiftUI)، ليست تصييرًا على جهاز حقيقي</p>

```swift
LhTag(text: "رئيسي", type: .primary)
LhTag(text: "نجاح محدود", type: .success, plain: true)
```

## الحجم وزاوية الانحناء

ثلاثة أحجام تُربط بالرموز `tag.height` / `paddingHorizontal` / `fontSize`؛ ويستبدل `round` زاوية الانحناء بنصف الارتفاع (كبسولة).

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>أحجام Tag</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-tag sim-tag--small sim-tag--primary">صغير</span>
      <span class="sim-tag sim-tag--primary">متوسط</span>
      <span class="sim-tag sim-tag--large sim-tag--primary">كبير</span>
    </div>
    <div class="sim-row">
      <span class="sim-tag sim-tag--primary">زاوية قائمة</span>
      <span class="sim-tag sim-tag--primary sim-tag--round">زاوية مستديرة</span>
    </div>
  </div>
</div>
<p class="sim-note">معاينة محاكاة HTML (مظهر iOS / SwiftUI)، ليست تصييرًا على جهاز حقيقي</p>

## قابل للإغلاق

يعرض `closable` زر إغلاق على الجانب، ويُطلق النقر عليه `onClose` (حالة ذهبية `closable-tap-emits-onclose`).

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>إغلاق Tag</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-tag sim-tag--primary">قابل للإغلاق<svg class="sim-tag__close" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.4"><path d="M6 6l12 12M18 6L6 18"/></svg></span>
      <span class="sim-tag">قابل للإغلاق<svg class="sim-tag__close" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.4"><path d="M6 6l12 12M18 6L6 18"/></svg></span>
    </div>
  </div>
</div>
<p class="sim-note">معاينة محاكاة HTML (مظهر iOS / SwiftUI)، ليست تصييرًا على جهاز حقيقي</p>

```swift
LhTag(text: "قابل للإغلاق", type: .primary, closable: true) {
  // onClose
}
```

## API

### Props

| Prop | الوصف | النوع | الافتراضي |
| --- | --- | --- | --- |
| `text` | نص الوسم | `String` | — |
| `type` | نوع الوسم، يحدد لوني الخلفية والنص | `LhTagType` | `.default` |
| `lhSize` | حجم الوسم، مرتبط برموز الأحجام | `LhTagSize` | `.medium` |
| `plain` | شكل الخلفية الفاتحة المحدودة أم لا | `Bool` | `false` |
| `round` | زاوية كبسولة أم لا (النصف قطر = الارتفاع / 2) | `Bool` | `false` |
| `closable` | عرض زر الإغلاق أم لا | `Bool` | `false` |
| `onClose` | رد النقر على زر الإغلاق | `(() -> Void)?` | `nil` |

### LhTagType

| القيمة | الخلفية | لون النص |
| --- | --- | --- |
| `.default` | `color.background.default` + حد `color.border.base` | `color.text.primary` |
| `.primary` | `color.primary.default` | `color.onPrimary` |
| `.success` | `color.success.default` | `color.onPrimary` |
| `.warning` | `color.warning.default` | `color.onPrimary` |
| `.danger` | `color.danger.default` | `color.onPrimary` |
| `.info` | `color.info.default` | `color.onPrimary` |

عند `plain = true`: تُؤخذ الخلفية من `color.<type>.bg`، ويُؤخذ الحد والنص من `color.<type>.default` (يتجاهل النوع `.default` قيمة `plain`، حالة ذهبية `default-type-renders-text`).

### LhTagSize

| القيمة | height | paddingHorizontal | fontSize |
| --- | --- | --- | --- |
| `.small` | `tag.height.small` (20pt) | `tag.paddingHorizontal.small` (8pt) | `tag.fontSize.small` (12pt) |
| `.medium` | `tag.height.medium` (24pt) | `tag.paddingHorizontal.medium` (12pt) | `tag.fontSize.medium` (13pt) |
| `.large` | `tag.height.large` (28pt) | `tag.paddingHorizontal.large` (16pt) | `tag.fontSize.large` (14pt) |

## مرجع الرموز

| الرمز | الغرض |
| --- | --- |
| `tag.height.{small,medium,large}` | ثلاثة ارتفاعات |
| `tag.paddingHorizontal.{small,medium,large}` | ثلاث حشوات أفقية |
| `tag.fontSize.{small,medium,large}` | ثلاثة أحجام للخط |
| `tag.borderRadius` / `tag.borderWidth` | زاوية الانحناء الافتراضية (تتبع `radius.small`) وعرض الحد |
| `tag.gap` | الفراغ بين النص وزر الإغلاق (يتبع `spacing.xs`) |
| `color.{primary,success,warning,danger,info}.{default,bg}` | خلفيات الأنواع الدلالية والخلفيات الفاتحة المحدودة |
| `color.onPrimary` | لون نص الأنواع الدلالية |
| `color.background.default` / `color.text.primary` / `color.border.base` | ألوان النوع الافتراضي الثلاثة |

## مرجع الحالات الذهبية

| case id | التأكيد | الاختبار المحلي |
| --- | --- | --- |
| `default-type-renders-text` | النوع الافتراضي بخلفية/نص محايد، ويتجاهل plain | `testDefaultTypeUsesNeutralTokens` / `testDefaultTypeIgnoresPlain` |
| `primary-type-uses-primary-tokens` | النوع الرئيسي يستهلك اللون الرئيسي و onPrimary | `testPrimaryTypeUsesPrimaryTokens` |
| `plain-uses-bg-tokens` | يستهلك plain الخلفية الدلالية bg والحد الدلالي | `testPlainUsesBgTokens` |
| `small-size-uses-small-tokens` | الحجم الصغير يستهلك رموز الحجم small | `testSmallSizeUsesSmallTokens` |
| `round-makes-radius-half-height` | زاوية round == الارتفاع / 2 | `testRoundMakesRadiusHalfHeight` |
| `closable-tap-emits-onclose` | زر الإغلاق يُطلق onClose | `testClosableTagInitAndRender` (تأكيدات الإيماءة تتطلب المحاكي) |

بالإضافة إلى اختبارات مخصّصة للوضع الداكن: `testDarkColorsComeFromDarkTokens` / `testPlainInDarkUsesDarkBgTokens` /
`testDimensionsAreIdenticalInDarkMode`.

```bash
swift test --filter LhTagTests    # يعمل على مضيف macOS، دون الحاجة إلى محاكي
```

# زر Button

زر إجراءات أساسي. يُشغّل إجراءً فوريًا، ويدعم الأنواع والأحجام وحالة التحميل والتعطيل والأيقونات وخلفية النمط الصيني.

> مصدر العقد: `lh-ui-core/specs/button.json` ·
> الحالات الذهبية: `lh-ui-core/cases/button.json` (8 حالات، مُترجمة إلى XCTest، قابلة للتشغيل على مضيف macOS)

## الأنواع

ستة أنواع تحدد لون الخلفية ولون النص.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>أنواع Button</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <button class="sim-btn">زر افتراضي</button>
      <button class="sim-btn sim-btn--primary">زر رئيسي</button>
    </div>
    <div class="sim-row">
      <button class="sim-btn sim-btn--success">زر نجاح</button>
      <button class="sim-btn sim-btn--warning">زر تحذير</button>
    </div>
    <div class="sim-row">
      <button class="sim-btn sim-btn--danger">زر خطر</button>
      <button class="sim-btn sim-btn--info">زر معلومات</button>
    </div>
  </div>
</div>
<p class="sim-note">معاينة محاكاة HTML (مظهر iOS / SwiftUI)، ليست تصييرًا على جهاز حقيقي</p>

```swift
LhButton(lhOnClick: {}, type: .primary, text: "زر رئيسي")
```

## الأحجام

ثلاثة أحجام تُربط بالرموز `button.height` / `paddingHorizontal` / `fontSize` / `iconSize`.
شكل iOS عبارة عن زاوية كبسولة (الرمز `radius.round`).

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>أحجام Button</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <button class="sim-btn sim-btn--small">زر صغير</button>
      <button class="sim-btn">زر متوسط</button>
      <button class="sim-btn sim-btn--large">زر كبير</button>
    </div>
  </div>
</div>
<p class="sim-note">معاينة محاكاة HTML (مظهر iOS / SwiftUI)، ليست تصييرًا على جهاز حقيقي</p>

## الحالات

لا يُطلق النقر `lhOnClick` في الحالتين المعطّلة والتحميل؛ وعند اجتماعهما تكون **الأولوية للتعطيل** (حالة ذهبية `disabled-precedes-loading`).

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>حالات Button</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <button class="sim-btn sim-btn--primary">عادي</button>
      <button class="sim-btn sim-btn--primary sim-btn--disabled">معطّل</button>
    </div>
    <div class="sim-row">
      <button class="sim-btn sim-btn--primary sim-btn--loading">
        <span class="sim-btn__spinner"></span>جارٍ التحميل
      </button>
      <button class="sim-btn sim-btn--primary sim-btn--disabled">التعطيل أولى</button>
    </div>
  </div>
</div>
<p class="sim-note">معاينة محاكاة HTML (مظهر iOS / SwiftUI)، ليست تصييرًا على جهاز حقيقي</p>

## الأيقونة وخلفية النمط

يُحلَّ اسم الأيقونة عبر نظام الأيقونات المحلي (`LhButtonStyle.icon(for:)` يربط بـ SF Symbol: search ← magnifyingglass،
refresh ← arrow.clockwise، check ← checkmark، close ← xmark؛ والأسماء غير المسجّلة لا تُرسم).
تستهلك خلفية النمط الرمز `color.decoration` وترسم Canvas خطوطًا قطرية بزاوية 45°، طبقة تحت لون الخلفية وفوق النص دون التأثير على التباين.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>أيقونة ونمط</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <button class="sim-btn sim-btn--primary"><span class="sim-btn__icon"></span>بحث</button>
      <button class="sim-btn"><span class="sim-btn__icon"></span>افتراضي</button>
    </div>
    <div class="sim-row">
      <button class="sim-btn sim-btn--primary sim-btn--pattern">نمط رئيسي</button>
      <button class="sim-btn sim-btn--pattern">نمط افتراضي</button>
    </div>
  </div>
</div>
<p class="sim-note">معاينة محاكاة HTML (مظهر iOS / SwiftUI)، ليست تصييرًا على جهاز حقيقي</p>

## السمتان الفاتحة والداكنة

بدّل سمة الموقع من الزاوية العلوية تتغيّر ألوان الأزرار داخل إطار هاتف المحاكي؛ وعلى الجهاز الحقيقي بدّل عبر `LhTheme(isDark: true)`.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>أزرار داكنة</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <button class="sim-btn sim-btn--primary">زر رئيسي</button>
      <button class="sim-btn">زر افتراضي</button>
    </div>
    <div class="sim-row">
      <button class="sim-btn sim-btn--primary sim-btn--disabled">معطّل</button>
      <button class="sim-btn sim-btn--success">نجاح</button>
    </div>
  </div>
</div>
<p class="sim-note">معاينة محاكاة HTML (مظهر iOS / SwiftUI)، ليست تصييرًا على جهاز حقيقي؛ وقيم الفاتح/الداكن كلها مأخوذة من لقطة رموز core</p>

## API

### Props

| Prop | الوصف | النوع | الافتراضي |
| --- | --- | --- | --- |
| `lhOnClick` | رد النقر؛ لا يُطلق عندما يكون `disabled` أو `loading` يساوي true | `() -> Void` | — |
| `type` | نوع الزر، يحدد لوني الخلفية والنص | `LhButtonType` | `.default` |
| `lhSize` | حجم الزر، مرتبط برموز الأحجام | `LhButtonSize` | `.medium` |
| `disabled` | معطّل أم لا | `Bool` | `false` |
| `loading` | في حالة التحميل أم لا (يعرض مؤشرًا، ولا يُطلق lhOnClick) | `Bool` | `false` |
| `icon` | اسم الأيقونة (يُحل عبر تخطيط SF Symbol) | `String?` | `nil` |
| `bgPattern` | رسم النمط الزخرفي الصيني أم لا | `Bool` | `false` |
| `label` / `text` | محتوى النص للزر (فتحة default في spec) | `Text` / سلسلة نصية | — |

### LhButtonType

| القيمة | الخلفية | لون النص |
| --- | --- | --- |
| `.default` | `color.background.default` | `color.text.primary` |
| `.primary` | `color.primary.default` | `color.onPrimary` |
| `.success` | `color.success.default` | `color.onPrimary` |
| `.warning` | `color.warning.default` | `color.onPrimary` |
| `.danger` | `color.danger.default` | `color.onPrimary` |
| `.info` | `color.info.default` | `color.onPrimary` |

### LhButtonSize

| القيمة | height | paddingHorizontal | fontSize | iconSize |
| --- | --- | --- | --- | --- |
| `.small` | `button.height.small` (32pt) | `button.paddingHorizontal.small` (16pt) | `button.fontSize.small` (13pt) | `button.iconSize.small` (16pt) |
| `.medium` | `button.height.medium` (40pt) | `button.paddingHorizontal.medium` (20pt) | `button.fontSize.medium` (14pt) | `button.iconSize.medium` (18pt) |
| `.large` | `button.height.large` (48pt) | `button.paddingHorizontal.large` (24pt) | `button.fontSize.large` (16pt) | `button.iconSize.large` (20pt) |

تجاوزات الحالة المعطّلة: الخلفية `color.disabled.bg`، والنص `color.disabled.text`، والحد `color.disabled.border`.

## مرجع الرموز

الرموز التي يستهلكها الزر (محاذاة واحدة تلو الأخرى مع `tokenRefs` في `specs/button.json`):

| الرمز | الغرض |
| --- | --- |
| `button.height.{small,medium,large}` | ثلاثة ارتفاعات |
| `button.paddingHorizontal.{small,medium,large}` | ثلاث حشوات أفقية |
| `button.fontSize.{small,medium,large}` | ثلاثة أحجام للخط |
| `button.iconSize.{small,medium,large}` | ثلاثة أحجام للأيقونة |
| `button.borderRadius` / `button.borderWidth` | زاوية الانحناء (تتبع `radius.base`) وعرض الحد |
| `button.fontWeight` | وزن الخط (يتبع `typography.fontWeight.primary`، ويُربط إلى Font.Weight في المنصة) |
| `color.primary.default` / `color.onPrimary` | خلفية/نص النوع الرئيسي |
| `color.{success,warning,danger,info}.default` | خلفيات الأنواع الدلالية |
| `color.background.default` / `color.text.primary` / `color.border.base` | خلفية/نص/حد النوع الافتراضي |
| `color.disabled.{bg,text,border}` | ألوان التعطيل الثلاثة |
| `color.decoration` | لون النمط الزخرفي |
| `shadow.lighter` | الارتفاع الافتراضي (حامل LhShadow) |
| `spacing.xs` | الفراغ بين الأيقونة والنص |

## مرجع الحالات الذهبية

كيفية محاذاة تأكيدات `cases/button.json` الثمانية مع XCTest:

| case id | التأكيد | الاختبار المحلي |
| --- | --- | --- |
| `click-emits-onclick` | البوابة تسمح بالمرور (تفاعلي) | `LhButtonTests.testEnabledButtonIsInteractive` |
| `disabled-blocks-click` | الحالة المعطّلة غير تفاعلية | `testDisabledIsNotInteractive` |
| `loading-blocks-click` | حالة التحميل غير تفاعلية | `testLoadingIsNotInteractive` |
| `disabled-precedes-loading` | التعطيل أولى مع نمط التعطيل | `testDisabledPrecedesLoading` |
| `default-type-renders-text` | النوع الافتراضي بخلفية/نص محايد | `testDefaultTypeUsesNeutralTokens` |
| `primary-type-uses-primary-tokens` | النوع الرئيسي يستهلك رموز اللون الرئيسي | `testPrimaryTypeUsesPrimaryTokens` |
| `small-size-uses-small-tokens` | الحجم الصغير يستهلك رموز الحجم small | `testSmallSizeUsesSmallTokens` |
| `bgpattern-uses-decoration-token` | خلفية النمط تستهلك لون الزخرفة | `testBgPatternUsesDecorationToken` |

بالإضافة إلى اختبارات مخصّصة للوضع الداكن: `testDarkColorsComeFromDarkTokens` / `testDisabledInDarkUsesDarkDisabledTokens` /
`testDimensionsAreIdenticalInDarkMode`.

```bash
swift test    # يعمل على مضيف macOS، دون الحاجة إلى محاكي
```

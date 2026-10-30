# Toast (تنبيه)

تنبيه خفيف تعريفي. يتحكم `@Binding var visible` في الإظهار والإخفاء، ويختفي تلقائيًا عند انتهاء المدة، وتُؤخذ الخلفية الداكنة من الرمز `color.ink`.

> مصدر العقد: `lh-ui-core/specs/toast.json` ·
> الحالات الذهبية: `lh-ui-core/cases/toast.json` (6 حالات، مُترجمة إلى XCTest، قابلة للتشغيل على مضيف macOS)

## الأنواع

النوع الافتراضي بلا أيقونة؛ وتعرض الأنواع الأخرى نقطة بلون دلالي إلى جانب النص. خلفية داكنة + نص أبيض، ويضمن `color.ink` التباين.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>أنواع Toast</span></div>
  <div class="sim-screen">
    <div class="sim-row"><button class="sim-btn sim-btn--primary">افتراضي</button></div>
  </div>
  <div class="sim-toast">تم الحفظ</div>
</div>
<p class="sim-note">معاينة محاكاة HTML (مظهر iOS / SwiftUI)، ليست تصييرًا على جهاز حقيقي</p>

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Toast الدلالية</span></div>
  <div class="sim-screen">
    <div class="sim-row"><button class="sim-btn sim-btn--success">نجاح</button></div>
  </div>
  <div class="sim-toast"><span class="sim-toast__dot sim-toast__dot--success"></span>تمت العملية بنجاح</div>
</div>
<p class="sim-note">معاينة محاكاة HTML (مظهر iOS / SwiftUI)، ليست تصييرًا على جهاز حقيقي</p>

```swift
@State private var visible = false

LhToast(visible: $visible, text: "تم الحفظ", type: .success)
```

## التموضع

ثلاثة مواضع: `top` (أعلى)، `center` (المنتصف، افتراضي)، `bottom` (أسفل).

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>تموضع Toast</span></div>
  <div class="sim-screen">
    <div class="sim-row"><button class="sim-btn sim-btn--primary">تموضع bottom</button></div>
  </div>
  <div class="sim-toast sim-toast--bottom"><span class="sim-toast__dot sim-toast__dot--warning"></span>تنبيه سفلي</div>
</div>
<p class="sim-note">معاينة محاكاة HTML (مظهر iOS / SwiftUI)، ليست تصييرًا على جهاز حقيقي</p>

## الاختفاء التلقائي

عندما يصبح `visible` يساوي `true` يبدأ مؤقت `.task`، وبعد انقضاء `duration` (بالميلي ثانية) يُعاد تعيينه إلى `false` ويُطلق `onClose`
(حالة ذهبية `auto-hides-after-duration`)؛ وقبل انتهاء المدة يبقى معروضًا دون إطلاق أي رد
(`tick-before-duration-keeps-visible`)؛ والإخفاء اليدوي من الخارج لا يُطلق ردًا (`hide-is-silent`).

::: tip وحدة المدة
الرمز `toast.duration` بالميلي ثانية (2000)، بينما يحتاج `Task.sleep` في SwiftUI إلى ثوانٍ،
فتُجرى على المنصة عملية التحويل `Double(duration) / 1000` (انظر `LhToastStyle`).
:::

```swift
LhToast(visible: $visible, text: "تمت العملية بنجاح", type: .success, duration: 2000) {
  // onClose (يُطلق فقط عند الاختفاء التلقائي)
}
```

## API

### Props

| Prop | الوصف | النوع | الافتراضي |
| --- | --- | --- | --- |
| `visible` | معروض أم لا (ربط ثنائي الاتجاه مُتحكَّم فيه، يُعاد إلى false تلقائيًا عند انتهاء المدة) | `Bool` | — |
| `text` | نص التنبيه | `String` | — |
| `type` | نوع التنبيه، يحدد عرض النقطة ولونها | `LhToastType` | `.default` |
| `lhPosition` | موضع العرض | `LhToastPosition` | `.center` |
| `duration` | مدة العرض (بالميلي ثانية) | `Int` | `2000` (يأخذ الرمز `toast.duration`) |
| `onClose` | رد الاختفاء التلقائي (الإخفاء اليدوي من الخارج لا يُطلقه) | `(() -> Void)?` | `nil` |

### LhToastType

| القيمة | لون النقطة |
| --- | --- |
| `.default` | بلا نقطة |
| `.success` | `color.success.default` |
| `.warning` | `color.warning.default` |
| `.danger` | `color.danger.default` |
| `.info` | `color.info.default` |

### LhToastPosition

| القيمة | التموضع |
| --- | --- |
| `.top` | أعلى (هامش `spacing.xl`) |
| `.center` | المنتصف |
| `.bottom` | أسفل (هامش `spacing.xl`) |

## مرجع الرموز

| الرمز | الغرض |
| --- | --- |
| `toast.paddingHorizontal` / `toast.paddingVertical` | الحشو الداخلي |
| `toast.fontSize` | حجم خط نص التنبيه |
| `toast.borderRadius` | زاوية الانحناء (تتبع `radius.small`) |
| `toast.gap` | الفراغ بين النقطة والنص |
| `toast.duration` | مدة العرض الافتراضية (بالميلي ثانية) |
| `color.ink` | الخلفية الداكنة (لها تجاوز مخصّص في الوضع الداكن، لتمييزها عن خلفية الصفحة) |
| `color.onPrimary` | النص الأبيض |
| `color.{success,warning,danger,info}.default` | ألوان النقاط الدلالية |
| `zIndex.toast` | مستوى الطبقة |
| `spacing.xl` | هامش التموضع العلوي/السفلي |

## مرجع الحالات الذهبية

| case id | التأكيد | الاختبار المحلي |
| --- | --- | --- |
| `show-makes-visible` | العرض يُرسم فورًا | `testShowMakesVisible` |
| `auto-hides-after-duration` | الاختفاء التلقائي عند انتهاء المدة وإطلاق onClose | `testDurationConvertsToSeconds` |
| `tick-before-duration-keeps-visible` | قبل انتهاء المدة يبقى معروضًا | `testVisibleDuringDuration` |
| `hide-is-silent` | الإخفاء اليدوي من الخارج لا يُطلق ردًا | `testHideIsSilent` |
| `success-type-uses-success-token` | نوع النجاح يستهلك رمز لون النجاح والرمز ink | `testSuccessTypeUsesSuccessToken` / `testInkBackgroundUsesInkToken` |
| `hidden-emits-no-commands` | عند الإخفاء تكون تعليمات الرسم فارغة | `testHiddenNotRendered` |

بالإضافة إلى اختبارات مخصّصة: `testDefaultTypeHasNoDot` / `testLayoutUsesToastTokens` /
`testDarkColorsComeFromDarkTokens` / `testDarkInkDiffersFromLightInk` /
`testDimensionsAreIdenticalInDarkMode` / `testToastViewInitAcceptsConstant`.

```bash
swift test --filter LhToastTests    # يعمل على مضيف macOS، دون الحاجة إلى محاكي
```

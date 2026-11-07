# منتقي Picker

منتقي عجلة سفلي تعريفي. يتحكم `@Binding var visible` في الإظهار والإخفاء، ويمثل `@Binding var value` فهرس العنصر المحدد،
والعجلة مرسومة يدويًا (`DragGesture` + الالتقاط عند رفع الإصبع)، دون أي اعتماد على عناصر النظام.

> مصدر العقد: `lh-ui-core/specs/picker.json` ·
> الحالات الذهبية: `lh-ui-core/cases/picker.json` (8 حالات، مُترجمة إلى XCTest، قابلة للتشغيل على مضيف macOS)

## الشكل الأساسي

ينبثق من الأسفل: شريط أدوات علوي (إلغاء / عنوان / تأكيد)، وفي المنتصف العجلة مع خطين مؤشرين.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Picker الأساسي</span></div>
  <div class="sim-screen">
    <div class="sim-row"><button class="sim-btn sim-btn--primary">منتقي</button></div>
  </div>
  <div class="sim-picker-mask"></div>
  <div class="sim-picker">
    <div class="sim-picker__toolbar">
      <span class="sim-picker__btn">إلغاء</span>
      <span class="sim-picker__title">اختيار</span>
      <span class="sim-picker__btn sim-picker__btn--confirm">تأكيد</span>
    </div>
    <div class="sim-picker__wheel">
      <div class="sim-picker__indicator"></div>
      <div class="sim-picker__item">خيار 1</div>
      <div class="sim-picker__item sim-picker__item--selected">خيار 2</div>
      <div class="sim-picker__item">خيار 3</div>
    </div>
  </div>
</div>
<p class="sim-note">معاينة محاكاة HTML (مظهر iOS / SwiftUI)، ليست تصييرًا على جهاز حقيقي</p>

```swift
@State private var visible = false
@State private var index = 1
let options = ["خيار 1", "خيار 2", "خيار 3"]

LhPicker(
  visible: $visible,
  options: options,
  value: $index,
  title: "اختيار"
)
```

## تفاعل العجلة

- السحب يغيّر الإزاحة الكلية؛ وعند رفع الإصبع يتم الالتقاط إلى أقرب خيار مرشّح (مدة الحركة `motion.duration.base`)،
  وعند تغيّر الفهرس المحدد يُطلق `onValueChange` (حالة ذهبية `scroll-emits-onvaluechange`).
- المسافة بين الخطين المؤشرين = `picker.itemHeight`، ويقع العنصر المحدد دائمًا في منتصف الخطين.

## الردود والحدود

- «تأكيد» يُطلق `onConfirm` (حمولته الفهرس الحالي) و`onClose` (`confirm-also-emits-onclose`).
- «إلغاء» يُطلق `onCancel`.
- عند خروج `value` عن النطاق يُطبَّق عليه clamp على المنصة: القيم السالبة تُصفَّر (`clamp-negative-value-to-zero`)،
  والقيم الزائدة تُردّ إلى العنصر الأخير (`clamp-overflow-value-to-last`)؛ وعند قائمة خيارات فارغة يكون الفهرس دائمًا 0.
- عند `visible = false` لا تُطلق أي تعليمة رسم (`hidden-not-rendered`).

```swift
LhPicker(
  visible: $visible,
  options: options,
  value: $index,
  title: "اختيار",
  confirmText: "تأكيد",
  cancelText: "إلغاء",
  onValueChange: { newIndex in
    // رد الالتقاط بعد السحب
  },
  onConfirm: { newIndex in
    // رد التأكيد (حمولته الفهرس الحالي)
  },
  onCancel: {
    // رد الإلغاء
  }
)
```

## API

### Props

| Prop | الوصف | النوع | الافتراضي |
| --- | --- | --- | --- |
| `visible` | معروض أم لا (ربط ثنائي الاتجاه مُتحكَّم فيه) | `Bool` | — |
| `options` | مصفوفة نصوص الخيارات (عمود واحد) | `[String]` | — |
| `value` | فهرس العنصر المحدد (ربط ثنائي الاتجاه مُتحكَّم فيه، يُطبَّق عليه clamp عند الخروج عن النطاق) | `Int` | — |
| `title` | عنوان شريط الأدوات | `String` | `""` |
| `confirmText` | نص زر التأكيد؛ `nil` (الافتراضي) يستخدم حزمة اللغة | `String?` | حزمة اللغة (الصينية المبسطة `"确认"`) |
| `cancelText` | نص زر الإلغاء؛ `nil` (الافتراضي) يستخدم حزمة اللغة | `String?` | حزمة اللغة (الصينية المبسطة `"取消"`) |
| `onValueChange` | رد الالتقاط بعد السحب، يستقبل الفهرس الجديد | `((Int) -> Void)?` | `nil` |
| `onConfirm` | رد التأكيد، يستقبل الفهرس الحالي | `((Int) -> Void)?` | `nil` |
| `onCancel` | رد الإلغاء | `(() -> Void)?` | `nil` |
| `onClose` | رد الإغلاق (يُطلقه كل من التأكيد والإلغاء) | `(() -> Void)?` | `nil` |

### الألوان

| المنطقة | اللون |
| --- | --- |
| خلفية اللوحة | `color.background.default` |
| القناع | `color.background.overlay` |
| زر الإلغاء / نصوص الخيارات | `color.text.primary` |
| العنوان / زر التأكيد | `color.primary.default` |
| الخطان المؤشران | `color.border.lighter` (العرض مأخوذ من `cell.borderWidth`) |

## مرجع الرموز

| الرمز | الغرض |
| --- | --- |
| `picker.height` | ارتفاع اللوحة (260pt) |
| `picker.toolbarHeight` | ارتفاع شريط الأدوات (44pt) |
| `picker.itemHeight` | ارتفاع العنصر الواحد (يحدد العجلة والمسافة بين الخطين المؤشرين) |
| `picker.itemFontSize` | حجم خط الخيارات وشريط الأدوات |
| `picker.borderRadius` | زاوية الانحناء العلوية |
| `color.background.overlay` / `color.background.default` | لونا القناع وخلفية اللوحة |
| `color.border.lighter` / `cell.borderWidth` | لون الخطوط المؤشرة وعرضها |
| `color.primary.default` | لون زر التأكيد ونص العنصر المحدد |
| `zIndex.{modalBackdrop,modal}` | مستوى طبقة القناع والوحة |
| `motion.duration.base` | مدة حركة الالتقاط (بالثواني على طرف iOS) |

## مرجع الحالات الذهبية

| case id | التأكيد | الاختبار المحلي |
| --- | --- | --- |
| `confirm-emits-onconfirm-with-value` | التأكيد يُطلق `onConfirm(1)` | `testConfirmUsesPrimaryToken` |
| `confirm-also-emits-onclose` | التأكيد يُطلق onClose أيضًا | `testConfirmUsesPrimaryToken` |
| `cancel-emits-oncancel` | الإلغاء يُطلق onCancel | `testCancelUsesNeutralColor` |
| `scroll-emits-onvaluechange` | الالتقاط بعد السحب يُطلق `onValueChange(2)` | طبقة View عبر `DragGesture.onEnded` (تأكيدات الإيماءة تتطلب المحاكي) |
| `clamp-negative-value-to-zero` | الفهرس السالب يُصفَّر إلى 0 | `testClampNegativeValueToZero` |
| `clamp-overflow-value-to-last` | الفهرس الزائد يُردّ إلى العنصر الأخير | `testClampOverflowValueToLast` |
| `title-renders-text` | يُعرض العنوان صحيحًا | `testTitleAndTextsAreExposed` |
| `hidden-not-rendered` | عند الإخفاء لا يُرسم | `testHiddenNotRendered` |

بالإضافة إلى اختبارات مخصّصة: `testVisibleRendersAppearance` / `testClampedValueIsExposed` /
`testLayoutUsesPickerTokens` / `testEmptyOptionsClampsToZero` /
`testDarkColorsComeFromDarkTokens` / `testDimensionsAreIdenticalInDarkMode` /
`testPickerViewInitAcceptsConstant`.

```bash
swift test --filter LhPickerTests    # يعمل على مضيف macOS، دون الحاجة إلى محاكي
```

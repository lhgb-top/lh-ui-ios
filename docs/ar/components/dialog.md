# مربع حوار Dialog

مربع حوار مشروط تعريفي. يتحكم `@Binding var visible` في الإظهار والإخفاء، مع قناع ولوحة متمركزة، وتُعيد الأزرار استخدام `LhButton`.

> مصدر العقد: `lh-ui-core/specs/dialog.json` ·
> الحالات الذهبية: `lh-ui-core/cases/dialog.json` (8 حالات، مُترجمة إلى XCTest، قابلة للتشغيل على مضيف macOS)

## الأنواع

ستة أنواع تحدد اللون الدلالي لزر التأكيد (`buttonType(for:)` يربط إلى `LhButtonType`).

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>أنواع Dialog</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <button class="sim-btn sim-btn--primary">مربع حوار افتراضي</button>
      <button class="sim-btn sim-btn--danger">مربع حوار خطر</button>
    </div>
  </div>
  <div class="sim-dialog-mask"></div>
  <div class="sim-dialog">
    <div class="sim-dialog__title">تأكيد الحذف</div>
    <div class="sim-dialog__content">سيحذف هذا الإجراء العنصر نهائيًا، هل تريد المتابعة؟</div>
    <div class="sim-dialog__actions">
      <button class="sim-btn">إلغاء</button>
      <button class="sim-btn sim-btn--danger">تأكيد</button>
    </div>
  </div>
</div>
<p class="sim-note">معاينة محاكاة HTML (مظهر iOS / SwiftUI)، ليست تصييرًا على جهاز حقيقي</p>

```swift
@State private var visible = false

LhDialog(
  visible: $visible,
  title: "تأكيد الحذف",
  content: "سيحذف هذا الإجراء العنصر نهائيًا، هل تريد المتابعة؟",
  type: .danger,
  confirmText: "تأكيد",
  cancelText: "إلغاء"
)
```

## الإظهار والإخفاء والردود

- عند `visible = true` يُعرض القناع والوحة؛ وعند `visible = false` لا تُطلق أي تعليمة رسم (حالة ذهبية `hidden-not-rendered`).
- النقر على «تأكيد» يُطلق `onConfirm` ثم `onClose` بالترتيب (`confirm-also-emits-onclose`).
- النقر على «إلغاء» يُطلق `onCancel`؛ ويتولّى المكوّن داخليًا إعادة `visible` إلى `false` (ضمن `withAnimation`).
- عند `closable = true` فإن النقر على القناع يُطلق `onClose` أيضًا (`closable-overlay-emits-onclose`)؛ والافتراض عدم الإغلاق (`not-closable-blocks-overlay-close`).

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>قناع Dialog قابل للإغلاق</span></div>
  <div class="sim-screen">
    <div class="sim-row"><button class="sim-btn sim-btn--primary">closable = true</button></div>
  </div>
  <div class="sim-dialog-mask"></div>
  <div class="sim-dialog">
    <div class="sim-dialog__title">تنبيه</div>
    <div class="sim-dialog__content">انقر على القناع للإغلاق</div>
    <div class="sim-dialog__actions">
      <button class="sim-btn">إلغاء</button>
      <button class="sim-btn sim-btn--primary">تأكيد</button>
    </div>
  </div>
</div>
<p class="sim-note">معاينة محاكاة HTML (مظهر iOS / SwiftUI)، ليست تصييرًا على جهاز حقيقي</p>

## API

### Props

| Prop | الوصف | النوع | الافتراضي |
| --- | --- | --- | --- |
| `visible` | معروض أم لا (ربط ثنائي الاتجاه مُتحكَّم فيه) | `Bool` | — |
| `title` | العنوان | `String` | `""` |
| `content` | المحتوى الرئيسي | `String` | `""` |
| `type` | نوع مربع الحوار، يحدد اللون الدلالي لزر التأكيد | `LhDialogType` | `.default` |
| `confirmText` | نص زر التأكيد | `String` | `"确认"` |
| `cancelText` | نص زر الإلغاء | `String` | `"取消"` |
| `closable` | الإغلاق بالنقر على القناع ممكن أم لا | `Bool` | `false` |
| `onConfirm` | رد التأكيد | `(() -> Void)?` | `nil` |
| `onCancel` | رد الإلغاء | `(() -> Void)?` | `nil` |
| `onClose` | رد الإغلاق (نقر القناع / زر·إلغاء / زر·تأكيد تُطلقه جميعًا) | `(() -> Void)?` | `nil` |

### LhDialogType

| القيمة | نوع زر التأكيد | الخلفية |
| --- | --- | --- |
| `.default` | `.default` | `color.background.default` + حد |
| `.primary` | `.primary` | `color.primary.default` |
| `.success` | `.success` | `color.success.default` |
| `.warning` | `.warning` | `color.warning.default` |
| `.danger` | `.danger` | `color.danger.default` |
| `.info` | `.info` | `color.info.default` |

## مرجع الرموز

| الرمز | الغرض |
| --- | --- |
| `dialog.width` | عرض اللوحة (320pt) |
| `dialog.paddingHorizontal` / `dialog.paddingVertical` | الحشو الداخلي للوحة |
| `dialog.borderRadius` | زاوية انحناء اللوحة |
| `dialog.titleFontSize` / `dialog.contentFontSize` | حجم خط العنوان والمحتوى |
| `dialog.gap` | الفراغ العامودي بين الكتل |
| `color.background.overlay` | لون القناع |
| `color.background.default` | لون خلفية اللوحة |
| `color.text.{primary,regular}` | لونا العنوان والمحتوى |
| `shadow.base` | ظل اللوحة (حامل LhShadow) |
| `zIndex.{modalBackdrop,modal}` | مستوى طبقة القناع واللوحة |

## مرجع الحالات الذهبية

| case id | التأكيد | الاختبار المحلي |
| --- | --- | --- |
| `confirm-emits-onconfirm` | التأكيد يُطلق onConfirm | `testConfirmUsesTypeColor` |
| `cancel-emits-oncancel` | الإلغاء يُطلق onCancel | `testCancelUsesNeutralColor` |
| `confirm-also-emits-onclose` | التأكيد يُطلق onClose أيضًا | `testConfirmUsesTypeColor` |
| `closable-overlay-emits-onclose` | النقر على القناع يُطلق onClose | `testClosableFlagIsExposed` |
| `not-closable-blocks-overlay-close` | القناع الافتراضي لا يغلق | `testNotClosableBlocksOverlay` |
| `hidden-not-rendered` | عند الإخفاء لا يُرسم | `testHiddenNotRendered` |
| `title-renders-text` | يُعرض العنوان صحيحًا | `testTitleUsesTitleTokens` |
| `danger-type-uses-danger-token` | النوع الخطير يستهلك رمز لون الخطر | `testDangerTypeUsesDangerToken` |

بالإضافة إلى اختبارات مخصّصة: `testVisibleRendersAppearance` / `testLayoutUsesDialogTokens` /
`testDarkColorsComeFromDarkTokens` / `testDimensionsAreIdenticalInDarkMode` /
`testDialogViewInitAcceptsConstant`.

```bash
swift test --filter LhDialogTests    # يعمل على مضيف macOS، دون الحاجة إلى محاكي
```

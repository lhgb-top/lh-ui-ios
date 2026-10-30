# زر اختيار Radio

زر اختيار مُتحكَّم فيه. يشير `@Binding var checked` إلى «هل هذا العنصر محدّد»، ويُستخدم عادة ضمن مجموعة؛ ولا يمكن إلا لعنصر واحد فقط داخل المجموعة أن يكون `true`.

> مصدر العقد: `lh-ui-core/specs/radio.json` ·
> الحالات الذهبية: `lh-ui-core/cases/radio.json` (6 حالات، مُترجمة إلى XCTest، قابلة للتشغيل على مضيف macOS)

## الحالات

حالة التحديد عبارة عن حلقة محدودة بحد باللون الرئيسي + نقطة مصمتة باللون الرئيسي؛ وحالة عدم التحديد حلقة فارغة محدودة بحد. وقطر النقطة يساوي الحجم مضروبًا في `radio.dotScale` (50%).

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>حالات Radio</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-radio"><span class="sim-radio__ring"></span>غير محدّد</span>
      <span class="sim-radio sim-radio--checked"><span class="sim-radio__ring"><span class="sim-radio__dot"></span></span>محدّد</span>
    </div>
    <div class="sim-row">
      <span class="sim-radio sim-radio--checked sim-radio--disabled"><span class="sim-radio__ring"><span class="sim-radio__dot"></span></span>محدّد ومعطّل</span>
      <span class="sim-radio sim-radio--disabled"><span class="sim-radio__ring"></span>غير محدّد ومعطّل</span>
    </div>
  </div>
</div>
<p class="sim-note">معاينة محاكاة HTML (مظهر iOS / SwiftUI)، ليست تصييرًا على جهاز حقيقي</p>

```swift
@State private var picked = "blue"

LhRadio(checked: Binding(get: { picked == "blue" }, set: { _ in }), value: "blue", label: "青花瓷") { _ in
  picked = "blue"
}
```

## الحجم

ثلاثة أحجام تُربط بالرمز `radio.size`؛ ويُؤخذ حد الحلقة من `radio.ringWidth`.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>أحجام Radio</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-radio sim-radio--checked"><span class="sim-radio__ring sim-radio__ring--small"><span class="sim-radio__dot sim-radio__dot--small"></span></span>صغير</span>
      <span class="sim-radio sim-radio--checked"><span class="sim-radio__ring"><span class="sim-radio__dot"></span></span>متوسط</span>
      <span class="sim-radio sim-radio--checked"><span class="sim-radio__ring sim-radio__ring--large"><span class="sim-radio__dot sim-radio__dot--large"></span></span>كبير</span>
    </div>
  </div>
</div>
<p class="sim-note">معاينة محاكاة HTML (مظهر iOS / SwiftUI)، ليست تصييرًا على جهاز حقيقي</p>

## بوابة النقر

النقر على عنصر محدّد يُبقيه محدّدًا ولا يُطلق `onChange` (حالة ذهبية `tap-checked-keeps-checked`)؛
والحالة المعطّلة لا تُطلقه (`disabled-blocks-change`). ويُترك حاوي المجموعة للإصدارات اللاحقة.

## API

### Props

| Prop | الوصف | النوع | الافتراضي |
| --- | --- | --- | --- |
| `checked` | هل هذا العنصر محدّد (ربط ثنائي الاتجاه مُتحكَّم فيه) | `Bool` | — |
| `value` | القيمة التي يمثلها هذا العنصر (يقترن مع `checked` لتنفيذ مجموعة اختيار واحد) | `String` | `""` |
| `disabled` | معطّل أم لا (لا يُطلق onChange) | `Bool` | `false` |
| `lhSize` | حجم زر الاختيار، مرتبط برموز الأحجام | `LhRadioSize` | `.medium` |
| `label` | التصنيف النصي | `String` | `""` |
| `onChange` | رد تغيير التحديد، يستقبل القيمة الجديدة | `((Bool) -> Void)?` | `nil` |

### LhRadioSize

| القيمة | حجم الحلقة | قطر النقطة |
| --- | --- | --- |
| `.small` | `radio.size.small` (16pt) | الحجم × `radio.dotScale` (8pt) |
| `.medium` | `radio.size.medium` (20pt) | الحجم × `radio.dotScale` (10pt) |
| `.large` | `radio.size.large` (24pt) | الحجم × `radio.dotScale` (12pt) |

### الألوان

| الحالة | حد الحلقة | النقطة |
| --- | --- | --- |
| غير محدّد | `color.border.base` (`radio.ringWidth`) | — |
| محدّد | `color.primary.default` | `color.primary.default` |
| معطّل | `color.disabled.border` | `color.disabled.text` |

## مرجع الرموز

| الرمز | الغرض |
| --- | --- |
| `radio.size.{small,medium,large}` | ثلاثة أحجام للحلقة |
| `radio.dotScale` | نسبة النقطة إلى حجم الحلقة (50%) |
| `radio.ringWidth` | عرض حد الحلقة |
| `radio.gap` | الفراغ بين الحلقة والنص (يتبع `spacing.sm`) |
| `color.primary.default` | لونا حد التحديد والنقطة |
| `color.border.base` | لون حد حالة عدم التحديد |
| `color.disabled.{border,text}` | لونا حد التحديد والنقطة في الحالة المعطّلة |
| `color.text.{primary,disabled}` | لون نص التصنيف |

## مرجع الحالات الذهبية

| case id | التأكيد | الاختبار المحلي |
| --- | --- | --- |
| `tap-unchecked-emits-onchange` | النقر على غير المحدّد يُطلق `onChange(true)` | `testUncheckedIsInteractive` |
| `tap-checked-keeps-checked` | النقر على المحدّد يُبقيه محدّدًا دون رد | `testCheckedShowsDot` |
| `disabled-blocks-change` | الحالة المعطّلة لا تُطلق onChange | `testDisabledBlocksChange` |
| `checked-uses-primary-tokens` | حالة التحديد تستهلك رمز اللون الرئيسي | `testCheckedUsesPrimaryTokens` |
| `unchecked-uses-border-token` | حالة عدم التحديد تستهلك رمز الحد | `testUncheckedUsesBorderToken` |
| `small-size-uses-small-token` | الحجم الصغير يستهلك رمز الحجم small | `testSmallSizeUsesSmallToken` |

بالإضافة إلى اختبارات مخصّصة: `testStrokeUsesRadioTokens` / `testDarkColorsComeFromDarkTokens` /
`testDisabledInDarkUsesDarkDisabledTokens` / `testDimensionsAreIdenticalInDarkMode` /
`testRadioViewInitAcceptsConstant`.

```bash
swift test --filter LhRadioTests    # يعمل على مضيف macOS، دون الحاجة إلى محاكي
```

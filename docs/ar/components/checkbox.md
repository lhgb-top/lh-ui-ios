# مربع اختيار Checkbox

مربّع اختيار مُتحكَّم فيه. ربط ثنائي الاتجاه عبر `@Binding var checked`، ويدعم ثلاث حالات (محدّد / غير محدّد / غير محدَّد).

> مصدر العقد: `lh-ui-core/specs/checkbox.json` ·
> الحالات الذهبية: `lh-ui-core/cases/checkbox.json` (6 حالات، مُترجمة إلى XCTest، قابلة للتشغيل على مضيف macOS)

## الحالات

حالة التحديد عبارة عن مربع مصمت باللون الرئيسي + علامة تحديد بيضاء؛ وحالة غير المحدَّد (indeterminate) مربع مصمت باللون الرئيسي + شريط أفقي أبيض؛ وحالة عدم التحديد إطار فارغ محدود بحد.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>حالات Checkbox</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-checkbox"><span class="sim-checkbox__box"></span>غير محدّد</span>
      <span class="sim-checkbox sim-checkbox--checked"><span class="sim-checkbox__box"><svg class="sim-checkbox__check" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.8"><path d="M4 12.5l5 5L20 6.5"/></svg></span>محدّد</span>
    </div>
    <div class="sim-row">
      <span class="sim-checkbox sim-checkbox--indeterminate"><span class="sim-checkbox__box"><span class="sim-checkbox__dash"></span></span>غير محدَّد</span>
      <span class="sim-checkbox sim-checkbox--checked sim-checkbox--disabled"><span class="sim-checkbox__box"><svg class="sim-checkbox__check" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.8"><path d="M4 12.5l5 5L20 6.5"/></svg></span>معطّل</span>
    </div>
  </div>
</div>
<p class="sim-note">معاينة محاكاة HTML (مظهر iOS / SwiftUI)، ليست تصييرًا على جهاز حقيقي</p>

```swift
@State private var checked = false

LhCheckbox(checked: $checked, label: "محدّد") { newValue in
  // onChange
}
```

## الحجم

ثلاثة أحجام تُربط بالرمز `checkbox.size`؛ ويُؤخذ عرض حد علامة التحديد من `checkbox.checkWidth`،
وعرض شريط حالة غير المحدَّد يساوي حجم المربع مضروبًا في `checkbox.dashScale` (50%).

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>أحجام Checkbox</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-checkbox sim-checkbox--checked"><span class="sim-checkbox__box sim-checkbox__box--small"><svg class="sim-checkbox__check" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.8"><path d="M4 12.5l5 5L20 6.5"/></svg></span>صغير</span>
      <span class="sim-checkbox sim-checkbox--checked"><span class="sim-checkbox__box"><svg class="sim-checkbox__check" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.8"><path d="M4 12.5l5 5L20 6.5"/></svg></span>متوسط</span>
      <span class="sim-checkbox sim-checkbox--checked"><span class="sim-checkbox__box sim-checkbox__box--large"><svg class="sim-checkbox__check" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.8"><path d="M4 12.5l5 5L20 6.5"/></svg></span>كبير</span>
    </div>
  </div>
</div>
<p class="sim-note">معاينة محاكاة HTML (مظهر iOS / SwiftUI)، ليست تصييرًا على جهاز حقيقي</p>

## حالة غير المحدَّد

عند `indeterminate = true` لا تُعرض علامة التحديد بل شريط أفقي؛ وبعد النقر يصبح بالضرورة **محدّدًا** (حالة ذهبية
`indeterminate-becomes-checked`)، لا مُبدَّلًا بين الحالتين.

```swift
@State private var checked = false

LhCheckbox(checked: $checked, label: "تحديد الكل", indeterminate: somePartial) { _ in }
```

## API

### Props

| Prop | الوصف | النوع | الافتراضي |
| --- | --- | --- | --- |
| `checked` | حالة التحديد (ربط ثنائي الاتجاه مُتحكَّم فيه) | `Bool` | — |
| `indeterminate` | حالة غير المحدَّد أم لا (تعرض شريطًا، وبعد النقر يصبح محدّدًا) | `Bool` | `false` |
| `disabled` | معطّل أم لا (لا يُطلق onChange) | `Bool` | `false` |
| `lhSize` | حجم مربّع الاختيار، مرتبط برموز الأحجام | `LhCheckboxSize` | `.medium` |
| `label` | التصنيف النصي | `String` | `""` |
| `onChange` | رد تغيير الحالة، يستقبل القيمة الجديدة | `((Bool) -> Void)?` | `nil` |

### LhCheckboxSize

| القيمة | الحجم |
| --- | --- |
| `.small` | `checkbox.size.small` (16pt) |
| `.medium` | `checkbox.size.medium` (20pt) |
| `.large` | `checkbox.size.large` (24pt) |

### الألوان

| الحالة | خلفية المربع | لون العلامة |
| --- | --- | --- |
| غير محدّد | شفاف + حد `color.border.base` (`checkbox.borderWidth`) | — |
| محدّد / غير محدَّد | `color.primary.default` | `color.onPrimary` |
| معطّل | `color.disabled.bg` + حد `color.disabled.border` | `color.disabled.text` |

## مرجع الرموز

| الرمز | الغرض |
| --- | --- |
| `checkbox.size.{small,medium,large}` | ثلاثة أحجام |
| `checkbox.borderRadius` / `checkbox.borderWidth` | زاوية الانحناء (تتبع `radius.small`) وعرض الحد |
| `checkbox.checkWidth` | عرض حد علامة التحديد |
| `checkbox.dashScale` | نسبة شريط حالة غير المحدَّد إلى حجم المربع (50%) |
| `checkbox.gap` | الفراغ بين المربع والنص (يتبع `spacing.sm`) |
| `color.primary.default` / `color.onPrimary` | لونا خلفية التحديد والعلامة |
| `color.border.base` | لون حد حالة عدم التحديد |
| `color.disabled.{bg,border,text}` | ألوان التعطيل الثلاثة |

## مرجع الحالات الذهبية

| case id | التأكيد | الاختبار المحلي |
| --- | --- | --- |
| `tap-toggles-and-emits-onchange` | النقر يُبدّل الحالة ويُطلق `onChange(true)` | `testTapTogglesAndEmitsOnChange` |
| `tap-checked-unchecks` | النقر على المحدّد يجعله غير محدّد | `testTapCheckedUnchecks` |
| `disabled-blocks-change` | الحالة المعطّلة لا تُطلق onChange | `testDisabledBlocksChange` |
| `checked-uses-primary-tokens` | حالة التحديد تستهلك اللون الرئيسي و onPrimary | `testCheckedUsesPrimaryTokens` |
| `unchecked-uses-border-token` | حالة عدم التحديد تستهلك رمز الحد | `testUncheckedUsesBorderToken` |
| `indeterminate-becomes-checked` | بعد النقر على حالة غير المحدَّد يصبح محدّدًا حتمًا | `testIndeterminateBecomesChecked` |

بالإضافة إلى اختبارات مخصّصة: `testSizeUsesSizeTokens` / `testStrokeUsesCheckboxTokens` /
`testDarkColorsComeFromDarkTokens` / `testDisabledInDarkUsesDarkDisabledTokens` /
`testDimensionsAreIdenticalInDarkMode` / `testCheckboxViewInitAcceptsConstant`.

```bash
swift test --filter LhCheckboxTests    # يعمل على مضيف macOS، دون الحاجة إلى محاكي
```

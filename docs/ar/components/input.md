# حقل إدخال Input

حقل إدخال أحادي السطر مُتحكَّم فيه. ربط ثنائي الاتجاه عبر `@Binding var value`، ويدعم النص الظاهر/السري وزر المسح وحدّ عدد الأحرف وحلقة التركيز.

> مصدر العقد: `lh-ui-core/specs/input.json` ·
> الحالات الذهبية: `lh-ui-core/cases/input.json` (8 حالات، مُترجمة إلى XCTest، قابلة للتشغيل على مضيف macOS)

## الشكل الأساسي

الارتفاع محاذٍ مع Button (ثلاثة مستويات للرمز `input.height`)، وعند التركيز يتبدّل الحد إلى `color.focus` ويتّسع ليصبح حلقة تركيز.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Input الأساسي</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-input"><input class="sim-input__field" placeholder="يرجى إدخال المحتوى" /></span>
    </div>
    <div class="sim-row">
      <span class="sim-input sim-input--focus"><input class="sim-input__field" value="青花瓷" /></span>
    </div>
  </div>
</div>
<p class="sim-note">معاينة محاكاة HTML (مظهر iOS / SwiftUI)، ليست تصييرًا على جهاز حقيقي</p>

```swift
@State private var text = ""

LhInput(value: $text, placeholder: "يرجى إدخال المحتوى") { newValue in
  // onValueChange
}
```

## الحجم

ثلاثة أحجام تُربط بالرموز `input.height` / `paddingHorizontal` / `fontSize`.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>أحجام Input</span></div>
  <div class="sim-screen">
    <div class="sim-row"><span class="sim-input sim-input--small"><input class="sim-input__field" placeholder="صغير" /></span></div>
    <div class="sim-row"><span class="sim-input"><input class="sim-input__field" placeholder="متوسط" /></span></div>
    <div class="sim-row"><span class="sim-input sim-input--large"><input class="sim-input__field" placeholder="كبير" /></span></div>
  </div>
</div>
<p class="sim-note">معاينة محاكاة HTML (مظهر iOS / SwiftUI)، ليست تصييرًا على جهاز حقيقي</p>

## كلمة المرور والمسح

يُترجم `type: .password` إلى `SecureField` (الاختبار `testPasswordTypeIsSecure`)؛
ويعرض `clearable` زر المسح عند وجود قيمة، ويُطلق النقر عليه `onValueChange("")` (حالة ذهبية `clearable-emits-empty-value`).

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Input موسّع</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-input"><input class="sim-input__field" type="password" value="secret" /><svg class="sim-input__clear" viewBox="0 0 24 24" fill="currentColor"><path d="M12 2a10 10 0 100 20 10 10 0 000-20zm1 15h-2v-2h2zm0-4h-2V7h2z"/></svg></span>
    </div>
    <div class="sim-row">
      <span class="sim-input sim-input--disabled"><input class="sim-input__field" value="حالة معطّلة" disabled /></span>
    </div>
  </div>
</div>
<p class="sim-note">معاينة محاكاة HTML (مظهر iOS / SwiftUI)، ليست تصييرًا على جهاز حقيقي</p>

```swift
LhInput(value: $pwd, type: .password, clearable: true)
```

## API

### Props

| Prop | الوصف | النوع | الافتراضي |
| --- | --- | --- | --- |
| `value` | محتوى الإدخال (ربط ثنائي الاتجاه مُتحكَّم فيه) | `String` | — |
| `placeholder` | نص الإشارة النائب | `String` | `""` |
| `type` | نوع الإدخال (نص ظاهر / نص سري) | `LhInputType` | `.text` |
| `lhSize` | حجم حقل الإدخال، مرتبط برموز الأحجام | `LhInputSize` | `.medium` |
| `disabled` | معطّل أم لا (لا يُطلق أي رد) | `Bool` | `false` |
| `readonly` | للقراءة فقط أم لا (لا يُطلق onValueChange، مع الاحتفاظ بنمط التركيز) | `Bool` | `false` |
| `clearable` | عرض زر المسح أم لا | `Bool` | `false` |
| `maxlength` | الحد الأقصى لعدد الأحرف (يقتطع عند تجاوزه، حالة ذهبية `maxlength-truncates-input`) | `Int?` | `nil` |
| `onValueChange` | رد تغيير المحتوى، يستقبل القيمة الجديدة | `((String) -> Void)?` | `nil` |
| `lhOnFocus` | رد التركيز | `(() -> Void)?` | `nil` |
| `lhOnBlur` | رد فقد التركيز | `(() -> Void)?` | `nil` |

### LhInputSize

| القيمة | height | paddingHorizontal | fontSize |
| --- | --- | --- | --- |
| `.small` | `input.height.small` (32pt) | `input.paddingHorizontal.small` (12pt) | `input.fontSize.small` (13pt) |
| `.medium` | `input.height.medium` (40pt) | `input.paddingHorizontal.medium` (16pt) | `input.fontSize.medium` (14pt) |
| `.large` | `input.height.large` (48pt) | `input.paddingHorizontal.large` (20pt) | `input.fontSize.large` (16pt) |

### LhInputType

| القيمة | التنفيذ على المنصة |
| --- | --- |
| `.text` | `TextField` |
| `.password` | `SecureField` |

### الألوان

| الحالة | الحد | النص / الإشارة النائب |
| --- | --- | --- |
| افتراضي | `color.border.base` (`input.borderWidth`) | `color.text.primary` / `color.text.placeholder` |
| تركيز | `color.focus` (`input.focusRingWidth`) | نفسه |
| معطّل | `color.disabled.border` | `color.disabled.text` |

## مرجع الرموز

| الرمز | الغرض |
| --- | --- |
| `input.height.{small,medium,large}` | ثلاثة ارتفاعات |
| `input.paddingHorizontal.{small,medium,large}` | ثلاث حشوات أفقية |
| `input.fontSize.{small,medium,large}` | ثلاثة أحجام للخط |
| `input.borderRadius` / `input.borderWidth` | زاوية الانحناء (تتبع `radius.small`) وعرض الحد |
| `input.focusRingWidth` | عرض حلقة التركيز |
| `input.clearIconSize` | حجم أيقونة زر المسح |
| `color.focus` | لون حد التركيز |
| `color.text.{primary,placeholder,disabled}` | ألوان النص والإشارة النائب |
| `color.border.base` / `color.disabled.border` | ألوان الحد |
| `color.background.default` / `color.disabled.bg` | ألوان الخلفية |

## مرجع الحالات الذهبية

| case id | التأكيد | الاختبار المحلي |
| --- | --- | --- |
| `input-emits-onvaluechange` | الإدخال يُطلق `onValueChange("青花瓷")` | `testDefaultIsEditable` |
| `clearable-emits-empty-value` | المسح يُطلق `onValueChange("")` | `testClearableShowsClearButtonWhenHasValue` |
| `disabled-blocks-input` | الحالة المعطّلة لا تُطلق onValueChange | `testDisabledBlocksInput` |
| `readonly-blocks-input` | حالة القراءة فقط لا تُطلق onValueChange | `testReadonlyBlocksInput` |
| `placeholder-uses-placeholder-token` | نص الإشارة النائب يأخذ رمز لون الإشارة النائب | `testPlaceholderUsesPlaceholderToken` |
| `focus-uses-focus-token` | التركيز يستهلك رمز focus ويُطلق lhOnFocus | `testFocusUsesFocusToken` |
| `small-size-uses-small-tokens` | الحجم الصغير يستهلك رموز الحجم small | `testSmallSizeUsesSmallTokens` |
| `maxlength-truncates-input` | تجاوز عدد الأحرف يقتطع | `testMaxlengthTruncatesInput` |

بالإضافة إلى اختبارات مخصّصة: `testPasswordTypeIsSecure` / `testDarkColorsComeFromDarkTokens` /
`testDimensionsAreIdenticalInDarkMode` / `testInputViewInitAcceptsConstant`.

```bash
swift test --filter LhInputTests    # يعمل على مضيف macOS، دون الحاجة إلى محاكي
```

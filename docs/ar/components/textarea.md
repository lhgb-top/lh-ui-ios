# منطقة نص Textarea

حقل إدخال متعدد الأسطر مُتحكَّم فيه. ربط ثنائي الاتجاه عبر `@Binding var value`، مع إشارة نائب وعدّاد أحرف.

> مصدر العقد: `lh-ui-core/specs/textarea.json` ·
> الحالات الذهبية: `lh-ui-core/cases/textarea.json` (6 حالات، مُترجمة إلى XCTest، قابلة للتشغيل على مضيف macOS)

## الشكل الأساسي

يُؤخذ الحد الأدنى للارتفاع من `textarea.minHeight`، والحشو الداخلي من `textarea.paddingHorizontal` / `paddingVertical`،
وعند التركيز يتبدّل الحد إلى `color.focus`.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Textarea الأساسية</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-textarea"><textarea class="sim-textarea__field" placeholder="يرجى إدخال المحتوى"></textarea></span>
    </div>
    <div class="sim-row">
      <span class="sim-textarea sim-textarea--focus"><textarea class="sim-textarea__field">青花瓷</textarea></span>
    </div>
  </div>
</div>
<p class="sim-note">معاينة محاكاة HTML (مظهر iOS / SwiftUI)، ليست تصييرًا على جهاز حقيقي</p>

```swift
@State private var text = ""

LhTextarea(value: $text, placeholder: "يرجى إدخال المحتوى") { newValue in
  // onValueChange
}
```

## عدّاد الأحرف

عند `showCount = true` يُعرض العدّاد في الأسفل الجانبي: إذا حُدِّد `maxlength` يُعرض `الحالي/الحد الأقصى` (حالة ذهبية
`showcount-renders-count`)، وإن لم يُحدَّد يُعرض طول النص الحالي فقط (`showcount-without-maxlength-renders-length-only`).

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>عدّاد Textarea</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-textarea">
        <textarea class="sim-textarea__field">青花瓷</textarea>
        <span class="sim-textarea__count">3/10</span>
      </span>
    </div>
    <div class="sim-row">
      <span class="sim-textarea sim-textarea--disabled">
        <textarea class="sim-textarea__field" disabled>حالة معطّلة</textarea>
      </span>
    </div>
  </div>
</div>
<p class="sim-note">معاينة محاكاة HTML (مظهر iOS / SwiftUI)، ليست تصييرًا على جهاز حقيقي</p>

```swift
LhTextarea(value: $text, showCount: true, maxlength: 10)
```

## API

### Props

| Prop | الوصف | النوع | الافتراضي |
| --- | --- | --- | --- |
| `value` | محتوى الإدخال (ربط ثنائي الاتجاه مُتحكَّم فيه) | `String` | — |
| `placeholder` | نص الإشارة النائب | `String` | `""` |
| `rows` | عدد الأسطور المرغوب (يؤثر في الحد الأدنى للارتفاع) | `Int` | `3` |
| `disabled` | معطّل أم لا (لا يُطلق أي رد) | `Bool` | `false` |
| `readonly` | للقراءة فقط أم لا (لا يُطلق onValueChange، مع الاحتفاظ بنمط التركيز) | `Bool` | `false` |
| `showCount` | عرض عدّاد الأحرف أم لا | `Bool` | `false` |
| `maxlength` | الحد الأقصى لعدد الأحرف (يقتطع عند تجاوزه) | `Int?` | `nil` |
| `onValueChange` | رد تغيير المحتوى، يستقبل القيمة الجديدة | `((String) -> Void)?` | `nil` |
| `lhOnFocus` | رد التركيز | `(() -> Void)?` | `nil` |
| `lhOnBlur` | رد فقد التركيز | `(() -> Void)?` | `nil` |

### الألوان

| الحالة | الحد | النص / الإشارة النائب |
| --- | --- | --- |
| افتراضي | `color.border.base` (`textarea.borderWidth`) | `color.text.primary` / `color.text.placeholder` |
| تركيز | `color.focus` (`textarea.focusRingWidth`) | نفسه |
| معطّل | `color.disabled.border` | `color.disabled.text` |

## مرجع الرموز

| الرمز | الغرض |
| --- | --- |
| `textarea.minHeight` | الحد الأدنى للارتفاع |
| `textarea.paddingHorizontal` / `textarea.paddingVertical` | الحشو الداخلي |
| `textarea.fontSize` | حجم الخط |
| `textarea.countFontSize` | حجم خط نص العدّاد |
| `textarea.borderRadius` / `textarea.borderWidth` | زاوية الانحناء وعرض الحد |
| `textarea.focusRingWidth` | عرض حلقة التركيز |
| `color.focus` | لون حد التركيز |
| `color.text.{primary,placeholder,disabled}` | ألوان النص والإشارة النائب |
| `color.border.base` / `color.disabled.border` | ألوان الحد |
| `color.background.default` / `color.disabled.bg` | ألوان الخلفية |

## مرجع الحالات الذهبية

| case id | التأكيد | الاختبار المحلي |
| --- | --- | --- |
| `input-emits-onvaluechange` | الإدخال يُطلق `onValueChange("青花瓷")` | `testDefaultIsEditable` |
| `disabled-blocks-input` | الحالة المعطّلة لا تُطلق onValueChange | `testDisabledBlocksInput` |
| `showcount-renders-count` | العدّاد يعرض `3/10` ويستهلك رمز حجم خط العدّاد | `testShowCountRendersCount` |
| `showcount-without-maxlength-renders-length-only` | دون حد أقصى يعرض `3` فقط | `testShowCountWithoutMaxlengthRendersLengthOnly` |
| `focus-uses-focus-token` | التركيز يستهلك رمز focus ويُطلق lhOnFocus | `testFocusUsesFocusToken` |
| `maxlength-truncates-input` | تجاوز عدد الأحرف يقتطع | `testMaxlengthTruncatesInput` |

بالإضافة إلى اختبارات مخصّصة: `testLayoutUsesTextareaTokens` / `testReadonlyBlocksInputButKeepsFocusStyle` /
`testDarkColorsComeFromDarkTokens` / `testDimensionsAreIdenticalInDarkMode` /
`testTextareaViewInitAcceptsConstant`.

```bash
swift test --filter LhTextareaTests    # يعمل على مضيف macOS، دون الحاجة إلى محاكي
```

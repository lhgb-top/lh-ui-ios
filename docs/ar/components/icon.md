# أيقونة Icon

أيقونة متجهة. تُربط بالاسم المنطقي إلى رموز النظام في المنصة (SF Symbol على iOS)، ويأتي الحجم واللون كلاهما من الرموز.

> مصدر العقد: `lh-ui-core/specs/icon.json` ·
> الحالات الذهبية: `lh-ui-core/cases/icon.json` (5 حالات، مُترجمة إلى XCTest، قابلة للتشغيل على مضيف macOS)

## اللون

يحدد `tone` لون الأيقونة. يتبع `default` لون النص الرئيسي، ويأخذ `regular` / `secondary` لون النص في المستوى المقابل، وما سواها يأخذ الألوان الدلالية.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>ألوان Icon</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-icon"><svg viewBox="0 0 24 24" fill="currentColor"><path d="M12 2l2.9 6.3 6.9.8-5.1 4.7 1.4 6.8L12 17.3 5.9 20.6l1.4-6.8L2.2 9.1l6.9-.8z"/></svg></span>
      <span class="sim-icon sim-icon--primary"><svg viewBox="0 0 24 24" fill="currentColor"><path d="M12 2l2.9 6.3 6.9.8-5.1 4.7 1.4 6.8L12 17.3 5.9 20.6l1.4-6.8L2.2 9.1l6.9-.8z"/></svg></span>
      <span class="sim-icon sim-icon--success"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M4 12.5l5 5L20 6.5"/></svg></span>
    </div>
    <div class="sim-row">
      <span class="sim-icon sim-icon--warning"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 3l10 18H2z"/><path d="M12 10v5"/></svg></span>
      <span class="sim-icon sim-icon--danger"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="9"/><path d="M12 8v5M12 16.5v.5"/></svg></span>
      <span class="sim-icon sim-icon--regular"><svg viewBox="0 0 24 24" fill="currentColor"><circle cx="12" cy="12" r="8"/></svg></span>
      <span class="sim-icon sim-icon--secondary"><svg viewBox="0 0 24 24" fill="currentColor"><circle cx="12" cy="12" r="8"/></svg></span>
    </div>
  </div>
</div>
<p class="sim-note">معاينة محاكاة HTML (مظهر iOS / SwiftUI)، ليست تصييرًا على جهاز حقيقي؛ وما يُرسم على الجهاز الحقيقي هو رمز SF Symbol متجه</p>

```swift
LhIcon(name: "star", tone: .primary)
```

## الحجم

ثلاثة أحجام تُربط بالرمز `icon.size`.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>أحجام Icon</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-icon sim-icon--small sim-icon--primary"><svg viewBox="0 0 24 24" fill="currentColor"><path d="M12 2l2.9 6.3 6.9.8-5.1 4.7 1.4 6.8L12 17.3 5.9 20.6l1.4-6.8L2.2 9.1l6.9-.8z"/></svg></span>
      <span class="sim-icon sim-icon--primary"><svg viewBox="0 0 24 24" fill="currentColor"><path d="M12 2l2.9 6.3 6.9.8-5.1 4.7 1.4 6.8L12 17.3 5.9 20.6l1.4-6.8L2.2 9.1l6.9-.8z"/></svg></span>
      <span class="sim-icon sim-icon--large sim-icon--primary"><svg viewBox="0 0 24 24" fill="currentColor"><path d="M12 2l2.9 6.3 6.9.8-5.1 4.7 1.4 6.8L12 17.3 5.9 20.6l1.4-6.8L2.2 9.1l6.9-.8z"/></svg></span>
    </div>
  </div>
</div>
<p class="sim-note">معاينة محاكاة HTML (مظهر iOS / SwiftUI)، ليست تصييرًا على جهاز حقيقي</p>

## تخطيط اسم الأيقونة

`name` هو اسم منطقي محاذٍ مع سلالة الويب، ويُربط على المنصة إلى SF Symbol عبر `LhIconMap.symbol(for:)`:

| الاسم المنطقي | SF Symbol |
| --- | --- |
| `star` / `search` / `check` / `close` | `star` / `magnifyingglass` / `checkmark` / `xmark` |
| `arrow-up` / `arrow-down` / `arrow-left` / `arrow-right` | `arrow.up` / `arrow.down` / `arrow.left` / `arrow.right` |
| `refresh` / `plus` / `minus` / `eye` / `link` | `arrow.clockwise` / `plus` / `minus` / `eye` / `link` |

الأسماء غير المسجّلة لا تُرسم (تُعيد `nil`)، ولا تسبب أي انهيار.

```swift
LhIcon(name: "search", lhSize: .large, tone: .secondary) {
  // lhOnClick
}
```

## API

### Props

| Prop | الوصف | النوع | الافتراضي |
| --- | --- | --- | --- |
| `name` | الاسم المنطقي للأيقونة (يُربط بـ SF Symbol عبر `LhIconMap`) | `String` | — |
| `lhSize` | حجم الأيقونة، مرتبط برموز الأحجام | `LhIconSize` | `.medium` |
| `tone` | لون الأيقونة، مرتبط برموز ألوان النص/الدلالية | `LhIconTone` | `.default` |
| `lhOnClick` | رد النقر؛ إذا لم يُمرَّر فلا تستجيب للنقر | `(() -> Void)?` | `nil` |

### LhIconSize

| القيمة | الحجم |
| --- | --- |
| `.small` | `icon.size.small` (16pt) |
| `.medium` | `icon.size.medium` (20pt) |
| `.large` | `icon.size.large` (24pt) |

### LhIconTone

| القيمة | اللون |
| --- | --- |
| `.default` | `color.text.primary` |
| `.primary` | `color.primary.default` |
| `.success` | `color.success.default` |
| `.warning` | `color.warning.default` |
| `.danger` | `color.danger.default` |
| `.info` | `color.info.default` |
| `.regular` | `color.text.regular` |
| `.secondary` | `color.text.secondary` |

## مرجع الرموز

| الرمز | الغرض |
| --- | --- |
| `icon.size.{small,medium,large}` | ثلاثة أحجام |
| `color.text.{primary,regular,secondary}` | ألوان النص |
| `color.{primary,success,warning,danger,info}.default` | الألوان الدلالية |

## مرجع الحالات الذهبية

| case id | التأكيد | الاختبار المحلي |
| --- | --- | --- |
| `click-emits-onclick` | النقر يُطلق `lhOnClick` مرة واحدة | طبقة View عبر `onTapGesture` (تأكيدات الإيماءة تتطلب المحاكي، انظر #Preview) |
| `default-tone-uses-text-primary` | اللون الافتراضي يأخذ لون النص الرئيسي | `testDefaultToneUsesTextPrimary` |
| `primary-tone-uses-primary-token` | اللون الرئيسي يأخذ رمز اللون الرئيسي | `testPrimaryToneUsesPrimaryToken` |
| `small-size-uses-small-token` | الحجم الصغير يأخذ رمز الحجم small | `testSmallSizeUsesSmallToken` |
| `render-emits-icon-command` | رسم تعليمة أيقونة واحدة فقط | `testRegisteredIconResolvesToSymbol` / `testUnknownIconReturnsNilSymbol` |

بالإضافة إلى اختبارات مخصّصة للوضع الداكن: `testDarkColorsComeFromDarkTokens` / `testDimensionsAreIdenticalInDarkMode`.

```bash
swift test --filter LhIconTests    # يعمل على مضيف macOS، دون الحاجة إلى محاكي
```

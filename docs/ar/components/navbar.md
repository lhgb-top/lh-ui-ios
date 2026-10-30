# شريط تنقل Navbar

شريط تنقل أعلى الصفحة. عنوان متمركز في المنتصف + محتوى على الجانبين، مع خط فصل سفلي، ومستوى الطبقة مأخوذ من `zIndex.sticky`.

> مصدر العقد: `lh-ui-core/specs/navbar.json` ·
> الحالات الذهبية: `lh-ui-core/cases/navbar.json` (6 حالات، مُترجمة إلى XCTest، قابلة للتشغيل على مضيف macOS)

## الشكل الأساسي

يُعرض `title` متمركزًا (تموضع مطلق، لا يتداخل مع محتوى الجانبين)؛ ويلتصق `leftText` / `rightText` بالجانبين.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Navbar الأساسي</span></div>
  <div class="sim-navbar sim-navbar--bordered">
    <span class="sim-navbar__side">رجوع</span>
    <span class="sim-navbar__title">青花瓷</span>
    <span class="sim-navbar__side">المزيد</span>
  </div>
  <div class="sim-screen">
    <div class="sim-row"><span class="sim-tag sim-tag--primary">محتوى الصفحة</span></div>
  </div>
</div>
<p class="sim-note">معاينة محاكاة HTML (مظهر iOS / SwiftUI)، ليست تصييرًا على جهاز حقيقي</p>

```swift
LhNavbar(
  title: "青花瓷",
  leftText: "رجوع",
  rightText: "المزيد",
  onLeftClick: { /* رجوع */ },
  onRightClick: { /* المزيد */ }
)
```

## الأيقونة والحد

يُربط `leftIcon` / `rightIcon` عبر `LhIconMap`، ويُعرضان جنبًا إلى جنب مع النص؛ ويزيل `bordered = false` خط الفصل السفلي.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>أيقونات Navbar</span></div>
  <div class="sim-navbar">
    <span class="sim-navbar__side">
      <span class="sim-navbar__icon"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M15 5l-7 7 7 7"/></svg></span>
      <span>رجوع</span>
    </span>
    <span class="sim-navbar__title">عنوان</span>
    <span class="sim-navbar__side">
      <span>إعدادات</span>
      <span class="sim-navbar__icon"><svg viewBox="0 0 24 24" fill="currentColor"><circle cx="12" cy="12" r="8"/></svg></span>
    </span>
  </div>
  <div class="sim-screen">
    <div class="sim-row"><span class="sim-tag">شريط تنقل بلا حدود</span></div>
  </div>
</div>
<p class="sim-note">معاينة محاكاة HTML (مظهر iOS / SwiftUI)، ليست تصييرًا على جهاز حقيقي</p>

## بوابة النقر

عند عدم توفير `leftText` / `leftIcon` لا يستجيب الجانب المقابل للنقر (حالة ذهبية `no-left-content-no-onleftclick`)،
وكذلك الحال بالنسبة للجانب الآخر. ويُترك التموضع العائم لاستدعاء المكوّن عبر `.overlay` (وفق العرف في SwiftUI)، بينما يوفّر المكوّن نفسه مستوى طبقة `zIndex.sticky`.

```swift
ZStack {
  contentView
    .padding(.top, LhTokens.Navbar.height)
  LhNavbar(title: "青花瓷", leftText: "رجوع", onLeftClick: { dismiss() })
    .overlay(alignment: .top) { ... }
}
```

## API

### Props

| Prop | الوصف | النوع | الافتراضي |
| --- | --- | --- | --- |
| `title` | العنوان المتمركز | `String` | `""` |
| `leftText` | نص الجانب (إذا كان فارغًا ولا يوجد leftIcon لا يستجيب للنقر) | `String` | `""` |
| `leftIcon` | الاسم المنطقي لأيقونة الجانب (ربط `LhIconMap`) | `String?` | `nil` |
| `rightText` | نص الجانب الآخر (إذا كان فارغًا ولا يوجد rightIcon لا يستجيب للنقر) | `String` | `""` |
| `rightIcon` | الاسم المنطقي لأيقونة الجانب الآخر | `String?` | `nil` |
| `bordered` | عرض خط الفصل السفلي أم لا | `Bool` | `true` |
| `onLeftClick` | رد النقر على الجانب | `(() -> Void)?` | `nil` |
| `onRightClick` | رد النقر على الجانب الآخر | `(() -> Void)?` | `nil` |

### الألوان

| المنطقة | اللون |
| --- | --- |
| الخلفية | `color.background.default` |
| العنوان / نصوص الجانبين / الأيقونات | `color.text.primary` |
| خط الفصل | `color.border.lighter` (العرض مأخوذ من `navbar.borderWidth`) |

## مرجع الرموز

| الرمز | الغرض |
| --- | --- |
| `navbar.height` | ارتفاع شريط التنقل (44pt) |
| `navbar.paddingHorizontal` | الحشو الأفقي للجانبين (12pt) |
| `navbar.titleFontSize` | حجم خط العنوان ونصوص الجانبين (16pt) |
| `navbar.iconSize` | حجم أيقونتي الجانبين (20pt) |
| `navbar.borderWidth` | عرض خط الفصل السفلي |
| `color.border.lighter` | لون خط الفصل |
| `color.text.primary` | لون العنوان ومحتوى الجانبين |
| `color.background.default` | لون الخلفية |
| `zIndex.sticky` | مستوى الطبقة العائمة |

## مرجع الحالات الذهبية

| case id | التأكيد | الاختبار المحلي |
| --- | --- | --- |
| `title-renders-text` | يُعرض العنوان صحيحًا | `testTitleUsesNavbarTokens` |
| `leftclick-emits-onleftclick` | النقر على الجانب يُطلق onLeftClick | `testLeftContentIsClickable` |
| `rightclick-emits-onrightclick` | النقر على الجانب الآخر يُطلق onRightClick | `testRightContentIsClickable` |
| `no-left-content-no-onleftclick` | عند عدم وجود محتوى في الجانب لا يُطلق | `testNoLeftContentIsNotClickable` |
| `bordered-uses-border-token` | خط الفصل يستهلك الرمز border.lighter | `testBorderedUsesBorderToken` |
| `height-uses-navbar-height-token` | الارتفاع يستهلك الرمز navbar.height | `testHeightUsesNavbarHeightToken` |

بالإضافة إلى اختبارات مخصّصة: `testContainerUsesBackgroundToken` / `testDarkColorsComeFromDarkTokens` /
`testDimensionsAreIdenticalInDarkMode` / `testNavbarInitAndRender`.

```bash
swift test --filter LhNavbarTests    # يعمل على مضيف macOS، دون الحاجة إلى محاكي
```

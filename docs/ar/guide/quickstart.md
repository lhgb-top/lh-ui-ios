# البدء السريع

## أصغر مثال

```swift
import SwiftUI
import LhUI

struct Demo: View {
  var body: some View {
    LhTheme {
      LhButton(
        lhOnClick: { /* معالجة النقر */ },
        type: .primary,
        text: "زر رئيسي"
      )
    }
  }
}
```

`LhTheme` هو حاوية السمات: تستهلك جميع مكوّنات Lh داخله الرموز تلقائيًا عبر Environment؛ وعند عدم وجود الغلاف يُرجَع إلى لوحة الألوان الفاتحة.

## الأنواع والأحجام

```swift
// ستة أنواع
LhButton(lhOnClick: {}, text: "افتراضي")                      // .default
LhButton(lhOnClick: {}, type: .primary, text: "رئيسي")
LhButton(lhOnClick: {}, type: .success, text: "نجاح")
LhButton(lhOnClick: {}, type: .warning, text: "تحذير")
LhButton(lhOnClick: {}, type: .danger, text: "خطر")
LhButton(lhOnClick: {}, type: .info, text: "معلومات")

// ثلاثة أحجام
LhButton(lhOnClick: {}, lhSize: .small, text: "صغير")
LhButton(lhOnClick: {}, lhSize: .medium, text: "متوسط")
LhButton(lhOnClick: {}, lhSize: .large, text: "كبير")
```

## الحالات

```swift
// معطّل: لا يستجيب للنقر، ويعرض المظهر المعطّل
LhButton(lhOnClick: {}, disabled: true, text: "معطّل")

// أثناء التحميل: يعرض مؤشرًا ولا يُطلق lhOnClick
LhButton(lhOnClick: {}, loading: true, text: "جارٍ التحميل")

// اجتماعهما: تُعالَج التعطيل كأولوية (الحالة الذهبية disabled-precedes-loading)
LhButton(lhOnClick: {}, disabled: true, loading: true, text: "التعطيل أولى")
```

## الأيقونة وخلفية النمط

```swift
// يُحلّ اسم الأيقونة وفق نظام الأيقونات المحلي (مطابقة SF Symbol في LhButtonStyle.icon(for:)، والأسماء غير المسجّلة لا تُرسم)
LhButton(lhOnClick: {}, type: .primary, icon: "search", text: "بحث")

// خلفية النمط الصيني (تستهلك الرمز color.decoration)
LhButton(lhOnClick: {}, type: .primary, bgPattern: true, text: "نمط زخرفي")
```

## السمتان الفاتحة والداكنة

```swift
LhTheme(isDark: isDark) {
  // تنتقل جميع المكوّنات الداخلية تلقائيًا إلى الرموز الداكنة (قيم مُحسوبة مسبقًا في core، دون مزج ألوان وقت التشغيل)
}
```

## معاينة أمثلة المكوّنات

لا يمكن تصيير واجهة المستخدم الأصلية في المتصفح لحظيًا، لذا يعرض هذا الموقع المظهر عبر **محاكي بإطار هاتفي من HTML ثابت مضمّن**:

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>lh-ui-ios</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <button class="sim-btn">زر افتراضي</button>
      <button class="sim-btn sim-btn--primary">زر رئيسي</button>
      <button class="sim-btn sim-btn--success">نجاح</button>
      <button class="sim-btn sim-btn--warning">تحذير</button>
      <button class="sim-btn sim-btn--danger">خطر</button>
      <button class="sim-btn sim-btn--info">معلومات</button>
    </div>
    <div class="sim-row">
      <button class="sim-btn sim-btn--small">صغير</button>
      <button class="sim-btn sim-btn--primary sim-btn--large">كبير</button>
      <button class="sim-btn sim-btn--primary sim-btn--disabled">معطّل</button>
      <button class="sim-btn sim-btn--primary sim-btn--loading">
        <span class="sim-btn__spinner"></span>جارٍ التحميل
      </button>
    </div>
    <div class="sim-row">
      <button class="sim-btn sim-btn--primary"><span class="sim-btn__icon"></span>بحث</button>
      <button class="sim-btn sim-btn--primary sim-btn--pattern">نمط زخرفي</button>
    </div>
  </div>
</div>
<p class="sim-note">معاينة محاكاة HTML (مظهر iOS / SwiftUI)، ليست تصييرًا على جهاز حقيقي؛ جميع قيم الأنماط مأخوذة من لقطة الرموز في core، بنفس المصدر والقيم كما على الجهاز الحقيقي. المظهر على الجهاز الحقيقي يحتكم إلى <code>#Preview</code> ولقطات الشاشة من الجهاز.</p>

> الوضع الداكن للمحاكي مرتبط بالموقع: بدّل السمة من الزاوية العلوية فتتغيّر ألوان إطار الهاتف (الرموز الداكنة مُحسوبة مسبقًا في core).

# السمات والوضع الداكن

## نموذج الرموز

المصدر الأصلي لرموز السلالة الأصلية موجود في `lh-ui-core/tokens/*.json`، ويولّد codegen منتجات iOS:

| المنتج | المحتوى | الشكل الداكن |
| --- | --- | --- |
| `LhTokens` | الفاتح الكامل: أبعاد Button، لوحة Color، Motion، Radius، Shadow، Spacing، Typography، ZIndex | — |
| `LhDarkTokens` | الكائن الفرعي `Color` فقط (نموذج **الكائنات المتوازية**) | الداكن يغطّي الألوان فقط؛ الأبعاد والحركات وزوايا الانحناء ثابتة في الداكن |
| `LhShadow` | بنية حاملة الظل في SwiftUI (color/opacity/radius/x/y) | — |

> هذا متّسق مع android / harmony / windows (كائنات متوازية)، ويختلف عن جهة التوثيق (دمج JSON سطحي).
> صُمّمت طبقة السمات بناءً على ذلك: `LhColors` يحمل الألوان فقط، وتُؤخذ الأبعاد من `LhTokens` مباشرةً داخل المكوّنات.

## LhColors

`LightLhColors` / `DarkLhColors` تسطّحان التعدادين المولّدين في نوع قيمة `Equatable`:

```swift
public struct LhColors: Equatable {
  public let primary: Color
  public let onPrimary: Color
  // ... جميع الألوان الدلالية
}

public let LightLhColors = LhColors(primary: LhTokens.Color.Primary.`default`, /* ... */)
public let DarkLhColors = LhColors(primary: LhDarkTokens.Color.Primary.`default`, /* ... */)
```

المُنشئ عام: يمكن لاختبارات الوحدة بناء لوحة الألوان مباشرةً للقيام بالتأكيدات؛ أما في جانب التطبيق فيجب أن يتم الاستهلاك عبر `LhTheme`.

## LhTheme

```swift
LhTheme(isDark: true) {
  // يحقن Environment(\.lhColors) قيمة DarkLhColors، وتستهلكها المكوّنات الداخلية تلقائيًا
}
```

عند عدم وجود غلاف `LhTheme`، ترجع القيمة الافتراضية لمفتاح Environment إلى `LightLhColors` (الفاتح هو الافتراضي).

## الحساب المسبق للوضع الداكن (مهم)

يُقيَّم الوضع الداكن في سلالة الويب ديناميكيًا بدالة CSS `color-mix()`، ولا يوجد تسلسل CSS على الجانب الأصلي، لذا قام core بحساب التعبيرات الداكنة **مسبقًا كقيم حرفية** (مثل `rgba(61,100,158,0.25)` و`#B1C1D8`). النتيجة (الخطة الرئيسية R-n6):

> **عند تعديل اللون الرئيسي للمسبق، لا تتبع القيم الداكنة المحسوبة مسبقًا التغيير تلقائيًا**، بل يجب إعادة حسابها يدويًا وتحديث
> `lh-ui-core/tokens/color-dark.json`، ثم تحديث *خط أساس لغة التصميم*.

## اصطلاحات خاصة بـ iOS

- **وحدة المدة هي الثانية**: `LhTokens.Motion.Duration.base = 0.300` (أما android / harmony فيستخلمان المللي ثانية، وكذلك C)،
  وتستهلكها واجهات حركة SwiftUI مباشرةً دون تحويل.
- **التعبير عن الألوان**: المنتجات المولّدة تستخدم RGB مُطبَّعًا (`SwiftUI.Color(red:green:blue:)` + `.opacity()`)،
  دون سلاسل hex.
- **زوايا الانحناء**: `Radius.circle` هي كسر بقيمة 0.5، ويُحسب على الجهاز كـ `min(العرض، الارتفاع)/2`، فلا يمكن استعماله كـ pt.
- **الظل**: لا يدعم SwiftUI مقدار الانتشار (spread)، وقد تجاهله `LhShadow` المولّد مع إضافة تعليق.
- **الخط**: `Typography.fontFamily` سلسلة رصة الخطوط، ويُؤخذ على الجهاز أول عائلة متوفرة؛ وserif ذو النمط الصيني هو الطابع الافتراضي.

## استعلام سريع للرموز

جدول الرموز الكامل (فاتح / داكن / الوصف) موجود في `dist/docs/tokens.md` داخل مستودع core (يُولَّد بعد `pnpm codegen`).
ولمطابقة الرموز على مستوى المكوّن راجع [مرجع الرموز لزر Button](/ar/components/button#مرجع-الرموز).

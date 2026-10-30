# التثبيت

## متطلبات البيئة

- Xcode 15+، Swift 5.9+
- iOS 15.0+ (macOS 12+ فقط لتشغيل XCTest على المضيف)
- سلسلة أدوات وقت البناء: Node.js >= 20 + pnpm (تُستخدم فقط لربط الرموز وموقع التوثيق، **ولا تدخل وقت التشغيل**)

## الدمج عبر SPM

في Xcode: File → Add Package Dependencies…، أدخل عنوان هذا المستودع؛ أو حرّر `Package.swift` مباشرة:

```swift
dependencies: [
  .package(url: "https://github.com/lhgb-top/lh-ui-ios", from: "0.0.1")
],
targets: [
  .target(name: "MyApp", dependencies: [.product(name: "LhUI", from: "lh-ui-ios")])
]
```

هدف الرموز `LhUITokens` مُضمَّن تلقائيًا مع تبعية `LhUI` (target ضمن حزمة SPM، لا حاجة إلى تعريفه منفصلًا).

## مزامنة الرموز (عند تطوير هذا المستودع من المصدر)

الرموز نتاج توليد، ويجب مزامنتها من `lh-ui-core` (المصدر الأصلي، ويُمنع التعديل اليدوي):

```bash
cd ../lh-ui-core && pnpm codegen   # يولّد منتجات رموز dist/ios
cd ../lh-ui-ios
pnpm install                        # يثبّت سلسلة أدوات وقت البناء
pnpm link:tokens                    # يزامن الرموز إلى Sources/LhUITokens/
```

يتضمن `pnpm link:tokens` حارس وجود من ثلاث مستويات: `../lh-ui-core/dist/ios` المحلي ← منتج npm الخاص بـ `@lh-ui/core` ← خطأ.

## التحقق من التثبيت

```bash
swift build        # ترجمة
swift test         # الحالات الذهبية (تعمل على مضيف macOS، دون الحاجة إلى محاكي)
```

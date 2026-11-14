# ⏳ المهام المؤجلة: دعم اتجاه الواجهات (RTL) وضبط ارتفاع السطور

تم تأجيل هذه المهام بناءً على خطة العمل لفصل التحسينات التخطيطية المتقدمة عن الخطوات الأساسية لإضافة ودعم نصوص اللغة العربية عبر `slang`.

---

## 1. دعم اتجاه الواجهات الكامل (RTL & Directionality)

### أ. تحويل الهوامش والمحاذاة المباشرة إلى Directional
في الواجهات المعقدة وعند تفعيل اللغة العربية، يجب فحص الشاشات واستبدال الهوامش الثابتة:
* **الهوامش والحشوات (Padding & Margins):**
  * استبدال `EdgeInsets.only(left: ..., right: ...)` بـ `EdgeInsetsDirectional.only(start: ..., end: ...)`.
  * استبدال `EdgeInsets.fromLTRB(...)` بـ `EdgeInsetsDirectional.fromSTEB(...)`.
* **المحاذاة (Alignment):**
  * استبدال `Alignment.centerLeft / centerRight` بـ `AlignmentDirectional.centerStart / centerEnd`.
  * استبدال `Alignment.topLeft / topRight` بـ `AlignmentDirectional.topStart / topEnd`.
* **العناصر المتموضعة (Positioned in Stack):**
  * استبدال `Positioned(left: ..., right: ...)` بـ `PositionedDirectional(start: ..., end: ...)`.

---

### ب. عكس اتجاه الأيقونات والأسهم (Icon Flipping / Mirroring)
* **زر الرجوع [`BackButtonWidget`](file:///E:/flutter/assignments/doctor_hunt/lib/apps/core/widgets/back_button_widget.dart):**
  * يستخدم حالياً `Icons.arrow_back_ios` مع إزاحة ثابتة (حشو من جهة اليسار).
  * المطلوب مستقبلاً: جعل الأيقونة تنعكس في العربية لتشير إلى اليمين (عبر `Icons.adaptive.arrow_back` أو فحص `Directionality.of(context)` أو `Transform.flip`).
* **أسهم القوائم والإعدادات (`Icons.arrow_forward_ios_rounded`):**
  * في الشاشات الإنجليزية تشير إلى اليمين، وفي الواجهة العربية يجب أن تشير إلى اليسار للإشارة إلى الدخول للشاشة التالية.
* **الأيقونات التي لا يجب عكسها:**
  * البحث، الهاتف، علامات التوثيق، القلب (المفضلة)، ومؤشرات التقييم بالنجوم.

---

### ج. فحص وتوافقية مكتبات الـ UI الخارجية (Third-Party Packages)
* **`kf_drawer` في [`PatientMainScreen`](file:///E:/flutter/assignments/doctor_hunt/lib/apps/features/patient/main_screen/presentation/screens/patient_main_screen.dart):**
  * مكتبة الـ 3D Drawer تعتمد حركتها الافتراضية على الانزلاق من اليسار لليمين.
  * المطلوب: فحص سلوكها في وضع الـ RTL للتأكد من انزلاق القائمة من اليمين أو ضبط الـ Controller والتحريك الخاص بها.
* **`calendar_date_picker2`:**
  * فحص اتجاه حركة التقويم وتنسيق أعمدة أيام الأسبوع أفقياً من اليمين لليسار في العربية.
* **`buttons_tabbar`:**
  * التحقق من اتجاه ترتيب التبويبات عند التمرير الأفقي في الـ RTL.
* **`cupertino_onboarding`:**
  * التحقق من اتجاه السحب (Swipe gestures) وترتيب صفحات التعريف.

---

## 2. ضبط ارتفاع السطور في التايبوجرافي (Line-Height Adjustments)

* **المشكلة التي تم تأجيل معالجتها:**
  * في بعض الخطوط العربية الكلاسيكية، تلتصق حركات التشكيل (الفتحة والضمة والكسرة) ونقاط الحروف في الجزء العلوي أو السفلي عند استخدام `height` ضيق أو خطوط مصممة للأبجدية اللاتينية.
* **الإجراء المؤجل:**
  * زيادة طفيفة لارتفاع السطور `height: 1.25 - 1.4` في العناوين والـ `TextFormField` في حال ملاحظة أي قص في أطراف الأحرف بعد تطبيق الخط العربي المختار.

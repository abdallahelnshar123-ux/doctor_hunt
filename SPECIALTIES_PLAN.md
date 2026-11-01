# خطة عمل: نظام التخصصات الديناميكية (Dynamic Specialties Logic Plan)

## 1. ملخص المتطلبات والقرارات
- **الهدف**: بناء طبقة البيانات وإدارة الحالة (Logic & Data Layer) الخاصة بالتخصصات الطبية بدون بناء أي واجهات (No UI).
- **مكان الكود**: `lib/apps/features/common/specialties/` (ميزة مشتركة بين جميع الأدوار).
- **اللغات المدعومة**: لغتان فقط (العربية والإنجليزية) بمتغيرات مسماة `en` و `ar`.
- **معرّف التخصص (`id`)**: مولّد تلقائياً من القيمة الإنجليزية `en` بحروف صغيرة فقط (lowercase) واستبدال المسافات بشرطة سفلية `_`.
- **بدون أيقونات**: نصوص وبيانات فقط.
- **بدون `isActive`**: لا يوجد حقل تفعيل/تعطيل، ولا يوجد حذف نهائي (فقط إضافة وتعديل).
- **استراتيجية التخزين**: قراءة عبر `Source.serverAndCache` للاستفادة من الكاش المحلي ومزامنة السيرفر فور توفر الإنترنت.

---

## 2. هيكل البيانات في Firestore
- **اسم الـ Collection**: `specialties`
- **شكل الـ Document**:
```json
{
  "id": "cardiology",
  "en": "Cardiology",
  "ar": "أمراض القلب",
  "created_at": "2026-10-30T15:00:00Z",
  "updated_at": "2026-10-30T15:00:00Z"
}
```

---

## 3. خطوات التنفيذ

### الخطوة 1: الثوابت (Firestore Constants)
- المسار: `lib/apps/core/constants/firestore_constants.dart`
- إضافة الثوابت:
  - `specialtiesCollection = 'specialties'`
  - الحقول: `specialtyId`, `specialtyEn`, `specialtyAr`, `createdAt`, `updatedAt`.

### الخطوة 2: نموذج البيانات (Specialty Model)
- المسار: `lib/apps/features/common/specialties/data/models/specialty_model.dart`
- الخصائص:
  - `final String id;`
  - `final String en;`
  - `final String ar;`
  - `final DateTime? createdAt;`
  - `final DateTime? updatedAt;`
- الدوال:
  - `fromFirestore(DocumentSnapshot doc)`
  - `toMap()`
  - `localizedName(String langCode)`: تُرجع `ar` إذا كانت اللغة الحالية عربي، وغير ذلك تُرجع `en`.

### الخطوة 3: خدمة البيانات (Specialty Service)
- المسار: `lib/apps/features/common/specialties/data/service/specialty_service.dart`
- مع وسم `@lazySingleton`.
- العمليات:
  - `getSpecialties()`: قراءة التخصصات باستخدام `GetOptions(source: Source.serverAndCache)`.
  - `addSpecialty(SpecialtyModel specialty)`: حفظ التخصص باستخدام `set()` مع التأكد من عدم تكرار الـ ID.
  - `updateSpecialty(SpecialtyModel specialty)`: تحديث `en`, `ar`, و `updated_at`.

### الخطوة 4: المستودع (Specialty Repository)
- المسار: `lib/apps/features/common/specialties/data/repo/specialty_repository.dart`
- مع وسم `@lazySingleton` وبدون واجهات مجردة (Concrete class مباشرة حسب `AGENTS.md`).
- نوع المخرجات: `Future<Either<Failure, T>>`.
- صيد الأخطاء وتحويلها لـ `ServerFailure` أو `NetworkFailure`.

### الخطوة 5: إدارة الحالة (Specialties BLoC)
- المسار: `lib/apps/features/common/specialties/presentation/controller/`
  - `specialties_event.dart`:
    - `GetSpecialtiesEvent({bool forceRefresh})`
    - `AddSpecialtyEvent({required String en, required String ar})`
    - `UpdateSpecialtyEvent(SpecialtyModel specialty)`
  - `specialties_state.dart`:
    - `isLoading`, `specialties`, `errorMessage`, `operationSuccess`.
  - `specialties_bloc.dart`:
    - `@lazySingleton` أو `@injectable`.
    - معالجة الأحداث والاحتفاظ بالقائمة محلياً في الذاكرة.

### الخطوة 6: توليد الأكواد (Code Generation)
- تشغيل:
  ```bash
  dart run build_runner build 
  ```
  لتسجيل الـ Service والـ Repo والـ BLoC في الـ DI (`di.config.dart`).

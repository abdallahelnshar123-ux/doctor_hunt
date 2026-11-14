///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'translations.g.dart';

// Path: <root>
class TranslationsAr extends Translations with BaseTranslations<AppLocale, Translations> {
  /// You can call this constructor and build your own translation instance of this locale.
  /// Constructing via the enum [AppLocale.build] is preferred.
  TranslationsAr({
    Map<String, Node>? overrides,
    PluralResolver? cardinalResolver,
    PluralResolver? ordinalResolver,
    TranslationMetadata<AppLocale, Translations>? meta,
  }) : assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
       _meta =
           meta ??
           TranslationMetadata(
             locale: AppLocale.ar,
             overrides: overrides ?? {},
             cardinalResolver: cardinalResolver,
             ordinalResolver: ordinalResolver,
           ),
       super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver);

  /// Metadata for the translations of <ar>.
  final TranslationMetadata<AppLocale, Translations> _meta;
  @override
  TranslationMetadata<AppLocale, Translations> get $meta => _meta;

  late final TranslationsAr _root = this; // ignore: unused_field

  @override
  TranslationsAr $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsAr(meta: meta ?? this.$meta);

  // Translations
  @override
  late final _Translations$auth$ar auth = _Translations$auth$ar._(_root);
  @override
  late final _Translations$forgotPassword$ar forgotPassword = _Translations$forgotPassword$ar._(_root);
  @override
  late final _Translations$onboarding$ar onboarding = _Translations$onboarding$ar._(_root);
  @override
  late final _Translations$chooseRole$ar chooseRole = _Translations$chooseRole$ar._(_root);
  @override
  late final _Translations$patientMain$ar patientMain = _Translations$patientMain$ar._(_root);
  @override
  late final _Translations$patientAppointments$ar patientAppointments = _Translations$patientAppointments$ar._(_root);
  @override
  late final _Translations$selectTime$ar selectTime = _Translations$selectTime$ar._(_root);
  @override
  late final _Translations$home$ar home = _Translations$home$ar._(_root);
  @override
  late final _Translations$favouriteDoctors$ar favouriteDoctors = _Translations$favouriteDoctors$ar._(_root);
  @override
  late final _Translations$settings$ar settings = _Translations$settings$ar._(_root);
  @override
  late final _Translations$profile$ar profile = _Translations$profile$ar._(_root);
  @override
  late final _Translations$privacyPolicy$ar privacyPolicy = _Translations$privacyPolicy$ar._(_root);
  @override
  late final _Translations$doctorDetails$ar doctorDetails = _Translations$doctorDetails$ar._(_root);
  @override
  late final _Translations$appointment$ar appointment = _Translations$appointment$ar._(_root);
  @override
  late final _Translations$createDoctor$ar createDoctor = _Translations$createDoctor$ar._(_root);
  @override
  late final _Translations$common$ar common = _Translations$common$ar._(_root);
  @override
  late final _Translations$dialog$ar dialog = _Translations$dialog$ar._(_root);
  @override
  late final _Translations$admin$ar admin = _Translations$admin$ar._(_root);
  @override
  late final _Translations$errors$ar errors = _Translations$errors$ar._(_root);
  @override
  late final _Translations$validators$ar validators = _Translations$validators$ar._(_root);
  @override
  late final _Translations$eCodes$ar eCodes = _Translations$eCodes$ar._(_root);
  @override
  late final _Translations$doctor$ar doctor = _Translations$doctor$ar._(_root);
}

// Path: auth
class _Translations$auth$ar extends Translations$auth$en {
  _Translations$auth$ar._(TranslationsAr root) : this._root = root, super.internal(root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get welcomeBack => 'مرحباً بعودتك';
  @override
  String get authSubtitle => 'يمكنك البحث عن دورات، التقديم عليها وإيجاد منح للدراسة بالخارج';
  @override
  String get adminSubtitle => 'تسجيل الدخول إلى حساب المسؤول';
  @override
  String get forgotPassword => 'نسيت كلمة المرور';
  @override
  String get noAccount => 'ليس لديك حساب؟ انضم إلينا';
  @override
  String get login => 'تسجيل الدخول';
  @override
  String get joinUs => 'انضم إلينا للبدء في البحث';
  @override
  String get haveAccount => 'لديك حساب بالفعل؟ سجل دخولك';
  @override
  String get agreeTerms => 'أوافق على شروط الخدمة وسياسة الخصوصية';
  @override
  String get signUp => 'إنشاء حساب';
  @override
  String get username => 'اسم المستخدم';
  @override
  String get password => 'كلمة المرور';
  @override
  String get google => 'جوجل';
  @override
  String get youMustAgreeToTerms => 'يجب أن توافق على شروط الخدمة وسياسة الخصوصية';
  @override
  String get email => 'البريد الإلكتروني';
  @override
  String get doctorSubtitle => 'تسجيل الدخول إلى حساب الطبيب';
}

// Path: forgotPassword
class _Translations$forgotPassword$ar extends Translations$forgotPassword$en {
  _Translations$forgotPassword$ar._(TranslationsAr root) : this._root = root, super.internal(root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'نسيت كلمة المرور';
  @override
  String get email => 'البريد الإلكتروني';
  @override
  String get description => 'أدخل بريدك الإلكتروني وسنرسل لك رابطاً لإعادة تعيين كلمة المرور.';
  @override
  String get sendLink => 'إرسال الرابط';
  @override
  String get successDialogMessage =>
      'لقد أرسلنا بريداً إلكترونياً لإعادة تعيين كلمة المرور الخاصة بك. يرجى مراجعة صندوق الوارد أو البريد العشوائي (Spam).';
}

// Path: onboarding
class _Translations$onboarding$ar extends Translations$onboarding$en {
  _Translations$onboarding$ar._(TranslationsAr root) : this._root = root, super.internal(root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get next => 'التالي';
  @override
  String get skip => 'تخطي';
  @override
  String get getStarted => 'ابدأ الآن';
  @override
  List<PageData> get pages => [
    _Translations$onboarding$pages$0$ar._(_root),
    _Translations$onboarding$pages$1$ar._(_root),
    _Translations$onboarding$pages$2$ar._(_root),
  ];
}

// Path: chooseRole
class _Translations$chooseRole$ar extends Translations$chooseRole$en {
  _Translations$chooseRole$ar._(TranslationsAr root) : this._root = root, super.internal(root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'دكتور هانت';
  @override
  String get roleSelection => 'اختر دورك';
  @override
  late final _Translations$chooseRole$patient$ar patient = _Translations$chooseRole$patient$ar._(_root);
  @override
  late final _Translations$chooseRole$admin$ar admin = _Translations$chooseRole$admin$ar._(_root);
  @override
  late final _Translations$chooseRole$doctor$ar doctor = _Translations$chooseRole$doctor$ar._(_root);
}

// Path: patientMain
class _Translations$patientMain$ar extends Translations$patientMain$en {
  _Translations$patientMain$ar._(TranslationsAr root) : this._root = root, super.internal(root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get home => 'الرئيسية';
  @override
  String get settings => 'الإعدادات';
  @override
  String get appointments => 'المواعيد';
  @override
  String get favourite => 'المفضلة';
}

// Path: patientAppointments
class _Translations$patientAppointments$ar extends Translations$patientAppointments$en {
  _Translations$patientAppointments$ar._(TranslationsAr root) : this._root = root, super.internal(root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'المواعيد';
  @override
  String get upcoming => 'القادمة';
  @override
  String get completed => 'المكتملة';
  @override
  String get canceled => 'الملغاة';
  @override
  String get viewDetails => 'عرض التفاصيل';
  @override
  String get cancelAppointment => 'إلغاء الموعد';
  @override
  String get rateDoctor => 'تقييم الطبيب';
  @override
  String get appointmentDate => 'تاريخ الموعد';
  @override
  String get consultationFee => 'رسوم الاستشارة';
  @override
  String get appointmentTime => 'وقت الموعد';
  @override
  String feeValue({required Object Fee}) => '${Fee} \$';
  @override
  String get noAppointmentsFound => 'لا توجد مواعيد';
  @override
  String get tabToWriteReview => 'اضغط لكتابة تقييم';
  @override
  String get youMustSelectAtLeastOneStar => 'يجب تحديد نجمة واحدة على الأقل';
}

// Path: selectTime
class _Translations$selectTime$ar extends Translations$selectTime$en {
  _Translations$selectTime$ar._(TranslationsAr root) : this._root = root, super.internal(root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'تحديد الوقت';
  @override
  String get noSlotsAvailable => 'لا تتوفر فترات متاحة';
  @override
  String slotAvailable({required Object Number}) => '${Number} موعد متاح';
  @override
  String morningSlots({required Object Number}) => 'الفترة الصباحية: ${Number} مواعيد';
  @override
  String afternoonSlots({required Object Number}) => 'فترة الظهيرة: ${Number} مواعيد';
  @override
  String eveningSlots({required Object Number}) => 'الفترة المسائية: ${Number} مواعيد';
  @override
  String get confirm => 'تأكيد';
  @override
  String get youMustSelectAppointmentTime => 'يجب اختيار وقت الموعد';
}

// Path: home
class _Translations$home$ar extends Translations$home$en {
  _Translations$home$ar._(TranslationsAr root) : this._root = root, super.internal(root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String welcome({required Object Name}) => 'أهلاً ${Name}';
  @override
  String get findDoctor => 'ابحث عن طبيبك';
  @override
  String get popularDoctors => 'الأطباء الأكثر طلباً';
  @override
  String get favouriteDoctors => 'الأطباء المفضلون';
  @override
  String get topRatedDoctors => 'الأعلى تقييماً';
  @override
  String get seeAll => 'عرض الكل';
  @override
  String get search => 'بحث...';
}

// Path: favouriteDoctors
class _Translations$favouriteDoctors$ar extends Translations$favouriteDoctors$en {
  _Translations$favouriteDoctors$ar._(TranslationsAr root) : this._root = root, super.internal(root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get noFavouriteDoctorsMatchSearch => 'لا يوجد أطباء مفضلون يطابقون البحث';
  @override
  String get noFavouriteDoctorsDescription => 'لم تقم بإضافة أي طبيب إلى المفضلة بعد.';
}

// Path: settings
class _Translations$settings$ar extends Translations$settings$en {
  _Translations$settings$ar._(TranslationsAr root) : this._root = root, super.internal(root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'الإعدادات';
  @override
  String get logout => 'تسجيل الخروج';
  @override
  String get accountSettings => 'إعدادات الحساب';
  @override
  String get changePassword => 'تغيير كلمة المرور';
  @override
  String get notifications => 'الإشعارات';
  @override
  String get privacyPolicy => 'سياسة الخصوصية';
  @override
  String get moreOptions => 'خيارات إضافية';
  @override
  String get language => 'اللغة';
  @override
  String get buildVersion => 'إصدار التطبيق';
  @override
  String get english => 'الإنجليزية';
  @override
  String get arabic => 'العربية';
  @override
  String get v100 => 'v1.0.0';
  @override
  String get logoutConfirmation => 'هل أنت متأكد من رغبتك في تسجيل الخروج؟';
}

// Path: profile
class _Translations$profile$ar extends Translations$profile$en {
  _Translations$profile$ar._(TranslationsAr root) : this._root = root, super.internal(root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'الملف الشخصي';
  @override
  String get personalInformation => 'المعلومات الشخصية';
  @override
  String get name => 'الاسم';
  @override
  String get phone => 'رقم الهاتف';
  @override
  String get dataWasUpdatedSuccessfully => 'تم تحديث البيانات بنجاح';
  @override
  String get addPhoneNumber => 'إضافة رقم هاتف';
}

// Path: privacyPolicy
class _Translations$privacyPolicy$ar extends Translations$privacyPolicy$en {
  _Translations$privacyPolicy$ar._(TranslationsAr root) : this._root = root, super.internal(root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'سياسة الخصوصية';
  @override
  String get lastUpdated => 'آخر تحديث: أكتوبر 2026';
  @override
  String get introduction =>
      'يحترم تطبيق دكتور هانت خصوصيتك ويلتزم بحماية بياناتك الشخصية والطبية. توضح سياسة الخصوصية هذه كيفية جمع معلوماتك واستخدامها وحمايتها عند استخدام تطبيقنا.';
  @override
  late final _Translations$privacyPolicy$sections$ar sections = _Translations$privacyPolicy$sections$ar._(_root);
}

// Path: doctorDetails
class _Translations$doctorDetails$ar extends Translations$doctorDetails$en {
  _Translations$doctorDetails$ar._(TranslationsAr root) : this._root = root, super.internal(root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'تفاصيل الطبيب';
  @override
  String get findDoctors => 'البحث عن الأطباء';
  @override
  String get bookNow => 'احجز الآن';
  @override
  String get services => 'الخدمات';
  @override
  List<String> get servicesList => [
    'رعاية المرضى يجب أن تكون الأولوية القصوى.',
    'إذا كنت تدير عيادتك الخاصة، فأنت تعرف حجم المسؤولية.',
    'لهذا السبب نوفر نظام تذكير متقدم بالمواعيد.',
  ];
  @override
  String get running => 'جاري';
  @override
  String get ongoing => 'مستمر';
  @override
  String get patient => 'مريض';
  @override
  String experience({required Object Years}) => 'خبرة ${Years} سنوات';
  @override
  String patientStories({required Object Count}) => '${Count} تقييم من المرضى';
  @override
  String get nextAvailable => 'الموعد المتاح القادم';
  @override
  String get tomorrow => 'غداً';
  @override
  String pricePerHour({required Object Price}) => '${Price}/ ساعة';
  @override
  String get doctorName => 'اسم الطبيب';
  @override
  String get toothDentist => 'طبيب أسنان';
}

// Path: appointment
class _Translations$appointment$ar extends Translations$appointment$en {
  _Translations$appointment$ar._(TranslationsAr root) : this._root = root, super.internal(root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get thankYou => 'شكراً لك !';
  @override
  String get success => 'تم حجز موعدك بنجاح';
  @override
  String bookingDetails({required Object Doctor, required Object Date, required Object Time}) =>
      'لقد حجزت موعداً مع ${Doctor} في ${Date}، الساعة ${Time}';
  @override
  String get done => 'تم';
}

// Path: createDoctor
class _Translations$createDoctor$ar extends Translations$createDoctor$en {
  _Translations$createDoctor$ar._(TranslationsAr root) : this._root = root, super.internal(root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'إضافة طبيب';
  @override
  String get addPhoto => 'إضافة صورة';
  @override
  String get doctorAddedSuccessfully => 'تمت إضافة الطبيب بنجاح';
  @override
  String get youMustPickDoctorImage => 'يجب اختيار صورة للطبيب';
}

// Path: common
class _Translations$common$ar extends Translations$common$en {
  _Translations$common$ar._(TranslationsAr root) : this._root = root, super.internal(root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get today => 'اليوم';
  @override
  String get tomorrow => 'غداً';
  @override
  String get am => 'ص';
  @override
  String get pm => 'م';
  @override
  String get min => 'دقيقة';
}

// Path: dialog
class _Translations$dialog$ar extends Translations$dialog$en {
  _Translations$dialog$ar._(TranslationsAr root) : this._root = root, super.internal(root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get ok => 'حسناً';
  @override
  String get success => 'نجاح';
  @override
  String get error => 'خطأ';
  @override
  String get registeredSuccessfully => 'تم التسجيل بنجاح، يرجى تسجيل الدخول.';
  @override
  String get cancel => 'إلغاء';
  @override
  String get confirm => 'تأكيد';
}

// Path: admin
class _Translations$admin$ar extends Translations$admin$en {
  _Translations$admin$ar._(TranslationsAr root) : this._root = root, super.internal(root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  late final _Translations$admin$main$ar main = _Translations$admin$main$ar._(_root);
  @override
  late final _Translations$admin$patientsTab$ar patientsTab = _Translations$admin$patientsTab$ar._(_root);
  @override
  late final _Translations$admin$appointmentDetails$ar appointmentDetails = _Translations$admin$appointmentDetails$ar._(_root);
  @override
  late final _Translations$admin$doctorsTab$ar doctorsTab = _Translations$admin$doctorsTab$ar._(_root);
  @override
  late final _Translations$admin$appointmentsTab$ar appointmentsTab = _Translations$admin$appointmentsTab$ar._(_root);
  @override
  late final _Translations$admin$settings$ar settings = _Translations$admin$settings$ar._(_root);
  @override
  late final _Translations$admin$addDoctorScreen$ar addDoctorScreen = _Translations$admin$addDoctorScreen$ar._(_root);
  @override
  late final _Translations$admin$doctorDetailsScreen$ar doctorDetailsScreen = _Translations$admin$doctorDetailsScreen$ar._(_root);
  @override
  late final _Translations$admin$updateDoctorDetails$ar updateDoctorDetails = _Translations$admin$updateDoctorDetails$ar._(_root);
  @override
  late final _Translations$admin$profileScreen$ar profileScreen = _Translations$admin$profileScreen$ar._(_root);
}

// Path: errors
class _Translations$errors$ar extends Translations$errors$en {
  _Translations$errors$ar._(TranslationsAr root) : this._root = root, super.internal(root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get noAccountAssociated => 'لا يوجد حساب مرتبط بهذا البريد الإلكتروني';
  @override
  String get accountDisabled => 'الحساب معطل. يرجى التواصل مع المسؤول.';
  @override
  String get someThingWentWrong => 'حدث خطأ ما، يرجى المحاولة لاحقاً';
  @override
  String get serverError => 'خطأ في الخادم';
  @override
  String get noInternet => 'لا يوجد اتصال بالإنترنت';
  @override
  String get emailOrPasswordIsIncorrect => 'البريد الإلكتروني أو كلمة المرور غير صحيحة';
  @override
  String get emailAddressAlreadyInUseByAnotherAccount => 'البريد الإلكتروني مستخدم بالفعل بواسطة حساب آخر';
  @override
  String get userNotAuthenticated => 'المستخدم غير مصرح له';
  @override
  String get errorWhileAddingDoctorPleaseTryAgainLater => 'حدث خطأ أثناء إضافة الطبيب، يرجى المحاولة لاحقاً';
  @override
  String get errorWhileUpdatingDoctorPleaseTryAgainLater => 'حدث خطأ أثناء تحديث بيانات الطبيب، يرجى المحاولة لاحقاً';
  @override
  String failedToFetchAppointments({required Object E}) => 'فشل جلب المواعيد: ${E}';
  @override
  String failedToBookAppointment({required Object E}) => 'فشل حجز الموعد: ${E}';
  @override
  String get slotAlreadyBooked => 'هذا الموعد محجوز بالفعل. يرجى اختيار موعد آخر.';
  @override
  String get userNotLoggedIn => 'المستخدم غير مسجل الدخول';
  @override
  String failedToUpdateAppointmentStatus({required Object E}) => 'فشل تحديث حالة الموعد: ${E}';
  @override
  String get cancelledByUser => 'تم الإلغاء بواسطة المستخدم';
}

// Path: validators
class _Translations$validators$ar extends Translations$validators$en {
  _Translations$validators$ar._(TranslationsAr root) : this._root = root, super.internal(root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get thisFieldIsRequired => 'هذا الحقل مطلوب';
  @override
  String get emailIsRequired => 'البريد الإلكتروني مطلوب';
  @override
  String get invalidEmailFormat => 'صيغة البريد الإلكتروني غير صالحة';
  @override
  String get passwordIsRequired => 'كلمة المرور مطلوبة';
  @override
  String get confirmPasswordIsRequired => 'تأكيد كلمة المرور مطلوب';
  @override
  String get passwordsDoNotMatch => 'كلمتا المرور غير متطابقتين';
  @override
  String get phoneIsRequired => 'رقم الهاتف مطلوب';
  @override
  String get invalidPhoneNumber => 'رقم الهاتف غير صالح';
  @override
  String get passwordMustBeAtLeast6Characters => 'يجب أن تتكون كلمة المرور من 6 أحرف على الأقل';
}

// Path: eCodes
class _Translations$eCodes$ar extends Translations$eCodes$en {
  _Translations$eCodes$ar._(TranslationsAr root) : this._root = root, super.internal(root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get webUserInteractionFailed => 'web-user-interaction-failed';
  @override
  String get cancelled => 'cancelled';
  @override
  String get invalidCredential => 'invalid-credential';
  @override
  String get emailAlreadyInUse => 'email-already-in-use';
}

// Path: doctor
class _Translations$doctor$ar extends Translations$doctor$en {
  _Translations$doctor$ar._(TranslationsAr root) : this._root = root, super.internal(root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  late final _Translations$doctor$main$ar main = _Translations$doctor$main$ar._(_root);
  @override
  late final _Translations$doctor$settings$ar settings = _Translations$doctor$settings$ar._(_root);
  @override
  late final _Translations$doctor$onboarding$ar onboarding = _Translations$doctor$onboarding$ar._(_root);
  @override
  late final _Translations$doctor$availability$ar availability = _Translations$doctor$availability$ar._(_root);
  @override
  late final _Translations$doctor$profile$ar profile = _Translations$doctor$profile$ar._(_root);
  @override
  late final _Translations$doctor$schedule$ar schedule = _Translations$doctor$schedule$ar._(_root);
}

// Path: onboarding.pages.0
class _Translations$onboarding$pages$0$ar extends Translations$onboarding$pages$0$en with PageData {
  _Translations$onboarding$pages$0$ar._(TranslationsAr root) : this._root = root, super.internal(root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'ابحث عن أطباء موثوقين';
  @override
  String get subtitle => 'اعثر على أطباء موثوقين بالقرب منك. احصل على الرعاية التي تحتاجها من متخصصين ذوي خبرة.';
  @override
  String get imagePath => 'assets/images/on_boarding1.png';
}

// Path: onboarding.pages.1
class _Translations$onboarding$pages$1$ar extends Translations$onboarding$pages$1$en with PageData {
  _Translations$onboarding$pages$1$ar._(TranslationsAr root) : this._root = root, super.internal(root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'اختر أفضل الأطباء';
  @override
  String get subtitle => 'استكشف الأطباء وفقاً لاحتياجاتك، واختر الطبيب الأنسب لك.';
  @override
  String get imagePath => 'assets/images/on_boarding2.png';
}

// Path: onboarding.pages.2
class _Translations$onboarding$pages$2$ar extends Translations$onboarding$pages$2$en with PageData {
  _Translations$onboarding$pages$2$ar._(TranslationsAr root) : this._root = root, super.internal(root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'حجز مواعيد بسهولة';
  @override
  String get subtitle => 'احجز موعدك بلمسات بسيطة، وحدد الوقت الأنسب لجدولك.';
  @override
  String get imagePath => 'assets/images/on_boarding3.png';
}

// Path: chooseRole.patient
class _Translations$chooseRole$patient$ar extends Translations$chooseRole$patient$en {
  _Translations$chooseRole$patient$ar._(TranslationsAr root) : this._root = root, super.internal(root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'مريض';
  @override
  String get description => 'حجز المواعيد واستشارة الأطباء.';
}

// Path: chooseRole.admin
class _Translations$chooseRole$admin$ar extends Translations$chooseRole$admin$en {
  _Translations$chooseRole$admin$ar._(TranslationsAr root) : this._root = root, super.internal(root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'مسؤول';
  @override
  String get description => 'إدارة الأطباء وإعدادات التطبيق.';
}

// Path: chooseRole.doctor
class _Translations$chooseRole$doctor$ar extends Translations$chooseRole$doctor$en {
  _Translations$chooseRole$doctor$ar._(TranslationsAr root) : this._root = root, super.internal(root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'طبيب';
  @override
  String get description => 'إدارة المواعيد واستشارة المرضى.';
}

// Path: privacyPolicy.sections
class _Translations$privacyPolicy$sections$ar extends Translations$privacyPolicy$sections$en {
  _Translations$privacyPolicy$sections$ar._(TranslationsAr root) : this._root = root, super.internal(root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  late final _Translations$privacyPolicy$sections$informationWeCollect$ar informationWeCollect =
      _Translations$privacyPolicy$sections$informationWeCollect$ar._(_root);
  @override
  late final _Translations$privacyPolicy$sections$howWeUseInformation$ar howWeUseInformation =
      _Translations$privacyPolicy$sections$howWeUseInformation$ar._(_root);
  @override
  late final _Translations$privacyPolicy$sections$dataSecurity$ar dataSecurity = _Translations$privacyPolicy$sections$dataSecurity$ar._(_root);
  @override
  late final _Translations$privacyPolicy$sections$thirdPartyServices$ar thirdPartyServices =
      _Translations$privacyPolicy$sections$thirdPartyServices$ar._(_root);
  @override
  late final _Translations$privacyPolicy$sections$yourRights$ar yourRights = _Translations$privacyPolicy$sections$yourRights$ar._(_root);
  @override
  late final _Translations$privacyPolicy$sections$contactUs$ar contactUs = _Translations$privacyPolicy$sections$contactUs$ar._(_root);
}

// Path: admin.main
class _Translations$admin$main$ar extends Translations$admin$main$en {
  _Translations$admin$main$ar._(TranslationsAr root) : this._root = root, super.internal(root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get doctors => 'الأطباء';
  @override
  String get patients => 'المرضى';
  @override
  String get settings => 'الإعدادات';
}

// Path: admin.patientsTab
class _Translations$admin$patientsTab$ar extends Translations$admin$patientsTab$en {
  _Translations$admin$patientsTab$ar._(TranslationsAr root) : this._root = root, super.internal(root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'المرضى';
  @override
  String get noPatients => 'لا يوجد مرضى';
  @override
  String get searchHint => 'البحث عن المرضى...';
  @override
  String get deletePatient => 'حذف المريض';
  @override
  String get deletePatientConfirmationTitle => 'تأكيد حذف المريض';
  @override
  String get deletePatientConfirmationMessage => 'هل أنت متأكد من حذف هذا المريض؟ لا يمكن التراجع عن هذا الإجراء.';
  @override
  String get patientDeletedSuccessfully => 'تم حذف المريض بنجاح';
}

// Path: admin.appointmentDetails
class _Translations$admin$appointmentDetails$ar extends Translations$admin$appointmentDetails$en {
  _Translations$admin$appointmentDetails$ar._(TranslationsAr root) : this._root = root, super.internal(root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'تفاصيل الموعد';
  @override
  String get patient => 'المريض';
  @override
  String get doctor => 'الطبيب';
  @override
  String get appointment => 'الموعد';
}

// Path: admin.doctorsTab
class _Translations$admin$doctorsTab$ar extends Translations$admin$doctorsTab$en {
  _Translations$admin$doctorsTab$ar._(TranslationsAr root) : this._root = root, super.internal(root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get createDoctor => 'إضافة طبيب';
  @override
  String get searchDoctors => 'البحث عن أطباء';
  @override
  String get noDoctorsFound => 'لم يتم العثور على أطباء';
  @override
  String get noDoctorsDescription => 'لا يوجد أطباء مسجلون حالياً في دكتور هانت. أضف أول طبيب للبدء.';
  @override
  String get totalDoctors => 'إجمالي الأطباء';
  @override
  String get enabled => 'مفعل';
  @override
  String get disabled => 'معطل';
  @override
  String get all => 'الكل';
  @override
  String get dash => '-';
  @override
  String get noDoctorNameOrSpecialtyMatchSearch => 'لا يوجد اسم طبيب أو تخصص يطابق البحث';
  @override
  String get noDoctors => 'لا يوجد أطباء';
  @override
  String get noDoctorsToSearchAddSome => 'لا يوجد أطباء للبحث، أضف بعض الأطباء';
}

// Path: admin.appointmentsTab
class _Translations$admin$appointmentsTab$ar extends Translations$admin$appointmentsTab$en {
  _Translations$admin$appointmentsTab$ar._(TranslationsAr root) : this._root = root, super.internal(root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'المواعيد';
  @override
  String get time => 'الوقت';
  @override
  String get date => 'التاريخ';
  @override
  String get fee => 'الرسوم';
  @override
  String get markAsCompleted => 'تحديد كمكتمل';
}

// Path: admin.settings
class _Translations$admin$settings$ar extends Translations$admin$settings$en {
  _Translations$admin$settings$ar._(TranslationsAr root) : this._root = root, super.internal(root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get adminProfile => 'الملف الشخصي للمسؤول';
  @override
  String get changePassword => 'تغيير كلمة المرور';
  @override
  String get appInformation => 'معلومات التطبيق';
  @override
  String get editSuperAdminDetailsPermissions => 'تعديل بيانات وصلاحيات المسؤول';
  @override
  String get updateMasterSecurityCredentials => 'تحديث بيانات الأمان الرئيسية';
  @override
  String get v100 => 'v1.0.0';
}

// Path: admin.addDoctorScreen
class _Translations$admin$addDoctorScreen$ar extends Translations$admin$addDoctorScreen$en {
  _Translations$admin$addDoctorScreen$ar._(TranslationsAr root) : this._root = root, super.internal(root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get createDoctor => 'إضافة طبيب';
  @override
  String get selectSpecialty => 'اختر التخصص';
  @override
  String get doctorName => 'اسم الطبيب';
  @override
  String get email => 'البريد الإلكتروني';
  @override
  String get password => 'كلمة المرور';
  @override
  String get emailExample => 'مثال: doctor@hospital.com';
  @override
  String get passwordExample => '••••••••';
  @override
  String get specialty => 'التخصص';
  @override
  String get consultationFee => 'رسوم الاستشارة';
  @override
  String get nameExample => 'مثال: د. أحمد علي';
  @override
  String get feeExample => 'مثال: 28.00 \$';
  @override
  String get englishName => 'الاسم بالإنجليزية';
  @override
  String get arabicName => 'الاسم بالعربية';
  @override
  String get addSpecialty => 'إضافة تخصص';
}

// Path: admin.doctorDetailsScreen
class _Translations$admin$doctorDetailsScreen$ar extends Translations$admin$doctorDetailsScreen$en {
  _Translations$admin$doctorDetailsScreen$ar._(TranslationsAr root) : this._root = root, super.internal(root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get doctorDetails => 'تفاصيل الطبيب';
  @override
  String get specialty => 'التخصص';
  @override
  String get accountStatus => 'حالة الحساب';
  @override
  String get heartCare => 'رعاية القلب';
  @override
  String get deleteDoctor => 'حذف الطبيب';
  @override
  String get doctorDeletedSuccessfully => 'تم حذف الطبيب بنجاح';
  @override
  String get deleteDoctorConfirmationTitle => 'تأكيد حذف الطبيب';
  @override
  String get deleteDoctorConfirmationMessage => 'هل أنت متأكد من حذف هذا الطبيب؟ لا يمكن التراجع عن هذا الإجراء.';
  @override
  String get rating => 'التقييم';
  @override
  String get consultationFee => 'رسوم الاستشارة';
  @override
  String fee({required Object Price}) => '${Price} \$';
}

// Path: admin.updateDoctorDetails
class _Translations$admin$updateDoctorDetails$ar extends Translations$admin$updateDoctorDetails$en {
  _Translations$admin$updateDoctorDetails$ar._(TranslationsAr root) : this._root = root, super.internal(root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get doctorWasUpdatedSuccessfully => 'تم تحديث بيانات الطبيب بنجاح';
  @override
  String get editDoctor => 'تعديل بيانات الطبيب';
  @override
  String get changePhoto => 'تغيير الصورة';
  @override
  String get doctorStatues => 'حالة الطبيب';
  @override
  String get activeAndAvailable => 'نشط ومتاح';
  @override
  String get inactive => 'غير نشط';
  @override
  String get deleteDoctor => 'حذف الطبيب';
  @override
  String get saveChanges => 'حفظ التغييرات';
}

// Path: admin.profileScreen
class _Translations$admin$profileScreen$ar extends Translations$admin$profileScreen$en {
  _Translations$admin$profileScreen$ar._(TranslationsAr root) : this._root = root, super.internal(root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'الملف الشخصي';
  @override
  String get fullName => 'الاسم الكامل';
  @override
  String get emailAddress => 'البريد الإلكتروني';
}

// Path: doctor.main
class _Translations$doctor$main$ar extends Translations$doctor$main$en {
  _Translations$doctor$main$ar._(TranslationsAr root) : this._root = root, super.internal(root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get mySchedule => 'جدول مواعيدي';
  @override
  String get appointments => _root.patientMain.appointments;
  @override
  String get settings => 'الإعدادات';
}

// Path: doctor.settings
class _Translations$doctor$settings$ar extends Translations$doctor$settings$en {
  _Translations$doctor$settings$ar._(TranslationsAr root) : this._root = root, super.internal(root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'إعدادات الطبيب';
  @override
  String get doctorProfile => 'الملف الشخصي للطبيب';
  @override
  String get editProfileDesc => 'تعديل ملفك الشخصي ورسوم الاستشارة';
  @override
  String get availability => 'إدارة أوقات العمل';
  @override
  String get availabilityDesc => 'تحديث أيام وساعات العمل';
  @override
  String get changePassword => 'تغيير كلمة المرور';
  @override
  String get updateMasterSecurityCredentials => 'تحديث كلمة مرور حسابك';
  @override
  String get appInformation => 'معلومات التطبيق';
  @override
  String get v100 => 'v1.0.0';
}

// Path: doctor.onboarding
class _Translations$doctor$onboarding$ar extends Translations$doctor$onboarding$en {
  _Translations$doctor$onboarding$ar._(TranslationsAr root) : this._root = root, super.internal(root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get welcomeTitle => 'مرحباً بك في دكتور هانت!';
  @override
  String get welcomeSubtitle => 'دعنا نكمل ملفك الشخصي ونحدد جدول عملك ليتمكن المرضى من العثور عليك وحجز المواعيد معك.';
  @override
  String get continueBtn => 'متابعة';
  @override
  String get stepProfileTitle => 'بيانات الملف الشخصي';
  @override
  String get stepProfileSubtitle => 'يرجى تقديم معلومات الاتصال ورسوم الاستشارة';
  @override
  String get phoneNumber => 'رقم الهاتف';
  @override
  String get phoneHint => '+20 100 000 0000';
  @override
  String get consultationFee => 'رسوم الاستشارة';
  @override
  String get feeHint => 'مثال: 200';
  @override
  String get photoRequired => 'يرجى اختيار صورة للملف الشخصي';
  @override
  String get choosePhoto => 'اختيار صورة';
  @override
  String get changePhoto => 'تغيير الصورة';
  @override
  String get stepAvailabilityTitle => 'جدول العمل';
  @override
  String get stepAvailabilitySubtitle => 'حدد أيام عملك وساعات الاستشارة';
  @override
  String get selectAtLeastOneDay => 'يرجى اختيار يوم عمل واحد على الأقل';
  @override
  String get saveAndContinue => 'حفظ وإكمال';
  @override
  String get successTitle => 'كل شيء جاهز!';
  @override
  String get successSubtitle => 'تم تحديث ملفك الشخصي ومواعيد توفرك بنجاح. أنت الآن جاهز لبدء استقبال المواعيد.';
  @override
  String get finish => 'إنهاء';
}

// Path: doctor.availability
class _Translations$doctor$availability$ar extends Translations$doctor$availability$en {
  _Translations$doctor$availability$ar._(TranslationsAr root) : this._root = root, super.internal(root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get doctorAvailability => 'أوقات توفر الطبيب';
  @override
  String get workingDays => 'أيام العمل';
  @override
  String get workingHours => 'ساعات العمل';
  @override
  String get startTime => 'وقت البدء';
  @override
  String get endTime => 'وقت الانتهاء';
  @override
  String get slotDuration => 'مدة الموعد';
  @override
  String get active => 'نشط';
  @override
  String get inactive => 'غير نشط';
  @override
  String get startTimeAndEndtimeMustBeDifferent => 'يجب أن يكون وقت البدء مختلفاً عن وقت الانتهاء';
  @override
  String get startTimeMustBeBeforeEndTime => 'يجب أن يكون وقت البدء قبل وقت الانتهاء';
  @override
  String get dataWasUpdatedSuccessfully => 'تم تحديث البيانات بنجاح';
}

// Path: doctor.profile
class _Translations$doctor$profile$ar extends Translations$doctor$profile$en {
  _Translations$doctor$profile$ar._(TranslationsAr root) : this._root = root, super.internal(root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'الملف الشخصي للطبيب';
  @override
  String get personalInformation => 'المعلومات الشخصية';
  @override
  String get name => 'الاسم';
  @override
  String get phone => 'الهاتف';
  @override
  String get dataWasUpdatedSuccessfully => 'تم تحديث البيانات بنجاح';
  @override
  String get speciality => 'التخصص';
  @override
  String get status => 'الحالة';
  @override
  String get active => 'نشط';
  @override
  String get inactive => 'غير نشط';
  @override
  String get fee => 'الرسوم';
}

// Path: doctor.schedule
class _Translations$doctor$schedule$ar extends Translations$doctor$schedule$en {
  _Translations$doctor$schedule$ar._(TranslationsAr root) : this._root = root, super.internal(root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'جدول مواعيدي';
  @override
  String get today => 'اليوم';
  @override
  String get tomorrow => 'غداً';
  @override
  String get next7Days => 'خلال 7 أيام';
  @override
  String get noAppointments => 'لا توجد مواعيد';
  @override
  String get refresh => 'تحديث';
}

// Path: privacyPolicy.sections.informationWeCollect
class _Translations$privacyPolicy$sections$informationWeCollect$ar extends Translations$privacyPolicy$sections$informationWeCollect$en {
  _Translations$privacyPolicy$sections$informationWeCollect$ar._(TranslationsAr root) : this._root = root, super.internal(root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get title => '١. المعلومات التي نجمعها';
  @override
  String get description => 'نقوم بجمع المعلومات اللازمة لتقديم خدمات حجز الأطباء وإدارة الرعاية الصحية:';
  @override
  List<String> get bullets => [
    'البيانات التعريفية: الاسم، البريد الإلكتروني، ورقم الهاتف.',
    'بيانات المواعيد: الأطباء المختارون، تواريخ المواعيد، الأوقات، وحالة الحجز.',
    'التفاصيل الطبية: تفضيلات الاستشارة وملاحظات المريض المشاركة للمواعيد.',
    'الحساب والبيانات التقنية: دور المستخدم (مريض، طبيب، مسؤول) وسجلات النظام.',
  ];
}

// Path: privacyPolicy.sections.howWeUseInformation
class _Translations$privacyPolicy$sections$howWeUseInformation$ar extends Translations$privacyPolicy$sections$howWeUseInformation$en {
  _Translations$privacyPolicy$sections$howWeUseInformation$ar._(TranslationsAr root) : this._root = root, super.internal(root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get title => '٢. كيف نستخدم معلوماتك';
  @override
  String get description => 'تُستخدم معلوماتك حصرياً لتقديم وتحسين خدمات الرعاية الصحية لدينا:';
  @override
  List<String> get bullets => [
    'تسهيل البحث عن الأطباء، جدولة المواعيد، وإدارتها.',
    'إرسال تذكيرات بالمواعيد وتحديثات الحساب.',
    'ضمان تسجيل الدخول الآمن والمصادقة.',
    'تحسين أداء التطبيق وتجربة دعم العملاء.',
  ];
}

// Path: privacyPolicy.sections.dataSecurity
class _Translations$privacyPolicy$sections$dataSecurity$ar extends Translations$privacyPolicy$sections$dataSecurity$en {
  _Translations$privacyPolicy$sections$dataSecurity$ar._(TranslationsAr root) : this._root = root, super.internal(root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get title => '٣. أمان البيانات وتخزينها';
  @override
  String get description => 'نأخذ أمان بياناتك الصحية والشخصية على محمل الجد:';
  @override
  List<String> get bullets => [
    'يتم تخزين البيانات بأمان باستخدام بنية تحتية سحابية مشفرة لقواعد البيانات.',
    'تقتصر صلاحيات الوصول إلى البيانات الإدارية والطبية على المستخدمين المصرح لهم فقط.',
    'نقوم بتحديث ممارساتنا الأمنية بانتظام للحماية من الوصول غير المصرح به.',
  ];
}

// Path: privacyPolicy.sections.thirdPartyServices
class _Translations$privacyPolicy$sections$thirdPartyServices$ar extends Translations$privacyPolicy$sections$thirdPartyServices$en {
  _Translations$privacyPolicy$sections$thirdPartyServices$ar._(TranslationsAr root) : this._root = root, super.internal(root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get title => '٤. خدمات الطرف الثالث';
  @override
  String get description => 'نقوم بدمج خدمات موثوقة من أطراف ثالثة لضمان الأداء الأمثل:';
  @override
  List<String> get bullets => [
    'فايربيز (Firebase): تُستخدم للمصادقة الآمنة وإدارة قواعد البيانات السحابية.',
    'كلاوديناري (Cloudinary): تُستخدم لتخزين وعرض الصور الشخصية وصور الأطباء بأمان.',
    'نحن لا نبيع أو نتاجر أو نؤجر بياناتك الشخصية لأطراف ثالثة لأغراض تسويقية أبداً.',
  ];
}

// Path: privacyPolicy.sections.yourRights
class _Translations$privacyPolicy$sections$yourRights$ar extends Translations$privacyPolicy$sections$yourRights$en {
  _Translations$privacyPolicy$sections$yourRights$ar._(TranslationsAr root) : this._root = root, super.internal(root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get title => '٥. حقوقك وتحكمك بالبيانات';
  @override
  String get description => 'لديك كامل التحكم في بياناتك الشخصية داخل تطبيق دكتور هانت:';
  @override
  List<String> get bullets => [
    'عرض وتحديث معلومات ملفك الشخصي في أي وقت.',
    'إدارة إعدادات الإشعارات والتنبيهات.',
    'طلب حذف الحساب أو مسح البيانات عبر التواصل مع الدعم.',
  ];
}

// Path: privacyPolicy.sections.contactUs
class _Translations$privacyPolicy$sections$contactUs$ar extends Translations$privacyPolicy$sections$contactUs$en {
  _Translations$privacyPolicy$sections$contactUs$ar._(TranslationsAr root) : this._root = root, super.internal(root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get title => '٦. تواصل معنا';
  @override
  String get description =>
      'إذا كانت لديك أي أسئلة أو استفسارات حول سياسة الخصوصية هذه أو حماية بياناتك، يرجى التواصل معنا عبر support@doctorhunt.com.';
}

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
  late final _Translations$core$ar core = _Translations$core$ar._(_root);
  @override
  late final _Translations$features$ar features = _Translations$features$ar._(_root);
}

// Path: core
class _Translations$core$ar extends Translations$core$en {
  _Translations$core$ar._(TranslationsAr root) : this._root = root, super.internal(root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  late final _Translations$core$common$ar common = _Translations$core$common$ar._(_root);
  @override
  late final _Translations$core$dialogs$ar dialogs = _Translations$core$dialogs$ar._(_root);
  @override
  late final _Translations$core$validators$ar validators = _Translations$core$validators$ar._(_root);
  @override
  late final _Translations$core$errors$ar errors = _Translations$core$errors$ar._(_root);
  @override
  late final _Translations$core$eCodes$ar eCodes = _Translations$core$eCodes$ar._(_root);
  @override
  late final _Translations$core$widgets$ar widgets = _Translations$core$widgets$ar._(_root);
}

// Path: features
class _Translations$features$ar extends Translations$features$en {
  _Translations$features$ar._(TranslationsAr root) : this._root = root, super.internal(root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  late final _Translations$features$common$ar common = _Translations$features$common$ar._(_root);
  @override
  late final _Translations$features$patient$ar patient = _Translations$features$patient$ar._(_root);
  @override
  late final _Translations$features$doctor$ar doctor = _Translations$features$doctor$ar._(_root);
  @override
  late final _Translations$features$admin$ar admin = _Translations$features$admin$ar._(_root);
}

// Path: core.common
class _Translations$core$common$ar extends Translations$core$common$en {
  _Translations$core$common$ar._(TranslationsAr root) : this._root = root, super.internal(root);

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
  @override
  List<String> get weekdays => ['الأحد', 'الإثنين', 'الثلاثاء', 'الأربعاء', 'الخميس', 'الجمعة', 'السبت'];
  @override
  String get name => 'الاسم';
  @override
  String get fullName => 'الاسم الكامل';
  @override
  String get email => 'البريد الإلكتروني';
  @override
  String get password => 'كلمة المرور';
  @override
  String get phone => 'رقم الهاتف';
  @override
  String get phoneNumber => 'رقم الهاتف';
  @override
  String get specialty => 'التخصص';
  @override
  String get consultationFee => 'رسوم الاستشارة';
  @override
  String get date => 'التاريخ';
  @override
  String get time => 'الوقت';
  @override
  String get fee => 'الرسوم';
  @override
  String feeValue({required Object Fee}) => '${Fee} \$';
  @override
  String get active => 'نشط';
  @override
  String get inactive => 'غير نشط';
  @override
  String get enabled => 'مفعل';
  @override
  String get disabled => 'معطل';
  @override
  String get all => 'الكل';
  @override
  String get dash => '-';
  @override
  String get saveChanges => 'حفظ التغييرات';
  @override
  String get logout => 'تسجيل الخروج';
  @override
  String get changePassword => 'تغيير كلمة المرور';
  @override
  String get appInformation => 'معلومات التطبيق';
  @override
  String get buildVersion => 'إصدار التطبيق';
  @override
  String get appVersionVal => 'v1.0.0';
  @override
  String get english => 'الإنجليزية';
  @override
  String get arabic => 'العربية';
  @override
  String get seeAll => 'عرض الكل';
  @override
  String get search => 'بحث...';
  @override
  String get viewDetails => 'عرض التفاصيل';
  @override
  String get dataUpdatedSuccessfully => 'تم تحديث البيانات بنجاح';
  @override
  String get logoutConfirmation => 'هل أنت متأكد من رغبتك في تسجيل الخروج؟';
}

// Path: core.dialogs
class _Translations$core$dialogs$ar extends Translations$core$dialogs$en {
  _Translations$core$dialogs$ar._(TranslationsAr root) : this._root = root, super.internal(root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get ok => 'حسناً';
  @override
  String get cancel => 'إلغاء';
  @override
  String get confirm => 'تأكيد';
  @override
  String get success => 'نجاح';
  @override
  String get error => 'خطأ';
  @override
  String get registeredSuccessfully => 'تم التسجيل بنجاح، يرجى تسجيل الدخول.';
}

// Path: core.validators
class _Translations$core$validators$ar extends Translations$core$validators$en {
  _Translations$core$validators$ar._(TranslationsAr root) : this._root = root, super.internal(root);

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

// Path: core.errors
class _Translations$core$errors$ar extends Translations$core$errors$en {
  _Translations$core$errors$ar._(TranslationsAr root) : this._root = root, super.internal(root);

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
  String get userNotLoggedIn => 'المستخدم غير مسجل الدخول';
  @override
  String get errorWhileAddingDoctorPleaseTryAgainLater => 'حدث خطأ أثناء إضافة الطبيب، يرجى المحاولة لاحقاً';
  @override
  String get errorWhileUpdatingDoctorPleaseTryAgainLater => 'حدث خطأ أثناء تحديث بيانات الطبيب، يرجى المحاولة لاحقاً';
  @override
  String failedToFetchAppointments({required Object E}) => 'فشل جلب المواعيد: ${E}';
  @override
  String failedToBookAppointment({required Object E}) => 'فشل حجز الموعد: ${E}';
  @override
  String failedToUpdateAppointmentStatus({required Object E}) => 'فشل تحديث حالة الموعد: ${E}';
  @override
  String get slotAlreadyBooked => 'هذا الموعد محجوز بالفعل. يرجى اختيار موعد آخر.';
  @override
  String get cancelledByUser => 'تم الإلغاء بواسطة المستخدم';
}

// Path: core.eCodes
class _Translations$core$eCodes$ar extends Translations$core$eCodes$en {
  _Translations$core$eCodes$ar._(TranslationsAr root) : this._root = root, super.internal(root);

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

// Path: core.widgets
class _Translations$core$widgets$ar extends Translations$core$widgets$en {
  _Translations$core$widgets$ar._(TranslationsAr root) : this._root = root, super.internal(root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  late final _Translations$core$widgets$appointment$ar appointment = _Translations$core$widgets$appointment$ar._(_root);
  @override
  late final _Translations$core$widgets$statusSwitchTile$ar statusSwitchTile = _Translations$core$widgets$statusSwitchTile$ar._(_root);
  @override
  late final _Translations$core$widgets$languagePicker$ar languagePicker = _Translations$core$widgets$languagePicker$ar._(_root);
}

// Path: features.common
class _Translations$features$common$ar extends Translations$features$common$en {
  _Translations$features$common$ar._(TranslationsAr root) : this._root = root, super.internal(root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  late final _Translations$features$common$auth$ar auth = _Translations$features$common$auth$ar._(_root);
  @override
  late final _Translations$features$common$onboarding$ar onboarding = _Translations$features$common$onboarding$ar._(_root);
  @override
  late final _Translations$features$common$chooseRole$ar chooseRole = _Translations$features$common$chooseRole$ar._(_root);
  @override
  late final _Translations$features$common$appointmentsManagement$ar appointmentsManagement =
      _Translations$features$common$appointmentsManagement$ar._(_root);
}

// Path: features.patient
class _Translations$features$patient$ar extends Translations$features$patient$en {
  _Translations$features$patient$ar._(TranslationsAr root) : this._root = root, super.internal(root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  late final _Translations$features$patient$mainScreen$ar mainScreen = _Translations$features$patient$mainScreen$ar._(_root);
  @override
  late final _Translations$features$patient$homeTab$ar homeTab = _Translations$features$patient$homeTab$ar._(_root);
  @override
  late final _Translations$features$patient$favouriteTab$ar favouriteTab = _Translations$features$patient$favouriteTab$ar._(_root);
  @override
  late final _Translations$features$patient$settingsTab$ar settingsTab = _Translations$features$patient$settingsTab$ar._(_root);
  @override
  late final _Translations$features$patient$patientProfileScreen$ar patientProfileScreen = _Translations$features$patient$patientProfileScreen$ar._(
    _root,
  );
  @override
  late final _Translations$features$patient$privacyPolicyScreen$ar privacyPolicyScreen = _Translations$features$patient$privacyPolicyScreen$ar._(
    _root,
  );
  @override
  late final _Translations$features$patient$doctorDetailsScreen$ar doctorDetailsScreen = _Translations$features$patient$doctorDetailsScreen$ar._(
    _root,
  );
  @override
  late final _Translations$features$patient$selectTimeScreen$ar selectTimeScreen = _Translations$features$patient$selectTimeScreen$ar._(_root);
  @override
  late final _Translations$features$patient$appointmentSuccessDialog$ar appointmentSuccessDialog =
      _Translations$features$patient$appointmentSuccessDialog$ar._(_root);
  @override
  late final _Translations$features$patient$appointmentDetailsScreen$ar appointmentDetailsScreen =
      _Translations$features$patient$appointmentDetailsScreen$ar._(_root);
}

// Path: features.doctor
class _Translations$features$doctor$ar extends Translations$features$doctor$en {
  _Translations$features$doctor$ar._(TranslationsAr root) : this._root = root, super.internal(root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  late final _Translations$features$doctor$doctorMainScreen$ar doctorMainScreen = _Translations$features$doctor$doctorMainScreen$ar._(_root);
  @override
  late final _Translations$features$doctor$scheduleTab$ar scheduleTab = _Translations$features$doctor$scheduleTab$ar._(_root);
  @override
  late final _Translations$features$doctor$doctorSettingsTab$ar doctorSettingsTab = _Translations$features$doctor$doctorSettingsTab$ar._(_root);
  @override
  late final _Translations$features$doctor$doctorProfileScreen$ar doctorProfileScreen = _Translations$features$doctor$doctorProfileScreen$ar._(_root);
  @override
  late final _Translations$features$doctor$doctorOnboardingScreen$ar doctorOnboardingScreen =
      _Translations$features$doctor$doctorOnboardingScreen$ar._(_root);
  @override
  late final _Translations$features$doctor$doctorAvailabilityScreen$ar doctorAvailabilityScreen =
      _Translations$features$doctor$doctorAvailabilityScreen$ar._(_root);
}

// Path: features.admin
class _Translations$features$admin$ar extends Translations$features$admin$en {
  _Translations$features$admin$ar._(TranslationsAr root) : this._root = root, super.internal(root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  late final _Translations$features$admin$adminMainScreen$ar adminMainScreen = _Translations$features$admin$adminMainScreen$ar._(_root);
  @override
  late final _Translations$features$admin$adminDoctorsTab$ar adminDoctorsTab = _Translations$features$admin$adminDoctorsTab$ar._(_root);
  @override
  late final _Translations$features$admin$adminPatientsTab$ar adminPatientsTab = _Translations$features$admin$adminPatientsTab$ar._(_root);
  @override
  late final _Translations$features$admin$adminSettingsTab$ar adminSettingsTab = _Translations$features$admin$adminSettingsTab$ar._(_root);
  @override
  late final _Translations$features$admin$adminProfileScreen$ar adminProfileScreen = _Translations$features$admin$adminProfileScreen$ar._(_root);
  @override
  late final _Translations$features$admin$addDoctorScreen$ar addDoctorScreen = _Translations$features$admin$addDoctorScreen$ar._(_root);
  @override
  late final _Translations$features$admin$doctorDetailsScreen$ar doctorDetailsScreen = _Translations$features$admin$doctorDetailsScreen$ar._(_root);
  @override
  late final _Translations$features$admin$updateDoctorDetailsScreen$ar updateDoctorDetailsScreen =
      _Translations$features$admin$updateDoctorDetailsScreen$ar._(_root);
  @override
  late final _Translations$features$admin$appointmentDetailsScreen$ar appointmentDetailsScreen =
      _Translations$features$admin$appointmentDetailsScreen$ar._(_root);
}

// Path: core.widgets.appointment
class _Translations$core$widgets$appointment$ar extends Translations$core$widgets$appointment$en {
  _Translations$core$widgets$appointment$ar._(TranslationsAr root) : this._root = root, super.internal(root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get upcoming => 'القادمة';
  @override
  String get completed => 'المكتملة';
  @override
  String get canceled => 'الملغاة';
  @override
  String get appointmentDate => 'تاريخ الموعد';
  @override
  String get appointmentTime => 'وقت الموعد';
  @override
  String get consultationFee => _root.core.common.consultationFee;
  @override
  String feeValue({required Object Fee}) => _root.core.common.feeValue(Fee: Fee);
  @override
  String get cancelAppointment => 'إلغاء الموعد';
  @override
  String get rateDoctor => 'تقييم الطبيب';
  @override
  String get markAsCompleted => 'تحديد كمكتمل';
  @override
  String get viewDetails => _root.core.common.viewDetails;
  @override
  String get tabToWriteReview => 'اضغط لكتابة تقييم';
  @override
  String get youMustSelectAtLeastOneStar => 'يجب تحديد نجمة واحدة على الأقل';
  @override
  String get noAppointmentsFound => 'لا توجد مواعيد';
}

// Path: core.widgets.statusSwitchTile
class _Translations$core$widgets$statusSwitchTile$ar extends Translations$core$widgets$statusSwitchTile$en {
  _Translations$core$widgets$statusSwitchTile$ar._(TranslationsAr root) : this._root = root, super.internal(root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get accountStatus => 'حالة الحساب';
  @override
  String get enabled => _root.core.common.enabled;
  @override
  String get disabled => _root.core.common.disabled;
}

// Path: core.widgets.languagePicker
class _Translations$core$widgets$languagePicker$ar extends Translations$core$widgets$languagePicker$en {
  _Translations$core$widgets$languagePicker$ar._(TranslationsAr root) : this._root = root, super.internal(root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get language => 'اللغة';
  @override
  String get english => _root.core.common.english;
  @override
  String get arabic => _root.core.common.arabic;
}

// Path: features.common.auth
class _Translations$features$common$auth$ar extends Translations$features$common$auth$en {
  _Translations$features$common$auth$ar._(TranslationsAr root) : this._root = root, super.internal(root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get welcomeBack => 'مرحباً بعودتك';
  @override
  String get authSubtitle => 'يمكنك البحث عن دورات، التقديم عليها وإيجاد منح للدراسة بالخارج';
  @override
  String get adminSubtitle => 'تسجيل الدخول إلى حساب المسؤول';
  @override
  String get doctorSubtitle => 'تسجيل الدخول إلى حساب الطبيب';
  @override
  String get login => 'تسجيل الدخول';
  @override
  String get signUp => 'إنشاء حساب';
  @override
  String get joinUs => 'انضم إلينا للبدء في البحث';
  @override
  String get haveAccount => 'لديك حساب بالفعل؟ سجل دخولك';
  @override
  String get noAccount => 'ليس لديك حساب؟ انضم إلينا';
  @override
  String get forgotPassword => 'نسيت كلمة المرور';
  @override
  String get username => 'اسم المستخدم';
  @override
  String get email => _root.core.common.email;
  @override
  String get password => _root.core.common.password;
  @override
  String get google => 'جوجل';
  @override
  String get agreeTerms => 'أوافق على شروط الخدمة وسياسة الخصوصية';
  @override
  String get youMustAgreeToTerms => 'يجب أن توافق على شروط الخدمة وسياسة الخصوصية';
  @override
  late final _Translations$features$common$auth$forgotPasswordScreen$ar forgotPasswordScreen =
      _Translations$features$common$auth$forgotPasswordScreen$ar._(_root);
}

// Path: features.common.onboarding
class _Translations$features$common$onboarding$ar extends Translations$features$common$onboarding$en {
  _Translations$features$common$onboarding$ar._(TranslationsAr root) : this._root = root, super.internal(root);

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
    _Translations$features$common$onboarding$pages$0$ar._(_root),
    _Translations$features$common$onboarding$pages$1$ar._(_root),
    _Translations$features$common$onboarding$pages$2$ar._(_root),
  ];
}

// Path: features.common.chooseRole
class _Translations$features$common$chooseRole$ar extends Translations$features$common$chooseRole$en {
  _Translations$features$common$chooseRole$ar._(TranslationsAr root) : this._root = root, super.internal(root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'دكتور هانت';
  @override
  String get roleSelection => 'اختر دورك';
  @override
  late final _Translations$features$common$chooseRole$patient$ar patient = _Translations$features$common$chooseRole$patient$ar._(_root);
  @override
  late final _Translations$features$common$chooseRole$admin$ar admin = _Translations$features$common$chooseRole$admin$ar._(_root);
  @override
  late final _Translations$features$common$chooseRole$doctor$ar doctor = _Translations$features$common$chooseRole$doctor$ar._(_root);
}

// Path: features.common.appointmentsManagement
class _Translations$features$common$appointmentsManagement$ar extends Translations$features$common$appointmentsManagement$en {
  _Translations$features$common$appointmentsManagement$ar._(TranslationsAr root) : this._root = root, super.internal(root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'المواعيد';
  @override
  String get upcoming => _root.core.widgets.appointment.upcoming;
  @override
  String get completed => _root.core.widgets.appointment.completed;
  @override
  String get canceled => _root.core.widgets.appointment.canceled;
  @override
  String get noAppointmentsFound => _root.core.widgets.appointment.noAppointmentsFound;
}

// Path: features.patient.mainScreen
class _Translations$features$patient$mainScreen$ar extends Translations$features$patient$mainScreen$en {
  _Translations$features$patient$mainScreen$ar._(TranslationsAr root) : this._root = root, super.internal(root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get home => 'الرئيسية';
  @override
  String get settings => 'الإعدادات';
  @override
  String get appointments => _root.features.common.appointmentsManagement.title;
  @override
  String get favourite => 'المفضلة';
}

// Path: features.patient.homeTab
class _Translations$features$patient$homeTab$ar extends Translations$features$patient$homeTab$en {
  _Translations$features$patient$homeTab$ar._(TranslationsAr root) : this._root = root, super.internal(root);

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
  String get seeAll => _root.core.common.seeAll;
  @override
  String get search => _root.core.common.search;
}

// Path: features.patient.favouriteTab
class _Translations$features$patient$favouriteTab$ar extends Translations$features$patient$favouriteTab$en {
  _Translations$features$patient$favouriteTab$ar._(TranslationsAr root) : this._root = root, super.internal(root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get title => _root.features.patient.homeTab.favouriteDoctors;
  @override
  String get noFavouriteDoctorsMatchSearch => 'لا يوجد أطباء مفضلون يطابقون البحث';
  @override
  String get noFavouriteDoctorsDescription => 'لم تقم بإضافة أي طبيب إلى المفضلة بعد.';
}

// Path: features.patient.settingsTab
class _Translations$features$patient$settingsTab$ar extends Translations$features$patient$settingsTab$en {
  _Translations$features$patient$settingsTab$ar._(TranslationsAr root) : this._root = root, super.internal(root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'الإعدادات';
  @override
  String get accountSettings => 'إعدادات الحساب';
  @override
  String get changePassword => _root.core.common.changePassword;
  @override
  String get notifications => 'الإشعارات';
  @override
  String get privacyPolicy => 'سياسة الخصوصية';
  @override
  String get moreOptions => 'خيارات إضافية';
  @override
  String get language => _root.core.widgets.languagePicker.language;
  @override
  String get buildVersion => _root.core.common.buildVersion;
  @override
  String get v100 => _root.core.common.appVersionVal;
  @override
  String get logout => _root.core.common.logout;
  @override
  String get logoutConfirmation => _root.core.common.logoutConfirmation;
}

// Path: features.patient.patientProfileScreen
class _Translations$features$patient$patientProfileScreen$ar extends Translations$features$patient$patientProfileScreen$en {
  _Translations$features$patient$patientProfileScreen$ar._(TranslationsAr root) : this._root = root, super.internal(root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'الملف الشخصي';
  @override
  String get personalInformation => 'المعلومات الشخصية';
  @override
  String get name => _root.core.common.name;
  @override
  String get phone => _root.core.common.phone;
  @override
  String get addPhoneNumber => 'إضافة رقم هاتف';
  @override
  String get dataUpdatedSuccessfully => _root.core.common.dataUpdatedSuccessfully;
}

// Path: features.patient.privacyPolicyScreen
class _Translations$features$patient$privacyPolicyScreen$ar extends Translations$features$patient$privacyPolicyScreen$en {
  _Translations$features$patient$privacyPolicyScreen$ar._(TranslationsAr root) : this._root = root, super.internal(root);

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
  late final _Translations$features$patient$privacyPolicyScreen$sections$ar sections =
      _Translations$features$patient$privacyPolicyScreen$sections$ar._(_root);
}

// Path: features.patient.doctorDetailsScreen
class _Translations$features$patient$doctorDetailsScreen$ar extends Translations$features$patient$doctorDetailsScreen$en {
  _Translations$features$patient$doctorDetailsScreen$ar._(TranslationsAr root) : this._root = root, super.internal(root);

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
  String get tomorrow => _root.core.common.tomorrow;
  @override
  String pricePerHour({required Object Price}) => '${Price}/ ساعة';
  @override
  String get doctorName => _root.core.common.name;
  @override
  String get toothDentist => 'طبيب أسنان';
}

// Path: features.patient.selectTimeScreen
class _Translations$features$patient$selectTimeScreen$ar extends Translations$features$patient$selectTimeScreen$en {
  _Translations$features$patient$selectTimeScreen$ar._(TranslationsAr root) : this._root = root, super.internal(root);

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
  String get confirm => _root.core.dialogs.confirm;
  @override
  String get youMustSelectAppointmentTime => 'يجب اختيار وقت الموعد';
}

// Path: features.patient.appointmentSuccessDialog
class _Translations$features$patient$appointmentSuccessDialog$ar extends Translations$features$patient$appointmentSuccessDialog$en {
  _Translations$features$patient$appointmentSuccessDialog$ar._(TranslationsAr root) : this._root = root, super.internal(root);

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

// Path: features.patient.appointmentDetailsScreen
class _Translations$features$patient$appointmentDetailsScreen$ar extends Translations$features$patient$appointmentDetailsScreen$en {
  _Translations$features$patient$appointmentDetailsScreen$ar._(TranslationsAr root) : this._root = root, super.internal(root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get title => _root.features.admin.appointmentDetailsScreen.title;
  @override
  String get doctor => _root.features.admin.appointmentDetailsScreen.doctor;
  @override
  String get appointment => _root.features.admin.appointmentDetailsScreen.appointment;
  @override
  String get date => _root.core.common.date;
  @override
  String get time => _root.core.common.time;
  @override
  String get fee => _root.core.common.fee;
}

// Path: features.doctor.doctorMainScreen
class _Translations$features$doctor$doctorMainScreen$ar extends Translations$features$doctor$doctorMainScreen$en {
  _Translations$features$doctor$doctorMainScreen$ar._(TranslationsAr root) : this._root = root, super.internal(root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get mySchedule => 'جدول مواعيدي';
  @override
  String get appointments => _root.features.common.appointmentsManagement.title;
  @override
  String get settings => 'الإعدادات';
}

// Path: features.doctor.scheduleTab
class _Translations$features$doctor$scheduleTab$ar extends Translations$features$doctor$scheduleTab$en {
  _Translations$features$doctor$scheduleTab$ar._(TranslationsAr root) : this._root = root, super.internal(root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'جدول مواعيدي';
  @override
  String get today => _root.core.common.today;
  @override
  String get tomorrow => _root.core.common.tomorrow;
  @override
  String get next7Days => 'خلال 7 أيام';
  @override
  String get noAppointments => _root.core.widgets.appointment.noAppointmentsFound;
  @override
  String get refresh => 'تحديث';
}

// Path: features.doctor.doctorSettingsTab
class _Translations$features$doctor$doctorSettingsTab$ar extends Translations$features$doctor$doctorSettingsTab$en {
  _Translations$features$doctor$doctorSettingsTab$ar._(TranslationsAr root) : this._root = root, super.internal(root);

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
  String get changePassword => _root.core.common.changePassword;
  @override
  String get updateMasterSecurityCredentials => 'تحديث كلمة مرور حسابك';
  @override
  String get appInformation => _root.core.common.appInformation;
  @override
  String get v100 => _root.core.common.appVersionVal;
}

// Path: features.doctor.doctorProfileScreen
class _Translations$features$doctor$doctorProfileScreen$ar extends Translations$features$doctor$doctorProfileScreen$en {
  _Translations$features$doctor$doctorProfileScreen$ar._(TranslationsAr root) : this._root = root, super.internal(root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'الملف الشخصي للطبيب';
  @override
  String get personalInformation => 'المعلومات الشخصية';
  @override
  String get name => _root.core.common.name;
  @override
  String get phone => _root.core.common.phone;
  @override
  String get addPhoneNumber => _root.features.patient.patientProfileScreen.addPhoneNumber;
  @override
  String get speciality => _root.core.common.specialty;
  @override
  String get status => 'الحالة';
  @override
  String get active => _root.core.common.active;
  @override
  String get inactive => _root.core.common.inactive;
  @override
  String get fee => _root.core.common.fee;
  @override
  String get dataUpdatedSuccessfully => _root.core.common.dataUpdatedSuccessfully;
}

// Path: features.doctor.doctorOnboardingScreen
class _Translations$features$doctor$doctorOnboardingScreen$ar extends Translations$features$doctor$doctorOnboardingScreen$en {
  _Translations$features$doctor$doctorOnboardingScreen$ar._(TranslationsAr root) : this._root = root, super.internal(root);

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
  String get phoneNumber => _root.core.common.phoneNumber;
  @override
  String get phoneHint => '+20 100 000 0000';
  @override
  String get consultationFee => _root.core.common.consultationFee;
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

// Path: features.doctor.doctorAvailabilityScreen
class _Translations$features$doctor$doctorAvailabilityScreen$ar extends Translations$features$doctor$doctorAvailabilityScreen$en {
  _Translations$features$doctor$doctorAvailabilityScreen$ar._(TranslationsAr root) : this._root = root, super.internal(root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'أوقات توفر الطبيب';
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
  String get active => _root.core.common.active;
  @override
  String get inactive => _root.core.common.inactive;
  @override
  String get startTimeAndEndtimeMustBeDifferent => 'يجب أن يكون وقت البدء مختلفاً عن وقت الانتهاء';
  @override
  String get startTimeMustBeBeforeEndTime => 'يجب أن يكون وقت البدء قبل وقت الانتهاء';
  @override
  String get dataUpdatedSuccessfully => _root.core.common.dataUpdatedSuccessfully;
}

// Path: features.admin.adminMainScreen
class _Translations$features$admin$adminMainScreen$ar extends Translations$features$admin$adminMainScreen$en {
  _Translations$features$admin$adminMainScreen$ar._(TranslationsAr root) : this._root = root, super.internal(root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get doctors => 'الأطباء';
  @override
  String get patients => 'المرضى';
  @override
  String get appointments => _root.features.common.appointmentsManagement.title;
  @override
  String get settings => 'الإعدادات';
}

// Path: features.admin.adminDoctorsTab
class _Translations$features$admin$adminDoctorsTab$ar extends Translations$features$admin$adminDoctorsTab$en {
  _Translations$features$admin$adminDoctorsTab$ar._(TranslationsAr root) : this._root = root, super.internal(root);

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
  String get enabled => _root.core.common.enabled;
  @override
  String get disabled => _root.core.common.disabled;
  @override
  String get all => _root.core.common.all;
  @override
  String get dash => _root.core.common.dash;
  @override
  String get noDoctorNameOrSpecialtyMatchSearch => 'لا يوجد اسم طبيب أو تخصص يطابق البحث';
  @override
  String get noDoctors => 'لا يوجد أطباء';
  @override
  String get noDoctorsToSearchAddSome => 'لا يوجد أطباء للبحث، أضف بعض الأطباء';
}

// Path: features.admin.adminPatientsTab
class _Translations$features$admin$adminPatientsTab$ar extends Translations$features$admin$adminPatientsTab$en {
  _Translations$features$admin$adminPatientsTab$ar._(TranslationsAr root) : this._root = root, super.internal(root);

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

// Path: features.admin.adminSettingsTab
class _Translations$features$admin$adminSettingsTab$ar extends Translations$features$admin$adminSettingsTab$en {
  _Translations$features$admin$adminSettingsTab$ar._(TranslationsAr root) : this._root = root, super.internal(root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get adminProfile => 'الملف الشخصي للمسؤول';
  @override
  String get changePassword => _root.core.common.changePassword;
  @override
  String get appInformation => _root.core.common.appInformation;
  @override
  String get editSuperAdminDetailsPermissions => 'تعديل بيانات وصلاحيات المسؤول';
  @override
  String get updateMasterSecurityCredentials => 'تحديث بيانات الأمان الرئيسية';
  @override
  String get buildVersion => _root.core.common.buildVersion;
  @override
  String get v100 => _root.core.common.appVersionVal;
  @override
  String get logout => _root.core.common.logout;
  @override
  String get logoutConfirmation => _root.core.common.logoutConfirmation;
}

// Path: features.admin.adminProfileScreen
class _Translations$features$admin$adminProfileScreen$ar extends Translations$features$admin$adminProfileScreen$en {
  _Translations$features$admin$adminProfileScreen$ar._(TranslationsAr root) : this._root = root, super.internal(root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'الملف الشخصي';
  @override
  String get fullName => _root.core.common.fullName;
  @override
  String get emailAddress => 'البريد الإلكتروني';
  @override
  String get dataUpdatedSuccessfully => _root.core.common.dataUpdatedSuccessfully;
}

// Path: features.admin.addDoctorScreen
class _Translations$features$admin$addDoctorScreen$ar extends Translations$features$admin$addDoctorScreen$en {
  _Translations$features$admin$addDoctorScreen$ar._(TranslationsAr root) : this._root = root, super.internal(root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'إضافة طبيب';
  @override
  String get createDoctor => 'إضافة طبيب';
  @override
  String get selectSpecialty => 'اختر التخصص';
  @override
  String get doctorName => _root.core.common.name;
  @override
  String get email => _root.core.common.email;
  @override
  String get password => _root.core.common.password;
  @override
  String get emailExample => 'مثال: doctor@hospital.com';
  @override
  String get passwordExample => '••••••••';
  @override
  String get specialty => _root.core.common.specialty;
  @override
  String get consultationFee => _root.core.common.consultationFee;
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
  @override
  String get doctorAddedSuccessfully => 'تمت إضافة الطبيب بنجاح';
  @override
  String get youMustPickDoctorImage => 'يجب اختيار صورة للطبيب';
}

// Path: features.admin.doctorDetailsScreen
class _Translations$features$admin$doctorDetailsScreen$ar extends Translations$features$admin$doctorDetailsScreen$en {
  _Translations$features$admin$doctorDetailsScreen$ar._(TranslationsAr root) : this._root = root, super.internal(root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'تفاصيل الطبيب';
  @override
  String get specialty => _root.core.common.specialty;
  @override
  String get accountStatus => _root.core.widgets.statusSwitchTile.accountStatus;
  @override
  String get rating => 'التقييم';
  @override
  String get consultationFee => _root.core.common.consultationFee;
  @override
  String fee({required Object Fee}) => _root.core.widgets.appointment.feeValue(Fee: Fee);
  @override
  String get deleteDoctor => 'حذف الطبيب';
  @override
  String get deleteDoctorConfirmationTitle => 'تأكيد حذف الطبيب';
  @override
  String get deleteDoctorConfirmationMessage => 'هل أنت متأكد من حذف هذا الطبيب؟ لا يمكن التراجع عن هذا الإجراء.';
  @override
  String get doctorDeletedSuccessfully => 'تم حذف الطبيب بنجاح';
}

// Path: features.admin.updateDoctorDetailsScreen
class _Translations$features$admin$updateDoctorDetailsScreen$ar extends Translations$features$admin$updateDoctorDetailsScreen$en {
  _Translations$features$admin$updateDoctorDetailsScreen$ar._(TranslationsAr root) : this._root = root, super.internal(root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'تعديل بيانات الطبيب';
  @override
  String get changePhoto => 'تغيير الصورة';
  @override
  String get doctorStatus => 'حالة الطبيب';
  @override
  String get activeAndAvailable => 'نشط ومتاح';
  @override
  String get inactive => _root.core.common.inactive;
  @override
  String get deleteDoctor => _root.features.admin.doctorDetailsScreen.deleteDoctor;
  @override
  String get saveChanges => _root.core.common.saveChanges;
  @override
  String get doctorUpdatedSuccessfully => 'تم تحديث بيانات الطبيب بنجاح';
}

// Path: features.admin.appointmentDetailsScreen
class _Translations$features$admin$appointmentDetailsScreen$ar extends Translations$features$admin$appointmentDetailsScreen$en {
  _Translations$features$admin$appointmentDetailsScreen$ar._(TranslationsAr root) : this._root = root, super.internal(root);

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
  @override
  String get date => _root.core.common.date;
  @override
  String get time => _root.core.common.time;
  @override
  String get fee => _root.core.common.fee;
}

// Path: features.common.auth.forgotPasswordScreen
class _Translations$features$common$auth$forgotPasswordScreen$ar extends Translations$features$common$auth$forgotPasswordScreen$en {
  _Translations$features$common$auth$forgotPasswordScreen$ar._(TranslationsAr root) : this._root = root, super.internal(root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'نسيت كلمة المرور';
  @override
  String get email => _root.core.common.email;
  @override
  String get description => 'أدخل بريدك الإلكتروني وسنرسل لك رابطاً لإعادة تعيين كلمة المرور.';
  @override
  String get sendLink => 'إرسال الرابط';
  @override
  String get successDialogMessage =>
      'لقد أرسلنا بريداً إلكترونياً لإعادة تعيين كلمة المرور الخاصة بك. يرجى مراجعة صندوق الوارد أو البريد العشوائي (Spam).';
}

// Path: features.common.onboarding.pages.0
class _Translations$features$common$onboarding$pages$0$ar extends Translations$features$common$onboarding$pages$0$en with PageData {
  _Translations$features$common$onboarding$pages$0$ar._(TranslationsAr root) : this._root = root, super.internal(root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'ابحث عن أطباء موثوقين';
  @override
  String get subtitle => 'اعثر على أطباء موثوقين بالقرب منك. احصل على الرعاية التي تحتاجها من متخصصين ذوي خبرة.';
  @override
  String get imagePath => 'assets/images/on_boarding1.png';
}

// Path: features.common.onboarding.pages.1
class _Translations$features$common$onboarding$pages$1$ar extends Translations$features$common$onboarding$pages$1$en with PageData {
  _Translations$features$common$onboarding$pages$1$ar._(TranslationsAr root) : this._root = root, super.internal(root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'اختر أفضل الأطباء';
  @override
  String get subtitle => 'استكشف الأطباء وفقاً لاحتياجاتك، واختر الطبيب الأنسب لك.';
  @override
  String get imagePath => 'assets/images/on_boarding2.png';
}

// Path: features.common.onboarding.pages.2
class _Translations$features$common$onboarding$pages$2$ar extends Translations$features$common$onboarding$pages$2$en with PageData {
  _Translations$features$common$onboarding$pages$2$ar._(TranslationsAr root) : this._root = root, super.internal(root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'حجز مواعيد بسهولة';
  @override
  String get subtitle => 'احجز موعدك بلمسات بسيطة، وحدد الوقت الأنسب لجدولك.';
  @override
  String get imagePath => 'assets/images/on_boarding3.png';
}

// Path: features.common.chooseRole.patient
class _Translations$features$common$chooseRole$patient$ar extends Translations$features$common$chooseRole$patient$en {
  _Translations$features$common$chooseRole$patient$ar._(TranslationsAr root) : this._root = root, super.internal(root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'مريض';
  @override
  String get description => 'حجز المواعيد واستشارة الأطباء.';
}

// Path: features.common.chooseRole.admin
class _Translations$features$common$chooseRole$admin$ar extends Translations$features$common$chooseRole$admin$en {
  _Translations$features$common$chooseRole$admin$ar._(TranslationsAr root) : this._root = root, super.internal(root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'مسؤول';
  @override
  String get description => 'إدارة الأطباء وإعدادات التطبيق.';
}

// Path: features.common.chooseRole.doctor
class _Translations$features$common$chooseRole$doctor$ar extends Translations$features$common$chooseRole$doctor$en {
  _Translations$features$common$chooseRole$doctor$ar._(TranslationsAr root) : this._root = root, super.internal(root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'طبيب';
  @override
  String get description => 'إدارة المواعيد واستشارة المرضى.';
}

// Path: features.patient.privacyPolicyScreen.sections
class _Translations$features$patient$privacyPolicyScreen$sections$ar extends Translations$features$patient$privacyPolicyScreen$sections$en {
  _Translations$features$patient$privacyPolicyScreen$sections$ar._(TranslationsAr root) : this._root = root, super.internal(root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  late final _Translations$features$patient$privacyPolicyScreen$sections$informationWeCollect$ar informationWeCollect =
      _Translations$features$patient$privacyPolicyScreen$sections$informationWeCollect$ar._(_root);
  @override
  late final _Translations$features$patient$privacyPolicyScreen$sections$howWeUseInformation$ar howWeUseInformation =
      _Translations$features$patient$privacyPolicyScreen$sections$howWeUseInformation$ar._(_root);
  @override
  late final _Translations$features$patient$privacyPolicyScreen$sections$dataSecurity$ar dataSecurity =
      _Translations$features$patient$privacyPolicyScreen$sections$dataSecurity$ar._(_root);
  @override
  late final _Translations$features$patient$privacyPolicyScreen$sections$thirdPartyServices$ar thirdPartyServices =
      _Translations$features$patient$privacyPolicyScreen$sections$thirdPartyServices$ar._(_root);
  @override
  late final _Translations$features$patient$privacyPolicyScreen$sections$yourRights$ar yourRights =
      _Translations$features$patient$privacyPolicyScreen$sections$yourRights$ar._(_root);
  @override
  late final _Translations$features$patient$privacyPolicyScreen$sections$contactUs$ar contactUs =
      _Translations$features$patient$privacyPolicyScreen$sections$contactUs$ar._(_root);
}

// Path: features.patient.privacyPolicyScreen.sections.informationWeCollect
class _Translations$features$patient$privacyPolicyScreen$sections$informationWeCollect$ar
    extends Translations$features$patient$privacyPolicyScreen$sections$informationWeCollect$en {
  _Translations$features$patient$privacyPolicyScreen$sections$informationWeCollect$ar._(TranslationsAr root)
    : this._root = root,
      super.internal(root);

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

// Path: features.patient.privacyPolicyScreen.sections.howWeUseInformation
class _Translations$features$patient$privacyPolicyScreen$sections$howWeUseInformation$ar
    extends Translations$features$patient$privacyPolicyScreen$sections$howWeUseInformation$en {
  _Translations$features$patient$privacyPolicyScreen$sections$howWeUseInformation$ar._(TranslationsAr root) : this._root = root, super.internal(root);

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

// Path: features.patient.privacyPolicyScreen.sections.dataSecurity
class _Translations$features$patient$privacyPolicyScreen$sections$dataSecurity$ar
    extends Translations$features$patient$privacyPolicyScreen$sections$dataSecurity$en {
  _Translations$features$patient$privacyPolicyScreen$sections$dataSecurity$ar._(TranslationsAr root) : this._root = root, super.internal(root);

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

// Path: features.patient.privacyPolicyScreen.sections.thirdPartyServices
class _Translations$features$patient$privacyPolicyScreen$sections$thirdPartyServices$ar
    extends Translations$features$patient$privacyPolicyScreen$sections$thirdPartyServices$en {
  _Translations$features$patient$privacyPolicyScreen$sections$thirdPartyServices$ar._(TranslationsAr root) : this._root = root, super.internal(root);

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

// Path: features.patient.privacyPolicyScreen.sections.yourRights
class _Translations$features$patient$privacyPolicyScreen$sections$yourRights$ar
    extends Translations$features$patient$privacyPolicyScreen$sections$yourRights$en {
  _Translations$features$patient$privacyPolicyScreen$sections$yourRights$ar._(TranslationsAr root) : this._root = root, super.internal(root);

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

// Path: features.patient.privacyPolicyScreen.sections.contactUs
class _Translations$features$patient$privacyPolicyScreen$sections$contactUs$ar
    extends Translations$features$patient$privacyPolicyScreen$sections$contactUs$en {
  _Translations$features$patient$privacyPolicyScreen$sections$contactUs$ar._(TranslationsAr root) : this._root = root, super.internal(root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get title => '٦. تواصل معنا';
  @override
  String get description =>
      'إذا كانت لديك أي أسئلة أو استفسارات حول سياسة الخصوصية هذه أو حماية بياناتك، يرجى التواصل معنا عبر support@doctorhunt.com.';
}

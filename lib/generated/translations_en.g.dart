///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

part of 'translations.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element

class Translations with BaseTranslations<AppLocale, Translations> {
  /// Returns the current translations of the given [context].
  ///
  /// Usage:
  /// final t = Translations.of(context);
  static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

  /// You can call this constructor and build your own translation instance of this locale.
  /// Constructing via the enum [AppLocale.build] is preferred.
  Translations({
    Map<String, Node>? overrides,
    PluralResolver? cardinalResolver,
    PluralResolver? ordinalResolver,
    TranslationMetadata<AppLocale, Translations>? meta,
  }) : assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
       _meta =
           meta ??
           TranslationMetadata(
             locale: AppLocale.en,
             overrides: overrides ?? {},
             cardinalResolver: cardinalResolver,
             ordinalResolver: ordinalResolver,
           );

  /// Metadata for the translations of <en>.
  final TranslationMetadata<AppLocale, Translations> _meta;
  @override
  TranslationMetadata<AppLocale, Translations> get $meta => _meta;

  late final Translations _root = this; // ignore: unused_field

  Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

  // Translations
  late final Translations$core$en core = Translations$core$en.internal(_root);
  late final Translations$features$en features = Translations$features$en.internal(_root);
  late final Translations$clinicLocation$en clinicLocation = Translations$clinicLocation$en.internal(_root);
}

// Path: core
class Translations$core$en {
  Translations$core$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  late final Translations$core$common$en common = Translations$core$common$en.internal(_root);
  late final Translations$core$dialogs$en dialogs = Translations$core$dialogs$en.internal(_root);
  late final Translations$core$validators$en validators = Translations$core$validators$en.internal(_root);
  late final Translations$core$errors$en errors = Translations$core$errors$en.internal(_root);
  late final Translations$core$eCodes$en eCodes = Translations$core$eCodes$en.internal(_root);
  late final Translations$core$widgets$en widgets = Translations$core$widgets$en.internal(_root);
}

// Path: features
class Translations$features$en {
  Translations$features$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  late final Translations$features$common$en common = Translations$features$common$en.internal(_root);
  late final Translations$features$patient$en patient = Translations$features$patient$en.internal(_root);
  late final Translations$features$doctor$en doctor = Translations$features$doctor$en.internal(_root);
  late final Translations$features$admin$en admin = Translations$features$admin$en.internal(_root);
}

// Path: clinicLocation
class Translations$clinicLocation$en {
  Translations$clinicLocation$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Clinic Location'
  ///
  /// ar: 'موقع العيادة'
  String get title => 'Clinic Location';

  /// en: 'Set Clinic Location'
  ///
  /// ar: 'تحديد موقع العيادة'
  String get pickLocation => 'Set Clinic Location';

  /// en: 'Change Clinic Location'
  ///
  /// ar: 'تعديل موقع العيادة'
  String get changeLocation => 'Change Clinic Location';

  /// en: 'Remove Location'
  ///
  /// ar: 'إزالة الموقع'
  String get removeLocation => 'Remove Location';

  /// en: 'Are you sure you want to remove the clinic location?'
  ///
  /// ar: 'هل أنت متأكد من رغبتك في إزالة موقع العيادة؟'
  String get removeLocationConfirm => 'Are you sure you want to remove the clinic location?';

  /// en: 'Confirm Location'
  ///
  /// ar: 'تأكيد الموقع'
  String get confirmLocation => 'Confirm Location';

  /// en: 'Clinic location not set yet'
  ///
  /// ar: 'لم يقم الطبيب بتحديد موقع العيادة بعد'
  String get locationNotSet => 'Clinic location not set yet';

  /// en: 'Get Directions'
  ///
  /// ar: 'الاتجاهات'
  String get getDirections => 'Get Directions';

  /// en: 'Detecting address...'
  ///
  /// ar: 'جاري تحديد العنوان...'
  String get addressLoading => 'Detecting address...';

  /// en: 'Could not detect address. You can enter it manually.'
  ///
  /// ar: 'تعذر تحديد العنوان تلقائياً. يمكنك كتابته يدوياً.'
  String get addressFailed => 'Could not detect address. You can enter it manually.';

  /// en: 'Location permission is required to detect your current position.'
  ///
  /// ar: 'إذن الموقع مطلوب لتحديد موقعك الحالي.'
  String get permissionDenied => 'Location permission is required to detect your current position.';

  /// en: 'Location permission is permanently denied. Please enable it in device settings.'
  ///
  /// ar: 'تم رفض إذن الموقع بشكل دائم. يرجى تفعيله من إعدادات الهاتف.'
  String get permissionPermanentlyDenied => 'Location permission is permanently denied. Please enable it in device settings.';

  /// en: 'Device GPS is turned off. Please turn it on or drag the map manually.'
  ///
  /// ar: 'خدمة الموقع (GPS) مغلقة. يرجى تشغيلها أو سحب الخريطة يدوياً.'
  String get gpsDisabled => 'Device GPS is turned off. Please turn it on or drag the map manually.';

  /// en: 'No internet connection. Map tiles may not load properly.'
  ///
  /// ar: 'لا يوجد اتصال بالإنترنت. قد لا يتم تحميل تفاصيل الخريطة.'
  String get offlineWarning => 'No internet connection. Map tiles may not load properly.';

  /// en: 'Clinic street or building details'
  ///
  /// ar: 'تفاصيل شارع أو مبنى العيادة'
  String get clinicAddressHint => 'Clinic street or building details';

  /// en: 'Open Settings'
  ///
  /// ar: 'فتح الإعدادات'
  String get openSettings => 'Open Settings';

  /// en: 'Clinic Location (Optional)'
  ///
  /// ar: 'موقع العيادة (اختياري)'
  String get clinicLocationOptional => 'Clinic Location (Optional)';
}

// Path: core.common
class Translations$core$common$en {
  Translations$core$common$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Today'
  ///
  /// ar: 'اليوم'
  String get today => 'Today';

  /// en: 'Tomorrow'
  ///
  /// ar: 'غداً'
  String get tomorrow => 'Tomorrow';

  /// en: 'AM'
  ///
  /// ar: 'ص'
  String get am => 'AM';

  /// en: 'PM'
  ///
  /// ar: 'م'
  String get pm => 'PM';

  /// en: 'Min.'
  ///
  /// ar: 'دقيقة'
  String get min => 'Min.';

  List<String> get weekdays => ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'];

  /// en: 'Name'
  ///
  /// ar: 'الاسم'
  String get name => 'Name';

  /// en: 'Full Name'
  ///
  /// ar: 'الاسم الكامل'
  String get fullName => 'Full Name';

  /// en: 'Email'
  ///
  /// ar: 'البريد الإلكتروني'
  String get email => 'Email';

  /// en: 'Password'
  ///
  /// ar: 'كلمة المرور'
  String get password => 'Password';

  /// en: 'Phone'
  ///
  /// ar: 'رقم الهاتف'
  String get phone => 'Phone';

  /// en: 'Phone Number'
  ///
  /// ar: 'رقم الهاتف'
  String get phoneNumber => 'Phone Number';

  /// en: 'Specialty'
  ///
  /// ar: 'التخصص'
  String get specialty => 'Specialty';

  /// en: 'Consultation fee'
  ///
  /// ar: 'رسوم الاستشارة'
  String get consultationFee => 'Consultation fee';

  /// en: 'Date'
  ///
  /// ar: 'التاريخ'
  String get date => 'Date';

  /// en: 'Time'
  ///
  /// ar: 'الوقت'
  String get time => 'Time';

  /// en: 'Fee'
  ///
  /// ar: 'الرسوم'
  String get fee => 'Fee';

  /// en: '$ ${fee}'
  ///
  /// ar: '${fee} $'
  String feeValue({required Object Fee}) => '\$ ${Fee}';

  /// en: 'Active'
  ///
  /// ar: 'نشط'
  String get active => 'Active';

  /// en: 'Inactive'
  ///
  /// ar: 'غير نشط'
  String get inactive => 'Inactive';

  /// en: 'Enabled'
  ///
  /// ar: 'مفعل'
  String get enabled => 'Enabled';

  /// en: 'Disabled'
  ///
  /// ar: 'معطل'
  String get disabled => 'Disabled';

  /// en: 'All'
  ///
  /// ar: 'الكل'
  String get all => 'All';

  /// en: '-'
  ///
  /// ar: '-'
  String get dash => '-';

  /// en: 'Save Changes'
  ///
  /// ar: 'حفظ التغييرات'
  String get saveChanges => 'Save Changes';

  /// en: 'Logout'
  ///
  /// ar: 'تسجيل الخروج'
  String get logout => 'Logout';

  /// en: 'Change Password'
  ///
  /// ar: 'تغيير كلمة المرور'
  String get changePassword => 'Change Password';

  /// en: 'App Information'
  ///
  /// ar: 'معلومات التطبيق'
  String get appInformation => 'App Information';

  /// en: 'Build Version'
  ///
  /// ar: 'إصدار التطبيق'
  String get buildVersion => 'Build Version';

  /// en: 'v1.0.0'
  ///
  /// ar: 'v1.0.0'
  String get appVersionVal => 'v1.0.0';

  /// en: 'English'
  ///
  /// ar: 'الإنجليزية'
  String get english => 'English';

  /// en: 'Arabic'
  ///
  /// ar: 'العربية'
  String get arabic => 'Arabic';

  /// en: 'See all'
  ///
  /// ar: 'عرض الكل'
  String get seeAll => 'See all';

  /// en: 'search....'
  ///
  /// ar: 'بحث...'
  String get search => 'search....';

  /// en: 'View Details'
  ///
  /// ar: 'عرض التفاصيل'
  String get viewDetails => 'View Details';

  /// en: 'Data was updated successfully'
  ///
  /// ar: 'تم تحديث البيانات بنجاح'
  String get dataUpdatedSuccessfully => 'Data was updated successfully';

  /// en: 'Are you sure you want to logout?'
  ///
  /// ar: 'هل أنت متأكد من رغبتك في تسجيل الخروج؟'
  String get logoutConfirmation => 'Are you sure you want to logout?';
}

// Path: core.dialogs
class Translations$core$dialogs$en {
  Translations$core$dialogs$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Ok'
  ///
  /// ar: 'حسناً'
  String get ok => 'Ok';

  /// en: 'Cancel'
  ///
  /// ar: 'إلغاء'
  String get cancel => 'Cancel';

  /// en: 'Confirm'
  ///
  /// ar: 'تأكيد'
  String get confirm => 'Confirm';

  /// en: 'Success'
  ///
  /// ar: 'نجاح'
  String get success => 'Success';

  /// en: 'Error'
  ///
  /// ar: 'خطأ'
  String get error => 'Error';

  /// en: 'Registered Successfully, Please login.'
  ///
  /// ar: 'تم التسجيل بنجاح، يرجى تسجيل الدخول.'
  String get registeredSuccessfully => 'Registered Successfully, Please login.';
}

// Path: core.validators
class Translations$core$validators$en {
  Translations$core$validators$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'This field is required'
  ///
  /// ar: 'هذا الحقل مطلوب'
  String get thisFieldIsRequired => 'This field is required';

  /// en: 'Email is required'
  ///
  /// ar: 'البريد الإلكتروني مطلوب'
  String get emailIsRequired => 'Email is required';

  /// en: 'Invalid email format'
  ///
  /// ar: 'صيغة البريد الإلكتروني غير صالحة'
  String get invalidEmailFormat => 'Invalid email format';

  /// en: 'Password is required'
  ///
  /// ar: 'كلمة المرور مطلوبة'
  String get passwordIsRequired => 'Password is required';

  /// en: 'Confirm password is required'
  ///
  /// ar: 'تأكيد كلمة المرور مطلوب'
  String get confirmPasswordIsRequired => 'Confirm password is required';

  /// en: 'Passwords do not match'
  ///
  /// ar: 'كلمتا المرور غير متطابقتين'
  String get passwordsDoNotMatch => 'Passwords do not match';

  /// en: 'Phone number is required'
  ///
  /// ar: 'رقم الهاتف مطلوب'
  String get phoneIsRequired => 'Phone number is required';

  /// en: 'Invalid phone number'
  ///
  /// ar: 'رقم الهاتف غير صالح'
  String get invalidPhoneNumber => 'Invalid phone number';

  /// en: 'Password must be at least 6 characters'
  ///
  /// ar: 'يجب أن تتكون كلمة المرور من 6 أحرف على الأقل'
  String get passwordMustBeAtLeast6Characters => 'Password must be at least 6 characters';
}

// Path: core.errors
class Translations$core$errors$en {
  Translations$core$errors$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'No account associated with this email'
  ///
  /// ar: 'لا يوجد حساب مرتبط بهذا البريد الإلكتروني'
  String get noAccountAssociated => 'No account associated with this email';

  /// en: 'Account is disabled. Please contact the administrator.'
  ///
  /// ar: 'الحساب معطل. يرجى التواصل مع المسؤول.'
  String get accountDisabled => 'Account is disabled. Please contact the administrator.';

  /// en: 'Some thing went wrong'
  ///
  /// ar: 'حدث خطأ ما، يرجى المحاولة لاحقاً'
  String get someThingWentWrong => 'Some thing went wrong';

  /// en: 'Server error'
  ///
  /// ar: 'خطأ في الخادم'
  String get serverError => 'Server error';

  /// en: 'No internet'
  ///
  /// ar: 'لا يوجد اتصال بالإنترنت'
  String get noInternet => 'No internet';

  /// en: 'The email or password is incorrect'
  ///
  /// ar: 'البريد الإلكتروني أو كلمة المرور غير صحيحة'
  String get emailOrPasswordIsIncorrect => 'The email or password is incorrect';

  /// en: 'The email address is already in use by another account'
  ///
  /// ar: 'البريد الإلكتروني مستخدم بالفعل بواسطة حساب آخر'
  String get emailAddressAlreadyInUseByAnotherAccount => 'The email address is already in use by another account';

  /// en: 'User isn't Authenticated'
  ///
  /// ar: 'المستخدم غير مصرح له'
  String get userNotAuthenticated => 'User isn\'t Authenticated';

  /// en: 'User not logged in'
  ///
  /// ar: 'المستخدم غير مسجل الدخول'
  String get userNotLoggedIn => 'User not logged in';

  /// en: 'Error while adding doctor please try again later'
  ///
  /// ar: 'حدث خطأ أثناء إضافة الطبيب، يرجى المحاولة لاحقاً'
  String get errorWhileAddingDoctorPleaseTryAgainLater => 'Error while adding doctor please try again later';

  /// en: 'Error while updating doctor please try again later'
  ///
  /// ar: 'حدث خطأ أثناء تحديث بيانات الطبيب، يرجى المحاولة لاحقاً'
  String get errorWhileUpdatingDoctorPleaseTryAgainLater => 'Error while updating doctor please try again later';

  /// en: 'Failed to fetch appointments ${E}'
  ///
  /// ar: 'فشل جلب المواعيد: ${E}'
  String failedToFetchAppointments({required Object E}) => 'Failed to fetch appointments ${E}';

  /// en: 'Failed to book appointment ${E}'
  ///
  /// ar: 'فشل حجز الموعد: ${E}'
  String failedToBookAppointment({required Object E}) => 'Failed to book appointment ${E}';

  /// en: 'Failed to update appointment status ${E}'
  ///
  /// ar: 'فشل تحديث حالة الموعد: ${E}'
  String failedToUpdateAppointmentStatus({required Object E}) => 'Failed to update appointment status ${E}';

  /// en: 'This time slot is already booked. Please choose another slot.'
  ///
  /// ar: 'هذا الموعد محجوز بالفعل. يرجى اختيار موعد آخر.'
  String get slotAlreadyBooked => 'This time slot is already booked. Please choose another slot.';

  /// en: 'Cancelled by user'
  ///
  /// ar: 'تم الإلغاء بواسطة المستخدم'
  String get cancelledByUser => 'Cancelled by user';
}

// Path: core.eCodes
class Translations$core$eCodes$en {
  Translations$core$eCodes$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'web-user-interaction-failed'
  ///
  /// ar: 'web-user-interaction-failed'
  String get webUserInteractionFailed => 'web-user-interaction-failed';

  /// en: 'cancelled'
  ///
  /// ar: 'cancelled'
  String get cancelled => 'cancelled';

  /// en: 'invalid-credential'
  ///
  /// ar: 'invalid-credential'
  String get invalidCredential => 'invalid-credential';

  /// en: 'email-already-in-use'
  ///
  /// ar: 'email-already-in-use'
  String get emailAlreadyInUse => 'email-already-in-use';
}

// Path: core.widgets
class Translations$core$widgets$en {
  Translations$core$widgets$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  late final Translations$core$widgets$appointment$en appointment = Translations$core$widgets$appointment$en.internal(_root);
  late final Translations$core$widgets$statusSwitchTile$en statusSwitchTile = Translations$core$widgets$statusSwitchTile$en.internal(_root);
  late final Translations$core$widgets$languagePicker$en languagePicker = Translations$core$widgets$languagePicker$en.internal(_root);
}

// Path: features.common
class Translations$features$common$en {
  Translations$features$common$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  late final Translations$features$common$auth$en auth = Translations$features$common$auth$en.internal(_root);
  late final Translations$features$common$onboarding$en onboarding = Translations$features$common$onboarding$en.internal(_root);
  late final Translations$features$common$chooseRole$en chooseRole = Translations$features$common$chooseRole$en.internal(_root);
  late final Translations$features$common$appointmentsManagement$en appointmentsManagement =
      Translations$features$common$appointmentsManagement$en.internal(_root);
}

// Path: features.patient
class Translations$features$patient$en {
  Translations$features$patient$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  late final Translations$features$patient$mainScreen$en mainScreen = Translations$features$patient$mainScreen$en.internal(_root);
  late final Translations$features$patient$homeTab$en homeTab = Translations$features$patient$homeTab$en.internal(_root);
  late final Translations$features$patient$favouriteTab$en favouriteTab = Translations$features$patient$favouriteTab$en.internal(_root);
  late final Translations$features$patient$settingsTab$en settingsTab = Translations$features$patient$settingsTab$en.internal(_root);
  late final Translations$features$patient$patientProfileScreen$en patientProfileScreen =
      Translations$features$patient$patientProfileScreen$en.internal(_root);
  late final Translations$features$patient$privacyPolicyScreen$en privacyPolicyScreen = Translations$features$patient$privacyPolicyScreen$en.internal(
    _root,
  );
  late final Translations$features$patient$doctorDetailsScreen$en doctorDetailsScreen = Translations$features$patient$doctorDetailsScreen$en.internal(
    _root,
  );
  late final Translations$features$patient$selectTimeScreen$en selectTimeScreen = Translations$features$patient$selectTimeScreen$en.internal(_root);
  late final Translations$features$patient$appointmentSuccessDialog$en appointmentSuccessDialog =
      Translations$features$patient$appointmentSuccessDialog$en.internal(_root);
  late final Translations$features$patient$appointmentDetailsScreen$en appointmentDetailsScreen =
      Translations$features$patient$appointmentDetailsScreen$en.internal(_root);
}

// Path: features.doctor
class Translations$features$doctor$en {
  Translations$features$doctor$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  late final Translations$features$doctor$doctorMainScreen$en doctorMainScreen = Translations$features$doctor$doctorMainScreen$en.internal(_root);
  late final Translations$features$doctor$scheduleTab$en scheduleTab = Translations$features$doctor$scheduleTab$en.internal(_root);
  late final Translations$features$doctor$doctorSettingsTab$en doctorSettingsTab = Translations$features$doctor$doctorSettingsTab$en.internal(_root);
  late final Translations$features$doctor$doctorProfileScreen$en doctorProfileScreen = Translations$features$doctor$doctorProfileScreen$en.internal(
    _root,
  );
  late final Translations$features$doctor$doctorOnboardingScreen$en doctorOnboardingScreen =
      Translations$features$doctor$doctorOnboardingScreen$en.internal(_root);
  late final Translations$features$doctor$doctorAvailabilityScreen$en doctorAvailabilityScreen =
      Translations$features$doctor$doctorAvailabilityScreen$en.internal(_root);
}

// Path: features.admin
class Translations$features$admin$en {
  Translations$features$admin$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  late final Translations$features$admin$adminMainScreen$en adminMainScreen = Translations$features$admin$adminMainScreen$en.internal(_root);
  late final Translations$features$admin$adminDoctorsTab$en adminDoctorsTab = Translations$features$admin$adminDoctorsTab$en.internal(_root);
  late final Translations$features$admin$adminPatientsTab$en adminPatientsTab = Translations$features$admin$adminPatientsTab$en.internal(_root);
  late final Translations$features$admin$adminSettingsTab$en adminSettingsTab = Translations$features$admin$adminSettingsTab$en.internal(_root);
  late final Translations$features$admin$adminProfileScreen$en adminProfileScreen = Translations$features$admin$adminProfileScreen$en.internal(_root);
  late final Translations$features$admin$addDoctorScreen$en addDoctorScreen = Translations$features$admin$addDoctorScreen$en.internal(_root);
  late final Translations$features$admin$doctorDetailsScreen$en doctorDetailsScreen = Translations$features$admin$doctorDetailsScreen$en.internal(
    _root,
  );
  late final Translations$features$admin$updateDoctorDetailsScreen$en updateDoctorDetailsScreen =
      Translations$features$admin$updateDoctorDetailsScreen$en.internal(_root);
  late final Translations$features$admin$appointmentDetailsScreen$en appointmentDetailsScreen =
      Translations$features$admin$appointmentDetailsScreen$en.internal(_root);
}

// Path: core.widgets.appointment
class Translations$core$widgets$appointment$en {
  Translations$core$widgets$appointment$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Upcoming'
  ///
  /// ar: 'القادمة'
  String get upcoming => 'Upcoming';

  /// en: 'Completed'
  ///
  /// ar: 'المكتملة'
  String get completed => 'Completed';

  /// en: 'Canceled'
  ///
  /// ar: 'الملغاة'
  String get canceled => 'Canceled';

  /// en: 'Appointment date'
  ///
  /// ar: 'تاريخ الموعد'
  String get appointmentDate => 'Appointment date';

  /// en: 'Appointment time'
  ///
  /// ar: 'وقت الموعد'
  String get appointmentTime => 'Appointment time';

  /// en: 'Consultation fee'
  ///
  /// ar: 'رسوم الاستشارة'
  String get consultationFee => _root.core.common.consultationFee;

  /// en: '$ ${fee}'
  ///
  /// ar: '${fee} $'
  String feeValue({required Object Fee}) => _root.core.common.feeValue(Fee: Fee);

  /// en: 'Cancel Appointment'
  ///
  /// ar: 'إلغاء الموعد'
  String get cancelAppointment => 'Cancel Appointment';

  /// en: 'Rate Doctor'
  ///
  /// ar: 'تقييم الطبيب'
  String get rateDoctor => 'Rate Doctor';

  /// en: 'Mark as completed'
  ///
  /// ar: 'تحديد كمكتمل'
  String get markAsCompleted => 'Mark as completed';

  /// en: 'View Details'
  ///
  /// ar: 'عرض التفاصيل'
  String get viewDetails => _root.core.common.viewDetails;

  /// en: 'Tab to write a review'
  ///
  /// ar: 'اضغط لكتابة تقييم'
  String get tabToWriteReview => 'Tab to write a review';

  /// en: 'You must select at least one star'
  ///
  /// ar: 'يجب تحديد نجمة واحدة على الأقل'
  String get youMustSelectAtLeastOneStar => 'You must select at least one star';

  /// en: 'No Appointments Found'
  ///
  /// ar: 'لا توجد مواعيد'
  String get noAppointmentsFound => 'No Appointments Found';
}

// Path: core.widgets.statusSwitchTile
class Translations$core$widgets$statusSwitchTile$en {
  Translations$core$widgets$statusSwitchTile$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Account Status'
  ///
  /// ar: 'حالة الحساب'
  String get accountStatus => 'Account Status';

  /// en: 'Enabled'
  ///
  /// ar: 'مفعل'
  String get enabled => _root.core.common.enabled;

  /// en: 'Disabled'
  ///
  /// ar: 'معطل'
  String get disabled => _root.core.common.disabled;
}

// Path: core.widgets.languagePicker
class Translations$core$widgets$languagePicker$en {
  Translations$core$widgets$languagePicker$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Language'
  ///
  /// ar: 'اللغة'
  String get language => 'Language';

  /// en: 'English'
  ///
  /// ar: 'الإنجليزية'
  String get english => _root.core.common.english;

  /// en: 'Arabic'
  ///
  /// ar: 'العربية'
  String get arabic => _root.core.common.arabic;
}

// Path: features.common.auth
class Translations$features$common$auth$en {
  Translations$features$common$auth$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Welcome back'
  ///
  /// ar: 'مرحباً بعودتك'
  String get welcomeBack => 'Welcome back';

  /// en: 'You can search course, apply course and find scholarship for abroad studies'
  ///
  /// ar: 'يمكنك البحث عن دورات، التقديم عليها وإيجاد منح للدراسة بالخارج'
  String get authSubtitle => 'You can search course, apply course and find scholarship for abroad studies';

  /// en: 'Login to your admin account'
  ///
  /// ar: 'تسجيل الدخول إلى حساب المسؤول'
  String get adminSubtitle => 'Login to your admin account';

  /// en: 'Login to your doctor account'
  ///
  /// ar: 'تسجيل الدخول إلى حساب الطبيب'
  String get doctorSubtitle => 'Login to your doctor account';

  /// en: 'Login'
  ///
  /// ar: 'تسجيل الدخول'
  String get login => 'Login';

  /// en: 'Sign up'
  ///
  /// ar: 'إنشاء حساب'
  String get signUp => 'Sign up';

  /// en: 'Join us to start searching'
  ///
  /// ar: 'انضم إلينا للبدء في البحث'
  String get joinUs => 'Join us to start searching';

  /// en: 'Have an account? Log in'
  ///
  /// ar: 'لديك حساب بالفعل؟ سجل دخولك'
  String get haveAccount => 'Have an account? Log in';

  /// en: 'Don’t have an account? Join us'
  ///
  /// ar: 'ليس لديك حساب؟ انضم إلينا'
  String get noAccount => 'Don’t have an account? Join us';

  /// en: 'Forgot password'
  ///
  /// ar: 'نسيت كلمة المرور'
  String get forgotPassword => 'Forgot password';

  /// en: 'username'
  ///
  /// ar: 'اسم المستخدم'
  String get username => 'username';

  /// en: 'Email'
  ///
  /// ar: 'البريد الإلكتروني'
  String get email => _root.core.common.email;

  /// en: 'Password'
  ///
  /// ar: 'كلمة المرور'
  String get password => _root.core.common.password;

  /// en: 'Google'
  ///
  /// ar: 'جوجل'
  String get google => 'Google';

  /// en: 'I agree with the Terms of Service & Privacy Policy'
  ///
  /// ar: 'أوافق على شروط الخدمة وسياسة الخصوصية'
  String get agreeTerms => 'I agree with the Terms of Service & Privacy Policy';

  /// en: 'you must agree with the Terms of Service & Privacy Policy'
  ///
  /// ar: 'يجب أن توافق على شروط الخدمة وسياسة الخصوصية'
  String get youMustAgreeToTerms => 'you must agree with the Terms of Service & Privacy Policy';

  late final Translations$features$common$auth$forgotPasswordScreen$en forgotPasswordScreen =
      Translations$features$common$auth$forgotPasswordScreen$en.internal(_root);
}

// Path: features.common.onboarding
class Translations$features$common$onboarding$en {
  Translations$features$common$onboarding$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Next'
  ///
  /// ar: 'التالي'
  String get next => 'Next';

  /// en: 'Skip'
  ///
  /// ar: 'تخطي'
  String get skip => 'Skip';

  /// en: 'Get Started'
  ///
  /// ar: 'ابدأ الآن'
  String get getStarted => 'Get Started';

  List<PageData> get pages => [
    Translations$features$common$onboarding$pages$0$en.internal(_root),
    Translations$features$common$onboarding$pages$1$en.internal(_root),
    Translations$features$common$onboarding$pages$2$en.internal(_root),
  ];
}

// Path: features.common.chooseRole
class Translations$features$common$chooseRole$en {
  Translations$features$common$chooseRole$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Doctor Hunt'
  ///
  /// ar: 'دكتور هانت'
  String get title => 'Doctor Hunt';

  /// en: 'Choose your role'
  ///
  /// ar: 'اختر دورك'
  String get roleSelection => 'Choose your role';

  late final Translations$features$common$chooseRole$patient$en patient = Translations$features$common$chooseRole$patient$en.internal(_root);
  late final Translations$features$common$chooseRole$admin$en admin = Translations$features$common$chooseRole$admin$en.internal(_root);
  late final Translations$features$common$chooseRole$doctor$en doctor = Translations$features$common$chooseRole$doctor$en.internal(_root);
}

// Path: features.common.appointmentsManagement
class Translations$features$common$appointmentsManagement$en {
  Translations$features$common$appointmentsManagement$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Appointments'
  ///
  /// ar: 'المواعيد'
  String get title => 'Appointments';

  /// en: 'Upcoming'
  ///
  /// ar: 'القادمة'
  String get upcoming => _root.core.widgets.appointment.upcoming;

  /// en: 'Completed'
  ///
  /// ar: 'المكتملة'
  String get completed => _root.core.widgets.appointment.completed;

  /// en: 'Canceled'
  ///
  /// ar: 'الملغاة'
  String get canceled => _root.core.widgets.appointment.canceled;

  /// en: 'No Appointments Found'
  ///
  /// ar: 'لا توجد مواعيد'
  String get noAppointmentsFound => _root.core.widgets.appointment.noAppointmentsFound;
}

// Path: features.patient.mainScreen
class Translations$features$patient$mainScreen$en {
  Translations$features$patient$mainScreen$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Home'
  ///
  /// ar: 'الرئيسية'
  String get home => 'Home';

  /// en: 'Settings'
  ///
  /// ar: 'الإعدادات'
  String get settings => 'Settings';

  /// en: 'Appointments'
  ///
  /// ar: 'المواعيد'
  String get appointments => _root.features.common.appointmentsManagement.title;

  /// en: 'Favourite'
  ///
  /// ar: 'المفضلة'
  String get favourite => 'Favourite';
}

// Path: features.patient.homeTab
class Translations$features$patient$homeTab$en {
  Translations$features$patient$homeTab$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Hi ${name}'
  ///
  /// ar: 'أهلاً ${name}'
  String welcome({required Object Name}) => 'Hi ${Name}';

  /// en: 'Find Your Doctor'
  ///
  /// ar: 'ابحث عن طبيبك'
  String get findDoctor => 'Find Your Doctor';

  /// en: 'Popular Doctors'
  ///
  /// ar: 'الأطباء الأكثر طلباً'
  String get popularDoctors => 'Popular Doctors';

  /// en: 'Favourite Doctors'
  ///
  /// ar: 'الأطباء المفضلون'
  String get favouriteDoctors => 'Favourite Doctors';

  /// en: 'Top Rated Doctors'
  ///
  /// ar: 'الأعلى تقييماً'
  String get topRatedDoctors => 'Top Rated Doctors';

  /// en: 'See all'
  ///
  /// ar: 'عرض الكل'
  String get seeAll => _root.core.common.seeAll;

  /// en: 'search....'
  ///
  /// ar: 'بحث...'
  String get search => _root.core.common.search;
}

// Path: features.patient.favouriteTab
class Translations$features$patient$favouriteTab$en {
  Translations$features$patient$favouriteTab$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Favourite Doctors'
  ///
  /// ar: 'الأطباء المفضلون'
  String get title => _root.features.patient.homeTab.favouriteDoctors;

  /// en: 'No Favourite Doctors Match Search '
  ///
  /// ar: 'لا يوجد أطباء مفضلون يطابقون البحث'
  String get noFavouriteDoctorsMatchSearch => 'No Favourite Doctors Match Search ';

  /// en: 'You haven't added any doctors to your favourites yet.'
  ///
  /// ar: 'لم تقم بإضافة أي طبيب إلى المفضلة بعد.'
  String get noFavouriteDoctorsDescription => 'You haven\'t added any doctors to your favourites yet.';
}

// Path: features.patient.settingsTab
class Translations$features$patient$settingsTab$en {
  Translations$features$patient$settingsTab$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Settings'
  ///
  /// ar: 'الإعدادات'
  String get title => 'Settings';

  /// en: 'Account Settings'
  ///
  /// ar: 'إعدادات الحساب'
  String get accountSettings => 'Account Settings';

  /// en: 'Change Password'
  ///
  /// ar: 'تغيير كلمة المرور'
  String get changePassword => _root.core.common.changePassword;

  /// en: 'Notifications'
  ///
  /// ar: 'الإشعارات'
  String get notifications => 'Notifications';

  /// en: 'Privacy Policy'
  ///
  /// ar: 'سياسة الخصوصية'
  String get privacyPolicy => 'Privacy Policy';

  /// en: 'More Options'
  ///
  /// ar: 'خيارات إضافية'
  String get moreOptions => 'More Options';

  /// en: 'Language'
  ///
  /// ar: 'اللغة'
  String get language => _root.core.widgets.languagePicker.language;

  /// en: 'Build Version'
  ///
  /// ar: 'إصدار التطبيق'
  String get buildVersion => _root.core.common.buildVersion;

  /// en: 'v1.0.0'
  ///
  /// ar: 'v1.0.0'
  String get v100 => _root.core.common.appVersionVal;

  /// en: 'Logout'
  ///
  /// ar: 'تسجيل الخروج'
  String get logout => _root.core.common.logout;

  /// en: 'Are you sure you want to logout?'
  ///
  /// ar: 'هل أنت متأكد من رغبتك في تسجيل الخروج؟'
  String get logoutConfirmation => _root.core.common.logoutConfirmation;
}

// Path: features.patient.patientProfileScreen
class Translations$features$patient$patientProfileScreen$en {
  Translations$features$patient$patientProfileScreen$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Profile'
  ///
  /// ar: 'الملف الشخصي'
  String get title => 'Profile';

  /// en: 'Personal information'
  ///
  /// ar: 'المعلومات الشخصية'
  String get personalInformation => 'Personal information';

  /// en: 'Name'
  ///
  /// ar: 'الاسم'
  String get name => _root.core.common.name;

  /// en: 'Phone'
  ///
  /// ar: 'رقم الهاتف'
  String get phone => _root.core.common.phone;

  /// en: 'Add phone number'
  ///
  /// ar: 'إضافة رقم هاتف'
  String get addPhoneNumber => 'Add phone number';

  /// en: 'Data was updated successfully'
  ///
  /// ar: 'تم تحديث البيانات بنجاح'
  String get dataUpdatedSuccessfully => _root.core.common.dataUpdatedSuccessfully;
}

// Path: features.patient.privacyPolicyScreen
class Translations$features$patient$privacyPolicyScreen$en {
  Translations$features$patient$privacyPolicyScreen$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Privacy Policy'
  ///
  /// ar: 'سياسة الخصوصية'
  String get title => 'Privacy Policy';

  /// en: 'Last updated: October 2026'
  ///
  /// ar: 'آخر تحديث: أكتوبر 2026'
  String get lastUpdated => 'Last updated: October 2026';

  /// en: 'Doctor Hunt respects your privacy and is committed to protecting your personal and medical data. This Privacy Policy outlines how we collect, use, and protect your information when using our app.'
  ///
  /// ar: 'يحترم تطبيق دكتور هانت خصوصيتك ويلتزم بحماية بياناتك الشخصية والطبية. توضح سياسة الخصوصية هذه كيفية جمع معلوماتك واستخدامها وحمايتها عند استخدام تطبيقنا.'
  String get introduction =>
      'Doctor Hunt respects your privacy and is committed to protecting your personal and medical data. This Privacy Policy outlines how we collect, use, and protect your information when using our app.';

  late final Translations$features$patient$privacyPolicyScreen$sections$en sections =
      Translations$features$patient$privacyPolicyScreen$sections$en.internal(_root);
}

// Path: features.patient.doctorDetailsScreen
class Translations$features$patient$doctorDetailsScreen$en {
  Translations$features$patient$doctorDetailsScreen$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Doctor Details'
  ///
  /// ar: 'تفاصيل الطبيب'
  String get title => 'Doctor Details';

  /// en: 'Find Doctors'
  ///
  /// ar: 'البحث عن الأطباء'
  String get findDoctors => 'Find Doctors';

  /// en: 'Book now'
  ///
  /// ar: 'احجز الآن'
  String get bookNow => 'Book now';

  /// en: 'Services'
  ///
  /// ar: 'الخدمات'
  String get services => 'Services';

  List<String> get servicesList => [
    'Patient care should be the number one priority.',
    'If you run your practice you know how frustrating.',
    'That’s why some of appointment reminder system.',
  ];

  /// en: 'Running'
  ///
  /// ar: 'جاري'
  String get running => 'Running';

  /// en: 'Ongoing'
  ///
  /// ar: 'مستمر'
  String get ongoing => 'Ongoing';

  /// en: 'Patient'
  ///
  /// ar: 'مريض'
  String get patient => 'Patient';

  /// en: '${years} Years experience'
  ///
  /// ar: 'خبرة ${years} سنوات'
  String experience({required Object Years}) => '${Years} Years experience';

  /// en: '${count} Patient Stories'
  ///
  /// ar: '${count} تقييم من المرضى'
  String patientStories({required Object Count}) => '${Count} Patient Stories';

  /// en: 'Next Available'
  ///
  /// ar: 'الموعد المتاح القادم'
  String get nextAvailable => 'Next Available';

  /// en: 'Tomorrow'
  ///
  /// ar: 'غداً'
  String get tomorrow => _root.core.common.tomorrow;

  /// en: '${price}/ hours'
  ///
  /// ar: '${price}/ ساعة'
  String pricePerHour({required Object Price}) => '${Price}/ hours';

  /// en: 'Name'
  ///
  /// ar: 'الاسم'
  String get doctorName => _root.core.common.name;

  /// en: 'Tooth Dentist'
  ///
  /// ar: 'طبيب أسنان'
  String get toothDentist => 'Tooth Dentist';
}

// Path: features.patient.selectTimeScreen
class Translations$features$patient$selectTimeScreen$en {
  Translations$features$patient$selectTimeScreen$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Select Time'
  ///
  /// ar: 'تحديد الوقت'
  String get title => 'Select Time';

  /// en: 'No slots available'
  ///
  /// ar: 'لا تتوفر فترات متاحة'
  String get noSlotsAvailable => 'No slots available';

  /// en: '${number} Slot available'
  ///
  /// ar: '${number} موعد متاح'
  String slotAvailable({required Object Number}) => '${Number} Slot available';

  /// en: 'Morning ${number} Slots'
  ///
  /// ar: 'الفترة الصباحية: ${number} مواعيد'
  String morningSlots({required Object Number}) => 'Morning ${Number} Slots';

  /// en: 'Afternoon ${number} Slots'
  ///
  /// ar: 'فترة الظهيرة: ${number} مواعيد'
  String afternoonSlots({required Object Number}) => 'Afternoon ${Number} Slots';

  /// en: 'Evening ${number} Slots'
  ///
  /// ar: 'الفترة المسائية: ${number} مواعيد'
  String eveningSlots({required Object Number}) => 'Evening ${Number} Slots';

  /// en: 'Confirm'
  ///
  /// ar: 'تأكيد'
  String get confirm => _root.core.dialogs.confirm;

  /// en: 'You must select appointment time'
  ///
  /// ar: 'يجب اختيار وقت الموعد'
  String get youMustSelectAppointmentTime => 'You must select appointment time';
}

// Path: features.patient.appointmentSuccessDialog
class Translations$features$patient$appointmentSuccessDialog$en {
  Translations$features$patient$appointmentSuccessDialog$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Thank You !'
  ///
  /// ar: 'شكراً لك !'
  String get thankYou => 'Thank You !';

  /// en: 'Your Appointment Successful'
  ///
  /// ar: 'تم حجز موعدك بنجاح'
  String get success => 'Your Appointment Successful';

  /// en: 'You booked an appointment with ${doctor} on ${date}, at ${time}'
  ///
  /// ar: 'لقد حجزت موعداً مع ${doctor} في ${date}، الساعة ${time}'
  String bookingDetails({required Object Doctor, required Object Date, required Object Time}) =>
      'You booked an appointment with ${Doctor} on ${Date}, at ${Time}';

  /// en: 'Done'
  ///
  /// ar: 'تم'
  String get done => 'Done';
}

// Path: features.patient.appointmentDetailsScreen
class Translations$features$patient$appointmentDetailsScreen$en {
  Translations$features$patient$appointmentDetailsScreen$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Appointment Details'
  ///
  /// ar: 'تفاصيل الموعد'
  String get title => _root.features.admin.appointmentDetailsScreen.title;

  /// en: 'Doctor'
  ///
  /// ar: 'الطبيب'
  String get doctor => _root.features.admin.appointmentDetailsScreen.doctor;

  /// en: 'Appointment'
  ///
  /// ar: 'الموعد'
  String get appointment => _root.features.admin.appointmentDetailsScreen.appointment;

  /// en: 'Date'
  ///
  /// ar: 'التاريخ'
  String get date => _root.core.common.date;

  /// en: 'Time'
  ///
  /// ar: 'الوقت'
  String get time => _root.core.common.time;

  /// en: 'Fee'
  ///
  /// ar: 'الرسوم'
  String get fee => _root.core.common.fee;
}

// Path: features.doctor.doctorMainScreen
class Translations$features$doctor$doctorMainScreen$en {
  Translations$features$doctor$doctorMainScreen$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'My Schedule'
  ///
  /// ar: 'جدول مواعيدي'
  String get mySchedule => 'My Schedule';

  /// en: 'Appointments'
  ///
  /// ar: 'المواعيد'
  String get appointments => _root.features.common.appointmentsManagement.title;

  /// en: 'Settings'
  ///
  /// ar: 'الإعدادات'
  String get settings => 'Settings';
}

// Path: features.doctor.scheduleTab
class Translations$features$doctor$scheduleTab$en {
  Translations$features$doctor$scheduleTab$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'My Schedule'
  ///
  /// ar: 'جدول مواعيدي'
  String get title => 'My Schedule';

  /// en: 'Today'
  ///
  /// ar: 'اليوم'
  String get today => _root.core.common.today;

  /// en: 'Tomorrow'
  ///
  /// ar: 'غداً'
  String get tomorrow => _root.core.common.tomorrow;

  /// en: 'Next 7 Days'
  ///
  /// ar: 'خلال 7 أيام'
  String get next7Days => 'Next 7 Days';

  /// en: 'No Appointments Found'
  ///
  /// ar: 'لا توجد مواعيد'
  String get noAppointments => _root.core.widgets.appointment.noAppointmentsFound;

  /// en: 'Refresh'
  ///
  /// ar: 'تحديث'
  String get refresh => 'Refresh';
}

// Path: features.doctor.doctorSettingsTab
class Translations$features$doctor$doctorSettingsTab$en {
  Translations$features$doctor$doctorSettingsTab$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Doctor Settings'
  ///
  /// ar: 'إعدادات الطبيب'
  String get title => 'Doctor Settings';

  /// en: 'Doctor Profile'
  ///
  /// ar: 'الملف الشخصي للطبيب'
  String get doctorProfile => 'Doctor Profile';

  /// en: 'Edit your profile and consultation fee'
  ///
  /// ar: 'تعديل ملفك الشخصي ورسوم الاستشارة'
  String get editProfileDesc => 'Edit your profile and consultation fee';

  /// en: 'Manage Availability'
  ///
  /// ar: 'إدارة أوقات العمل'
  String get availability => 'Manage Availability';

  /// en: 'Update working days and working hours'
  ///
  /// ar: 'تحديث أيام وساعات العمل'
  String get availabilityDesc => 'Update working days and working hours';

  /// en: 'Change Password'
  ///
  /// ar: 'تغيير كلمة المرور'
  String get changePassword => _root.core.common.changePassword;

  /// en: 'Update your account password'
  ///
  /// ar: 'تحديث كلمة مرور حسابك'
  String get updateMasterSecurityCredentials => 'Update your account password';

  /// en: 'App Information'
  ///
  /// ar: 'معلومات التطبيق'
  String get appInformation => _root.core.common.appInformation;

  /// en: 'v1.0.0'
  ///
  /// ar: 'v1.0.0'
  String get v100 => _root.core.common.appVersionVal;
}

// Path: features.doctor.doctorProfileScreen
class Translations$features$doctor$doctorProfileScreen$en {
  Translations$features$doctor$doctorProfileScreen$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Doctor Profile'
  ///
  /// ar: 'الملف الشخصي للطبيب'
  String get title => 'Doctor Profile';

  /// en: 'Personal information'
  ///
  /// ar: 'المعلومات الشخصية'
  String get personalInformation => 'Personal information';

  /// en: 'Name'
  ///
  /// ar: 'الاسم'
  String get name => _root.core.common.name;

  /// en: 'Phone'
  ///
  /// ar: 'رقم الهاتف'
  String get phone => _root.core.common.phone;

  /// en: 'Add phone number'
  ///
  /// ar: 'إضافة رقم هاتف'
  String get addPhoneNumber => _root.features.patient.patientProfileScreen.addPhoneNumber;

  /// en: 'Specialty'
  ///
  /// ar: 'التخصص'
  String get speciality => _root.core.common.specialty;

  /// en: 'Status'
  ///
  /// ar: 'الحالة'
  String get status => 'Status';

  /// en: 'Active'
  ///
  /// ar: 'نشط'
  String get active => _root.core.common.active;

  /// en: 'Inactive'
  ///
  /// ar: 'غير نشط'
  String get inactive => _root.core.common.inactive;

  /// en: 'Fee'
  ///
  /// ar: 'الرسوم'
  String get fee => _root.core.common.fee;

  /// en: 'Data was updated successfully'
  ///
  /// ar: 'تم تحديث البيانات بنجاح'
  String get dataUpdatedSuccessfully => _root.core.common.dataUpdatedSuccessfully;
}

// Path: features.doctor.doctorOnboardingScreen
class Translations$features$doctor$doctorOnboardingScreen$en {
  Translations$features$doctor$doctorOnboardingScreen$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Welcome to Doctor Hunt!'
  ///
  /// ar: 'مرحباً بك في دكتور هانت!'
  String get welcomeTitle => 'Welcome to Doctor Hunt!';

  /// en: 'Let's complete your profile and set up your working schedule so patients can find and book appointments with you.'
  ///
  /// ar: 'دعنا نكمل ملفك الشخصي ونحدد جدول عملك ليتمكن المرضى من العثور عليك وحجز المواعيد معك.'
  String get welcomeSubtitle => 'Let\'s complete your profile and set up your working schedule so patients can find and book appointments with you.';

  /// en: 'Continue'
  ///
  /// ar: 'متابعة'
  String get continueBtn => 'Continue';

  /// en: 'Profile Details'
  ///
  /// ar: 'بيانات الملف الشخصي'
  String get stepProfileTitle => 'Profile Details';

  /// en: 'Please provide your contact information and consultation fee'
  ///
  /// ar: 'يرجى تقديم معلومات الاتصال ورسوم الاستشارة'
  String get stepProfileSubtitle => 'Please provide your contact information and consultation fee';

  /// en: 'Phone Number'
  ///
  /// ar: 'رقم الهاتف'
  String get phoneNumber => _root.core.common.phoneNumber;

  /// en: '+20 100 000 0000'
  ///
  /// ar: '+20 100 000 0000'
  String get phoneHint => '+20 100 000 0000';

  /// en: 'Consultation fee'
  ///
  /// ar: 'رسوم الاستشارة'
  String get consultationFee => _root.core.common.consultationFee;

  /// en: 'e.g. 200'
  ///
  /// ar: 'مثال: 200'
  String get feeHint => 'e.g. 200';

  /// en: 'Please choose a profile photo'
  ///
  /// ar: 'يرجى اختيار صورة للملف الشخصي'
  String get photoRequired => 'Please choose a profile photo';

  /// en: 'Choose Photo'
  ///
  /// ar: 'اختيار صورة'
  String get choosePhoto => 'Choose Photo';

  /// en: 'Change Photo'
  ///
  /// ar: 'تغيير الصورة'
  String get changePhoto => 'Change Photo';

  /// en: 'Working Schedule'
  ///
  /// ar: 'جدول العمل'
  String get stepAvailabilityTitle => 'Working Schedule';

  /// en: 'Set your working days and consultation hours'
  ///
  /// ar: 'حدد أيام عملك وساعات الاستشارة'
  String get stepAvailabilitySubtitle => 'Set your working days and consultation hours';

  /// en: 'Please select at least one working day'
  ///
  /// ar: 'يرجى اختيار يوم عمل واحد على الأقل'
  String get selectAtLeastOneDay => 'Please select at least one working day';

  /// en: 'Save & Complete'
  ///
  /// ar: 'حفظ وإكمال'
  String get saveAndContinue => 'Save & Complete';

  /// en: 'All Set!'
  ///
  /// ar: 'كل شيء جاهز!'
  String get successTitle => 'All Set!';

  /// en: 'Your profile and availability have been successfully updated. You are now ready to start receiving appointments.'
  ///
  /// ar: 'تم تحديث ملفك الشخصي ومواعيد توفرك بنجاح. أنت الآن جاهز لبدء استقبال المواعيد.'
  String get successSubtitle => 'Your profile and availability have been successfully updated. You are now ready to start receiving appointments.';

  /// en: 'Finish'
  ///
  /// ar: 'إنهاء'
  String get finish => 'Finish';
}

// Path: features.doctor.doctorAvailabilityScreen
class Translations$features$doctor$doctorAvailabilityScreen$en {
  Translations$features$doctor$doctorAvailabilityScreen$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Doctor Availability'
  ///
  /// ar: 'أوقات توفر الطبيب'
  String get title => 'Doctor Availability';

  /// en: 'Working Days'
  ///
  /// ar: 'أيام العمل'
  String get workingDays => 'Working Days';

  /// en: 'Working Hours'
  ///
  /// ar: 'ساعات العمل'
  String get workingHours => 'Working Hours';

  /// en: 'Start Time'
  ///
  /// ar: 'وقت البدء'
  String get startTime => 'Start Time';

  /// en: 'End Time'
  ///
  /// ar: 'وقت الانتهاء'
  String get endTime => 'End Time';

  /// en: 'Slot Duration'
  ///
  /// ar: 'مدة الموعد'
  String get slotDuration => 'Slot Duration';

  /// en: 'Active'
  ///
  /// ar: 'نشط'
  String get active => _root.core.common.active;

  /// en: 'Inactive'
  ///
  /// ar: 'غير نشط'
  String get inactive => _root.core.common.inactive;

  /// en: 'Start time and end time must be different'
  ///
  /// ar: 'يجب أن يكون وقت البدء مختلفاً عن وقت الانتهاء'
  String get startTimeAndEndtimeMustBeDifferent => 'Start time and end time must be different';

  /// en: 'Start time must be before end time'
  ///
  /// ar: 'يجب أن يكون وقت البدء قبل وقت الانتهاء'
  String get startTimeMustBeBeforeEndTime => 'Start time must be before end time';

  /// en: 'Data was updated successfully'
  ///
  /// ar: 'تم تحديث البيانات بنجاح'
  String get dataUpdatedSuccessfully => _root.core.common.dataUpdatedSuccessfully;
}

// Path: features.admin.adminMainScreen
class Translations$features$admin$adminMainScreen$en {
  Translations$features$admin$adminMainScreen$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Doctors'
  ///
  /// ar: 'الأطباء'
  String get doctors => 'Doctors';

  /// en: 'Patients'
  ///
  /// ar: 'المرضى'
  String get patients => 'Patients';

  /// en: 'Appointments'
  ///
  /// ar: 'المواعيد'
  String get appointments => _root.features.common.appointmentsManagement.title;

  /// en: 'Settings'
  ///
  /// ar: 'الإعدادات'
  String get settings => 'Settings';
}

// Path: features.admin.adminDoctorsTab
class Translations$features$admin$adminDoctorsTab$en {
  Translations$features$admin$adminDoctorsTab$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Create doctor'
  ///
  /// ar: 'إضافة طبيب'
  String get createDoctor => 'Create doctor';

  /// en: 'Search doctors'
  ///
  /// ar: 'البحث عن أطباء'
  String get searchDoctors => 'Search doctors';

  /// en: 'No Doctors Found'
  ///
  /// ar: 'لم يتم العثور على أطباء'
  String get noDoctorsFound => 'No Doctors Found';

  /// en: 'There are currently no doctors registered on Doctor Hunt. Add your first doctor to get started.'
  ///
  /// ar: 'لا يوجد أطباء مسجلون حالياً في دكتور هانت. أضف أول طبيب للبدء.'
  String get noDoctorsDescription => 'There are currently no doctors registered on Doctor Hunt. Add your first doctor to get started.';

  /// en: 'Total doctors'
  ///
  /// ar: 'إجمالي الأطباء'
  String get totalDoctors => 'Total doctors';

  /// en: 'Enabled'
  ///
  /// ar: 'مفعل'
  String get enabled => _root.core.common.enabled;

  /// en: 'Disabled'
  ///
  /// ar: 'معطل'
  String get disabled => _root.core.common.disabled;

  /// en: 'All'
  ///
  /// ar: 'الكل'
  String get all => _root.core.common.all;

  /// en: '-'
  ///
  /// ar: '-'
  String get dash => _root.core.common.dash;

  /// en: 'No doctor name or specialty match search'
  ///
  /// ar: 'لا يوجد اسم طبيب أو تخصص يطابق البحث'
  String get noDoctorNameOrSpecialtyMatchSearch => 'No doctor name or specialty match search';

  /// en: 'No doctors'
  ///
  /// ar: 'لا يوجد أطباء'
  String get noDoctors => 'No doctors';

  /// en: 'No doctors to search add some'
  ///
  /// ar: 'لا يوجد أطباء للبحث، أضف بعض الأطباء'
  String get noDoctorsToSearchAddSome => 'No doctors to search add some';
}

// Path: features.admin.adminPatientsTab
class Translations$features$admin$adminPatientsTab$en {
  Translations$features$admin$adminPatientsTab$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Patients'
  ///
  /// ar: 'المرضى'
  String get title => 'Patients';

  /// en: 'No patients found'
  ///
  /// ar: 'لا يوجد مرضى'
  String get noPatients => 'No patients found';

  /// en: 'Search patients...'
  ///
  /// ar: 'البحث عن المرضى...'
  String get searchHint => 'Search patients...';

  /// en: 'Delete Patient'
  ///
  /// ar: 'حذف المريض'
  String get deletePatient => 'Delete Patient';

  /// en: 'Delete Patient'
  ///
  /// ar: 'تأكيد حذف المريض'
  String get deletePatientConfirmationTitle => 'Delete Patient';

  /// en: 'Are you sure you want to delete this patient? This action cannot be undone.'
  ///
  /// ar: 'هل أنت متأكد من حذف هذا المريض؟ لا يمكن التراجع عن هذا الإجراء.'
  String get deletePatientConfirmationMessage => 'Are you sure you want to delete this patient? This action cannot be undone.';

  /// en: 'Patient was deleted successfully'
  ///
  /// ar: 'تم حذف المريض بنجاح'
  String get patientDeletedSuccessfully => 'Patient was deleted successfully';
}

// Path: features.admin.adminSettingsTab
class Translations$features$admin$adminSettingsTab$en {
  Translations$features$admin$adminSettingsTab$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Admin Profile'
  ///
  /// ar: 'الملف الشخصي للمسؤول'
  String get adminProfile => 'Admin Profile';

  /// en: 'Change Password'
  ///
  /// ar: 'تغيير كلمة المرور'
  String get changePassword => _root.core.common.changePassword;

  /// en: 'App Information'
  ///
  /// ar: 'معلومات التطبيق'
  String get appInformation => _root.core.common.appInformation;

  /// en: 'Edit super admin details & permissions'
  ///
  /// ar: 'تعديل بيانات وصلاحيات المسؤول'
  String get editSuperAdminDetailsPermissions => 'Edit super admin details & permissions';

  /// en: 'Update master security credentials'
  ///
  /// ar: 'تحديث بيانات الأمان الرئيسية'
  String get updateMasterSecurityCredentials => 'Update master security credentials';

  /// en: 'Build Version'
  ///
  /// ar: 'إصدار التطبيق'
  String get buildVersion => _root.core.common.buildVersion;

  /// en: 'v1.0.0'
  ///
  /// ar: 'v1.0.0'
  String get v100 => _root.core.common.appVersionVal;

  /// en: 'Logout'
  ///
  /// ar: 'تسجيل الخروج'
  String get logout => _root.core.common.logout;

  /// en: 'Are you sure you want to logout?'
  ///
  /// ar: 'هل أنت متأكد من رغبتك في تسجيل الخروج؟'
  String get logoutConfirmation => _root.core.common.logoutConfirmation;
}

// Path: features.admin.adminProfileScreen
class Translations$features$admin$adminProfileScreen$en {
  Translations$features$admin$adminProfileScreen$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Profile'
  ///
  /// ar: 'الملف الشخصي'
  String get title => 'Profile';

  /// en: 'Full Name'
  ///
  /// ar: 'الاسم الكامل'
  String get fullName => _root.core.common.fullName;

  /// en: 'Email Address'
  ///
  /// ar: 'البريد الإلكتروني'
  String get emailAddress => 'Email Address';

  /// en: 'Data was updated successfully'
  ///
  /// ar: 'تم تحديث البيانات بنجاح'
  String get dataUpdatedSuccessfully => _root.core.common.dataUpdatedSuccessfully;
}

// Path: features.admin.addDoctorScreen
class Translations$features$admin$addDoctorScreen$en {
  Translations$features$admin$addDoctorScreen$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Create doctor'
  ///
  /// ar: 'إضافة طبيب'
  String get title => 'Create doctor';

  /// en: 'Create doctor'
  ///
  /// ar: 'إضافة طبيب'
  String get createDoctor => 'Create doctor';

  /// en: 'Select specialty'
  ///
  /// ar: 'اختر التخصص'
  String get selectSpecialty => 'Select specialty';

  /// en: 'Name'
  ///
  /// ar: 'الاسم'
  String get doctorName => _root.core.common.name;

  /// en: 'Email'
  ///
  /// ar: 'البريد الإلكتروني'
  String get email => _root.core.common.email;

  /// en: 'Password'
  ///
  /// ar: 'كلمة المرور'
  String get password => _root.core.common.password;

  /// en: 'e.g. doctor@hospital.com'
  ///
  /// ar: 'مثال: doctor@hospital.com'
  String get emailExample => 'e.g. doctor@hospital.com';

  /// en: '••••••••'
  ///
  /// ar: '••••••••'
  String get passwordExample => '••••••••';

  /// en: 'Specialty'
  ///
  /// ar: 'التخصص'
  String get specialty => _root.core.common.specialty;

  /// en: 'Consultation fee'
  ///
  /// ar: 'رسوم الاستشارة'
  String get consultationFee => _root.core.common.consultationFee;

  /// en: 'e.g. Dr. Ahmed Ali'
  ///
  /// ar: 'مثال: د. أحمد علي'
  String get nameExample => 'e.g. Dr. Ahmed Ali';

  /// en: 'e.g. $ 28.00'
  ///
  /// ar: 'مثال: 28.00 $'
  String get feeExample => 'e.g. \$ 28.00';

  /// en: 'English Name'
  ///
  /// ar: 'الاسم بالإنجليزية'
  String get englishName => 'English Name';

  /// en: 'Arabic Name'
  ///
  /// ar: 'الاسم بالعربية'
  String get arabicName => 'Arabic Name';

  /// en: 'Add Specialty'
  ///
  /// ar: 'إضافة تخصص'
  String get addSpecialty => 'Add Specialty';

  /// en: 'Doctor was added Successfully'
  ///
  /// ar: 'تمت إضافة الطبيب بنجاح'
  String get doctorAddedSuccessfully => 'Doctor was added Successfully';

  /// en: 'You must pick doctor image'
  ///
  /// ar: 'يجب اختيار صورة للطبيب'
  String get youMustPickDoctorImage => 'You must pick doctor image';
}

// Path: features.admin.doctorDetailsScreen
class Translations$features$admin$doctorDetailsScreen$en {
  Translations$features$admin$doctorDetailsScreen$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Doctor details'
  ///
  /// ar: 'تفاصيل الطبيب'
  String get title => 'Doctor details';

  /// en: 'Specialty'
  ///
  /// ar: 'التخصص'
  String get specialty => _root.core.common.specialty;

  /// en: 'Account Status'
  ///
  /// ar: 'حالة الحساب'
  String get accountStatus => _root.core.widgets.statusSwitchTile.accountStatus;

  /// en: 'Rating'
  ///
  /// ar: 'التقييم'
  String get rating => 'Rating';

  /// en: 'Consultation fee'
  ///
  /// ar: 'رسوم الاستشارة'
  String get consultationFee => _root.core.common.consultationFee;

  /// en: '$ ${fee}'
  ///
  /// ar: '${fee} $'
  String fee({required Object Fee}) => _root.core.widgets.appointment.feeValue(Fee: Fee);

  /// en: 'Delete Doctor'
  ///
  /// ar: 'حذف الطبيب'
  String get deleteDoctor => 'Delete Doctor';

  /// en: 'Delete Doctor'
  ///
  /// ar: 'تأكيد حذف الطبيب'
  String get deleteDoctorConfirmationTitle => 'Delete Doctor';

  /// en: 'Are you sure you want to delete this doctor? This action cannot be undone.'
  ///
  /// ar: 'هل أنت متأكد من حذف هذا الطبيب؟ لا يمكن التراجع عن هذا الإجراء.'
  String get deleteDoctorConfirmationMessage => 'Are you sure you want to delete this doctor? This action cannot be undone.';

  /// en: 'Doctor was deleted successfully'
  ///
  /// ar: 'تم حذف الطبيب بنجاح'
  String get doctorDeletedSuccessfully => 'Doctor was deleted successfully';
}

// Path: features.admin.updateDoctorDetailsScreen
class Translations$features$admin$updateDoctorDetailsScreen$en {
  Translations$features$admin$updateDoctorDetailsScreen$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Edit doctor'
  ///
  /// ar: 'تعديل بيانات الطبيب'
  String get title => 'Edit doctor';

  /// en: 'Change photo'
  ///
  /// ar: 'تغيير الصورة'
  String get changePhoto => 'Change photo';

  /// en: 'Doctor Status'
  ///
  /// ar: 'حالة الطبيب'
  String get doctorStatus => 'Doctor Status';

  /// en: 'Active & Available'
  ///
  /// ar: 'نشط ومتاح'
  String get activeAndAvailable => 'Active & Available';

  /// en: 'Inactive'
  ///
  /// ar: 'غير نشط'
  String get inactive => _root.core.common.inactive;

  /// en: 'Delete Doctor'
  ///
  /// ar: 'حذف الطبيب'
  String get deleteDoctor => _root.features.admin.doctorDetailsScreen.deleteDoctor;

  /// en: 'Save Changes'
  ///
  /// ar: 'حفظ التغييرات'
  String get saveChanges => _root.core.common.saveChanges;

  /// en: 'Doctor was Updated Successfully'
  ///
  /// ar: 'تم تحديث بيانات الطبيب بنجاح'
  String get doctorUpdatedSuccessfully => 'Doctor was Updated Successfully';
}

// Path: features.admin.appointmentDetailsScreen
class Translations$features$admin$appointmentDetailsScreen$en {
  Translations$features$admin$appointmentDetailsScreen$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Appointment Details'
  ///
  /// ar: 'تفاصيل الموعد'
  String get title => 'Appointment Details';

  /// en: 'Patient'
  ///
  /// ar: 'المريض'
  String get patient => 'Patient';

  /// en: 'Doctor'
  ///
  /// ar: 'الطبيب'
  String get doctor => 'Doctor';

  /// en: 'Appointment'
  ///
  /// ar: 'الموعد'
  String get appointment => 'Appointment';

  /// en: 'Date'
  ///
  /// ar: 'التاريخ'
  String get date => _root.core.common.date;

  /// en: 'Time'
  ///
  /// ar: 'الوقت'
  String get time => _root.core.common.time;

  /// en: 'Fee'
  ///
  /// ar: 'الرسوم'
  String get fee => _root.core.common.fee;
}

// Path: features.common.auth.forgotPasswordScreen
class Translations$features$common$auth$forgotPasswordScreen$en {
  Translations$features$common$auth$forgotPasswordScreen$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Forgot Password'
  ///
  /// ar: 'نسيت كلمة المرور'
  String get title => 'Forgot Password';

  /// en: 'Email'
  ///
  /// ar: 'البريد الإلكتروني'
  String get email => _root.core.common.email;

  /// en: 'Enter your email address and we'll send you a link to reset your password.'
  ///
  /// ar: 'أدخل بريدك الإلكتروني وسنرسل لك رابطاً لإعادة تعيين كلمة المرور.'
  String get description => 'Enter your email address and we\'ll send you a link to reset your password.';

  /// en: 'Send Link'
  ///
  /// ar: 'إرسال الرابط'
  String get sendLink => 'Send Link';

  /// en: 'We've sent you an email to reset your password. Please check your inbox or spam folder.'
  ///
  /// ar: 'لقد أرسلنا بريداً إلكترونياً لإعادة تعيين كلمة المرور الخاصة بك. يرجى مراجعة صندوق الوارد أو البريد العشوائي (Spam).'
  String get successDialogMessage => 'We\'ve sent you an email to reset your password. Please check your inbox or spam folder.';
}

// Path: features.common.onboarding.pages.0
class Translations$features$common$onboarding$pages$0$en with PageData {
  Translations$features$common$onboarding$pages$0$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  @override
  String get title => 'Find Trusted Doctors';

  @override
  String get subtitle => 'Find trusted doctors near you. Get the care you need from experienced professionals.';

  @override
  String get imagePath => 'assets/images/on_boarding1.png';
}

// Path: features.common.onboarding.pages.1
class Translations$features$common$onboarding$pages$1$en with PageData {
  Translations$features$common$onboarding$pages$1$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  @override
  String get title => 'Choose Best Doctors';

  @override
  String get subtitle => 'Explore doctors based on your needs. Choose the one that’s right for you.';

  @override
  String get imagePath => 'assets/images/on_boarding2.png';
}

// Path: features.common.onboarding.pages.2
class Translations$features$common$onboarding$pages$2$en with PageData {
  Translations$features$common$onboarding$pages$2$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  @override
  String get title => 'Easy Appointments';

  @override
  String get subtitle => 'Book your appointment in just a few taps. Choose a time that works best for you.';

  @override
  String get imagePath => 'assets/images/on_boarding3.png';
}

// Path: features.common.chooseRole.patient
class Translations$features$common$chooseRole$patient$en {
  Translations$features$common$chooseRole$patient$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Patient'
  ///
  /// ar: 'مريض'
  String get title => 'Patient';

  /// en: 'Book appointments and consult with doctors.'
  ///
  /// ar: 'حجز المواعيد واستشارة الأطباء.'
  String get description => 'Book appointments and consult with doctors.';
}

// Path: features.common.chooseRole.admin
class Translations$features$common$chooseRole$admin$en {
  Translations$features$common$chooseRole$admin$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Admin'
  ///
  /// ar: 'مسؤول'
  String get title => 'Admin';

  /// en: 'Manage doctors and app settings.'
  ///
  /// ar: 'إدارة الأطباء وإعدادات التطبيق.'
  String get description => 'Manage doctors and app settings.';
}

// Path: features.common.chooseRole.doctor
class Translations$features$common$chooseRole$doctor$en {
  Translations$features$common$chooseRole$doctor$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Doctor'
  ///
  /// ar: 'طبيب'
  String get title => 'Doctor';

  /// en: 'Manage appointments and consult with patients.'
  ///
  /// ar: 'إدارة المواعيد واستشارة المرضى.'
  String get description => 'Manage appointments and consult with patients.';
}

// Path: features.patient.privacyPolicyScreen.sections
class Translations$features$patient$privacyPolicyScreen$sections$en {
  Translations$features$patient$privacyPolicyScreen$sections$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  late final Translations$features$patient$privacyPolicyScreen$sections$informationWeCollect$en informationWeCollect =
      Translations$features$patient$privacyPolicyScreen$sections$informationWeCollect$en.internal(_root);
  late final Translations$features$patient$privacyPolicyScreen$sections$howWeUseInformation$en howWeUseInformation =
      Translations$features$patient$privacyPolicyScreen$sections$howWeUseInformation$en.internal(_root);
  late final Translations$features$patient$privacyPolicyScreen$sections$dataSecurity$en dataSecurity =
      Translations$features$patient$privacyPolicyScreen$sections$dataSecurity$en.internal(_root);
  late final Translations$features$patient$privacyPolicyScreen$sections$thirdPartyServices$en thirdPartyServices =
      Translations$features$patient$privacyPolicyScreen$sections$thirdPartyServices$en.internal(_root);
  late final Translations$features$patient$privacyPolicyScreen$sections$yourRights$en yourRights =
      Translations$features$patient$privacyPolicyScreen$sections$yourRights$en.internal(_root);
  late final Translations$features$patient$privacyPolicyScreen$sections$contactUs$en contactUs =
      Translations$features$patient$privacyPolicyScreen$sections$contactUs$en.internal(_root);
}

// Path: features.patient.privacyPolicyScreen.sections.informationWeCollect
class Translations$features$patient$privacyPolicyScreen$sections$informationWeCollect$en {
  Translations$features$patient$privacyPolicyScreen$sections$informationWeCollect$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: '1. Information We Collect'
  ///
  /// ar: '١. المعلومات التي نجمعها'
  String get title => '1. Information We Collect';

  /// en: 'We collect information required to provide doctor booking and healthcare management services:'
  ///
  /// ar: 'نقوم بجمع المعلومات اللازمة لتقديم خدمات حجز الأطباء وإدارة الرعاية الصحية:'
  String get description => 'We collect information required to provide doctor booking and healthcare management services:';

  List<String> get bullets => [
    'Personal Identification: Name, email address, and phone number.',
    'Appointment Data: Selected doctors, appointment dates, times, and booking status.',
    'Medical Details: Basic consultation preferences and patient notes shared for appointments.',
    'Account & Technical Data: User role (Patient, Doctor, Admin) and system log data.',
  ];
}

// Path: features.patient.privacyPolicyScreen.sections.howWeUseInformation
class Translations$features$patient$privacyPolicyScreen$sections$howWeUseInformation$en {
  Translations$features$patient$privacyPolicyScreen$sections$howWeUseInformation$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: '2. How We Use Your Information'
  ///
  /// ar: '٢. كيف نستخدم معلوماتك'
  String get title => '2. How We Use Your Information';

  /// en: 'Your information is used strictly to deliver and improve our healthcare services:'
  ///
  /// ar: 'تُستخدم معلوماتك حصرياً لتقديم وتحسين خدمات الرعاية الصحية لدينا:'
  String get description => 'Your information is used strictly to deliver and improve our healthcare services:';

  List<String> get bullets => [
    'Facilitating doctor searches, appointment scheduling, and management.',
    'Sending appointment reminders and account updates.',
    'Ensuring secure login and authentication.',
    'Enhancing app performance and customer support experience.',
  ];
}

// Path: features.patient.privacyPolicyScreen.sections.dataSecurity
class Translations$features$patient$privacyPolicyScreen$sections$dataSecurity$en {
  Translations$features$patient$privacyPolicyScreen$sections$dataSecurity$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: '3. Data Security & Storage'
  ///
  /// ar: '٣. أمان البيانات وتخزينها'
  String get title => '3. Data Security & Storage';

  /// en: 'We take the security of your health and personal data seriously:'
  ///
  /// ar: 'نأخذ أمان بياناتك الصحية والشخصية على محمل الجد:'
  String get description => 'We take the security of your health and personal data seriously:';

  List<String> get bullets => [
    'Data is stored securely using encrypted cloud database infrastructure.',
    'Access controls restrict administrative and medical data to authorized users only.',
    'We regularly update our security practices to protect against unauthorized access.',
  ];
}

// Path: features.patient.privacyPolicyScreen.sections.thirdPartyServices
class Translations$features$patient$privacyPolicyScreen$sections$thirdPartyServices$en {
  Translations$features$patient$privacyPolicyScreen$sections$thirdPartyServices$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: '4. Third-Party Services'
  ///
  /// ar: '٤. خدمات الطرف الثالث'
  String get title => '4. Third-Party Services';

  /// en: 'We integrate trusted third-party services to ensure optimal performance:'
  ///
  /// ar: 'نقوم بدمج خدمات موثوقة من أطراف ثالثة لضمان الأداء الأمثل:'
  String get description => 'We integrate trusted third-party services to ensure optimal performance:';

  List<String> get bullets => [
    'Firebase: Used for secure user authentication and cloud database management.',
    'Cloudinary: Used for secure storage and delivery of profile and doctor images.',
    'We never sell, trade, or rent your personal data to third parties for marketing purposes.',
  ];
}

// Path: features.patient.privacyPolicyScreen.sections.yourRights
class Translations$features$patient$privacyPolicyScreen$sections$yourRights$en {
  Translations$features$patient$privacyPolicyScreen$sections$yourRights$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: '5. Your Rights & Control'
  ///
  /// ar: '٥. حقوقك وتحكمك بالبيانات'
  String get title => '5. Your Rights & Control';

  /// en: 'You have full control over your personal data within Doctor Hunt:'
  ///
  /// ar: 'لديك كامل التحكم في بياناتك الشخصية داخل تطبيق دكتور هانت:'
  String get description => 'You have full control over your personal data within Doctor Hunt:';

  List<String> get bullets => [
    'View and update your personal profile information at any time.',
    'Manage notification settings and reminders.',
    'Request account deletion or data erasure by contacting support.',
  ];
}

// Path: features.patient.privacyPolicyScreen.sections.contactUs
class Translations$features$patient$privacyPolicyScreen$sections$contactUs$en {
  Translations$features$patient$privacyPolicyScreen$sections$contactUs$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: '6. Contact Us'
  ///
  /// ar: '٦. تواصل معنا'
  String get title => '6. Contact Us';

  /// en: 'If you have any questions or concerns regarding this Privacy Policy or your data protection, please contact us at support@doctorhunt.com.'
  ///
  /// ar: 'إذا كانت لديك أي أسئلة أو استفسارات حول سياسة الخصوصية هذه أو حماية بياناتك، يرجى التواصل معنا عبر support@doctorhunt.com.'
  String get description =>
      'If you have any questions or concerns regarding this Privacy Policy or your data protection, please contact us at support@doctorhunt.com.';
}

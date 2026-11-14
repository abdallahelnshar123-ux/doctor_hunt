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
  late final Translations$auth$en auth = Translations$auth$en.internal(_root);
  late final Translations$forgotPassword$en forgotPassword = Translations$forgotPassword$en.internal(_root);
  late final Translations$onboarding$en onboarding = Translations$onboarding$en.internal(_root);
  late final Translations$chooseRole$en chooseRole = Translations$chooseRole$en.internal(_root);
  late final Translations$patientMain$en patientMain = Translations$patientMain$en.internal(_root);
  late final Translations$patientAppointments$en patientAppointments = Translations$patientAppointments$en.internal(_root);
  late final Translations$selectTime$en selectTime = Translations$selectTime$en.internal(_root);
  late final Translations$home$en home = Translations$home$en.internal(_root);
  late final Translations$favouriteDoctors$en favouriteDoctors = Translations$favouriteDoctors$en.internal(_root);
  late final Translations$settings$en settings = Translations$settings$en.internal(_root);
  late final Translations$profile$en profile = Translations$profile$en.internal(_root);
  late final Translations$privacyPolicy$en privacyPolicy = Translations$privacyPolicy$en.internal(_root);
  late final Translations$doctorDetails$en doctorDetails = Translations$doctorDetails$en.internal(_root);
  late final Translations$appointment$en appointment = Translations$appointment$en.internal(_root);
  late final Translations$createDoctor$en createDoctor = Translations$createDoctor$en.internal(_root);
  late final Translations$common$en common = Translations$common$en.internal(_root);
  late final Translations$dialog$en dialog = Translations$dialog$en.internal(_root);
  late final Translations$admin$en admin = Translations$admin$en.internal(_root);
  late final Translations$errors$en errors = Translations$errors$en.internal(_root);
  late final Translations$validators$en validators = Translations$validators$en.internal(_root);
  late final Translations$eCodes$en eCodes = Translations$eCodes$en.internal(_root);
  late final Translations$doctor$en doctor = Translations$doctor$en.internal(_root);
}

// Path: auth
class Translations$auth$en {
  Translations$auth$en.internal(this._root);

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

  /// en: 'Forgot password'
  ///
  /// ar: 'نسيت كلمة المرور'
  String get forgotPassword => 'Forgot password';

  /// en: 'Don’t have an account? Join us'
  ///
  /// ar: 'ليس لديك حساب؟ انضم إلينا'
  String get noAccount => 'Don’t have an account? Join us';

  /// en: 'Login'
  ///
  /// ar: 'تسجيل الدخول'
  String get login => 'Login';

  /// en: 'Join us to start searching'
  ///
  /// ar: 'انضم إلينا للبدء في البحث'
  String get joinUs => 'Join us to start searching';

  /// en: 'Have an account? Log in'
  ///
  /// ar: 'لديك حساب بالفعل؟ سجل دخولك'
  String get haveAccount => 'Have an account? Log in';

  /// en: 'I agree with the Terms of Service & Privacy Policy'
  ///
  /// ar: 'أوافق على شروط الخدمة وسياسة الخصوصية'
  String get agreeTerms => 'I agree with the Terms of Service & Privacy Policy';

  /// en: 'Sign up'
  ///
  /// ar: 'إنشاء حساب'
  String get signUp => 'Sign up';

  /// en: 'username'
  ///
  /// ar: 'اسم المستخدم'
  String get username => 'username';

  /// en: 'Password'
  ///
  /// ar: 'كلمة المرور'
  String get password => 'Password';

  /// en: 'Google'
  ///
  /// ar: 'جوجل'
  String get google => 'Google';

  /// en: 'you must agree with the Terms of Service & Privacy Policy'
  ///
  /// ar: 'يجب أن توافق على شروط الخدمة وسياسة الخصوصية'
  String get youMustAgreeToTerms => 'you must agree with the Terms of Service & Privacy Policy';

  /// en: 'email'
  ///
  /// ar: 'البريد الإلكتروني'
  String get email => 'email';

  /// en: 'Login to your doctor account'
  ///
  /// ar: 'تسجيل الدخول إلى حساب الطبيب'
  String get doctorSubtitle => 'Login to your doctor account';
}

// Path: forgotPassword
class Translations$forgotPassword$en {
  Translations$forgotPassword$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Forgot Password'
  ///
  /// ar: 'نسيت كلمة المرور'
  String get title => 'Forgot Password';

  /// en: 'Email'
  ///
  /// ar: 'البريد الإلكتروني'
  String get email => 'Email';

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

// Path: onboarding
class Translations$onboarding$en {
  Translations$onboarding$en.internal(this._root);

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
    Translations$onboarding$pages$0$en.internal(_root),
    Translations$onboarding$pages$1$en.internal(_root),
    Translations$onboarding$pages$2$en.internal(_root),
  ];
}

// Path: chooseRole
class Translations$chooseRole$en {
  Translations$chooseRole$en.internal(this._root);

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

  late final Translations$chooseRole$patient$en patient = Translations$chooseRole$patient$en.internal(_root);
  late final Translations$chooseRole$admin$en admin = Translations$chooseRole$admin$en.internal(_root);
  late final Translations$chooseRole$doctor$en doctor = Translations$chooseRole$doctor$en.internal(_root);
}

// Path: patientMain
class Translations$patientMain$en {
  Translations$patientMain$en.internal(this._root);

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
  String get appointments => 'Appointments';

  /// en: 'Favourite'
  ///
  /// ar: 'المفضلة'
  String get favourite => 'Favourite';
}

// Path: patientAppointments
class Translations$patientAppointments$en {
  Translations$patientAppointments$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Appointments'
  ///
  /// ar: 'المواعيد'
  String get title => 'Appointments';

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

  /// en: 'View Details'
  ///
  /// ar: 'عرض التفاصيل'
  String get viewDetails => 'View Details';

  /// en: 'Cancel Appointment'
  ///
  /// ar: 'إلغاء الموعد'
  String get cancelAppointment => 'Cancel Appointment';

  /// en: 'Rate Doctor'
  ///
  /// ar: 'تقييم الطبيب'
  String get rateDoctor => 'Rate Doctor';

  /// en: 'Appointment date'
  ///
  /// ar: 'تاريخ الموعد'
  String get appointmentDate => 'Appointment date';

  /// en: 'Consultation fee'
  ///
  /// ar: 'رسوم الاستشارة'
  String get consultationFee => 'Consultation fee';

  /// en: 'Appointment time'
  ///
  /// ar: 'وقت الموعد'
  String get appointmentTime => 'Appointment time';

  /// en: '$ ${fee}'
  ///
  /// ar: '${fee} $'
  String feeValue({required Object Fee}) => '\$ ${Fee}';

  /// en: 'No Appointments Found'
  ///
  /// ar: 'لا توجد مواعيد'
  String get noAppointmentsFound => 'No Appointments Found';

  /// en: 'Tab to write a review'
  ///
  /// ar: 'اضغط لكتابة تقييم'
  String get tabToWriteReview => 'Tab to write a review';

  /// en: 'You must select at least one star'
  ///
  /// ar: 'يجب تحديد نجمة واحدة على الأقل'
  String get youMustSelectAtLeastOneStar => 'You must select at least one star';
}

// Path: selectTime
class Translations$selectTime$en {
  Translations$selectTime$en.internal(this._root);

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
  String get confirm => 'Confirm';

  /// en: 'You must select appointment time'
  ///
  /// ar: 'يجب اختيار وقت الموعد'
  String get youMustSelectAppointmentTime => 'You must select appointment time';
}

// Path: home
class Translations$home$en {
  Translations$home$en.internal(this._root);

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
  String get seeAll => 'See all';

  /// en: 'search....'
  ///
  /// ar: 'بحث...'
  String get search => 'search....';
}

// Path: favouriteDoctors
class Translations$favouriteDoctors$en {
  Translations$favouriteDoctors$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'No Favourite Doctors Match Search '
  ///
  /// ar: 'لا يوجد أطباء مفضلون يطابقون البحث'
  String get noFavouriteDoctorsMatchSearch => 'No Favourite Doctors Match Search ';

  /// en: 'You haven't added any doctors to your favourites yet.'
  ///
  /// ar: 'لم تقم بإضافة أي طبيب إلى المفضلة بعد.'
  String get noFavouriteDoctorsDescription => 'You haven\'t added any doctors to your favourites yet.';
}

// Path: settings
class Translations$settings$en {
  Translations$settings$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Settings'
  ///
  /// ar: 'الإعدادات'
  String get title => 'Settings';

  /// en: 'Logout'
  ///
  /// ar: 'تسجيل الخروج'
  String get logout => 'Logout';

  /// en: 'Account Settings'
  ///
  /// ar: 'إعدادات الحساب'
  String get accountSettings => 'Account Settings';

  /// en: 'Change Password'
  ///
  /// ar: 'تغيير كلمة المرور'
  String get changePassword => 'Change Password';

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
  String get language => 'Language';

  /// en: 'Build Version'
  ///
  /// ar: 'إصدار التطبيق'
  String get buildVersion => 'Build Version';

  /// en: 'English'
  ///
  /// ar: 'الإنجليزية'
  String get english => 'English';

  /// en: 'Arabic'
  ///
  /// ar: 'العربية'
  String get arabic => 'Arabic';

  /// en: 'v1.0.0'
  ///
  /// ar: 'v1.0.0'
  String get v100 => 'v1.0.0';

  /// en: 'Are you sure you want to logout?'
  ///
  /// ar: 'هل أنت متأكد من رغبتك في تسجيل الخروج؟'
  String get logoutConfirmation => 'Are you sure you want to logout?';
}

// Path: profile
class Translations$profile$en {
  Translations$profile$en.internal(this._root);

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
  String get name => 'Name';

  /// en: 'Phone'
  ///
  /// ar: 'رقم الهاتف'
  String get phone => 'Phone';

  /// en: 'Data was updated successfully'
  ///
  /// ar: 'تم تحديث البيانات بنجاح'
  String get dataWasUpdatedSuccessfully => 'Data was updated successfully';

  /// en: 'Add phone number'
  ///
  /// ar: 'إضافة رقم هاتف'
  String get addPhoneNumber => 'Add phone number';
}

// Path: privacyPolicy
class Translations$privacyPolicy$en {
  Translations$privacyPolicy$en.internal(this._root);

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

  late final Translations$privacyPolicy$sections$en sections = Translations$privacyPolicy$sections$en.internal(_root);
}

// Path: doctorDetails
class Translations$doctorDetails$en {
  Translations$doctorDetails$en.internal(this._root);

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

  /// en: 'tomorrow'
  ///
  /// ar: 'غداً'
  String get tomorrow => 'tomorrow';

  /// en: '${price}/ hours'
  ///
  /// ar: '${price}/ ساعة'
  String pricePerHour({required Object Price}) => '${Price}/ hours';

  /// en: 'Doctor name'
  ///
  /// ar: 'اسم الطبيب'
  String get doctorName => 'Doctor name';

  /// en: 'Tooth Dentist'
  ///
  /// ar: 'طبيب أسنان'
  String get toothDentist => 'Tooth Dentist';
}

// Path: appointment
class Translations$appointment$en {
  Translations$appointment$en.internal(this._root);

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

// Path: createDoctor
class Translations$createDoctor$en {
  Translations$createDoctor$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Create doctor'
  ///
  /// ar: 'إضافة طبيب'
  String get title => 'Create doctor';

  /// en: 'Add photo'
  ///
  /// ar: 'إضافة صورة'
  String get addPhoto => 'Add photo';

  /// en: 'Doctor was added Successfully'
  ///
  /// ar: 'تمت إضافة الطبيب بنجاح'
  String get doctorAddedSuccessfully => 'Doctor was added Successfully';

  /// en: 'You must pick doctor image'
  ///
  /// ar: 'يجب اختيار صورة للطبيب'
  String get youMustPickDoctorImage => 'You must pick doctor image';
}

// Path: common
class Translations$common$en {
  Translations$common$en.internal(this._root);

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
}

// Path: dialog
class Translations$dialog$en {
  Translations$dialog$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Ok'
  ///
  /// ar: 'حسناً'
  String get ok => 'Ok';

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

  /// en: 'Cancel'
  ///
  /// ar: 'إلغاء'
  String get cancel => 'Cancel';

  /// en: 'Confirm'
  ///
  /// ar: 'تأكيد'
  String get confirm => 'Confirm';
}

// Path: admin
class Translations$admin$en {
  Translations$admin$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  late final Translations$admin$main$en main = Translations$admin$main$en.internal(_root);
  late final Translations$admin$patientsTab$en patientsTab = Translations$admin$patientsTab$en.internal(_root);
  late final Translations$admin$appointmentDetails$en appointmentDetails = Translations$admin$appointmentDetails$en.internal(_root);
  late final Translations$admin$doctorsTab$en doctorsTab = Translations$admin$doctorsTab$en.internal(_root);
  late final Translations$admin$appointmentsTab$en appointmentsTab = Translations$admin$appointmentsTab$en.internal(_root);
  late final Translations$admin$settings$en settings = Translations$admin$settings$en.internal(_root);
  late final Translations$admin$addDoctorScreen$en addDoctorScreen = Translations$admin$addDoctorScreen$en.internal(_root);
  late final Translations$admin$doctorDetailsScreen$en doctorDetailsScreen = Translations$admin$doctorDetailsScreen$en.internal(_root);
  late final Translations$admin$updateDoctorDetails$en updateDoctorDetails = Translations$admin$updateDoctorDetails$en.internal(_root);
  late final Translations$admin$profileScreen$en profileScreen = Translations$admin$profileScreen$en.internal(_root);
}

// Path: errors
class Translations$errors$en {
  Translations$errors$en.internal(this._root);

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

  /// en: 'This time slot is already booked. Please choose another slot.'
  ///
  /// ar: 'هذا الموعد محجوز بالفعل. يرجى اختيار موعد آخر.'
  String get slotAlreadyBooked => 'This time slot is already booked. Please choose another slot.';

  /// en: 'User not logged in'
  ///
  /// ar: 'المستخدم غير مسجل الدخول'
  String get userNotLoggedIn => 'User not logged in';

  /// en: 'Failed to update appointment status ${E}'
  ///
  /// ar: 'فشل تحديث حالة الموعد: ${E}'
  String failedToUpdateAppointmentStatus({required Object E}) => 'Failed to update appointment status ${E}';

  /// en: 'Cancelled by user'
  ///
  /// ar: 'تم الإلغاء بواسطة المستخدم'
  String get cancelledByUser => 'Cancelled by user';
}

// Path: validators
class Translations$validators$en {
  Translations$validators$en.internal(this._root);

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

// Path: eCodes
class Translations$eCodes$en {
  Translations$eCodes$en.internal(this._root);

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

// Path: doctor
class Translations$doctor$en {
  Translations$doctor$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  late final Translations$doctor$main$en main = Translations$doctor$main$en.internal(_root);
  late final Translations$doctor$settings$en settings = Translations$doctor$settings$en.internal(_root);
  late final Translations$doctor$onboarding$en onboarding = Translations$doctor$onboarding$en.internal(_root);
  late final Translations$doctor$availability$en availability = Translations$doctor$availability$en.internal(_root);
  late final Translations$doctor$profile$en profile = Translations$doctor$profile$en.internal(_root);
  late final Translations$doctor$schedule$en schedule = Translations$doctor$schedule$en.internal(_root);
}

// Path: onboarding.pages.0
class Translations$onboarding$pages$0$en with PageData {
  Translations$onboarding$pages$0$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  @override
  String get title => 'Find Trusted Doctors';

  @override
  String get subtitle => 'Find trusted doctors near you. Get the care you need from experienced professionals.';

  @override
  String get imagePath => 'assets/images/on_boarding1.png';
}

// Path: onboarding.pages.1
class Translations$onboarding$pages$1$en with PageData {
  Translations$onboarding$pages$1$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  @override
  String get title => 'Choose Best Doctors';

  @override
  String get subtitle => 'Explore doctors based on your needs. Choose the one that’s right for you.';

  @override
  String get imagePath => 'assets/images/on_boarding2.png';
}

// Path: onboarding.pages.2
class Translations$onboarding$pages$2$en with PageData {
  Translations$onboarding$pages$2$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  @override
  String get title => 'Easy Appointments';

  @override
  String get subtitle => 'Book your appointment in just a few taps. Choose a time that works best for you.';

  @override
  String get imagePath => 'assets/images/on_boarding3.png';
}

// Path: chooseRole.patient
class Translations$chooseRole$patient$en {
  Translations$chooseRole$patient$en.internal(this._root);

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

// Path: chooseRole.admin
class Translations$chooseRole$admin$en {
  Translations$chooseRole$admin$en.internal(this._root);

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

// Path: chooseRole.doctor
class Translations$chooseRole$doctor$en {
  Translations$chooseRole$doctor$en.internal(this._root);

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

// Path: privacyPolicy.sections
class Translations$privacyPolicy$sections$en {
  Translations$privacyPolicy$sections$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  late final Translations$privacyPolicy$sections$informationWeCollect$en informationWeCollect =
      Translations$privacyPolicy$sections$informationWeCollect$en.internal(_root);
  late final Translations$privacyPolicy$sections$howWeUseInformation$en howWeUseInformation =
      Translations$privacyPolicy$sections$howWeUseInformation$en.internal(_root);
  late final Translations$privacyPolicy$sections$dataSecurity$en dataSecurity = Translations$privacyPolicy$sections$dataSecurity$en.internal(_root);
  late final Translations$privacyPolicy$sections$thirdPartyServices$en thirdPartyServices =
      Translations$privacyPolicy$sections$thirdPartyServices$en.internal(_root);
  late final Translations$privacyPolicy$sections$yourRights$en yourRights = Translations$privacyPolicy$sections$yourRights$en.internal(_root);
  late final Translations$privacyPolicy$sections$contactUs$en contactUs = Translations$privacyPolicy$sections$contactUs$en.internal(_root);
}

// Path: admin.main
class Translations$admin$main$en {
  Translations$admin$main$en.internal(this._root);

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

  /// en: 'Settings'
  ///
  /// ar: 'الإعدادات'
  String get settings => 'Settings';
}

// Path: admin.patientsTab
class Translations$admin$patientsTab$en {
  Translations$admin$patientsTab$en.internal(this._root);

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

// Path: admin.appointmentDetails
class Translations$admin$appointmentDetails$en {
  Translations$admin$appointmentDetails$en.internal(this._root);

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
}

// Path: admin.doctorsTab
class Translations$admin$doctorsTab$en {
  Translations$admin$doctorsTab$en.internal(this._root);

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

// Path: admin.appointmentsTab
class Translations$admin$appointmentsTab$en {
  Translations$admin$appointmentsTab$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Appointments'
  ///
  /// ar: 'المواعيد'
  String get title => 'Appointments';

  /// en: 'Time'
  ///
  /// ar: 'الوقت'
  String get time => 'Time';

  /// en: 'Date'
  ///
  /// ar: 'التاريخ'
  String get date => 'Date';

  /// en: 'Fee'
  ///
  /// ar: 'الرسوم'
  String get fee => 'Fee';

  /// en: 'Mark as completed'
  ///
  /// ar: 'تحديد كمكتمل'
  String get markAsCompleted => 'Mark as completed';
}

// Path: admin.settings
class Translations$admin$settings$en {
  Translations$admin$settings$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Admin Profile'
  ///
  /// ar: 'الملف الشخصي للمسؤول'
  String get adminProfile => 'Admin Profile';

  /// en: 'Change Password'
  ///
  /// ar: 'تغيير كلمة المرور'
  String get changePassword => 'Change Password';

  /// en: 'App Information'
  ///
  /// ar: 'معلومات التطبيق'
  String get appInformation => 'App Information';

  /// en: 'Edit super admin details & permissions'
  ///
  /// ar: 'تعديل بيانات وصلاحيات المسؤول'
  String get editSuperAdminDetailsPermissions => 'Edit super admin details & permissions';

  /// en: 'Update master security credentials'
  ///
  /// ar: 'تحديث بيانات الأمان الرئيسية'
  String get updateMasterSecurityCredentials => 'Update master security credentials';

  /// en: 'v1.0.0'
  ///
  /// ar: 'v1.0.0'
  String get v100 => 'v1.0.0';
}

// Path: admin.addDoctorScreen
class Translations$admin$addDoctorScreen$en {
  Translations$admin$addDoctorScreen$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Create doctor'
  ///
  /// ar: 'إضافة طبيب'
  String get createDoctor => 'Create doctor';

  /// en: 'Select specialty'
  ///
  /// ar: 'اختر التخصص'
  String get selectSpecialty => 'Select specialty';

  /// en: 'Doctor name'
  ///
  /// ar: 'اسم الطبيب'
  String get doctorName => 'Doctor name';

  /// en: 'Email'
  ///
  /// ar: 'البريد الإلكتروني'
  String get email => 'Email';

  /// en: 'Password'
  ///
  /// ar: 'كلمة المرور'
  String get password => 'Password';

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
  String get specialty => 'Specialty';

  /// en: 'Consultation fee'
  ///
  /// ar: 'رسوم الاستشارة'
  String get consultationFee => 'Consultation fee';

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
}

// Path: admin.doctorDetailsScreen
class Translations$admin$doctorDetailsScreen$en {
  Translations$admin$doctorDetailsScreen$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Doctor details'
  ///
  /// ar: 'تفاصيل الطبيب'
  String get doctorDetails => 'Doctor details';

  /// en: 'Specialty'
  ///
  /// ar: 'التخصص'
  String get specialty => 'Specialty';

  /// en: 'Account Status'
  ///
  /// ar: 'حالة الحساب'
  String get accountStatus => 'Account Status';

  /// en: 'Heart Care'
  ///
  /// ar: 'رعاية القلب'
  String get heartCare => 'Heart Care';

  /// en: 'Delete Doctor'
  ///
  /// ar: 'حذف الطبيب'
  String get deleteDoctor => 'Delete Doctor';

  /// en: 'Doctor was deleted successfully'
  ///
  /// ar: 'تم حذف الطبيب بنجاح'
  String get doctorDeletedSuccessfully => 'Doctor was deleted successfully';

  /// en: 'Delete Doctor'
  ///
  /// ar: 'تأكيد حذف الطبيب'
  String get deleteDoctorConfirmationTitle => 'Delete Doctor';

  /// en: 'Are you sure you want to delete this doctor? This action cannot be undone.'
  ///
  /// ar: 'هل أنت متأكد من حذف هذا الطبيب؟ لا يمكن التراجع عن هذا الإجراء.'
  String get deleteDoctorConfirmationMessage => 'Are you sure you want to delete this doctor? This action cannot be undone.';

  /// en: 'Rating'
  ///
  /// ar: 'التقييم'
  String get rating => 'Rating';

  /// en: 'Consultation Fee'
  ///
  /// ar: 'رسوم الاستشارة'
  String get consultationFee => 'Consultation Fee';

  /// en: '$ ${price}'
  ///
  /// ar: '${price} $'
  String fee({required Object Price}) => '\$ ${Price}';
}

// Path: admin.updateDoctorDetails
class Translations$admin$updateDoctorDetails$en {
  Translations$admin$updateDoctorDetails$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Doctor was Updated Successfully'
  ///
  /// ar: 'تم تحديث بيانات الطبيب بنجاح'
  String get doctorWasUpdatedSuccessfully => 'Doctor was Updated Successfully';

  /// en: 'Edit doctor'
  ///
  /// ar: 'تعديل بيانات الطبيب'
  String get editDoctor => 'Edit doctor';

  /// en: 'Change photo'
  ///
  /// ar: 'تغيير الصورة'
  String get changePhoto => 'Change photo';

  /// en: 'Doctor Statues'
  ///
  /// ar: 'حالة الطبيب'
  String get doctorStatues => 'Doctor Statues';

  /// en: 'Active & Available'
  ///
  /// ar: 'نشط ومتاح'
  String get activeAndAvailable => 'Active & Available';

  /// en: 'Inactive'
  ///
  /// ar: 'غير نشط'
  String get inactive => 'Inactive';

  /// en: 'Delete Doctor'
  ///
  /// ar: 'حذف الطبيب'
  String get deleteDoctor => 'Delete Doctor';

  /// en: 'Save Changes'
  ///
  /// ar: 'حفظ التغييرات'
  String get saveChanges => 'Save Changes';
}

// Path: admin.profileScreen
class Translations$admin$profileScreen$en {
  Translations$admin$profileScreen$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Profile'
  ///
  /// ar: 'الملف الشخصي'
  String get title => 'Profile';

  /// en: 'Full Name'
  ///
  /// ar: 'الاسم الكامل'
  String get fullName => 'Full Name';

  /// en: 'Email Address'
  ///
  /// ar: 'البريد الإلكتروني'
  String get emailAddress => 'Email Address';
}

// Path: doctor.main
class Translations$doctor$main$en {
  Translations$doctor$main$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'My Schedule'
  ///
  /// ar: 'جدول مواعيدي'
  String get mySchedule => 'My Schedule';

  /// en: 'Appointments'
  ///
  /// ar: 'المواعيد'
  String get appointments => _root.patientMain.appointments;

  /// en: 'Settings'
  ///
  /// ar: 'الإعدادات'
  String get settings => 'Settings';
}

// Path: doctor.settings
class Translations$doctor$settings$en {
  Translations$doctor$settings$en.internal(this._root);

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
  String get changePassword => 'Change Password';

  /// en: 'Update your account password'
  ///
  /// ar: 'تحديث كلمة مرور حسابك'
  String get updateMasterSecurityCredentials => 'Update your account password';

  /// en: 'App Information'
  ///
  /// ar: 'معلومات التطبيق'
  String get appInformation => 'App Information';

  /// en: 'v1.0.0'
  ///
  /// ar: 'v1.0.0'
  String get v100 => 'v1.0.0';
}

// Path: doctor.onboarding
class Translations$doctor$onboarding$en {
  Translations$doctor$onboarding$en.internal(this._root);

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
  String get phoneNumber => 'Phone Number';

  /// en: '+20 100 000 0000'
  ///
  /// ar: '+20 100 000 0000'
  String get phoneHint => '+20 100 000 0000';

  /// en: 'Consultation Fee'
  ///
  /// ar: 'رسوم الاستشارة'
  String get consultationFee => 'Consultation Fee';

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

// Path: doctor.availability
class Translations$doctor$availability$en {
  Translations$doctor$availability$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Doctor Availability'
  ///
  /// ar: 'أوقات توفر الطبيب'
  String get doctorAvailability => 'Doctor Availability';

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
  String get active => 'Active';

  /// en: 'Inactive'
  ///
  /// ar: 'غير نشط'
  String get inactive => 'Inactive';

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
  String get dataWasUpdatedSuccessfully => 'Data was updated successfully';
}

// Path: doctor.profile
class Translations$doctor$profile$en {
  Translations$doctor$profile$en.internal(this._root);

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
  String get name => 'Name';

  /// en: 'Phone'
  ///
  /// ar: 'الهاتف'
  String get phone => 'Phone';

  /// en: 'Data was updated successfully'
  ///
  /// ar: 'تم تحديث البيانات بنجاح'
  String get dataWasUpdatedSuccessfully => 'Data was updated successfully';

  /// en: 'Specialty'
  ///
  /// ar: 'التخصص'
  String get speciality => 'Specialty';

  /// en: 'Status'
  ///
  /// ar: 'الحالة'
  String get status => 'Status';

  /// en: 'Active'
  ///
  /// ar: 'نشط'
  String get active => 'Active';

  /// en: 'Inactive'
  ///
  /// ar: 'غير نشط'
  String get inactive => 'Inactive';

  /// en: 'Fee'
  ///
  /// ar: 'الرسوم'
  String get fee => 'Fee';
}

// Path: doctor.schedule
class Translations$doctor$schedule$en {
  Translations$doctor$schedule$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'My Schedule'
  ///
  /// ar: 'جدول مواعيدي'
  String get title => 'My Schedule';

  /// en: 'Today'
  ///
  /// ar: 'اليوم'
  String get today => 'Today';

  /// en: 'Tomorrow'
  ///
  /// ar: 'غداً'
  String get tomorrow => 'Tomorrow';

  /// en: 'Next 7 Days'
  ///
  /// ar: 'خلال 7 أيام'
  String get next7Days => 'Next 7 Days';

  /// en: 'No appointments found'
  ///
  /// ar: 'لا توجد مواعيد'
  String get noAppointments => 'No appointments found';

  /// en: 'Refresh'
  ///
  /// ar: 'تحديث'
  String get refresh => 'Refresh';
}

// Path: privacyPolicy.sections.informationWeCollect
class Translations$privacyPolicy$sections$informationWeCollect$en {
  Translations$privacyPolicy$sections$informationWeCollect$en.internal(this._root);

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

// Path: privacyPolicy.sections.howWeUseInformation
class Translations$privacyPolicy$sections$howWeUseInformation$en {
  Translations$privacyPolicy$sections$howWeUseInformation$en.internal(this._root);

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

// Path: privacyPolicy.sections.dataSecurity
class Translations$privacyPolicy$sections$dataSecurity$en {
  Translations$privacyPolicy$sections$dataSecurity$en.internal(this._root);

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

// Path: privacyPolicy.sections.thirdPartyServices
class Translations$privacyPolicy$sections$thirdPartyServices$en {
  Translations$privacyPolicy$sections$thirdPartyServices$en.internal(this._root);

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

// Path: privacyPolicy.sections.yourRights
class Translations$privacyPolicy$sections$yourRights$en {
  Translations$privacyPolicy$sections$yourRights$en.internal(this._root);

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

// Path: privacyPolicy.sections.contactUs
class Translations$privacyPolicy$sections$contactUs$en {
  Translations$privacyPolicy$sections$contactUs$en.internal(this._root);

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

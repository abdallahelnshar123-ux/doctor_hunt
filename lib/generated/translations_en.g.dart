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
       $meta =
           meta ??
           TranslationMetadata(
             locale: AppLocale.en,
             overrides: overrides ?? {},
             cardinalResolver: cardinalResolver,
             ordinalResolver: ordinalResolver,
           );

  /// Metadata for the translations of <en>.
  @override
  final TranslationMetadata<AppLocale, Translations> $meta;

  late final Translations _root = this; // ignore: unused_field

  Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

  // Translations
  late final Translations$auth$en auth = Translations$auth$en.internal(_root);
  late final Translations$onboarding$en onboarding = Translations$onboarding$en.internal(_root);
  late final Translations$choose_role$en choose_role = Translations$choose_role$en.internal(_root);
  late final Translations$home$en home = Translations$home$en.internal(_root);
  late final Translations$doctor_details$en doctor_details = Translations$doctor_details$en.internal(_root);
  late final Translations$appointment$en appointment = Translations$appointment$en.internal(_root);
  late final Translations$common$en common = Translations$common$en.internal(_root);
}

// Path: auth
class Translations$auth$en {
  Translations$auth$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Welcome back'
  String get welcome_back => 'Welcome back';

  /// en: 'You can search course, apply course and find scholarship for abroad studies'
  String get auth_subtitle => 'You can search course, apply course and find scholarship for abroad studies';

  /// en: 'Login to your admin account'
  String get admin_subtitle => 'Login to your admin account';

  /// en: 'Forgot password'
  String get forgot_password => 'Forgot password';

  /// en: 'Don’t have an account? Join us'
  String get no_account => 'Don’t have an account? Join us';

  /// en: 'Login'
  String get login => 'Login';

  /// en: 'Join us to start searching'
  String get join_us => 'Join us to start searching';

  /// en: 'Have an account? Log in'
  String get have_account => 'Have an account? Log in';

  /// en: 'I agree with the Terms of Service & Privacy Policy'
  String get agree_terms => 'I agree with the Terms of Service & Privacy Policy';

  /// en: 'Sign up'
  String get sign_up => 'Sign up';

  /// en: 'email'
  String get email => 'email';

  /// en: 'username'
  String get username => 'username';

  /// en: 'Password'
  String get password => 'Password';

  /// en: 'Google'
  String get google => 'Google';

  /// en: 'Facebook'
  String get facebook => 'Facebook';
}

// Path: onboarding
class Translations$onboarding$en {
  Translations$onboarding$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Next'
  String get next => 'Next';

  /// en: 'Skip'
  String get skip => 'Skip';

  /// en: 'Get Started'
  String get get_started => 'Get Started';

  late final Translations$onboarding$page1$en page1 = Translations$onboarding$page1$en.internal(_root);
  late final Translations$onboarding$page2$en page2 = Translations$onboarding$page2$en.internal(_root);
  late final Translations$onboarding$page3$en page3 = Translations$onboarding$page3$en.internal(_root);
}

// Path: choose_role
class Translations$choose_role$en with PageData2 {
  Translations$choose_role$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Doctor Hunt'
  @override
  String get title => 'Doctor Hunt';

  /// en: 'Choose your role'
  String get role_selection => 'Choose your role';

  late final Translations$choose_role$patient$en patient = Translations$choose_role$patient$en.internal(_root);
  late final Translations$choose_role$doctor$en doctor = Translations$choose_role$doctor$en.internal(_root);
  late final Translations$choose_role$admin$en admin = Translations$choose_role$admin$en.internal(_root);
}

// Path: home
class Translations$home$en {
  Translations$home$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Hi ${name}'
  String welcome({required Object Name}) => 'Hi ${Name}';

  /// en: 'Find Your Doctor'
  String get find_doctor => 'Find Your Doctor';

  /// en: 'Live Doctors'
  String get live_doctors => 'Live Doctors';

  /// en: 'Popular Doctors'
  String get popular_doctors => 'Popular Doctors';

  /// en: 'Favourite Doctors'
  String get favourite_doctors => 'Favourite Doctors';

  /// en: 'Feature Doctor'
  String get feature_doctor => 'Feature Doctor';

  /// en: 'See all'
  String get see_all => 'See all';

  /// en: 'search'
  String get search => 'search';

  /// en: 'Live'
  String get live => 'Live';
}

// Path: doctor_details
class Translations$doctor_details$en with PageData2 {
  Translations$doctor_details$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Doctor Details'
  @override
  String get title => 'Doctor Details';

  /// en: 'Find Doctors'
  String get find_doctors => 'Find Doctors';

  /// en: 'Book now'
  String get book_now => 'Book now';

  /// en: 'Services'
  String get services => 'Services';

  List<String> get services_list => [
    'Patient care should be the number one priority.',
    'If you run your practice you know how frustrating.',
    'That’s why some of appointment reminder system.',
  ];

  /// en: 'Running'
  String get running => 'Running';

  /// en: 'Ongoing'
  String get ongoing => 'Ongoing';

  /// en: 'Patient'
  String get patient => 'Patient';

  /// en: '${years} Years experience'
  String experience({required Object Years}) => '${Years} Years experience';

  /// en: '${count} Patient Stories'
  String patient_stories({required Object Count}) => '${Count} Patient Stories';

  /// en: 'Next Available'
  String get next_available => 'Next Available';

  /// en: 'tomorrow'
  String get tomorrow => 'tomorrow';

  /// en: '${price}/ hours'
  String price_per_hour({required Object Price}) => '${Price}/ hours';

  /// en: 'Doctor name'
  String get doctor_name => 'Doctor name';

  /// en: 'Specialist Cardiologist'
  String get specialist_cardiology => 'Specialist Cardiologist';

  /// en: 'Tooths Dentist'
  String get tooths_dentist => 'Tooths Dentist';
}

// Path: appointment
class Translations$appointment$en with PageData2 {
  Translations$appointment$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Appointment'
  @override
  String get title => 'Appointment';

  /// en: 'Pick a date to see available time'
  String get pick_date => 'Pick a date to see available time';

  /// en: 'Available Time'
  String get available_time => 'Available Time';

  /// en: 'Reminder Me Before'
  String get reminder_me => 'Reminder Me Before';

  /// en: 'Thank You !'
  String get thank_you => 'Thank You !';

  /// en: 'Your Appointment Successful'
  String get success => 'Your Appointment Successful';

  /// en: 'You booked an appointment with ${doctor} on ${date}, at ${time}'
  String booking_details({required Object Doctor, required Object Date, required Object Time}) =>
      'You booked an appointment with ${Doctor} on ${Date}, at ${Time}';

  /// en: 'Done'
  String get done => 'Done';

  /// en: 'Edit your appointment'
  String get edit => 'Edit your appointment';

  /// en: 'Confirm'
  String get confirm => 'Confirm';
}

// Path: common
class Translations$common$en {
  Translations$common$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'AM'
  String get am => 'AM';

  /// en: 'PM'
  String get pm => 'PM';

  /// en: 'Min.'
  String get min => 'Min.';

  List<String> get weekdays => ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'];
}

// Path: onboarding.page1
class Translations$onboarding$page1$en with PageData2 {
  Translations$onboarding$page1$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Find Trusted Doctors'
  @override
  String get title => 'Find Trusted Doctors';

  /// en: 'Find trusted doctors near you. Get the care you need from experienced professionals.'
  String get subtitle => 'Find trusted doctors near you. Get the care you need from experienced professionals.';
}

// Path: onboarding.page2
class Translations$onboarding$page2$en with PageData2 {
  Translations$onboarding$page2$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Choose Best Doctors'
  @override
  String get title => 'Choose Best Doctors';

  /// en: 'Explore doctors based on your needs. Choose the one that’s right for you.'
  String get subtitle => 'Explore doctors based on your needs. Choose the one that’s right for you.';
}

// Path: onboarding.page3
class Translations$onboarding$page3$en with PageData2 {
  Translations$onboarding$page3$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Easy Appointments'
  @override
  String get title => 'Easy Appointments';

  /// en: 'Book your appointment in just a few taps. Choose a time that works best for you.'
  String get subtitle => 'Book your appointment in just a few taps. Choose a time that works best for you.';
}

// Path: choose_role.patient
class Translations$choose_role$patient$en with PageData2 {
  Translations$choose_role$patient$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Patient'
  @override
  String get title => 'Patient';

  /// en: 'Book appointments and consult with doctors.'
  String get description => 'Book appointments and consult with doctors.';
}

// Path: choose_role.doctor
class Translations$choose_role$doctor$en with PageData2 {
  Translations$choose_role$doctor$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Doctor'
  @override
  String get title => 'Doctor';

  /// en: 'Manage appointments and consult with patients.'
  String get description => 'Manage appointments and consult with patients.';
}

// Path: choose_role.admin
class Translations$choose_role$admin$en with PageData2 {
  Translations$choose_role$admin$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Admin'
  @override
  String get title => 'Admin';

  /// en: 'Manage doctors and app settings.'
  String get description => 'Manage doctors and app settings.';
}

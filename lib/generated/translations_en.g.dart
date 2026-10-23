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
}

// Path: auth
class Translations$auth$en {
  Translations$auth$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Welcome back'
  String get welcomeBack => 'Welcome back';

  /// en: 'You can search course, apply course and find scholarship for abroad studies'
  String get authSubtitle => 'You can search course, apply course and find scholarship for abroad studies';

  /// en: 'Login to your admin account'
  String get adminSubtitle => 'Login to your admin account';

  /// en: 'Forgot password'
  String get forgotPassword => 'Forgot password';

  /// en: 'Don’t have an account? Join us'
  String get noAccount => 'Don’t have an account? Join us';

  /// en: 'Login'
  String get login => 'Login';

  /// en: 'Join us to start searching'
  String get joinUs => 'Join us to start searching';

  /// en: 'Have an account? Log in'
  String get haveAccount => 'Have an account? Log in';

  /// en: 'I agree with the Terms of Service & Privacy Policy'
  String get agreeTerms => 'I agree with the Terms of Service & Privacy Policy';

  /// en: 'Sign up'
  String get signUp => 'Sign up';

  /// en: 'username'
  String get username => 'username';

  /// en: 'Password'
  String get password => 'Password';

  /// en: 'Google'
  String get google => 'Google';

  /// en: 'you must agree with the Terms of Service & Privacy Policy'
  String get youMustAgreeToTerms => 'you must agree with the Terms of Service & Privacy Policy';

  /// en: 'email'
  String get email => 'email';
}

// Path: forgotPassword
class Translations$forgotPassword$en with PageData2 {
  Translations$forgotPassword$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Forgot Password'
  @override
  String get title => 'Forgot Password';

  /// en: 'Email'
  String get email => 'Email';

  /// en: 'Enter your email address and we'll send you a link to reset your password.'
  String get description => 'Enter your email address and we\'ll send you a link to reset your password.';

  /// en: 'Send Link'
  String get sendLink => 'Send Link';

  /// en: 'We've sent you an email to reset your password. Please check your inbox or spam folder.'
  String get successDialogMessage => 'We\'ve sent you an email to reset your password. Please check your inbox or spam folder.';
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
  String get getStarted => 'Get Started';

  late final Translations$onboarding$page1$en page1 = Translations$onboarding$page1$en.internal(_root);
  late final Translations$onboarding$page2$en page2 = Translations$onboarding$page2$en.internal(_root);
  late final Translations$onboarding$page3$en page3 = Translations$onboarding$page3$en.internal(_root);
}

// Path: chooseRole
class Translations$chooseRole$en with PageData2 {
  Translations$chooseRole$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Doctor Hunt'
  @override
  String get title => 'Doctor Hunt';

  /// en: 'Choose your role'
  String get roleSelection => 'Choose your role';

  late final Translations$chooseRole$patient$en patient = Translations$chooseRole$patient$en.internal(_root);
  late final Translations$chooseRole$admin$en admin = Translations$chooseRole$admin$en.internal(_root);
}

// Path: patientMain
class Translations$patientMain$en {
  Translations$patientMain$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Home'
  String get home => 'Home';

  /// en: 'Settings'
  String get settings => 'Settings';

  /// en: 'Appointment'
  String get appointment => 'Appointment';

  /// en: 'Favourite'
  String get favourite => 'Favourite';
}

// Path: patientAppointments
class Translations$patientAppointments$en with PageData2 {
  Translations$patientAppointments$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Appointments'
  @override
  String get title => 'Appointments';

  /// en: 'Upcoming'
  String get upcoming => 'Upcoming';

  /// en: 'Completed'
  String get completed => 'Completed';

  /// en: 'Canceled'
  String get canceled => 'Canceled';

  /// en: 'View Details'
  String get viewDetails => 'View Details';

  /// en: 'Cancel Appointment'
  String get cancelAppointment => 'Cancel Appointment';

  /// en: 'Rate Doctor'
  String get rateDoctor => 'Rate Doctor';

  /// en: 'Appointment date'
  String get appointmentDate => 'Appointment date';

  /// en: 'Consultation fee'
  String get consultationFee => 'Consultation fee';

  /// en: 'Appointment time'
  String get appointmentTime => 'Appointment time';

  /// en: '$ ${fee}'
  String feeValue({required Object Fee}) => '\$ ${Fee}';

  /// en: 'No Appointments Found'
  String get noAppointmentsFound => 'No Appointments Found';

  /// en: 'Tab to write a review'
  String get tabToWriteReview => 'Tab to write a review';

  /// en: 'You must select at least one star'
  String get youMustSelectAtLeastOneStar => 'You must select at least one star';
}

// Path: selectTime
class Translations$selectTime$en with PageData2 {
  Translations$selectTime$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Select Time'
  @override
  String get title => 'Select Time';

  /// en: 'No slots available'
  String get noSlotsAvailable => 'No slots available';

  /// en: '${number} Slot available'
  String slotAvailable({required Object Number}) => '${Number} Slot available';

  /// en: 'Morning ${number} Slots'
  String morningSlots({required Object Number}) => 'Morning ${Number} Slots';

  /// en: 'Afternoon ${number} Slots'
  String afternoonSlots({required Object Number}) => 'Afternoon ${Number} Slots';

  /// en: 'Evening ${number} Slots'
  String eveningSlots({required Object Number}) => 'Evening ${Number} Slots';

  /// en: 'Confirm'
  String get confirm => 'Confirm';

  /// en: 'You must select appointment time'
  String get youMustSelectAppointmentTime => 'You must select appointment time';
}

// Path: home
class Translations$home$en {
  Translations$home$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Hi ${name}'
  String welcome({required Object Name}) => 'Hi ${Name}';

  /// en: 'Find Your Doctor'
  String get findDoctor => 'Find Your Doctor';

  /// en: 'Popular Doctors'
  String get popularDoctors => 'Popular Doctors';

  /// en: 'Favourite Doctors'
  String get favouriteDoctors => 'Favourite Doctors';

  /// en: 'Top Rated Doctors'
  String get topRatedDoctors => 'Top Rated Doctors';

  /// en: 'See all'
  String get seeAll => 'See all';

  /// en: 'search....'
  String get search => 'search....';
}

// Path: favouriteDoctors
class Translations$favouriteDoctors$en {
  Translations$favouriteDoctors$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'No Favourite Doctors Match Search '
  String get noFavouriteDoctorsMatchSearch => 'No Favourite Doctors Match Search ';

  /// en: 'You haven't added any doctors to your favourites yet.'
  String get noFavouriteDoctorsDescription => 'You haven\'t added any doctors to your favourites yet.';
}

// Path: settings
class Translations$settings$en with PageData2 {
  Translations$settings$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Settings'
  @override
  String get title => 'Settings';

  /// en: 'Logout'
  String get logout => 'Logout';

  /// en: 'Account Settings'
  String get accountSettings => 'Account Settings';

  /// en: 'Change Password'
  String get changePassword => 'Change Password';

  /// en: 'Notifications'
  String get notifications => 'Notifications';

  /// en: 'Privacy Policy'
  String get privacyPolicy => 'Privacy Policy';

  /// en: 'More Options'
  String get moreOptions => 'More Options';

  /// en: 'Language'
  String get language => 'Language';

  /// en: 'Build Version'
  String get buildVersion => 'Build Version';

  /// en: 'English'
  String get english => 'English';

  /// en: 'v1.0.0'
  String get v100 => 'v1.0.0';

  /// en: 'Are you sure you want to logout?'
  String get logoutConfirmation => 'Are you sure you want to logout?';
}

// Path: profile
class Translations$profile$en with PageData2 {
  Translations$profile$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Profile'
  @override
  String get title => 'Profile';

  /// en: 'Personal information'
  String get personalInformation => 'Personal information';

  /// en: 'Name'
  String get name => 'Name';

  /// en: 'Phone'
  String get phone => 'Phone';

  /// en: 'Data was updated successfully'
  String get dataWasUpdatedSuccessfully => 'Data was updated successfully';

  /// en: 'Add phone number'
  String get addPhoneNumber => 'Add phone number';
}

// Path: privacyPolicy
class Translations$privacyPolicy$en with PageData2 {
  Translations$privacyPolicy$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Privacy Policy'
  @override
  String get title => 'Privacy Policy';

  /// en: 'Last updated: October 2026'
  String get lastUpdated => 'Last updated: October 2026';

  /// en: 'Doctor Hunt respects your privacy and is committed to protecting your personal and medical data. This Privacy Policy outlines how we collect, use, and protect your information when using our app.'
  String get introduction =>
      'Doctor Hunt respects your privacy and is committed to protecting your personal and medical data. This Privacy Policy outlines how we collect, use, and protect your information when using our app.';

  late final Translations$privacyPolicy$sections$en sections = Translations$privacyPolicy$sections$en.internal(_root);
}

// Path: doctorDetails
class Translations$doctorDetails$en with PageData2 {
  Translations$doctorDetails$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Doctor Details'
  @override
  String get title => 'Doctor Details';

  /// en: 'Find Doctors'
  String get findDoctors => 'Find Doctors';

  /// en: 'Book now'
  String get bookNow => 'Book now';

  /// en: 'Services'
  String get services => 'Services';

  List<String> get servicesList => [
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
  String patientStories({required Object Count}) => '${Count} Patient Stories';

  /// en: 'Next Available'
  String get nextAvailable => 'Next Available';

  /// en: 'tomorrow'
  String get tomorrow => 'tomorrow';

  /// en: '${price}/ hours'
  String pricePerHour({required Object Price}) => '${Price}/ hours';

  /// en: 'Doctor name'
  String get doctorName => 'Doctor name';

  /// en: 'Tooth Dentist'
  String get toothDentist => 'Tooth Dentist';
}

// Path: appointment
class Translations$appointment$en {
  Translations$appointment$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Thank You !'
  String get thankYou => 'Thank You !';

  /// en: 'Your Appointment Successful'
  String get success => 'Your Appointment Successful';

  /// en: 'You booked an appointment with ${doctor} on ${date}, at ${time}'
  String bookingDetails({required Object Doctor, required Object Date, required Object Time}) =>
      'You booked an appointment with ${Doctor} on ${Date}, at ${Time}';

  /// en: 'Done'
  String get done => 'Done';
}

// Path: createDoctor
class Translations$createDoctor$en with PageData2 {
  Translations$createDoctor$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Create doctor'
  @override
  String get title => 'Create doctor';

  /// en: 'Add photo'
  String get addPhoto => 'Add photo';

  /// en: 'Doctor was added Successfully'
  String get doctorAddedSuccessfully => 'Doctor was added Successfully';

  /// en: 'You must pick doctor image'
  String get youMustPickDoctorImage => 'You must pick doctor image';
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
}

// Path: dialog
class Translations$dialog$en {
  Translations$dialog$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Ok'
  String get ok => 'Ok';

  /// en: 'Success'
  String get success => 'Success';

  /// en: 'Error'
  String get error => 'Error';

  /// en: 'Registered Successfully, Please login.'
  String get registeredSuccessfully => 'Registered Successfully, Please login.';

  /// en: 'Cancel'
  String get cancel => 'Cancel';

  /// en: 'Confirm'
  String get confirm => 'Confirm';
}

// Path: admin
class Translations$admin$en {
  Translations$admin$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  late final Translations$admin$main$en main = Translations$admin$main$en.internal(_root);
  late final Translations$admin$appointmentDetails$en appointmentDetails = Translations$admin$appointmentDetails$en.internal(_root);
  late final Translations$admin$doctorsTab$en doctorsTab = Translations$admin$doctorsTab$en.internal(_root);
  late final Translations$admin$appointmentsTab$en appointmentsTab = Translations$admin$appointmentsTab$en.internal(_root);
  late final Translations$admin$settings$en settings = Translations$admin$settings$en.internal(_root);
  late final Translations$admin$addDoctorScreen$en addDoctorScreen = Translations$admin$addDoctorScreen$en.internal(_root);
  late final Translations$admin$doctorDetailsScreen$en doctorDetailsScreen = Translations$admin$doctorDetailsScreen$en.internal(_root);
  late final Translations$admin$doctorAvailabilityScreen$en doctorAvailabilityScreen = Translations$admin$doctorAvailabilityScreen$en.internal(_root);
  late final Translations$admin$updateDoctorDetails$en updateDoctorDetails = Translations$admin$updateDoctorDetails$en.internal(_root);
  late final Translations$admin$profileScreen$en profileScreen = Translations$admin$profileScreen$en.internal(_root);
}

// Path: errors
class Translations$errors$en {
  Translations$errors$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'No account associated with this email'
  String get noAccountAssociated => 'No account associated with this email';

  /// en: 'Some thing went wrong'
  String get someThingWentWrong => 'Some thing went wrong';

  /// en: 'Server error'
  String get serverError => 'Server error';

  /// en: 'No internet'
  String get noInternet => 'No internet';

  /// en: 'The email or password is incorrect'
  String get emailOrPasswordIsIncorrect => 'The email or password is incorrect';

  /// en: 'The email address is already in use by another account'
  String get emailAddressAlreadyInUseByAnotherAccount => 'The email address is already in use by another account';

  /// en: 'User isn't Authenticated'
  String get userNotAuthenticated => 'User isn\'t Authenticated';

  /// en: 'Error while adding doctor please try again later'
  String get errorWhileAddingDoctorPleaseTryAgainLater => 'Error while adding doctor please try again later';

  /// en: 'Error while updating doctor please try again later'
  String get errorWhileUpdatingDoctorPleaseTryAgainLater => 'Error while updating doctor please try again later';

  /// en: 'Failed to fetch appointments ${E}'
  String failedToFetchAppointments({required Object E}) => 'Failed to fetch appointments ${E}';

  /// en: 'Failed to book appointment ${E}'
  String failedToBookAppointment({required Object E}) => 'Failed to book appointment ${E}';

  /// en: 'User not logged in'
  String get userNotLoggedIn => 'User not logged in';

  /// en: 'Failed to update appointment status ${E}'
  String failedToUpdateAppointmentStatus({required Object E}) => 'Failed to update appointment status ${E}';

  /// en: 'Cancelled by user'
  String get cancelledByUser => 'Cancelled by user';
}

// Path: validators
class Translations$validators$en {
  Translations$validators$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'This field is required'
  String get thisFieldIsRequired => 'This field is required';

  /// en: 'Email is required'
  String get emailIsRequired => 'Email is required';

  /// en: 'Invalid email format'
  String get invalidEmailFormat => 'Invalid email format';

  /// en: 'Password is required'
  String get passwordIsRequired => 'Password is required';

  /// en: 'Confirm password is required'
  String get confirmPasswordIsRequired => 'Confirm password is required';

  /// en: 'Passwords do not match'
  String get passwordsDoNotMatch => 'Passwords do not match';

  /// en: 'Phone number is required'
  String get phoneIsRequired => 'Phone number is required';

  /// en: 'Invalid phone number'
  String get invalidPhoneNumber => 'Invalid phone number';

  /// en: 'Password must be at least 6 characters'
  String get passwordMustBeAtLeast6Characters => 'Password must be at least 6 characters';
}

// Path: eCodes
class Translations$eCodes$en {
  Translations$eCodes$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'web-user-interaction-failed'
  String get webUserInteractionFailed => 'web-user-interaction-failed';

  /// en: 'cancelled'
  String get cancelled => 'cancelled';

  /// en: 'invalid-credential'
  String get invalidCredential => 'invalid-credential';

  /// en: 'email-already-in-use'
  String get emailAlreadyInUse => 'email-already-in-use';
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

// Path: chooseRole.patient
class Translations$chooseRole$patient$en with PageData2 {
  Translations$chooseRole$patient$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Patient'
  @override
  String get title => 'Patient';

  /// en: 'Book appointments and consult with doctors.'
  String get description => 'Book appointments and consult with doctors.';
}

// Path: chooseRole.admin
class Translations$chooseRole$admin$en with PageData2 {
  Translations$chooseRole$admin$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Admin'
  @override
  String get title => 'Admin';

  /// en: 'Manage doctors and app settings.'
  String get description => 'Manage doctors and app settings.';
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
  String get doctors => 'Doctors';

  /// en: 'Settings'
  String get settings => 'Settings';
}

// Path: admin.appointmentDetails
class Translations$admin$appointmentDetails$en with PageData2 {
  Translations$admin$appointmentDetails$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Appointment Details'
  @override
  String get title => 'Appointment Details';

  /// en: 'Patient'
  String get patient => 'Patient';

  /// en: 'Doctor'
  String get doctor => 'Doctor';

  /// en: 'Appointment'
  String get appointment => 'Appointment';
}

// Path: admin.doctorsTab
class Translations$admin$doctorsTab$en {
  Translations$admin$doctorsTab$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Add doctor'
  String get addDoctor => 'Add doctor';

  /// en: 'Search doctors'
  String get searchDoctors => 'Search doctors';

  /// en: 'No Doctors Found'
  String get noDoctorsFound => 'No Doctors Found';

  /// en: 'There are currently no doctors registered on Doctor Hunt. Add your first doctor to get started.'
  String get noDoctorsDescription => 'There are currently no doctors registered on Doctor Hunt. Add your first doctor to get started.';

  /// en: 'Total doctors'
  String get totalDoctors => 'Total doctors';

  /// en: 'Active'
  String get active => 'Active';

  /// en: 'Inactive'
  String get inactive => 'Inactive';

  /// en: 'All'
  String get all => 'All';

  /// en: '-'
  String get dash => '-';

  /// en: 'No doctor name or specialty match search'
  String get noDoctorNameOrSpecialtyMatchSearch => 'No doctor name or specialty match search';

  /// en: 'No doctors'
  String get noDoctors => 'No doctors';

  /// en: 'No doctors to search add some'
  String get noDoctorsToSearchAddSome => 'No doctors to search add some';
}

// Path: admin.appointmentsTab
class Translations$admin$appointmentsTab$en with PageData2 {
  Translations$admin$appointmentsTab$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Appointments'
  @override
  String get title => 'Appointments';

  /// en: 'Time'
  String get time => 'Time';

  /// en: 'Date'
  String get date => 'Date';

  /// en: 'Fee'
  String get fee => 'Fee';

  /// en: 'Mark as completed'
  String get markAsCompleted => 'Mark as completed';
}

// Path: admin.settings
class Translations$admin$settings$en {
  Translations$admin$settings$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Admin Profile'
  String get adminProfile => 'Admin Profile';

  /// en: 'Change Password'
  String get changePassword => 'Change Password';

  /// en: 'App Information'
  String get appInformation => 'App Information';

  /// en: 'Edit super admin details & permissions'
  String get editSuperAdminDetailsPermissions => 'Edit super admin details & permissions';

  /// en: 'Update master security credentials'
  String get updateMasterSecurityCredentials => 'Update master security credentials';

  /// en: 'v1.0.0'
  String get v100 => 'v1.0.0';
}

// Path: admin.addDoctorScreen
class Translations$admin$addDoctorScreen$en {
  Translations$admin$addDoctorScreen$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Create doctor'
  String get createDoctor => 'Create doctor';

  /// en: 'Select specialty'
  String get selectSpecialty => 'Select specialty';

  /// en: 'Doctor name'
  String get doctorName => 'Doctor name';

  /// en: 'Specialty'
  String get specialty => 'Specialty';

  /// en: 'Consultation fee'
  String get consultationFee => 'Consultation fee';

  /// en: 'e.g. Dr. Ahmed Ali'
  String get nameExample => 'e.g. Dr. Ahmed Ali';

  /// en: 'e.g. $ 28.00'
  String get feeExample => 'e.g. \$ 28.00';
}

// Path: admin.doctorDetailsScreen
class Translations$admin$doctorDetailsScreen$en {
  Translations$admin$doctorDetailsScreen$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Doctor details'
  String get doctorDetails => 'Doctor details';

  /// en: 'Specialty'
  String get specialty => 'Specialty';

  /// en: 'Account Status'
  String get accountStatus => 'Account Status';

  /// en: 'Heart Care'
  String get heartCare => 'Heart Care';

  /// en: 'Edit Doctor'
  String get editDoctor => 'Edit Doctor';

  /// en: 'Manage Availability'
  String get manageAvailability => 'Manage Availability';

  /// en: 'Doctor was deleted successfully'
  String get doctorDeletedSuccessfully => 'Doctor was deleted successfully';

  /// en: 'Rating'
  String get rating => 'Rating';

  /// en: 'Consultation Fee'
  String get consultationFee => 'Consultation Fee';

  /// en: '$ ${price}'
  String fee({required Object Price}) => '\$ ${Price}';
}

// Path: admin.doctorAvailabilityScreen
class Translations$admin$doctorAvailabilityScreen$en {
  Translations$admin$doctorAvailabilityScreen$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Doctor Availability'
  String get doctorAvailability => 'Doctor Availability';

  /// en: 'Working Days'
  String get workingDays => 'Working Days';

  /// en: 'Working Hours'
  String get workingHours => 'Working Hours';

  /// en: 'Start Time'
  String get startTime => 'Start Time';

  /// en: 'End Time'
  String get endTime => 'End Time';

  /// en: 'Slot Duration'
  String get slotDuration => 'Slot Duration';

  /// en: 'Active'
  String get active => 'Active';

  /// en: 'Inactive'
  String get inactive => 'Inactive';

  /// en: 'Start time and end time must be different'
  String get startTimeAndEndtimeMustBeDifferent => 'Start time and end time must be different';

  /// en: 'Data was updated successfully'
  String get dataWasUpdatedSuccessfully => 'Data was updated successfully';
}

// Path: admin.updateDoctorDetails
class Translations$admin$updateDoctorDetails$en {
  Translations$admin$updateDoctorDetails$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Doctor was Updated Successfully'
  String get doctorWasUpdatedSuccessfully => 'Doctor was Updated Successfully';

  /// en: 'Edit doctor'
  String get editDoctor => 'Edit doctor';

  /// en: 'Change photo'
  String get changePhoto => 'Change photo';

  /// en: 'Doctor Statues'
  String get doctorStatues => 'Doctor Statues';

  /// en: 'Active & Available'
  String get activeAndAvailable => 'Active & Available';

  /// en: 'Inactive'
  String get inactive => 'Inactive';

  /// en: 'Delete Doctor'
  String get deleteDoctor => 'Delete Doctor';

  /// en: 'Save Changes'
  String get saveChanges => 'Save Changes';
}

// Path: admin.profileScreen
class Translations$admin$profileScreen$en with PageData2 {
  Translations$admin$profileScreen$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Profile'
  @override
  String get title => 'Profile';

  /// en: 'Full Name'
  String get fullName => 'Full Name';

  /// en: 'Email Address'
  String get emailAddress => 'Email Address';
}

// Path: privacyPolicy.sections.informationWeCollect
class Translations$privacyPolicy$sections$informationWeCollect$en with PageData2 {
  Translations$privacyPolicy$sections$informationWeCollect$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: '1. Information We Collect'
  @override
  String get title => '1. Information We Collect';

  /// en: 'We collect information required to provide doctor booking and healthcare management services:'
  String get description => 'We collect information required to provide doctor booking and healthcare management services:';

  List<String> get bullets => [
    'Personal Identification: Name, email address, and phone number.',
    'Appointment Data: Selected doctors, appointment dates, times, and booking status.',
    'Medical Details: Basic consultation preferences and patient notes shared for appointments.',
    'Account & Technical Data: User role (Patient, Doctor, Admin) and system log data.',
  ];
}

// Path: privacyPolicy.sections.howWeUseInformation
class Translations$privacyPolicy$sections$howWeUseInformation$en with PageData2 {
  Translations$privacyPolicy$sections$howWeUseInformation$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: '2. How We Use Your Information'
  @override
  String get title => '2. How We Use Your Information';

  /// en: 'Your information is used strictly to deliver and improve our healthcare services:'
  String get description => 'Your information is used strictly to deliver and improve our healthcare services:';

  List<String> get bullets => [
    'Facilitating doctor searches, appointment scheduling, and management.',
    'Sending appointment reminders and account updates.',
    'Ensuring secure login and authentication.',
    'Enhancing app performance and customer support experience.',
  ];
}

// Path: privacyPolicy.sections.dataSecurity
class Translations$privacyPolicy$sections$dataSecurity$en with PageData2 {
  Translations$privacyPolicy$sections$dataSecurity$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: '3. Data Security & Storage'
  @override
  String get title => '3. Data Security & Storage';

  /// en: 'We take the security of your health and personal data seriously:'
  String get description => 'We take the security of your health and personal data seriously:';

  List<String> get bullets => [
    'Data is stored securely using encrypted cloud database infrastructure.',
    'Access controls restrict administrative and medical data to authorized users only.',
    'We regularly update our security practices to protect against unauthorized access.',
  ];
}

// Path: privacyPolicy.sections.thirdPartyServices
class Translations$privacyPolicy$sections$thirdPartyServices$en with PageData2 {
  Translations$privacyPolicy$sections$thirdPartyServices$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: '4. Third-Party Services'
  @override
  String get title => '4. Third-Party Services';

  /// en: 'We integrate trusted third-party services to ensure optimal performance:'
  String get description => 'We integrate trusted third-party services to ensure optimal performance:';

  List<String> get bullets => [
    'Firebase: Used for secure user authentication and cloud database management.',
    'Cloudinary: Used for secure storage and delivery of profile and doctor images.',
    'We never sell, trade, or rent your personal data to third parties for marketing purposes.',
  ];
}

// Path: privacyPolicy.sections.yourRights
class Translations$privacyPolicy$sections$yourRights$en with PageData2 {
  Translations$privacyPolicy$sections$yourRights$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: '5. Your Rights & Control'
  @override
  String get title => '5. Your Rights & Control';

  /// en: 'You have full control over your personal data within Doctor Hunt:'
  String get description => 'You have full control over your personal data within Doctor Hunt:';

  List<String> get bullets => [
    'View and update your personal profile information at any time.',
    'Manage notification settings and reminders.',
    'Request account deletion or data erasure by contacting support.',
  ];
}

// Path: privacyPolicy.sections.contactUs
class Translations$privacyPolicy$sections$contactUs$en with PageData2 {
  Translations$privacyPolicy$sections$contactUs$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: '6. Contact Us'
  @override
  String get title => '6. Contact Us';

  /// en: 'If you have any questions or concerns regarding this Privacy Policy or your data protection, please contact us at support@doctorhunt.com.'
  String get description =>
      'If you have any questions or concerns regarding this Privacy Policy or your data protection, please contact us at support@doctorhunt.com.';
}

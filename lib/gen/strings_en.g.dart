///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

part of 'strings.g.dart';

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
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations
	late final Translations$auth$en auth = Translations$auth$en._(_root);
	late final Translations$onboarding$en onboarding = Translations$onboarding$en._(_root);
	late final Translations$chooseRole$en chooseRole = Translations$chooseRole$en._(_root);
	late final Translations$home$en home = Translations$home$en._(_root);
	late final Translations$doctorDetails$en doctorDetails = Translations$doctorDetails$en._(_root);
	late final Translations$appointment$en appointment = Translations$appointment$en._(_root);
	late final Translations$common$en common = Translations$common$en._(_root);
}

// Path: auth
class Translations$auth$en {
	Translations$auth$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Welcome back'
	String get welcomeBack => 'Welcome back';

	/// en: 'You can search course, apply course and find scholarship for abroad studies'
	String get authSubtitle => 'You can search course, apply course and find scholarship for abroad studies';

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
	Translations$onboarding$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Next'
	String get next => 'Next';

	/// en: 'Skip'
	String get skip => 'Skip';

	/// en: 'Get Started'
	String get getStarted => 'Get Started';

	late final Translations$onboarding$page1$en page1 = Translations$onboarding$page1$en._(_root);
	late final Translations$onboarding$page2$en page2 = Translations$onboarding$page2$en._(_root);
	late final Translations$onboarding$page3$en page3 = Translations$onboarding$page3$en._(_root);
}

// Path: chooseRole
class Translations$chooseRole$en {
	Translations$chooseRole$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Doctor Hunt'
	String get title => 'Doctor Hunt';

	/// en: 'Choose your role'
	String get roleSelection => 'Choose your role';

	/// en: 'The selected role determines the experience and available features.'
	String get subtitle => 'The selected role determines the experience and available features.';

	late final Translations$chooseRole$admin$en admin = Translations$chooseRole$admin$en._(_root);
	late final Translations$chooseRole$patient$en patient = Translations$chooseRole$patient$en._(_root);

	/// en: 'Continue'
	String get kContinue => 'Continue';
}

// Path: home
class Translations$home$en {
	Translations$home$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Hi ${name}!'
	String welcome({required Object name}) => 'Hi ${name}!';

	/// en: 'Find Your Doctor'
	String get findDoctor => 'Find Your Doctor';

	/// en: 'Live Doctors'
	String get liveDoctors => 'Live Doctors';

	/// en: 'Popular Doctors'
	String get popularDoctors => 'Popular Doctors';

	/// en: 'Favourite Doctors'
	String get favouriteDoctors => 'Favourite Doctors';

	/// en: 'Feature Doctor'
	String get featureDoctor => 'Feature Doctor';

	/// en: 'See all'
	String get seeAll => 'See all';

	/// en: 'search'
	String get search => 'search';

	/// en: 'Live'
	String get live => 'Live';
}

// Path: doctorDetails
class Translations$doctorDetails$en {
	Translations$doctorDetails$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Doctor Details'
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
	String experience({required Object years}) => '${years} Years experience';

	/// en: '${count} Patient Stories'
	String patientStories({required Object count}) => '${count} Patient Stories';

	/// en: 'Next Available'
	String get nextAvailable => 'Next Available';

	/// en: 'tomorrow'
	String get tomorrow => 'tomorrow';

	/// en: '${price}/ hours'
	String pricePerHour({required Object price}) => '${price}/ hours';

	/// en: 'Doctor name'
	String get doctorName => 'Doctor name';

	/// en: 'Specialist Cardiologist'
	String get specialistCardiology => 'Specialist Cardiologist';

	/// en: 'Tooths Dentist'
	String get toothsDentist => 'Tooths Dentist';
}

// Path: appointment
class Translations$appointment$en {
	Translations$appointment$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Appointment'
	String get title => 'Appointment';

	/// en: 'Pick a date to see available time'
	String get pickDate => 'Pick a date to see available time';

	/// en: 'Available Time'
	String get availableTime => 'Available Time';

	/// en: 'Reminder Me Before'
	String get reminderMe => 'Reminder Me Before';

	/// en: 'Thank You !'
	String get thankYou => 'Thank You !';

	/// en: 'Your Appointment Successful'
	String get success => 'Your Appointment Successful';

	/// en: 'You booked an appointment with ${doctor} on ${date}, at ${time}'
	String bookingDetails({required Object doctor, required Object date, required Object time}) => 'You booked an appointment with ${doctor} on ${date}, at ${time}';

	/// en: 'Done'
	String get done => 'Done';

	/// en: 'Edit your appointment'
	String get edit => 'Edit your appointment';

	/// en: 'Confirm'
	String get confirm => 'Confirm';
}

// Path: common
class Translations$common$en {
	Translations$common$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'AM'
	String get am => 'AM';

	/// en: 'PM'
	String get pm => 'PM';

	/// en: 'Min.'
	String get min => 'Min.';

	List<String> get weekdays => [
		'Su',
		'Mo',
		'Tu',
		'We',
		'Th',
		'Fr',
		'Sa',
	];
}

// Path: onboarding.page1
class Translations$onboarding$page1$en {
	Translations$onboarding$page1$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Find Trusted Doctors'
	String get title => 'Find Trusted Doctors';

	/// en: 'Find trusted doctors near you. Get the care you need from experienced professionals.'
	String get subtitle => 'Find trusted doctors near you. Get the care you need from experienced professionals.';
}

// Path: onboarding.page2
class Translations$onboarding$page2$en {
	Translations$onboarding$page2$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Choose Best Doctors'
	String get title => 'Choose Best Doctors';

	/// en: 'Explore doctors based on your needs. Choose the one that’s right for you.'
	String get subtitle => 'Explore doctors based on your needs. Choose the one that’s right for you.';
}

// Path: onboarding.page3
class Translations$onboarding$page3$en {
	Translations$onboarding$page3$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Easy Appointments'
	String get title => 'Easy Appointments';

	/// en: 'Book your appointment in just a few taps. Choose a time that works best for you.'
	String get subtitle => 'Book your appointment in just a few taps. Choose a time that works best for you.';
}

// Path: chooseRole.admin
class Translations$chooseRole$admin$en {
	Translations$chooseRole$admin$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Admin'
	String get title => 'Admin';

	/// en: 'Manage doctors, appointments, users, and the platform.'
	String get description => 'Manage doctors, appointments, users, and the platform.';
}

// Path: chooseRole.patient
class Translations$chooseRole$patient$en {
	Translations$chooseRole$patient$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Patient'
	String get title => 'Patient';

	/// en: 'Find doctors, book appointments, and manage your medical records.'
	String get description => 'Find doctors, book appointments, and manage your medical records.';
}

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'auth.welcomeBack' => 'Welcome back',
			'auth.authSubtitle' => 'You can search course, apply course and find scholarship for abroad studies',
			'auth.forgotPassword' => 'Forgot password',
			'auth.noAccount' => 'Don’t have an account? Join us',
			'auth.login' => 'Login',
			'auth.joinUs' => 'Join us to start searching',
			'auth.haveAccount' => 'Have an account? Log in',
			'auth.agreeTerms' => 'I agree with the Terms of Service & Privacy Policy',
			'auth.signUp' => 'Sign up',
			'auth.email' => 'email',
			'auth.username' => 'username',
			'auth.password' => 'Password',
			'auth.google' => 'Google',
			'auth.facebook' => 'Facebook',
			'onboarding.next' => 'Next',
			'onboarding.skip' => 'Skip',
			'onboarding.getStarted' => 'Get Started',
			'onboarding.page1.title' => 'Find Trusted Doctors',
			'onboarding.page1.subtitle' => 'Find trusted doctors near you. Get the care you need from experienced professionals.',
			'onboarding.page2.title' => 'Choose Best Doctors',
			'onboarding.page2.subtitle' => 'Explore doctors based on your needs. Choose the one that’s right for you.',
			'onboarding.page3.title' => 'Easy Appointments',
			'onboarding.page3.subtitle' => 'Book your appointment in just a few taps. Choose a time that works best for you.',
			'chooseRole.title' => 'Doctor Hunt',
			'chooseRole.roleSelection' => 'Choose your role',
			'chooseRole.subtitle' => 'The selected role determines the experience and available features.',
			'chooseRole.admin.title' => 'Admin',
			'chooseRole.admin.description' => 'Manage doctors, appointments, users, and the platform.',
			'chooseRole.patient.title' => 'Patient',
			'chooseRole.patient.description' => 'Find doctors, book appointments, and manage your medical records.',
			'chooseRole.kContinue' => 'Continue',
			'home.welcome' => ({required Object name}) => 'Hi ${name}!',
			'home.findDoctor' => 'Find Your Doctor',
			'home.liveDoctors' => 'Live Doctors',
			'home.popularDoctors' => 'Popular Doctors',
			'home.favouriteDoctors' => 'Favourite Doctors',
			'home.featureDoctor' => 'Feature Doctor',
			'home.seeAll' => 'See all',
			'home.search' => 'search',
			'home.live' => 'Live',
			'doctorDetails.title' => 'Doctor Details',
			'doctorDetails.findDoctors' => 'Find Doctors',
			'doctorDetails.bookNow' => 'Book now',
			'doctorDetails.services' => 'Services',
			'doctorDetails.servicesList.0' => 'Patient care should be the number one priority.',
			'doctorDetails.servicesList.1' => 'If you run your practice you know how frustrating.',
			'doctorDetails.servicesList.2' => 'That’s why some of appointment reminder system.',
			'doctorDetails.running' => 'Running',
			'doctorDetails.ongoing' => 'Ongoing',
			'doctorDetails.patient' => 'Patient',
			'doctorDetails.experience' => ({required Object years}) => '${years} Years experience',
			'doctorDetails.patientStories' => ({required Object count}) => '${count} Patient Stories',
			'doctorDetails.nextAvailable' => 'Next Available',
			'doctorDetails.tomorrow' => 'tomorrow',
			'doctorDetails.pricePerHour' => ({required Object price}) => '${price}/ hours',
			'doctorDetails.doctorName' => 'Doctor name',
			'doctorDetails.specialistCardiology' => 'Specialist Cardiologist',
			'doctorDetails.toothsDentist' => 'Tooths Dentist',
			'appointment.title' => 'Appointment',
			'appointment.pickDate' => 'Pick a date to see available time',
			'appointment.availableTime' => 'Available Time',
			'appointment.reminderMe' => 'Reminder Me Before',
			'appointment.thankYou' => 'Thank You !',
			'appointment.success' => 'Your Appointment Successful',
			'appointment.bookingDetails' => ({required Object doctor, required Object date, required Object time}) => 'You booked an appointment with ${doctor} on ${date}, at ${time}',
			'appointment.done' => 'Done',
			'appointment.edit' => 'Edit your appointment',
			'appointment.confirm' => 'Confirm',
			'common.am' => 'AM',
			'common.pm' => 'PM',
			'common.min' => 'Min.',
			'common.weekdays.0' => 'Su',
			'common.weekdays.1' => 'Mo',
			'common.weekdays.2' => 'Tu',
			'common.weekdays.3' => 'We',
			'common.weekdays.4' => 'Th',
			'common.weekdays.5' => 'Fr',
			'common.weekdays.6' => 'Sa',
			_ => null,
		};
	}
}

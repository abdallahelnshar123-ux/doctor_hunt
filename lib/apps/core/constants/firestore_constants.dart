class FirestoreConstants {
  // Collections
  static const String usersCollection = 'users';
  static const String doctorsCollection = 'doctors';
  static const String adminsCollection = 'admins';
  static const String appointmentsCollection = 'appointments';
  static const String specialtiesCollection = 'specialties';

  // Common Fields
  static const String id = 'id';
  static const String createdAt = 'created_at';
  static const String updatedAt = 'updated_at';

  // Specialty Fields
  static const String en = 'en';
  static const String ar = 'ar';

  // User Fields
  static const String name = 'name';
  static const String email = 'email';
  static const String provider = 'provider';
  static const String image = 'image';
  static const String role = 'role';
  static const String phone = 'phone';
  static const String specialty = 'specialty';
  static const String patientInfo = 'patient_info';
  static const String adminInfo = 'admin_info';
  static const String favDoctors = 'fav_doctors';
  static const String active = 'active';

  // Appointment Fields
  static const String patient = 'patient';
  static const String doctor = 'doctor';
  static const String sessionTime = 'session_time';
  static const String fee = 'fee';
  static const String status = 'status';
  static const String review = 'review';

  // Doctor Fields
  static const String consultationFee = 'consultation_fee';
  static const String rating = 'rating';
  static const String reviews = 'reviews';
  static const String reviewer = 'reviewer';
  static const String comment = 'comment';
  static const String availability = 'availability';
  static const String workingDays = 'working_days';
  static const String startTime = 'start_time';
  static const String endTime = 'end_time';
  static const String slotDuration = 'slot_duration';

  // static const String password = 'password';
  static const String loginMethods = 'login_methods';
}

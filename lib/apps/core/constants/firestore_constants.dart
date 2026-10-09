class FirestoreConstants {
  // Collections
  static const String usersCollection = 'users';
  static const String doctorsCollection = 'doctors';
  static const String adminsCollection = 'admins';
  static const String appointmentsCollection = 'appointments';

  // Common Fields
  static const String id = 'id';
  static const String createdAt = 'created_at';

  // User Fields
  static const String name = 'name';
  static const String email = 'email';
  static const String provider = 'provider';
  static const String image = 'image';
  static const String role = 'role';
  static const String phone = 'phone';
  static const String adminId = 'admin_id';
  static const String specialty = 'specialty';
  static const String patientInfo = 'patient_info';
  static const String adminInfo = 'admin_info';
  static const String favDoctors = 'fav_doctors';

  // Appointment Fields
  static const String patient = 'patient';
  static const String doctor = 'doctor';
  static const String date = 'date';
  static const String time = 'time';
  static const String fee = 'fee';
  static const String status = 'status';

  // Doctor Fields
  static const String consultationFee = 'consultation_fee';
  static const String rating = 'rating';
  static const String reviews = 'reviews';
  static const String reviewer = 'reviewer';
  static const String comment = 'comment';

  // static const String password = 'password';
  static const String active = 'active';
  static const String loginMethods = 'login_methods';
}

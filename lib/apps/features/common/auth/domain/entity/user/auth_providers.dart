//CR use enum: Convert 'AuthProviders' static string constants into a strongly typed enum (e.g. enum AuthProvider { google, emailPassword, facebook, apple, etc. }) and use it in MyUser / DTOs.
class AuthProviders {
  static const String google = 'google';
  static const String emailPassword = 'emailPassword';
  static const String phone = 'phone';
  static const String facebook = 'facebook';
  static const String playGames = 'playGames';
  static const String gameCenter = 'gameCenter';
  static const String apple = 'apple';
  static const String github = 'github';
  static const String microsoft = 'microsoft';
  static const String twitter = 'twitter';
  static const String yahoo = 'yahoo';
}

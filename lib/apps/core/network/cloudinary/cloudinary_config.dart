abstract class CloudinaryConfig {
  static const String cloudName = String.fromEnvironment(
    'CLOUDINARY_CLOUD_NAME',
  );

  static const String uploadPreset = String.fromEnvironment(
    'CLOUDINARY_UPLOAD_PRESET',
  );

  static const String apiKey = String.fromEnvironment(
    'CLOUDINARY_API_KEY',
  );

  static const String apiSecret = String.fromEnvironment(
    'CLOUDINARY_API_SECRET',
  );
}

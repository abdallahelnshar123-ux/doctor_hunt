import 'package:injectable/injectable.dart';
@module
abstract class CloudinaryConfig {
  @Named('cloud_name')
  String get cloudName => 'der5mc1es';

  @Named('upload_preset')
  String get uploadPreset => 'doctor_hunt';
}

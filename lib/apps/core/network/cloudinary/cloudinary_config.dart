import 'package:injectable/injectable.dart';

@module
abstract class CloudinaryConfig {
  @Named('cloud_name')
  String get cloudName => 'der5mc1es';

  @Named('upload_preset')
  String get uploadPreset => 'doctor_hunt';

  @Named('api_key')
  String get apiKey => '729666688939527';

  @Named('api_secret')
  String get apiSecret => 'I-yhlYVZ1iqXmnPhS_9NuwtEBbA';
}

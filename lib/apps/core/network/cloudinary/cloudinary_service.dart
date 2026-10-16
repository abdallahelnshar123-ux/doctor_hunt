import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

import '../../../../generated/translations.g.dart';
import '../../exceptions/app_exceptions.dart';

@injectable
class CloudinaryService {
  final String cloudName;

  final String uploadPreset;

  CloudinaryService({
    @Named('cloud_name') required this.cloudName,
    @Named('upload_preset') required this.uploadPreset,
  });

  Future<String> uploadImage({required File file}) async {
    final uri = Uri.parse(
      'https://api.cloudinary.com/v1_1/$cloudName/image/upload',
    );

    final request = http.MultipartRequest('POST', uri);

    request.fields['upload_preset'] = uploadPreset;

    request.files.add(await http.MultipartFile.fromPath('file', file.path));

    final response = await request.send();

    final responseBody = await response.stream.bytesToString();

    if (response.statusCode != 200) {
      throw ServerException(message: t.errors.some_thing_went_wrong);
    }

    final data = jsonDecode(responseBody) as Map<String, dynamic>;

    final secureUrl = data['secure_url'] as String?;

    if (secureUrl == null || secureUrl.isEmpty) {
      throw ServerException(message: t.errors.some_thing_went_wrong);
    }

    return secureUrl;
  }
}

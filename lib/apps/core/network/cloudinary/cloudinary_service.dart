import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';


@injectable
class  CloudinaryService {

  final String cloudName;

  final String uploadPreset;

  CloudinaryService({
    @Named('cloud_name')

    required this.cloudName,
    @Named('upload_preset')

    required this.uploadPreset,
  });


  Future<String> uploadImage({
    required File file,
  }) async {
    final uri = Uri.parse(
      'https://api.cloudinary.com/v1_1/$cloudName/image/upload',
    );

    final request = http.MultipartRequest(
      'POST',
      uri,
    );

    request.fields['upload_preset'] = uploadPreset;

    request.files.add(
      await http.MultipartFile.fromPath(
        'file',
        file.path,
      ),
    );

    final response = await request.send();

    final responseBody = await response.stream.bytesToString();

    if (response.statusCode != 200) {
      throw Exception(
        'Cloudinary upload failed: $responseBody',
      );
    }

    final data = jsonDecode(responseBody) as Map<String, dynamic>;

    final secureUrl = data['secure_url'] as String?;

    if (secureUrl == null || secureUrl.isEmpty) {
      throw Exception('Cloudinary did not return secure_url');
    }

    return secureUrl;
  }
}
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
  final String apiKey;
  final String apiSecret;

  CloudinaryService({
    @Named('cloud_name') required this.cloudName,
    @Named('upload_preset') required this.uploadPreset,
    @Named('api_key') required this.apiKey,
    @Named('api_secret') required this.apiSecret,
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
      throw ServerException(message: t.errors.someThingWentWrong);
    }

    final data = jsonDecode(responseBody) as Map<String, dynamic>;

    final secureUrl = data['secure_url'] as String?;

    if (secureUrl == null || secureUrl.isEmpty) {
      throw ServerException(message: t.errors.someThingWentWrong);
    }

    return secureUrl;
  }

  Future<void> deleteImage(String secureUrl) async {
    try {
      final uri = Uri.parse(secureUrl);
      final pathSegments = uri.pathSegments;
      
      final uploadIndex = pathSegments.indexOf('upload');
      if (uploadIndex == -1 || uploadIndex + 2 >= pathSegments.length) return;
      
      final publicIdWithExt = pathSegments.sublist(uploadIndex + 2).join('/');
      final publicId = publicIdWithExt.substring(0, publicIdWithExt.lastIndexOf('.'));
      
      final deleteUri = Uri.parse(
        'https://api.cloudinary.com/v1_1/$cloudName/resources/image/upload',
      ).replace(queryParameters: {
        'public_ids[]': publicId,
      });

      final basicAuth = 'Basic ${base64Encode(utf8.encode('$apiKey:$apiSecret'))}';

      final response = await http.delete(
        deleteUri,
        headers: {
          'Authorization': basicAuth,
        },
      );

      if (response.statusCode != 200) {
        // We can just log it or ignore, since we don't want to break the app if delete fails.
        // print('Failed to delete image: ${response.body}');
      }
    } catch (e) {
      // Ignore deletion errors to not interrupt the user flow
    }
  }
}


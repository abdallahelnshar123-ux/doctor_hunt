import 'dart:io';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';

@injectable
class ImageService {
  static final ImagePicker _picker = ImagePicker();

  Future<File?> pickImage() async {
    var status = await Permission.photos.request();

    if (status.isGranted) {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
      );

      if (pickedFile == null) return null;
      final CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      );

      if (croppedFile == null) return null;

      final file = File(croppedFile.path);

      return file;
    } else {
      return null;
    }
  }
}

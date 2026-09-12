import 'dart:io';

import 'package:doctor_hunt/apps/core/exceptions/app_exceptions.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';

@injectable
class ImageService {
  static final ImagePicker _picker = ImagePicker();

  Future<File> pickImage() async {
    var status = await Permission.photos.request();

    if (status.isGranted) {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
      );

      if (pickedFile == null) throw CancelledByUserException();
      final CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      );

      if (croppedFile == null) throw CancelledByUserException();

      final file = File(croppedFile.path);

      return file;
    } else {
      throw CancelledByUserException();
    }
  }
}

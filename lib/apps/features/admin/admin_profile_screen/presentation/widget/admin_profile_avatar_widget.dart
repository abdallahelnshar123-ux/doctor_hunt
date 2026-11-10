import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_hunt/apps/core/extensions/context_extensions.dart';
import 'package:doctor_hunt/apps/core/theme/app_colors.dart';
import 'package:doctor_hunt/generated/app_assets.dart';
import 'package:flutter/material.dart';

import '../../../../common/auth/domain/entity/user/app_user.dart';

class AdminProfileAvatarWidget extends StatelessWidget {
  const AdminProfileAvatarWidget({
    super.key,
    required this.user,
    required this.selectedImageNotifier,
    this.onCameraTap,
  });

  final AppUserEntity user;
  final ValueNotifier<File?> selectedImageNotifier;
  final VoidCallback? onCameraTap;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<File?>(
      valueListenable: selectedImageNotifier,
      builder: (context, imageFile, child) {
        ImageProvider avatarImage;
        if (imageFile != null) {
          avatarImage = FileImage(imageFile);
        } else if (user.image != null && user.image!.isNotEmpty) {
          avatarImage = CachedNetworkImageProvider(user.image!);
        } else {
          avatarImage = AssetImage(AppAssets.images.fallbackUserImage.path);
        }

        return GestureDetector(
          onTap: onCameraTap,
          child: Center(
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  width: context.width * 0.35,
                  height: context.width * 0.35,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.brandPrimary20,
                    border: Border.all(color: AppColors.brandPrimary, width: 2),
                    image: DecorationImage(
                      image: avatarImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.white, width: 2),
                    color: AppColors.brandPrimary,
                  ),
                  child: const Icon(
                    Icons.camera_alt_rounded,
                    color: AppColors.white,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

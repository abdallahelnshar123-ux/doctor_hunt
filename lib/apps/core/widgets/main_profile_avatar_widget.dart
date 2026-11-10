import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_hunt/apps/core/extensions/context_extensions.dart';
import 'package:doctor_hunt/apps/core/theme/app_colors.dart';
import 'package:doctor_hunt/generated/app_assets.dart';
import 'package:flutter/material.dart';

import '../../features/common/auth/domain/entity/user/app_user.dart';

class MainProfileAvatarWidget extends StatelessWidget {
  const MainProfileAvatarWidget({
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
    return Container(
      padding: const EdgeInsets.all(15),
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: AppColors.brandPrimary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: ValueListenableBuilder<File?>(
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
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  width: context.width * 0.4,
                  height: context.width * 0.4,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.brandPrimary20,
                    image: DecorationImage(
                      image: avatarImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.profileBlack,
                  ),
                  child: const Icon(
                    Icons.camera_alt_rounded,
                    color: AppColors.white,
                    size: 20,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

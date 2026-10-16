import 'package:doctor_hunt/apps/core/data/models/doctor/doctor.dart';
import 'package:doctor_hunt/apps/core/theme/app_colors.dart';
import 'package:doctor_hunt/apps/core/widgets/app_container_with_shadow.dart';
import 'package:doctor_hunt/apps/core/widgets/custom_cached_network_image.dart';
import 'package:doctor_hunt/generated/app_assets.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:flutter/material.dart';

import '../../../../../core/widgets/rating_widget.dart';

class PopularDoctorsItem extends StatelessWidget {
  final Doctor doctor;

  const PopularDoctorsItem({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return AppContainerWithShadow(
      clipBehavior: .antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: AppColors.bgPrimary,
      ),
      width: 190,
      child: Column(
        crossAxisAlignment: .center,
        children: [
          Expanded(
            child: doctor.imageUrl != null && doctor.imageUrl!.isNotEmpty
                ? CustomCachedNetworkImage(
                    imgUrl: doctor.imageUrl!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  )
                : Image.asset(
                    AppAssets.images.testDoctorImage.path,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              spacing: 5,
              crossAxisAlignment: .center,
              children: [
                FittedBox(
                  fit: .scaleDown,
                  child: Text(
                    doctor.name,
                    style: context.medium18.textTertiary.rubik,
                  ),
                ),
                Text(
                  doctor.specialty.name,
                  style: context.light12.textSecondary80.rubik,
                ),
                RatingWidget(
                  rating: doctor.rating.rating,
                  starSize: 13,
                  showRating: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

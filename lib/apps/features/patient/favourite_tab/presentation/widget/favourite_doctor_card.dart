import 'package:doctor_hunt/apps/core/theme/app_colors.dart';
import 'package:doctor_hunt/apps/core/widgets/app_container_with_shadow.dart';
import 'package:doctor_hunt/apps/core/widgets/favorite_button_widget.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:flutter/material.dart';

import '../../../../../core/data/models/doctor/doctor.dart';
import '../../../../../core/widgets/custom_cached_network_image.dart';

class FavouriteDoctorCard extends StatelessWidget {
  const FavouriteDoctorCard({super.key, required this.doctor});

  final Doctor doctor;

  @override
  Widget build(BuildContext context) {
    return AppContainerWithShadow(
      padding: EdgeInsets.all(15),
      clipBehavior: .antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: AppColors.bgPrimary,
      ),
      width: double.infinity,
      height: double.infinity,
      child: Column(
        spacing: 5,
        crossAxisAlignment: .center,
        children: [
          Align(
            alignment: .topRight,
            child: FavoriteButtonWidget(doctorId: doctor.id, size: 25),
          ),
          Expanded(
            child: CircleAvatar(
              maxRadius: double.infinity,
              backgroundImage: CustomCachedNetworkImage.getProvider(
                doctor.imageUrl,
              ),
            ),
          ),

          Text(
            doctor.name,
            style: context.medium16.textTertiary.rubik,
            overflow: .ellipsis,
          ),

          Text(
            doctor.specialty.name,
            style: context.regular12.brandPrimary.rubik,
            overflow: .ellipsis,
          ),
        ],
      ),
    );
  }
}

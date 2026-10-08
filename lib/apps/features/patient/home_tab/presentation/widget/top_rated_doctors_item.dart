import 'package:doctor_hunt/apps/core/data/models/doctor/doctor.dart';
import 'package:doctor_hunt/apps/core/router/app_routes.dart';
import 'package:doctor_hunt/apps/core/theme/app_colors.dart';
import 'package:doctor_hunt/apps/core/widgets/app_container_with_shadow.dart';
import 'package:doctor_hunt/apps/core/widgets/custom_cached_network_image.dart';
import 'package:doctor_hunt/apps/core/widgets/favorite_button_widget.dart';
import 'package:doctor_hunt/generated/app_assets.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TopRatedDoctorsItem extends StatelessWidget {
  const TopRatedDoctorsItem({super.key, required this.doctor});

  final Doctor doctor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        PatientDoctorDetailsRoute(doctor).push(context);
      },
      child: AppContainerWithShadow(
        padding: EdgeInsets.all(8),
        clipBehavior: .antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: AppColors.bgPrimary,
        ),
        width: 105,
        child: Column(
          spacing: 7,
          crossAxisAlignment: .center,
          children: [
            Row(
              spacing: 5,
              children: [
                FavoriteButtonWidget(
                  doctorId: doctor.id,
                  size: 15,
                  readOnly: true,
                ),
                Spacer(),
                SvgPicture.asset(AppAssets.icons.starIconRated.path, width: 15),
                Text('5.0', style: context.medium10.black.rubik),
              ],
            ),
            Expanded(
              child: CircleAvatar(
                maxRadius: double.infinity,
                backgroundColor: AppColors.shimmerBaseColor,
                foregroundImage: CustomCachedNetworkImage.getProvider(
                  doctor.imageUrl,
                ),
              ),
            ),
            Text(
              doctor.name,
              style: context.medium12.textTertiary.rubik,
              overflow: .ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

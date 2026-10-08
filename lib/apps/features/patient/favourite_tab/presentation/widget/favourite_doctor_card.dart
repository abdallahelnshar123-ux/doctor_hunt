import 'package:doctor_hunt/apps/core/theme/app_colors.dart';
import 'package:doctor_hunt/apps/core/widgets/app_container_with_shadow.dart';
import 'package:doctor_hunt/apps/core/widgets/favorite_button_widget.dart';
import 'package:doctor_hunt/generated/app_assets.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter/material.dart';

class FavouriteDoctorCard extends StatelessWidget {
  const FavouriteDoctorCard({super.key, required this.doctorId});

  final String doctorId;

  @override
  Widget build(BuildContext context) {
    return AppContainerWithShadow(
      padding: EdgeInsets.all(10),
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
          // Row(
          //   mainAxisAlignment: .end,
          //   children: [
          //     GestureDetector(
          //       onTap: () {},
          //       child: Icon(Icons.favorite, color: AppColors.badge, size: 20),
          //     ),
          //   ],
          // ),
          Align(
            alignment: .topRight,
            child: FavoriteButtonWidget(doctorId: doctorId, size: 25),
          ),
          Expanded(
            child: CircleAvatar(
              maxRadius: double.infinity,
              foregroundImage: AssetImage(
                AppAssets.images.testDoctorImage.path,
              ),
            ),
          ),
          FittedBox(
            fit: .scaleDown,
            child: Text(
              Translations.of(context).doctor_details.doctor_name,
              style: context.medium16.textTertiary.rubik,
            ),
          ),

          FittedBox(
            fit: .scaleDown,
            child: Text(
              Translations.of(context).doctor_details.specialist_cardiology,
              style: context.regular12.brandPrimary.rubik,
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

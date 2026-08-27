import 'package:doctor_hunt/apps/core/theme/app_colors.dart';
import 'package:doctor_hunt/apps/core/widgets/app_container_with_shadow.dart';
import 'package:doctor_hunt/generated/app_assets.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FavouriteDoctorCard extends StatelessWidget {
  const FavouriteDoctorCard({super.key});

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


           Row(
             mainAxisAlignment: .end,
             children: [
               GestureDetector(
                  onTap: () {},
                  child: Icon(Icons.favorite, color: AppColors.badge, size: 20),
                ),
             ],
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
              'Doctor name',
              style: context.medium16.textTertiary.rubik,
            ),
          ),

          FittedBox(            fit: .scaleDown,
              child: Text('Specalist Cardiology', style: context.regular12.brandPrimary.rubik)),
        ],
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_hunt/apps/core/widgets/favorite_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../generated/app_assets.dart';
import '../../../../../generated/style_atoms.dart';
import '../../../../core/data/models/doctor/doctor.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_container_with_shadow.dart';

class DoctorCardWide extends StatelessWidget {
  final Doctor doctor;
  final EdgeInsetsGeometry? margin;

  const DoctorCardWide({super.key, required this.doctor , this.margin});

  @override
  Widget build(BuildContext context) {
    return AppContainerWithShadow(
      margin:margin ,
      width: double.infinity,
      height: 120,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.white,
      ),
      child: Row(
        spacing: 15,
        children: [
          LayoutBuilder(
            builder: (context, constraints) => Container(
              width: constraints.maxHeight,
              height: constraints.maxHeight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  fit: .cover,
                  image: doctor.imageUrl != null && doctor.imageUrl!.isNotEmpty
                      ? CachedNetworkImageProvider(doctor.imageUrl!)
                      : AssetImage(AppAssets.images.testDoctorImage.path)
                            as ImageProvider,
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: .spaceBetween,
              crossAxisAlignment: .start,
              children: [
                Row(
                  crossAxisAlignment: .start,
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: '${doctor.name}\n',
                        style: context.medium18.textTertiary.rubik,
                        children: [
                          TextSpan(
                            text: doctor.specialty.name,
                            style: context.light14.textSecondary.rubik,
                          ),
                        ],
                      ),
                      overflow: .ellipsis,
                    ),
                    FavoriteButtonWidget(doctorId: doctor.id, size: 25),
                  ],
                ),
                Row(
                  spacing: 6,
                  crossAxisAlignment: .center,
                  children: List.generate(
                    5,
                    (index) => SvgPicture.asset(
                      AppAssets.icons.starIconRated.path,
                      width: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

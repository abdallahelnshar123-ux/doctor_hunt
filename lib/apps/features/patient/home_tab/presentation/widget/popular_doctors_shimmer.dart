import 'package:doctor_hunt/apps/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../generated/app_assets.dart';
import '../../../../../../generated/style_atoms.dart';
import '../../../../../core/widgets/app_container_with_shadow.dart';
import '../../../../../core/widgets/rating_widget.dart';

class PopularDoctorsShimmer extends StatelessWidget {
  const PopularDoctorsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 330,
      width: double.infinity,
      child: ListView.separated(
        itemBuilder: (context, index) {
          return AppContainerWithShadow(
            clipBehavior: .antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: AppColors.bgPrimary,
            ),
            width: 190,
            child: Shimmer.fromColors(
              baseColor: AppColors.shimmerBaseColor,
              highlightColor: AppColors.shimmerHighlightColor,
              child: Column(
                crossAxisAlignment: .center,
                children: [
                  Expanded(
                    child: Image.asset(
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
                            '',
                            style: context.medium18.textTertiary.rubik,
                          ),
                        ),
                        Text('', style: context.light12.textSecondary80.rubik),
                        RatingWidget(
                          rating: 0,
                          starSize: 13,
                          showRating: false,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(width: 15),
        itemCount: 10,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(20),
      ),
    );
  }
}

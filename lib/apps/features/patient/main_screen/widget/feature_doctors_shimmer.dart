import 'package:doctor_hunt/apps/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class FeatureDoctorsShimmer extends StatelessWidget {
  const FeatureDoctorsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.shimmerBaseColor,
      highlightColor: AppColors.shimmerHighlightColor,
      child: ListView.separated(
        itemBuilder: (context, index) => Container(
          width: 105,
          height: 170,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        separatorBuilder: (context, index) => const SizedBox(width: 15),
        itemCount: 10,
        scrollDirection: .horizontal,
        padding: const EdgeInsets.all(20),
      ),
    );
  }
}

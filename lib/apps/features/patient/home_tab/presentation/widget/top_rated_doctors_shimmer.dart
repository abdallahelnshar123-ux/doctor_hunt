import 'package:doctor_hunt/apps/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../generated/app_assets.dart';
import '../../../../../../generated/style_atoms.dart';
import '../../../../../core/widgets/app_container_with_shadow.dart';
import '../../../../../core/widgets/custom_cached_network_image.dart';
import '../../../../../core/widgets/favorite_button_widget.dart';

class TopRatedDoctorsShimmer extends StatelessWidget {
  const TopRatedDoctorsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) => AppContainerWithShadow(
        padding: EdgeInsets.all(8),
        clipBehavior: .antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: AppColors.bgPrimary,
        ),
        width: 105,
        child: Shimmer.fromColors(
          baseColor: AppColors.shimmerBaseColor,
          highlightColor: AppColors.shimmerHighlightColor,
          child: Column(
            spacing: 7,
            crossAxisAlignment: .center,
            children: [
              Row(
                spacing: 5,
                children: [
                  FavoriteButtonWidget(doctorId: '', size: 15, readOnly: true),
                  Spacer(),
                  SvgPicture.asset(
                    AppAssets.icons.starIconRated.path,
                    width: 15,
                  ),
                  Text('', style: context.medium10.black.rubik),
                ],
              ),
              Expanded(
                child: CircleAvatar(
                  maxRadius: double.infinity,
                  backgroundColor: AppColors.shimmerBaseColor,
                  foregroundImage: CustomCachedNetworkImage.getProvider(''),
                ),
              ),
            ],
          ),
        ),
      ),
      separatorBuilder: (context, index) => const SizedBox(width: 15),
      itemCount: 10,
      scrollDirection: .horizontal,
      padding: const EdgeInsets.all(20),
    );
  }
}

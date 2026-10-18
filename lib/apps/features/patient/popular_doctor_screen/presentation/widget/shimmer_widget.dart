part of '../screens/popular_doctor_screen.dart';

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return AppContainerWithShadow(
          width: double.infinity,
          height: 120,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppColors.white,
          ),
          child: Shimmer.fromColors(
            baseColor: AppColors.shimmerBaseColor,
            highlightColor: AppColors.shimmerHighlightColor,
            child: Row(
              crossAxisAlignment: .start,
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
                        image:
                            AssetImage(AppAssets.images.testDoctorImage.path)
                                as ImageProvider,
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      Text(
                        '',
                        style: context.medium18.textTertiary.rubik,
                        overflow: .ellipsis,
                      ),
                      Text(
                        '',
                        style: context.light14.textSecondary.rubik,
                        overflow: .ellipsis,
                      ),
                      Spacer(),
                      RatingWidget(rating: 0, showRating: false, starSize: 17),
                    ],
                  ),
                ),
                FavoriteButtonWidget(doctorId: '', size: 25),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 15),
      itemCount: 10,
      padding: const EdgeInsets.all(20),
    );
  }
}

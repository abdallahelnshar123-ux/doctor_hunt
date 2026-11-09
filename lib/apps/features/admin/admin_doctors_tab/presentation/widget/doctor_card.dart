part of '../screens/admin_doctors_tab.dart';

class DoctorCard extends StatelessWidget {
  final DoctorEntity doctor;

  const DoctorCard({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return AppContainerWithShadow(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.white,
      ),
      child: Row(
        spacing: 15,
        children: [
          CustomCachedNetworkImage(
            imgUrl: doctor.image,
            width: context.width * 0.18,
            height: context.width * 0.18,
            borderRadius: BorderRadius.circular(12),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Text(
                  doctor.name,
                  style: context.medium16.textTertiary.rubik,
                  overflow: .ellipsis,
                ),
                Text(
                  doctor.specialty.localizedName(),
                  style: context.medium12.textSecondary.rubik,
                  overflow: .ellipsis,
                ),
                SizedBox(height: 10),
                RatingWidget(
                  rating: doctor.rating.rating,
                  starSize: 15,
                  showRating: false,
                ),
              ],
            ),
          ),
          Chip(
            padding: EdgeInsets.all(5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            side: BorderSide(width: 0, color: AppColors.transparent),
            backgroundColor: !doctor.disabled
                ? AppColors.brandPrimary20
                : AppColors.statusErrorSurface,
            avatarBoxConstraints: .tightFor(width: 15),
            avatar: Icon(
              Icons.circle,
              size: 10,
              color: !doctor.disabled
                  ? AppColors.brandPrimaryDark
                  : AppColors.statusError,
            ),
            label: Text(
              !doctor.disabled
                  ? t.admin.doctorsTab.active
                  : t.admin.doctorsTab.inactive,
              style: !doctor.disabled
                  ? context.medium10.brandPrimaryDark.rubik
                  : context.regular10.statusError.rubik,
            ),
          ),
        ],
      ),
    );
  }
}

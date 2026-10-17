part of '../screens/admin_doctor_details_screen.dart';

class DoctorDetailsWidget extends StatelessWidget {
  const DoctorDetailsWidget({super.key, required this.doctor});

  final Doctor doctor;

  @override
  Widget build(BuildContext context) {
    return AppContainerWithShadow(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          _buildSettingsCard(
            context,
            title: t.admin.doctor_details_screen.specialty,
            icon: AppAssets.icons.medicalIcon.path,
            subtitleWidget: Text(
              doctor.specialty.name,
              style: context.semiBold14.textTertiary.rubik,
            ),
          ),
          _buildDivider(),
          _buildSettingsCard(
            context,
            title: t.admin.doctor_details_screen.rating,
            subtitleWidget: RatingWidget(
              rating: doctor.rating.rating,
              starSize: 17,
            ),
            icon: AppAssets.icons.starIcon.path,
          ),
          _buildDivider(),
          _buildSettingsCard(
            context,
            title: t.admin.doctor_details_screen.consultation_fee,
            icon: AppAssets.icons.feeIcon.path,
            subtitleWidget: Text(
              t.admin.doctor_details_screen.fee(
                Price: doctor.consultationFee.toString(),
              ),
              style: context.semiBold14.textTertiary.rubik,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsCard(
    BuildContext context, {
    required String title,
    required Widget subtitleWidget,
    required String icon,
  }) {
    return Material(
      color: AppColors.transparent,
      child: ListTile(
        leading: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.brandPrimary8,
            borderRadius: BorderRadius.circular(8),
          ),
          child: SvgPicture.asset(
            icon,
            colorFilter: ColorFilter.mode(AppColors.brandPrimary, .srcIn),
            width: 25,
          ),
        ),
        title: Text(title, overflow: .ellipsis),
        subtitle: subtitleWidget,
        titleTextStyle: context.regular12.textSecondary.rubik,
        contentPadding: EdgeInsets.zero,
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(color: AppColors.bgSurfaceLight);
  }
}

part of '../screens/admin_doctor_details_screen.dart';

class DoctorDetailsWidget extends StatelessWidget {
  const DoctorDetailsWidget({super.key, required this.doctor});

  final Doctor doctor;

  @override
  Widget build(BuildContext context) {
    // final user = context.select<UserBloc, MyUser?>((bloc) => bloc.currentUser);
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

            // trailing: Icon(
            //   Icons.arrow_forward_ios_rounded,
            //   color: AppColors.textSecondary,
            //   weight: 0.01,
            // ),
            // onTap: () {},
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
            // trailing: Icon(
            //   Icons.arrow_forward_ios_rounded,
            //   color: AppColors.textSecondary,
            //   weight: 0.01,
            // ),
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
            // trailing: Text(
            //   t.settings.v1_0_0,
            //   style: context.light12.textSecondary.rubik,
            // ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsCard(
    BuildContext context, {
    required String title,
    required Widget subtitleWidget,
    // void Function()? onTap,
    required String icon,
    // required Widget trailing,
  }) {
    return Material(
      color: AppColors.transparent,
      child: ListTile(
        // onTap: onTap,
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
        // subtitleTextStyle: context.regular12.textSecondary.rubik,
        // trailing: trailing,
        contentPadding: EdgeInsets.zero,
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(color: AppColors.bgSurfaceLight);
  }
}

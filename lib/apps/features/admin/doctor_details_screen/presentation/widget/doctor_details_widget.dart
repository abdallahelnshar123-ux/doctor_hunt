part of '../screens/admin_doctor_details_screen.dart';

class DoctorDetailsWidget extends HookWidget {
  const DoctorDetailsWidget({
    super.key,
    required this.doctor,
    required this.isActiveChip,
  });

  final DoctorEntity doctor;
  final ValueChanged<bool> isActiveChip;

  @override
  Widget build(BuildContext context) {
    final isActive = useValueNotifier(doctor.active);

    return BlocListener<AdminDoctorActionBloc, AdminDoctorActionState>(
      listener: (context, state) {
        if (state is DeleteDoctorLoading) {
          DialogUtils.showLoading(context: context);
        } else if (state is DeleteDoctorSuccess) {
          DialogUtils.hideLoading(context: context);
          SnackBarUtils.showSuccessSnackBar(
            context: context,
            message: t.admin.doctorDetailsScreen.doctorDeletedSuccessfully,
          );
          Navigator.pop(context); // Go back to the previous screen
        } else if (state is DeleteDoctorError) {
          DialogUtils.hideLoading(context: context);
          SnackBarUtils.showErrorSnackBar(
            context: context,
            message: state.message,
          );
        } else if (state is ToggleDoctorActiveStatusError) {
          // Revert back on failure (UI-first rollback)
          isActive.value = !isActive.value;
          isActiveChip(isActive.value);
          SnackBarUtils.showErrorSnackBar(
            context: context,
            message: state.message,
          );
        } else if (state is ToggleDoctorActiveStatusSuccess) {
          // SnackBarUtils.showSuccessSnackBar(
          //   context: context,
          //   message: t.admin.updateDoctorDetails.doctorWasUpdatedSuccessfully,
          // );
        }
      },
      child: AppContainerWithShadow(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            _buildSettingsCard(
              context,
              title: t.admin.doctorDetailsScreen.specialty,
              icon: AppAssets.icons.medicalIcon.path,
              subtitleWidget: Text(
                doctor.specialty.localizedName(),
                style: context.semiBold14.textTertiary.rubik,
              ),
            ),
            _buildDivider(),
            _buildSettingsCard(
              context,
              title: t.admin.doctorDetailsScreen.rating,
              subtitleWidget: RatingWidget(
                rating: doctor.rating.rating,
                starSize: 17,
              ),
              icon: AppAssets.icons.starIcon.path,
            ),
            _buildDivider(),
            _buildSettingsCard(
              context,
              title: t.admin.doctorDetailsScreen.consultationFee,
              icon: AppAssets.icons.feeIcon.path,
              subtitleWidget: Text(
                t.admin.doctorDetailsScreen.fee(
                  Price: doctor.consultationFee.toString(),
                ),
                style: context.semiBold14.textTertiary.rubik,
              ),
            ),
            _buildDivider(),
            ValueListenableBuilder<bool>(
              valueListenable: isActive,
              builder: (context, value, _) {
                return _buildSettingsCard(
                  context,
                  title: t.admin.doctorDetailsScreen.accountStatus,
                  icon: AppAssets.icons.switchIcon.path,
                  subtitleWidget: Text(
                    value
                        ? t.admin.doctorsTab.active
                        : t.admin.doctorsTab.inactive,
                    style: context.semiBold14.textTertiary.rubik,
                  ),
                  trailing: Switch(
                    value: value,
                    onChanged: (newValue) {
                      isActive.value = newValue;
                      isActiveChip(newValue);
                      context.read<AdminDoctorActionBloc>().add(
                        ToggleDoctorActiveStatusRequested(
                          doctorId: doctor.id,
                          active: newValue,
                        ),
                      );
                    },
                    activeThumbColor: AppColors.white,
                    activeTrackColor: AppColors.brandPrimary,
                    thumbIcon: WidgetStateProperty.resolveWith<Icon?>((
                      Set<WidgetState> states,
                    ) {
                      if (states.contains(WidgetState.selected)) {
                        return const Icon(
                          Icons.check_rounded,
                          color: AppColors.brandPrimary,
                        );
                      }
                      return null;
                    }),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsCard(
    BuildContext context, {
    required String title,
    required Widget subtitleWidget,
    required String icon,
    Widget? trailing,
  }) {
    return Material(
      color: AppColors.transparent,
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.brandPrimary8,
            borderRadius: BorderRadius.circular(8),
          ),
          child: SvgPicture.asset(
            icon,
            colorFilter: const ColorFilter.mode(AppColors.brandPrimary, .srcIn),
            width: 25,
          ),
        ),
        title: Text(title, overflow: .ellipsis),
        subtitle: subtitleWidget,
        trailing: trailing,
        titleTextStyle: context.regular12.textSecondary.rubik,
        contentPadding: EdgeInsets.zero,
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(color: AppColors.bgSurfaceLight);
  }
}

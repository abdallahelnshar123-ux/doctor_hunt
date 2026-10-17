part of '../screens/admin_doctor_details_screen.dart';

class DetailsWidget extends StatelessWidget {
  const DetailsWidget({
    super.key,
    required this.doctor,
    required this.isActive,
  });

  final Doctor doctor;
  final ValueNotifier<bool> isActive;

  @override
  Widget build(BuildContext context) {
    return AppContainerWithShadow(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          _buildInfoCard(
            context,
            value: doctor.specialty.name,
            title: t.admin.doctor_details_screen.specialty,
            icon: AppAssets.icons.medicalIcon.path,
            trailing: Chip(
              padding: EdgeInsets.all(5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              side: BorderSide(width: 0, color: AppColors.transparent),
              backgroundColor: AppColors.bgSurfaceLight,
              avatarBoxConstraints: .tightFor(width: 15),

              label: Text(
                t.admin.doctor_details_screen.heart_care,
                style: context.medium12.brandPrimary.rubik,
              ),
            ),
          ),
          Divider(color: AppColors.textSecondary),
          ValueListenableBuilder(
            valueListenable: isActive,
            builder: (context, value, child) {
              return _buildInfoCard(
                context,
                value: value
                    ? t.admin.doctors_tab.active
                    : t.admin.doctors_tab.inactive,
                title: t.admin.doctor_details_screen.account_status,
                icon: AppAssets.icons.switchIcon.path,
                trailing: ValueListenableBuilder(
                  valueListenable: isActive,
                  builder: (context, value, child) {
                    return Switch(
                      value: value,

                      onChanged: (value) {
                        context.read<AdminDoctorActionBloc>().add(
                          ToggleDoctorActiveStatusRequested(
                            doctorId: doctor.id,
                            active: value,
                          ),
                        );
                      },
                      activeThumbColor: AppColors.white,
                      activeTrackColor: AppColors.brandPrimary,
                      thumbIcon: WidgetStateProperty.resolveWith<Icon?>((
                        Set<WidgetState> states,
                      ) {
                        if (states.contains(WidgetState.selected)) {
                          return Icon(
                            Icons.check_rounded,
                            color: AppColors.brandPrimary,
                          );
                        }
                        return null;
                      }),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context, {
    required String value,
    required String title,
    required String icon,
    required Widget trailing,
  }) {
    return ListTile(
      leading: SvgPicture.asset(
        icon,
        fit: BoxFit.scaleDown,
        colorFilter: ColorFilter.mode(AppColors.brandPrimary, BlendMode.srcIn),
      ),
      title: Text(title),
      titleTextStyle: context.regular12.textSecondary.rubik,
      subtitle: Text(value),
      subtitleTextStyle: context.semiBold14.textPrimary.rubik,
      trailing: trailing,
      contentPadding: EdgeInsets.all(0),
    );
  }
}

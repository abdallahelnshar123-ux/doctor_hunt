import 'package:doctor_hunt/apps/core/router/app_routes.dart';
import 'package:doctor_hunt/apps/core/theme/app_colors.dart';
import 'package:doctor_hunt/apps/core/widgets/app_container_with_shadow.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter/material.dart';

class DoctorAccountSettingsWidget extends StatelessWidget {
  const DoctorAccountSettingsWidget({
    super.key,
    this.onSelectScheduleTab,
    this.onSelectProfileTab,
  });

  final VoidCallback? onSelectScheduleTab;
  final VoidCallback? onSelectProfileTab;

  @override
  Widget build(BuildContext context) {
    return AppContainerWithShadow(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSettingsCard(
            context,
            title: t.doctor.settings.doctorProfile,
            subtitle: t.doctor.settings.editProfileDesc,
            icon: Icons.person_outline,
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColors.textSecondary,
              size: 16,
            ),
            onTap: () {


                const DoctorProfileRoute().push(context);

            },
          ),
          _buildDivider(),
          _buildSettingsCard(
            context,
            title: t.doctor.settings.availability,
            subtitle: t.doctor.settings.availabilityDesc,
            icon: Icons.calendar_month_outlined,
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColors.textSecondary,
              size: 16,
            ),
            onTap: () {
              if (onSelectScheduleTab != null) {
                onSelectScheduleTab!();
              } else {
                const DoctorAvailabilityRoute().push(context);
              }
            },
          ),
          _buildDivider(),
          _buildSettingsCard(
            context,
            title: t.doctor.settings.changePassword,
            subtitle: t.doctor.settings.updateMasterSecurityCredentials,
            icon: Icons.lock_reset_outlined,
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColors.textSecondary,
              size: 16,
            ),
            onTap: () {
              const ForgotPasswordRoute().push(context);
            },
          ),
          _buildDivider(),
          _buildSettingsCard(
            context,
            title: t.doctor.settings.appInformation,
            subtitle: t.doctor.settings.v100,
            icon: Icons.info_outline,
            trailing: Text(
              t.settings.v100,
              style: context.light12.textSecondary.rubik,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    VoidCallback? onTap,
    required IconData icon,
    required Widget trailing,
  }) {
    return Material(
      color: AppColors.transparent,
      child: ListTile(
        onTap: onTap,
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.brandPrimary8,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: AppColors.brandPrimary),
        ),
        title: Text(title, overflow: TextOverflow.ellipsis),
        subtitle: Text(subtitle, overflow: TextOverflow.ellipsis),
        titleTextStyle: context.semiBold14.textTertiary.rubik,
        subtitleTextStyle: context.regular12.textSecondary.rubik,
        trailing: trailing,
        contentPadding: EdgeInsets.zero,
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(color: AppColors.bgSurfaceLight);
  }
}

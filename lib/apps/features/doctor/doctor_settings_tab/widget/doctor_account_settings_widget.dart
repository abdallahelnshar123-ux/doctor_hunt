import 'package:doctor_hunt/apps/core/router/app_routes.dart';
import 'package:doctor_hunt/apps/core/theme/app_colors.dart';
import 'package:doctor_hunt/apps/core/widgets/app_container_with_shadow.dart';
import 'package:doctor_hunt/apps/core/widgets/language_picker_popup_menu.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter/material.dart';

class DoctorAccountSettingsWidget extends StatelessWidget {
  const DoctorAccountSettingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t;
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
            title: t.features.doctor.doctorSettingsTab.doctorProfile,
            subtitle: t.features.doctor.doctorSettingsTab.editProfileDesc,
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
            title: t.features.doctor.doctorSettingsTab.availability,
            subtitle: t.features.doctor.doctorSettingsTab.availabilityDesc,
            icon: Icons.calendar_month_outlined,
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColors.textSecondary,
              size: 16,
            ),
            onTap: () {
              const DoctorAvailabilityRoute().push(context);
            },
          ),
          _buildDivider(),
          _buildSettingsCard(
            context,
            title: t.features.doctor.doctorSettingsTab.changePassword,
            subtitle:
                t.features.doctor.doctorSettingsTab.updateMasterSecurityCredentials,
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
          LanguagePickerPopupMenu(
            child: _buildSettingsCard(
              context,
              title: t.core.widgets.languagePicker.language,
              subtitle: LanguagePickerPopupMenu.getCurrentLanguageName(),
              icon: Icons.language_outlined,
              trailing: const Icon(
                Icons.arrow_forward_ios_rounded,
                color: AppColors.textSecondary,
                size: 16,
              ),
            ),
          ),
          _buildDivider(),
          _buildSettingsCard(
            context,
            title: t.features.doctor.doctorSettingsTab.appInformation,
            subtitle: t.features.doctor.doctorSettingsTab.v100,
            icon: Icons.info_outline,
            trailing: Text(
              t.core.common.appVersionVal,
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

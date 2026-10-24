part of '../screens/admin_settings_tab.dart';

class AccountSettingsWidget extends StatelessWidget {
  const AccountSettingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.select<UserBloc, MyUser?>((bloc) => bloc.currentUser);
    return AppContainerWithShadow(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        spacing: 5,
        crossAxisAlignment: .start,
        children: [
          _buildSettingsCard(
            subtitle: t.admin.settings.editSuperAdminDetailsPermissions,
            context,
            title: t.admin.settings.adminProfile,
            icon: Icons.person_2_outlined,
            trailing: Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColors.textSecondary,
              weight: 0.01,
            ),
            onTap: () {
              if (user == null) return;
              AdminProfileRoute(user).push(context);
            },
          ),
          _buildDivider(),
          _buildSettingsCard(
            onTap: () {
              const ForgotPasswordRoute().push(context);
            },
            context,
            title: t.admin.settings.changePassword,
            subtitle: t.admin.settings.updateMasterSecurityCredentials,
            icon: Icons.lock_reset_outlined,
            trailing: Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColors.textSecondary,
              weight: 0.01,
            ),
          ),
          _buildDivider(),
          _buildSettingsCard(
            context,
            title: t.admin.settings.appInformation,
            subtitle: t.admin.settings.v100,
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
    void Function()? onTap,
    required IconData icon,
    required Widget trailing,
  }) {
    return Material(
      color: AppColors.transparent,
      child: ListTile(
        onTap: onTap,
        leading: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.brandPrimary8,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: AppColors.brandPrimary),
        ),
        title: Text(title, overflow: .ellipsis),
        subtitle: Text(subtitle, overflow: .ellipsis),
        titleTextStyle: context.semiBold14.textTertiary.rubik,
        subtitleTextStyle: context.regular12.textSecondary.rubik,
        trailing: trailing,
        contentPadding: EdgeInsets.all(0),
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(color: AppColors.bgSurfaceLight);
  }
}

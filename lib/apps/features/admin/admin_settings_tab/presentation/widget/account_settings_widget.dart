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
            subtitle: t.admin.settings.edit_super_admin_details_permissions,
            context,
            title: t.admin.settings.admin_profile,
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
            context,
            title: t.admin.settings.change_password,
            subtitle: t.admin.settings.update_master_security_credentials,
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
            title: t.admin.settings.app_information,
            subtitle: t.admin.settings.v1_0_0,
            icon: Icons.info_outline,
            trailing: Text(
              t.settings.v1_0_0,
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

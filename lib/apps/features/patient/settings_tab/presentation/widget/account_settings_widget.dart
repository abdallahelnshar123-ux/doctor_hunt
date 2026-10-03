part of '../screens/settings_tab.dart';

class AccountSettingsWidget extends StatelessWidget {
  const AccountSettingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 5,
      crossAxisAlignment: .start,
      children: [
        Text(
          t.settings.account_settings,
          style: context.medium16.textSecondary.rubik,
        ),
        _buildSettingsCard(
          context,
          title: t.settings.change_password,
          icon: Icons.lock,
          trailing: Icon(
            Icons.arrow_forward_ios_rounded,
            color: AppColors.textSecondary,
            weight: 0.01,
          ),
          backgroundColor: AppColors.settingsRed,
        ),
        _buildDivider(),
        _buildSettingsCard(
          context,
          title: t.settings.notifications,
          icon: Icons.notifications_active,
          trailing: Switch(
            value: true,
            onChanged: (value) {},
            activeTrackColor: AppColors.brandPrimary,
          ),
          backgroundColor: AppColors.settingsGreen,
        ),
        _buildDivider(),
        _buildSettingsCard(
          context,
          title: t.settings.privacy_policy,
          icon: Icons.supervisor_account_rounded,
          trailing: Icon(
            Icons.arrow_forward_ios_rounded,
            color: AppColors.textSecondary,
            weight: 0.01,
          ),
          backgroundColor: AppColors.settingsOrange,
          onTap: () {
            const PrivacyPolicyRoute().push(context);
          },
        ),
      ],
    );
  }

  Widget _buildSettingsCard(
    BuildContext context, {
    required String title,
    void Function()? onTap,
    required IconData icon,
    required Widget trailing,
    required Color backgroundColor,
  }) {
    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        backgroundColor: backgroundColor,
        radius: 22,
        child: Icon(icon, color: AppColors.white, size: 25),
      ),
      title: Text(title),
      titleTextStyle: context.light16.textSecondary.rubik,
      trailing: trailing,
      contentPadding: EdgeInsets.all(0),
    );
  }

  Widget _buildDivider() {
    return Divider(color: AppColors.bgSurfaceLight);
  }
}

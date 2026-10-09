part of '../screens/settings_tab.dart';

class MoreOptionWidget extends StatelessWidget {
  const MoreOptionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Text(t.settings.more_options, style: context.medium16.textSecondary.rubik),
        SizedBox(height: 5),
        _buildSettingsCard(
          context,
          title: t.settings.language,
          trailing: Row(
            mainAxisSize: .min,
            children: [
              Text(
                t.settings.english,
                style: context.light12.textSecondary.rubik,
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: AppColors.textSecondary,
                weight: 0.01,
              ),
            ],
          ),
          backgroundColor: AppColors.settingsRed,
        ),
        _buildDivider(),
        _buildSettingsCard(
          context,
          title: t.settings.build_version,
          trailing: Text(
            t.settings.v1_0_0,
            style: context.light12.textSecondary.rubik,
          ),
          backgroundColor: AppColors.settingsOrange,
        ),
      ],
    );
  }

  Widget _buildSettingsCard(
    BuildContext context, {
    required String title,
    required Widget trailing,
    required Color backgroundColor,
  }) {
    return ListTile(
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

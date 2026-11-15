part of '../screens/settings_tab.dart';

class MoreOptionWidget extends StatelessWidget {
  const MoreOptionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Text(
          t.features.patient.settingsTab.moreOptions,
          style: context.medium16.textSecondary.rubik,
        ),
        SizedBox(height: 5),
        LanguagePickerPopupMenu(
          child: _buildSettingsCard(
            context,
            title: t.features.patient.settingsTab.language,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  LanguagePickerPopupMenu.getCurrentLanguageName(),
                  style: context.light12.textSecondary.rubik,
                ),
                const SizedBox(width: 4),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: AppColors.textSecondary,
                  size: 14,
                ),
              ],
            ),
            backgroundColor: AppColors.settingsRed,
          ),
        ),
        _buildDivider(),
        _buildSettingsCard(
          context,
          title: t.features.patient.settingsTab.buildVersion,
          trailing: Text(
            t.features.patient.settingsTab.v100,
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

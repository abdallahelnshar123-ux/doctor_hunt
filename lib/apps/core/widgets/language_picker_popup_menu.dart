import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../generated/style_atoms.dart';
import '../../../../generated/translations.g.dart';
import '../data/shared_prefs/user_pref.dart';
import '../di/di.dart';
import '../theme/app_colors.dart';

class LanguagePickerPopupMenu extends StatelessWidget {
  final Widget child;

  const LanguagePickerPopupMenu({
    super.key,
    required this.child,
  });

  static String getCurrentLanguageName() {
    return LocaleSettings.currentLocale == AppLocale.ar
        ? t.settings.arabic
        : t.settings.english;
  }

  Future<void> _onLocaleSelected(AppLocale newLocale) async {
    if (newLocale == LocaleSettings.currentLocale) return;
    await getIt<UserPrefs>().setLanguage(newLocale.languageCode);
    LocaleSettings.setLocale(newLocale);
    Intl.defaultLocale = newLocale.languageCode;
  }

  @override
  Widget build(BuildContext context) {
    final currentLocale = LocaleSettings.currentLocale;

    return PopupMenuButton<AppLocale>(
      tooltip: t.settings.language,
      offset: const Offset(0, 40),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: AppColors.white,
      elevation: 4,
      onSelected: _onLocaleSelected,
      itemBuilder: (context) => [
        _buildPopupItem(
          context: context,
          locale: AppLocale.en,
          title: 'English',
          subtitle: t.settings.english,
          isSelected: currentLocale == AppLocale.en,
        ),
        const PopupMenuDivider(height: 1),
        _buildPopupItem(
          context: context,
          locale: AppLocale.ar,
          title: 'العربية',
          subtitle: t.settings.arabic,
          isSelected: currentLocale == AppLocale.ar,
        ),
      ],
      child: child,
    );
  }

  PopupMenuItem<AppLocale> _buildPopupItem({
    required BuildContext context,
    required AppLocale locale,
    required String title,
    required String subtitle,
    required bool isSelected,
  }) {
    return PopupMenuItem<AppLocale>(
      value: locale,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                title,
                style: isSelected
                    ? context.semiBold14.brandPrimary.rubik
                    : context.regular14.textPrimary.rubik,
              ),
              const SizedBox(width: 6),
              Text(
                '($subtitle)',
                style: context.light12.textSecondary.rubik,
              ),
            ],
          ),
          if (isSelected)
            const Icon(
              Icons.check_rounded,
              size: 18,
              color: AppColors.brandPrimary,
            ),
        ],
      ),
    );
  }
}

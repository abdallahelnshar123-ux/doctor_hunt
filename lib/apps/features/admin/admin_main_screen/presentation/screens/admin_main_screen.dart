import 'package:doctor_hunt/apps/features/admin/admin_doctors_tab/presentation/screens/admin_doctors_tab.dart';
import 'package:doctor_hunt/apps/features/admin/admin_settings_tab/presentation/screens/admin_settings_tab.dart';
import 'package:doctor_hunt/generated/app_assets.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/theme/app_colors.dart';

class AdminMainScreen extends HookWidget {
  const AdminMainScreen({super.key});

  static const List<Widget> _tabsList = [AdminDoctorsTab(), AdminSettingsTab()];

  @override
  Widget build(BuildContext context) {
    final selectedIndex = useState(0);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBody: true,
      body: _tabsList[selectedIndex.value],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: AppColors.transparent,
          highlightColor: AppColors.transparent,
          canvasColor: AppColors.bgPrimary,
        ),

        child: BottomNavigationBar(
          type: .fixed,
          currentIndex: selectedIndex.value,
          elevation: 0,
          unselectedLabelStyle: context.regular12.textSecondary.rubik,
          selectedLabelStyle: context.bold12.brandPrimary.rubik,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedItemColor: AppColors.brandPrimary,
          unselectedItemColor: AppColors.textSecondary,
          backgroundColor: AppColors.bgPrimary,
          onTap: (index) {
            if (selectedIndex.value != index) {
              selectedIndex.value = index;
            }
          },
          items: [
            builtBottomNavigationBarItem(
              iconName: AppAssets.icons.medicalIcon.path,
              label: t.admin.main.doctors,
              index: 0,
              selectedIndex: selectedIndex.value,
              context: context,
            ),
            builtBottomNavigationBarItem(
              iconName: AppAssets.icons.settingsIcon.path,
              label: t.admin.main.settings,
              index: 1,
              selectedIndex: selectedIndex.value,
              context: context,
            ),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem builtBottomNavigationBarItem({
    required String iconName,
    required int index,
    required int selectedIndex,
    required String label,
    required BuildContext context,
  }) {
    return BottomNavigationBarItem(
      label: label,
      icon: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SvgPicture.asset(
          iconName,
          width: 25,
          colorFilter: ColorFilter.mode(
            index == selectedIndex
                ? AppColors.brandPrimary
                : AppColors.textSecondary,
            .srcIn,
          ),
        ),
      ),
    );
  }
}

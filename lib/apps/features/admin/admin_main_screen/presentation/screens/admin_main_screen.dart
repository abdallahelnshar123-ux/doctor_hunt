import 'package:doctor_hunt/apps/features/admin/admin_doctors_tab/presentation/screens/admin_doctors_tab.dart';
import 'package:doctor_hunt/apps/features/admin/admin_settings_tab/presentation/screens/admin_settings_tab.dart';
import 'package:doctor_hunt/generated/app_assets.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/theme/app_colors.dart';

class AdminMainScreen extends StatefulWidget {
  const AdminMainScreen({super.key});

  @override
  State<AdminMainScreen> createState() => _AdminMainScreenState();
}

class _AdminMainScreenState extends State<AdminMainScreen> {
  int selectedIndex = 0;

  final List<Widget> _tabsList = const [AdminDoctorsTab(), AdminSettingsTab()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBody: true,
      body: _tabsList[selectedIndex],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: AppColors.transparent,
          highlightColor: AppColors.transparent,
          canvasColor: AppColors.bgPrimary,
        ),

        child: BottomNavigationBar(
          type: .fixed,
          currentIndex: selectedIndex,
          elevation: 0,
          unselectedLabelStyle: context.regular12.textSecondary.rubik,
          selectedLabelStyle: context.bold12.brandPrimary.rubik,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedItemColor: AppColors.brandPrimary,
          unselectedItemColor: AppColors.textSecondary,
          backgroundColor: AppColors.bgPrimary,
          onTap: (index) {
            setState(() {
              if (selectedIndex != index) {
                selectedIndex = index;
              }
            });
          },
          items: [
            builtBottomNavigationBarItem(
              iconName: AppAssets.icons.medicalIcon.path,
              label: t.admin.main.doctors,
              index: 0,
              context: context,
            ),
            builtBottomNavigationBarItem(
              iconName: AppAssets.icons.settingsIcon.path,
              label: t.admin.main.settings,
              index: 1,
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

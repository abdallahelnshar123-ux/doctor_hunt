import 'package:doctor_hunt/apps/core/theme/app_colors.dart';
import 'package:doctor_hunt/apps/features/doctor/doctor_avaiability_screen/screen/doctor_availability_screen.dart';
import 'package:doctor_hunt/apps/features/doctor/doctor_profile_screen/screen/doctor_profile_screen.dart';
import 'package:doctor_hunt/generated/app_assets.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../doctor_settings_tab/screen/doctor_settings_tab.dart';

class DoctorMainScreen extends HookWidget {
  const DoctorMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedIndex = useState(0);

    final tabsList = [
      const DoctorAvailabilityScreen(
        showAppBar: true,
        automaticallyImplyLeading: false,
      ),
      const DoctorProfileScreen(
        showAppBar: true,
        automaticallyImplyLeading: false,
      ),
      DoctorSettingsTab(
        onSelectScheduleTab: () => selectedIndex.value = 0,
        onSelectProfileTab: () => selectedIndex.value = 1,
      ),
    ];

    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBody: true,
      body: tabsList[selectedIndex.value],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: AppColors.transparent,
          highlightColor: AppColors.transparent,
          canvasColor: AppColors.bgPrimary,
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
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
            _buildBottomNavigationBarItem(
              iconName: AppAssets.icons.appointmentsIcon.path,
              label: t.doctor.main.mySchedule,
              index: 0,
              selectedIndex: selectedIndex.value,
              context: context,
            ),
            _buildBottomNavigationBarItem(
              iconName: AppAssets.icons.medicalIcon.path,
              label: t.doctor.main.myProfile,
              index: 1,
              selectedIndex: selectedIndex.value,
              context: context,
            ),
            _buildBottomNavigationBarItem(
              iconName: AppAssets.icons.settingsIcon.path,
              label: t.doctor.main.settings,
              index: 2,
              selectedIndex: selectedIndex.value,
              context: context,
            ),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem({
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
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}

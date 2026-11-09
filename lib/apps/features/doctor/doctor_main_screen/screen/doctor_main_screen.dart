import 'package:doctor_hunt/apps/core/di/di.dart';
import 'package:doctor_hunt/apps/core/theme/app_colors.dart';
import 'package:doctor_hunt/apps/features/doctor/appointments_tab/presentation/screens/doctor_appointments_tab.dart';
import 'package:doctor_hunt/apps/features/doctor/schedule_tab/presentation/controller/doctor_schedule_bloc.dart';
import 'package:doctor_hunt/apps/features/doctor/schedule_tab/presentation/controller/doctor_schedule_event.dart';
import 'package:doctor_hunt/apps/features/doctor/schedule_tab/screen/schedule_tab.dart';
import 'package:doctor_hunt/generated/app_assets.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/widgets/app_scaffold.dart';
import '../../doctor_settings_tab/screen/doctor_settings_tab.dart';

class DoctorMainScreen extends HookWidget {
  const DoctorMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<DoctorScheduleBloc>()..add(const FetchDoctorSchedule()),
      child: const _DoctorMainScreenContent(),
    );
  }
}

class _DoctorMainScreenContent extends HookWidget {
  const _DoctorMainScreenContent();

  @override
  Widget build(BuildContext context) {
    final selectedIndex = useState(0);

    final tabsList = [
      const ScheduleTab(),
      const DoctorAppointmentsTab(),
      const DoctorSettingsTab(),
    ];

    return AppScaffold(
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
              iconName: AppAssets.icons.scheduleIcon.path,
              label: t.doctor.main.mySchedule,
              index: 0,
              selectedIndex: selectedIndex.value,
              context: context,
            ),
            _buildBottomNavigationBarItem(
              iconName: AppAssets.icons.appointmentsIcon.path,
              label: t.doctor.main.appointments,
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

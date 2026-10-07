import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:doctor_hunt/apps/core/data/models/doctor/doctor.dart';
import 'package:doctor_hunt/apps/core/theme/app_colors.dart';
import 'package:doctor_hunt/apps/core/widgets/app_container_with_shadow.dart';
import 'package:doctor_hunt/apps/core/widgets/app_scaffold.dart';
import 'package:doctor_hunt/apps/core/widgets/main_app_bar.dart';
import 'package:doctor_hunt/apps/features/patient/main_screen/widget/doctor_card_wide.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../generated/app_assets.dart';
import '../../../../common/auth/presentation/widgets/custom_elevated_button.dart';
import '../../../appointments_tab/presentation/widget/patient_appointment_card.dart';

class SelectTimeScreen extends HookWidget {
  const SelectTimeScreen({super.key, required this.doctor});

  final Doctor doctor;

  @override
  Widget build(BuildContext context) {
    final selectedTabIndex = useValueNotifier<int>(0);
    // final tabController = useTabController(initialLength: 3 ,initialIndex:0 );
    return AppScaffold(
      body: DefaultTabController(
        length: 3,
        child: Column(
          spacing: 15,
          children: [
            MainAppBar(title: t.select_time.title),
            DoctorCardWide(
              doctor: doctor,
              margin: EdgeInsets.symmetric(horizontal: 20),
            ),

            ButtonsTabBar(
              borderWidth: 1,
              unselectedBorderWidth: 1,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              contentCenter: true,
              subtitleStyle: context.light10.white.rubik,
              unselectedSubtitleStyle: context.light10.textSecondary.rubik,
              labelStyle: context.medium16.white.rubik,
              unselectedLabelStyle: context.medium16.textTertiary.rubik,
              buttonMargin: EdgeInsets.all(20),
              borderColor: AppColors.brandPrimary,
              unselectedBorderColor: AppColors.borderMuted,
              backgroundColor: AppColors.brandPrimary,
              unselectedBackgroundColor: AppColors.transparent,
              tabs: [
                ButtonsTab(
                  subtitle: 'No slots available',
                  text: 'Today, 23 Feb',
                ),
                ButtonsTab(
                  subtitle: 'No slots available',
                  text: 'Today, 23 Feb',
                ),
                ButtonsTab(
                  subtitle: 'No slots available',
                  text: 'Today, 23 Feb',
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  ListView.separated(
                    itemBuilder: (context, index) => PatientAppointmentCard(),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 15),
                    itemCount: 10,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                  ),
                  ListView.separated(
                    itemBuilder: (context, index) => PatientAppointmentCard(),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 15),
                    itemCount: 10,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                  ),
                  ListView.separated(
                    itemBuilder: (context, index) => PatientAppointmentCard(),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 15),
                    itemCount: 10,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCalender({
    required BuildContext context,
    required ValueNotifier<DateTime?> selectedDate,
  }) {
    return AppContainerWithShadow(
      clipBehavior: .antiAlias,
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: CalendarDatePicker2(
        config: CalendarDatePicker2Config(
          weekdayLabelTextStyle: context.regular14.black.rubik,
          dayTextStyle: context.regular14.black.rubik,
          selectedDayTextStyle: context.regular14.white.rubik,
          selectedDayHighlightColor: AppColors.brandPrimary,
          controlsBackgroundColor: AppColors.brandPrimary,
          calendarViewMode: .day,
          controlsTextStyle: context.medium16.white.rubik,
          controlsHeight: 60,
          nextMonthIcon: Icon(
            Icons.arrow_forward_ios_rounded,
            color: AppColors.white,
            size: 20,
          ),
          lastMonthIcon: Icon(
            Icons.arrow_back_ios_rounded,
            color: AppColors.white,
            size: 20,
          ),
          dynamicCalendarRows: true,
          disableVibration: true,
          disableModePicker: true,
          disableMonthPicker: true,
          weekdayLabels: t.common.weekdays,
          calendarType: CalendarDatePicker2Type.single,
        ),
        value: [selectedDate.value],
        onValueChanged: (dates) {
          selectedDate.value = dates[0];
        },
      ),
    );
  }

  Future<dynamic> _buildSuccessDialog(BuildContext context) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(25),
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 130),
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.bgPrimary,
          borderRadius: BorderRadius.circular(16),
        ),
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(40),
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: .circle,
                color: AppColors.brandPrimary20,
              ),
              child: SvgPicture.asset(
                AppAssets.icons.likeIcon.path,
                width: double.infinity,
              ),
            ),
            Text(
              t.appointment.thank_you,
              style: context.medium38.black.rubik,
              textAlign: .center,
            ),
            FittedBox(
              fit: .scaleDown,
              child: Text(
                t.appointment.success,
                style: context.regular20.textSecondary.rubik,
                textAlign: .center,
              ),
            ),
            SizedBox(height: 30),
            Text(
              t.appointment.booking_details(
                Doctor: 'Pediatrician Purpieson',
                Date: 'February 21',
                Time: '02:00 ${t.common.pm}',
              ),
              style: context.regular14.textSecondary.rubik,
              textAlign: .center,
            ),
            SizedBox(height: 30),
            CustomElevatedButton(
              buttonWidth: double.infinity,
              borderRadius: 6,
              backgroundColor: AppColors.brandPrimary,
              onPressed: () {
                context.pop();
              },
              child: Text(
                t.appointment.done,
                style: context.medium18.white.rubik,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                t.appointment.edit,
                style: context.regular14.textSecondary.rubik,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:doctor_hunt/apps/core/theme/app_colors.dart';
import 'package:doctor_hunt/apps/core/widgets/app_container_with_shadow.dart';
import 'package:doctor_hunt/apps/core/widgets/app_scaffold.dart';
import 'package:doctor_hunt/apps/core/widgets/main_app_bar.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:flutter/material.dart';

import '../widget/available_time_widget.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  // final _scaffoldKey = GlobalKey<ScaffoldState>();
  //
  // PersistentBottomSheetController? _bottomSheetController;

  final ValueNotifier _selectedDate = ValueNotifier(null);
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Column(
        children: [
          MainAppBar(title: 'Appointment'),
          _buildCalender(context: context),
          SizedBox(height: 25),
          Expanded(
            child: ValueListenableBuilder(
                valueListenable: _selectedDate,
                builder: (context, value, child) {
                  return AppContainerWithShadow(
                    width: double.infinity,
                    height: double.infinity,
                    clipBehavior: .antiAlias,
                    decoration: BoxDecoration(
                      color: AppColors.bgPrimary,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(45),
                        topRight: Radius.circular(45),
                      ),
                    ),
                    child: value == null ? Center(
                        child: Text('Pick a date to see available time',
                          style: context.medium14.textTertiary.rubik,)) : AvailableTimeWidget(),
                  );
                }
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalender({required BuildContext context}) {
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
          weekdayLabels: ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'],
          calendarType: CalendarDatePicker2Type.single,
        ),
        value: [_selectedDate.value],
        onValueChanged: (dates) {
          _selectedDate.value = dates[0];

          // _availableTimeBottomSheet(context: context);
        },
      ),
    );
  }

// PersistentBottomSheetController _availableTimeBottomSheet({
//   required BuildContext context,
// }) {
//   return Scaffold.of(context).showBottomSheet((context) {
//     return SizedBox(
//       height: MediaQuery.sizeOf(context).height * 0.5,
//       child: ListView(
//         padding: const EdgeInsets.all(16),
//         children: [
//           CustomElevatedButton(
//             borderRadius: 6,
//             backgroundColor: AppColors.brandPrimary,
//             onPressed: () {},
//             child: Text('Confirm', style: context.medium18.white.rubik),
//           ),
//         ],
//       ),
//     );
//   });
// }

//   context.showBottomSheet(
//   backgroundColor: AppColors.bgPrimary,
//   isDismissible: false,
//
//   bottomSheetBody: AppContainerWithShadow(
//     constraints: BoxConstraints(maxHeight: 400),
//     child: ListView(
//       children: [
//         CustomElevatedButton(borderRadius: 6,
//           backgroundColor: AppColors.brandPrimary,
//           onPressed: () {},
//           child: Text('Confirm', style: context.medium18.white.rubik),
//         ),
//       ],
//     ),
//   ),
// );
// }
}

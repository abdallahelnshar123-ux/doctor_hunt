import 'package:doctor_hunt/apps/core/data/models/doctor/slot_duration.dart';
import 'package:doctor_hunt/apps/core/data/models/doctor/working_days.dart';
import 'package:doctor_hunt/apps/core/data/models/doctor/working_hour.dart';
import 'package:doctor_hunt/apps/core/presentation/controller/user/user_bloc.dart';
import 'package:doctor_hunt/apps/core/theme/app_colors.dart';
import 'package:doctor_hunt/apps/core/utils/dialog_utils.dart';
import 'package:doctor_hunt/apps/core/utils/snack_bar_utils.dart';
import 'package:doctor_hunt/apps/core/widgets/app_container_with_shadow.dart';
import 'package:doctor_hunt/apps/core/widgets/custom_cached_network_image.dart';
import 'package:doctor_hunt/apps/features/common/auth/domain/entity/user/app_user.dart';
import 'package:doctor_hunt/apps/features/common/auth/domain/entity/user/doctor.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/widgets/custom_elevated_button.dart';
import 'package:doctor_hunt/apps/features/doctor/doctor_avaiability_screen/controller/doctor_availability_bloc.dart';
import 'package:doctor_hunt/apps/features/doctor/doctor_avaiability_screen/controller/doctor_availability_event.dart';
import 'package:doctor_hunt/apps/features/doctor/doctor_avaiability_screen/controller/doctor_availability_state.dart';
import 'package:doctor_hunt/apps/features/doctor/widget/working_days_widget.dart';
import 'package:doctor_hunt/apps/features/doctor/widget/working_hours_widget.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class DoctorAvailabilityScreen extends HookWidget {
  const DoctorAvailabilityScreen({
    super.key,
    this.showAppBar = true,
    this.automaticallyImplyLeading = true,
  });

  final bool showAppBar;
  final bool automaticallyImplyLeading;

  @override
  Widget build(BuildContext context) {
    final user = context.select<UserBloc, AppUserEntity?>(
      (bloc) => bloc.currentUser,
    );
    final doctor = user is DoctorEntity ? user : null;

    final workingDays = useValueNotifier<List<WorkingDay>>(
      doctor?.availability?.workingDays ?? [],
    );
    final startTime = useRef(
      doctor?.availability?.startTime ?? WorkingHour.values.first,
    );
    final endTime = useRef(
      doctor?.availability?.endTime ?? WorkingHour.values.first,
    );
    final slotDuration = useRef(
      doctor?.availability?.slotDuration ?? SlotDuration.values.first,
    );

    return BlocListener<DoctorAvailabilityBloc, DoctorAvailabilityState>(
      listener: (context, state) {
        if (state is DoctorAvailabilityError) {
          DialogUtils.hideLoading(context: context);
          SnackBarUtils.showErrorSnackBar(
            context: context,
            message: state.message,
          );
        }
        if (state is DoctorAvailabilitySuccess) {
          DialogUtils.hideLoading(context: context);
          SnackBarUtils.showSuccessSnackBar(
            context: context,
            message:
                t.doctor.doctorAvailabilityScreen.dataWasUpdatedSuccessfully,
          );
        }
        if (state is DoctorAvailabilityLoading) {
          DialogUtils.showLoading(context: context);
        }
      },
      child: Scaffold(
        appBar: showAppBar
            ? AppBar(
                title: Text(
                  t.doctor.doctorAvailabilityScreen.doctorAvailability,
                ),
                automaticallyImplyLeading: automaticallyImplyLeading,
                centerTitle: true,
              )
            : null,
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            if (doctor != null)
              _buildDoctorCard(doctor: doctor, context: context),
            WorkingDaysWidget(workingDays: workingDays),
            // _buildText(
            //   context: context,
            //   text: t.admin.doctorAvailabilityScreen.workingDays,
            // ),
            // _buildWorkingDaysWidget(context: context, workingDays: workingDays),
            // _buildText(
            //   context: context,
            //   text: t.doctor.doctorAvailabilityScreen.workingHours,
            // ),
            // _buildDropDownGroup(
            //   context: context,
            //   startTime: startTime,
            //   endTime: endTime,
            //   slotDuration: slotDuration,
            // ),
            WorkingHoursWidget(
              startTime: startTime,
              endTime: endTime,
              slotDuration: slotDuration,
            ),
            const SizedBox(height: 20),
            CustomElevatedButton(
              backgroundColor: AppColors.brandPrimary,
              onPressed: () {
                if (startTime.value == endTime.value) {
                  SnackBarUtils.showInfoSnackBar(
                    context: context,
                    message: t
                        .doctor
                        .doctorAvailabilityScreen
                        .startTimeAndEndtimeMustBeDifferent,
                  );
                  return;
                }
                context.read<DoctorAvailabilityBloc>().add(
                  UpdateAvailabilityConfigEvent(
                    workingDays: workingDays.value,
                    startTime: startTime.value,
                    endTime: endTime.value,
                    slotDuration: slotDuration.value,
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.check_rounded,
                    color: AppColors.white,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    t.admin.updateDoctorDetails.saveChanges,
                    style: context.semiBold16.white.rubik,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  // Widget _buildDropDownGroup({
  //   required BuildContext context,
  //   required ObjectRef<WorkingHour> startTime,
  //   required ObjectRef<WorkingHour> endTime,
  //   required ObjectRef<SlotDuration> slotDuration,
  // }) {
  //   return AppContainerWithShadow(
  //     padding: const EdgeInsets.all(15),
  //     decoration: BoxDecoration(
  //       color: AppColors.white,
  //       borderRadius: BorderRadius.circular(16),
  //     ),
  //     child: Column(
  //       spacing: 10,
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Row(
  //           spacing: 10,
  //           children: [
  //             Expanded(
  //               child: TimeDropDown(
  //                 initialSelection: startTime.value,
  //                 onSelected: (value) => startTime.value = WorkingHour.values
  //                     .firstWhere((element) => element.name == value),
  //                 title: t.doctor.doctorAvailabilityScreen.startTime,
  //               ),
  //             ),
  //             Expanded(
  //               child: TimeDropDown(
  //                 initialSelection: endTime.value,
  //                 onSelected: (value) => endTime.value = WorkingHour.values
  //                     .firstWhere((element) => element.name == value),
  //                 title: t.doctor.doctorAvailabilityScreen.endTime,
  //               ),
  //             ),
  //           ],
  //         ),
  //         SlotDurationDropDown(
  //           initialSelection: slotDuration.value,
  //           onSelected: (value) => slotDuration.value = SlotDuration.values
  //               .firstWhere((element) => element.name == value),
  //           title: t.doctor.doctorAvailabilityScreen.slotDuration,
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget _buildDivider() {
  //   return const Divider(color: AppColors.bgSurfaceLight, height: 5);
  // }

  // Widget _buildWorkingDaysWidget({
  //   required BuildContext context,
  //   required ValueNotifier<List<WorkingDay>> workingDays,
  // }) {
  //   return AppContainerWithShadow(
  //     padding: const EdgeInsets.all(15),
  //     decoration: BoxDecoration(
  //       color: AppColors.white,
  //       borderRadius: BorderRadius.circular(16),
  //     ),
  //     child: ListView.separated(
  //       physics: const NeverScrollableScrollPhysics(),
  //       shrinkWrap: true,
  //       itemBuilder: (context, index) {
  //         final day = WorkingDay.values[index];
  //         return ValueListenableBuilder(
  //           valueListenable: workingDays,
  //           builder: (context, workingDaysValue, child) {
  //             final bool isActive = workingDaysValue.contains(day);
  //             return ListTile(
  //               leading: Container(
  //                 padding: const EdgeInsets.all(7),
  //                 decoration: BoxDecoration(
  //                   color: isActive
  //                       ? AppColors.brandPrimary8
  //                       : AppColors.borderDefault,
  //                   borderRadius: BorderRadius.circular(8),
  //                 ),
  //                 child: Icon(
  //                   Icons.calendar_month_outlined,
  //                   color: isActive
  //                       ? AppColors.brandPrimary
  //                       : AppColors.textSecondary,
  //                 ),
  //               ),
  //               title: Text(day.name),
  //               titleTextStyle: isActive
  //                   ? context.semiBold14.textPrimary.rubik
  //                   : context.semiBold14.textSecondary.rubik,
  //               trailing: Switch(
  //                 value: isActive,
  //                 onChanged: (val) {
  //                   final newList = List<WorkingDay>.from(workingDaysValue);
  //                   val ? newList.add(day) : newList.remove(day);
  //                   workingDays.value = newList;
  //                 },
  //                 activeThumbColor: AppColors.white,
  //                 activeTrackColor: AppColors.brandPrimary,
  //               ),
  //               contentPadding: EdgeInsets.zero,
  //             );
  //           },
  //         );
  //       },
  //       separatorBuilder: (context, index) => _buildDivider(),
  //       itemCount: WorkingDay.values.length,
  //     ),
  //   );
  // }

  Widget _buildDoctorCard({
    required DoctorEntity doctor,
    required BuildContext context,
  }) {
    return AppContainerWithShadow(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: CustomCachedNetworkImage.getProvider(doctor.image ?? ''),
              ),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doctor.name,
                  style: context.medium16.textPrimary.rubik,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  doctor.specialty.localizedName(),
                  style: context.light14.textSecondary.rubik,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Chip(
            padding: const EdgeInsets.all(5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            side: const BorderSide(width: 0, color: AppColors.transparent),
            backgroundColor: doctor.active
                ? AppColors.brandPrimary20
                : AppColors.statusErrorSurface,
            avatarBoxConstraints: const BoxConstraints.tightFor(width: 15),
            avatar: Icon(
              Icons.circle,
              size: 10,
              color: doctor.active
                  ? AppColors.brandPrimaryDark
                  : AppColors.statusError,
            ),
            label: Text(
              doctor.active
                  ? t.doctor.doctorAvailabilityScreen.active
                  : t.doctor.doctorAvailabilityScreen.inactive,
              style: doctor.active
                  ? context.medium10.brandPrimaryDark.rubik
                  : context.regular10.statusError.rubik,
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildText({required BuildContext context, required String text}) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 15),
  //     child: Text(text, style: context.bold14.textTertiary.rubik),
  //   );
  // }
}

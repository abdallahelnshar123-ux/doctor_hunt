import 'package:doctor_hunt/apps/core/data/models/doctor/slot_duration.dart';
import 'package:doctor_hunt/apps/core/data/models/doctor/working_hour.dart';
import 'package:doctor_hunt/apps/core/utils/snack_bar_utils.dart';
import 'package:doctor_hunt/apps/core/widgets/custom_cached_network_image.dart';
import 'package:doctor_hunt/apps/features/admin/doctor_availability_screen/presentation/controller/doctor_availability_bloc.dart';
import 'package:doctor_hunt/apps/features/admin/doctor_availability_screen/presentation/controller/doctor_availability_event.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/widgets/custom_elevated_button.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../../../generated/style_atoms.dart';
import '../../../../../core/data/models/doctor/doctor.dart';
import '../../../../../core/data/models/doctor/working_days.dart';
import '../../../../../core/extensions/context_extensions.dart';
import '../../../../../core/router/app_routes.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/dialog_utils.dart';
import '../../../../../core/utils/validators.dart';
import '../../../../../core/widgets/app_container_with_shadow.dart';
import '../controller/doctor_availability_state.dart';

part '../widget/slot_duration_drop_down.dart';

part '../widget/time_drop_down.dart';

class DoctorAvailabilityScreen extends HookWidget {
  const DoctorAvailabilityScreen({super.key, required this.doctor});

  final Doctor doctor;

  @override
  Widget build(BuildContext context) {
    final workingDays = useValueNotifier<List<WorkingDay>>(
      doctor.availability?.workingDays ?? [],
    );
    final startTime = useRef(
      doctor.availability?.startTime ?? WorkingHour.values.first,
    );
    final endTime = useRef(
      doctor.availability?.endTime ?? WorkingHour.values.first,
    );
    final slotDuration = useRef(
      doctor.availability?.slotDuration ?? SlotDuration.values.first,
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
            message: t
                .admin
                .doctor_availability_screen
                .data_was_updated_successfully,
          );
          const AdminMainRoute().go(context);
        }
        if (state is DoctorAvailabilityLoading) {
          DialogUtils.showLoading(context: context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(t.admin.doctor_availability_screen.doctor_availability),
        ),
        body: ListView(
          padding: EdgeInsets.all(20),
          children: [
            _buildDoctorCard(doctor: doctor, context: context),
            _buildText(
              context: context,
              text: t.admin.doctor_availability_screen.working_days,
            ),
            _buildWorkingDaysWidget(context: context, workingDays: workingDays),
            _buildText(
              context: context,
              text: t.admin.doctor_availability_screen.working_hours,
            ),
            _buildDropDownGroup(
              context: context,
              startTime: startTime,
              endTime: endTime,
              slotDuration: slotDuration,
            ),
            SizedBox(height: 20),
            CustomElevatedButton(
              backgroundColor: AppColors.brandPrimary,
              onPressed: () {
                if (startTime.value == endTime.value) {
                  SnackBarUtils.showInfoSnackBar(
                    context: context,
                    message: t
                        .admin
                        .doctor_availability_screen
                        .start_time_and_endtime_must_be_different,
                  );
                  return;
                }
                context.read<DoctorAvailabilityBloc>().add(
                  UpdateAvailabilityConfigEvent(
                    doctor: doctor,
                    workingDays: workingDays.value,
                    startTime: startTime.value,
                    endTime: endTime.value,
                    slotDuration: slotDuration.value,
                  ),
                );
              },
              child: Row(
                spacing: 8,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.check_rounded,
                    color: AppColors.white,
                    size: 20,
                  ),
                  Text(
                    t.admin.update_doctor_details.save_changes,
                    style: context.semiBold16.white.rubik,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropDownGroup({
    required BuildContext context,
    required ObjectRef<WorkingHour> startTime,
    required ObjectRef<WorkingHour> endTime,
    required ObjectRef<SlotDuration> slotDuration,
  }) {
    return AppContainerWithShadow(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        spacing: 10,
        mainAxisAlignment: .start,

        children: [
          Row(
            spacing: 10,
            children: [
              Expanded(
                child: TimeDropDown(
                  initialSelection: startTime.value,
                  onSelected: (value) => startTime.value = WorkingHour.values
                      .firstWhere((element) => element.name == value),
                  title: t.admin.doctor_availability_screen.start_time,
                ),
              ),
              Expanded(
                child: TimeDropDown(
                  initialSelection: endTime.value,
                  onSelected: (value) => endTime.value = WorkingHour.values
                      .firstWhere((element) => element.name == value),
                  title: t.admin.doctor_availability_screen.end_time,
                ),
              ),
            ],
          ),
          SlotDurationDropDown(
            initialSelection: slotDuration.value,
            onSelected: (value) => slotDuration.value = SlotDuration.values
                .firstWhere((element) => element.name == value),
            title: t.admin.doctor_availability_screen.slot_duration,
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(color: AppColors.bgSurfaceLight, height: 5);
  }

  Widget _buildWorkingDaysWidget({
    required BuildContext context,
    required ValueNotifier<List<WorkingDay>> workingDays,
  }) {
    return AppContainerWithShadow(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          var workingDaysList = WorkingDay.values
              .map(
                (day) => ValueListenableBuilder(
                  valueListenable: workingDays,
                  builder: (context, workingDaysValue, child) {
                    bool isActive = workingDaysValue.contains(day);
                    return ListTile(
                      leading: Container(
                        padding: EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          color: isActive
                              ? AppColors.brandPrimary8
                              : AppColors.borderDefault,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.calendar_month_outlined,
                          color: isActive
                              ? AppColors.brandPrimary
                              : AppColors.textSecondary,
                        ),
                      ),
                      title: Text(day.name),
                      titleTextStyle: isActive
                          ? context.semiBold14.textPrimary.rubik
                          : context.semiBold14.textSecondary.rubik,

                      trailing: Switch(
                        value: workingDaysValue.contains(day),

                        onChanged: (val) {
                          final newList = List<WorkingDay>.from(
                            workingDaysValue,
                          );
                          val ? newList.add(day) : newList.remove(day);
                          workingDays.value = newList;
                        },
                        activeThumbColor: AppColors.white,
                        activeTrackColor: AppColors.brandPrimary,
                      ),
                      contentPadding: EdgeInsets.all(0),
                    );
                  },
                ),
              )
              .toList();
          return workingDaysList[index];
        },
        separatorBuilder: (context, index) => _buildDivider(),
        itemCount: WorkingDay.values.length,
      ),
    );
  }

  Widget _buildDoctorCard({
    required Doctor doctor,
    required BuildContext context,
  }) {
    return AppContainerWithShadow(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        spacing: 15,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                fit: .cover,
                image: CustomCachedNetworkImage.getProvider(
                  doctor.imageUrl ?? '',
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Text(
                  doctor.name,
                  style: context.medium16.textPrimary.rubik,
                  overflow: .ellipsis,
                ),
                Text(
                  doctor.specialty.name,
                  style: context.light14.textSecondary.rubik,
                  overflow: .ellipsis,
                ),
              ],
            ),
          ),
          Chip(
            padding: EdgeInsets.all(5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            side: BorderSide(width: 0, color: AppColors.transparent),
            backgroundColor: doctor.active
                ? AppColors.brandPrimary20
                : AppColors.statusErrorSurface,
            avatarBoxConstraints: .tightFor(width: 15),
            avatar: Icon(
              Icons.circle,
              size: 10,
              color: doctor.active
                  ? AppColors.brandPrimaryDark
                  : AppColors.statusError,
            ),
            label: Text(
              doctor.active
                  ? t.admin.doctor_availability_screen.active
                  : t.admin.doctor_availability_screen.inactive,
              style: doctor.active
                  ? context.medium10.brandPrimaryDark.rubik
                  : context.regular10.statusError.rubik,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildText({required BuildContext context, required String text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Text(text, style: context.bold14.textTertiary.rubik),
    );
  }
}

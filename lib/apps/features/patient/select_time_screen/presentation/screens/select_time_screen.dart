import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:doctor_hunt/apps/core/data/models/doctor/doctor.dart';
import 'package:doctor_hunt/apps/core/data/models/doctor/time_slot.dart';
import 'package:doctor_hunt/apps/core/router/app_routes.dart';
import 'package:doctor_hunt/apps/core/theme/app_colors.dart';
import 'package:doctor_hunt/apps/core/utils/snack_bar_utils.dart';
import 'package:doctor_hunt/apps/core/widgets/app_scaffold.dart';
import 'package:doctor_hunt/apps/core/widgets/main_app_bar.dart';
import 'package:doctor_hunt/apps/core/widgets/main_empty_list_widget.dart';
import 'package:doctor_hunt/apps/features/patient/main_screen/widget/doctor_card_wide.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../../../../generated/app_assets.dart';
import '../../../../../core/extensions/context_extensions.dart';
import '../../../../../core/utils/date_formatter_utils.dart';
import '../../../../common/auth/presentation/widgets/custom_elevated_button.dart';
import '../controller/select_time_bloc.dart';
import '../controller/select_time_event.dart';
import '../controller/select_time_state.dart';

part '../widget/slots_tab.dart';

class SelectTimeScreen extends HookWidget {
  const SelectTimeScreen({super.key, required this.doctor});

  final Doctor doctor;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: DefaultTabController(
        length: 7,
        child: Column(
          spacing: 15,
          children: [
            MainAppBar(title: t.select_time.title),
            DoctorCardWide(
              doctor: doctor,
              margin: EdgeInsets.symmetric(horizontal: 20),
            ),

            BlocConsumer<SelectTimeBloc, SelectTimeState>(
              listener: (context, state) {
                if (state is BookAppointmentSuccess) {
                  _buildSuccessDialog(context, state.selectedTime, doctor);
                } else if (state is BookAppointmentError) {
                  SnackBarUtils.showErrorSnackBar(
                    context: context,
                    message: state.message,
                  );
                }
              },
              builder: (context, state) {
                if (state is SelectTimeLoaded) {
                  return Expanded(
                    child: Column(
                      children: [
                        ButtonsTabBar(
                          borderWidth: 1,
                          unselectedBorderWidth: 1,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          contentCenter: true,
                          subtitleStyle: context.light10.white.rubik,
                          unselectedSubtitleStyle:
                          context.light10.textSecondary.rubik,
                          labelStyle: context.medium16.white.rubik,
                          unselectedLabelStyle:
                          context.medium16.textTertiary.rubik,
                          buttonMargin: EdgeInsets.all(20),
                          borderColor: AppColors.brandPrimary,
                          unselectedBorderColor: AppColors.borderMuted,
                          backgroundColor: AppColors.brandPrimary,
                          unselectedBackgroundColor: AppColors.transparent,
                          tabs: List.generate(7, (index) {
                            final date = state.weeklyAvailability[index].date;
                            final tabText =
                            DateFormatterUtils.formatToRelativeDayAndDate(
                              date,
                            );
                            return ButtonsTab(
                              subtitle:
                              state
                                  .weeklyAvailability[index]
                                  .availableSlots
                                  .isEmpty
                                  ? t.select_time.no_slots_available
                                  : t.select_time.slot_available(
                                Number: state
                                    .weeklyAvailability[index]
                                    .availableSlots
                                    .length,
                              ),
                              text: tabText,
                            );
                          }),
                        ),
                        Expanded(
                          child: TabBarView(
                            physics: NeverScrollableScrollPhysics(),
                            children: List.generate(7, (index) {
                              if (state
                                  .weeklyAvailability[index]
                                  .availableSlots
                                  .isEmpty) {
                                return MainEmptyListWidget(
                                    title: t.select_time.no_slots_available,
                                    );
                                // return Center(
                                //   child: Column(
                                //     children: [
                                //       Lottie.asset(
                                //         AppAssets.lottie.emptyState.path,
                                //         width: context.width - 100,
                                //       ),
                                //       Text(
                                //         t.select_time.no_slots_available,
                                //         style: context
                                //             .regular14
                                //             .textSecondary
                                //             .rubik,
                                //       ),
                                //     ],
                                //   ),
                                // );
                              }
                              return SlotsTab(
                                index: index,
                                state: state,
                                doctor: doctor,
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (state is SelectTimeError) {
                  return Expanded(
                    child: Center(
                      child: Text(
                        state.message,
                        style: context.medium16.textSecondary.rubik,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }

                return const Expanded(
                  child: Center(child: CircularProgressIndicator()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> _buildSuccessDialog(BuildContext context,
      DateTime selectedTime,
      Doctor doctor,) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) =>
          Container(
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
                    Doctor: doctor.name,
                    Date: DateFormat('MMMM d').format(selectedTime),
                    Time: DateFormat('hh:mm a').format(selectedTime),
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
                    const PatientMainRoute().go(context);
                  },
                  child: Text(
                    t.appointment.done,
                    style: context.medium18.white.rubik,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    const PatientMainRoute().go(context);
                  },
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

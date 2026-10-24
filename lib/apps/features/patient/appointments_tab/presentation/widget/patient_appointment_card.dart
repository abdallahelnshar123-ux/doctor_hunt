import 'package:doctor_hunt/apps/core/router/app_routes.dart';
import 'package:doctor_hunt/apps/core/theme/app_colors.dart';
import 'package:doctor_hunt/apps/core/utils/snack_bar_utils.dart';
import 'package:doctor_hunt/apps/core/widgets/app_container_with_shadow.dart';
import 'package:doctor_hunt/apps/core/widgets/appointment_review_read_only_widget.dart';
import 'package:doctor_hunt/apps/core/widgets/custom_cached_network_image.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/widgets/custom_elevated_button.dart';
import 'package:doctor_hunt/apps/features/patient/appointments_tab/presentation/controller/appointments_bloc.dart';
import 'package:doctor_hunt/apps/features/patient/appointments_tab/presentation/screens/appointments_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';

import '../../../../../../generated/style_atoms.dart';
import '../../../../../../generated/translations.g.dart';
import '../../../../../core/data/models/doctor/review.dart';
import '../../data/models/appointment/appointment.dart';

class PatientAppointmentCard extends HookWidget {
  const PatientAppointmentCard({super.key, required this.appointment});

  final Appointment appointment;

  @override
  Widget build(BuildContext context) {
    final appointmentReview = useValueNotifier<Review?>(appointment.review);
    final tempReview = useRef<Review?>(null);
    final isLoading = useValueNotifier<bool>(false);
    return BlocListener<AppointmentsBloc, AppointmentsState>(
      listenWhen: (previous, current) {
        if (current is AddReviewLoading &&
            current.appointmentId == appointment.id) {
          return true;
        }
        if (current is AddReviewSuccess &&
            current.appointmentId == appointment.id) {
          return true;
        }
        if (current is AddReviewError &&
            current.appointmentId == appointment.id) {
          return true;
        }
        if (current is CancelAppointmentLoading &&
            current.appointmentId == appointment.id) {
          return true;
        }
        if (current is CancelAppointmentSuccess &&
            current.appointmentId == appointment.id) {
          return true;
        }
        if (current is CancelAppointmentError &&
            current.appointmentId == appointment.id) {
          return true;
        }
        return false;
      },
      listener: (context, state) {
        if (state is AddReviewSuccess) {
          appointmentReview.value = tempReview.value;
          tempReview.value = null;
        } else if (state is AddReviewError) {
          appointmentReview.value = null;
          SnackBarUtils.showErrorSnackBar(
            context: context,
            message: state.message,
          );
        }
        if (state is CancelAppointmentSuccess) {
          isLoading.value = false;
        }
        if (state is CancelAppointmentError) {
          isLoading.value = false;
          SnackBarUtils.showErrorSnackBar(
            context: context,
            message: state.message,
          );
        }
        if (state is CancelAppointmentLoading) {
          isLoading.value = true;
        }
      },
      child: ValueListenableBuilder(
        valueListenable: isLoading,
        builder: (BuildContext context, bool isLoading, Widget? child) {
          return IgnorePointer(
            ignoring: isLoading,
            child: Opacity(
              opacity: isLoading ? .5 : 1.0,
              child: AppContainerWithShadow(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  spacing: 10,
                  crossAxisAlignment: .start,
                  children: [
                    ///doctor details
                    Row(
                      spacing: 15,
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              fit: .cover,
                              image: CustomCachedNetworkImage.getProvider(
                                appointment.doctor.imageUrl,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: .spaceBetween,
                            crossAxisAlignment: .start,
                            children: [
                              Text(
                                appointment.doctor.name,
                                style: context.medium16.textTertiary.rubik,
                                overflow: .ellipsis,
                              ),
                              Text(
                                appointment.doctor.specialty.name,
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
                          side: BorderSide(
                            width: 0,
                            color: AppColors.transparent,
                          ),
                          backgroundColor:
                              appointment.status != AppointmentStatus.cancelled
                              ? AppColors.brandPrimary20
                              : AppColors.statusErrorSurface,
                          avatarBoxConstraints: .tightFor(width: 15),
                          avatar: Icon(
                            Icons.circle,
                            size: 10,
                            color:
                                appointment.status !=
                                    AppointmentStatus.cancelled
                                ? AppColors.brandPrimaryDark
                                : AppColors.statusError,
                          ),
                          label: Text(
                            appointment.status.name,
                            style:
                                appointment.status !=
                                    AppointmentStatus.cancelled
                                ? context.medium9.brandPrimaryDark.rubik
                                : context.regular9.statusError.rubik,
                          ),
                        ),
                      ],
                    ),
                    Divider(color: AppColors.textSecondary, thickness: 0.2),

                    /// appointment details
                    Wrap(
                      spacing: 30,
                      runSpacing: 15,
                      children: [
                        _buildListTile(
                          icon: Icons.calendar_month_outlined,
                          title: t.patientAppointments.appointmentDate,
                          subtitle: DateFormat(
                            'dd MMM yyyy',
                          ).format(appointment.sessionTime),
                          context: context,
                        ),
                        _buildListTile(
                          icon: Icons.access_time,
                          title: t.patientAppointments.appointmentTime,
                          subtitle: DateFormat(
                            'hh:mm a',
                          ).format(appointment.sessionTime),
                          context: context,
                        ),
                        _buildListTile(
                          icon: Icons.payments_outlined,
                          title: t.patientAppointments.consultationFee,
                          subtitle: t.patientAppointments.feeValue(
                            Fee: appointment.fee.toString(),
                          ),
                          context: context,
                        ),
                      ],
                    ),
                    ?appointment.status == AppointmentStatus.completed
                        ? ValueListenableBuilder(
                            valueListenable: appointmentReview,
                            builder: (context, value, child) {
                              if (value == null) {
                                return ReviewInputWidget(
                                  onReviewChanged: (value) =>
                                      tempReview.value = value,
                                  reviewer: appointment.patient,
                                );
                              }
                              return AppointmentReviewReadOnlyWidget(
                                review: appointmentReview.value!,
                              );
                            },
                          )
                        : null,

                    /// buttons
                    switch (appointment.status) {
                      AppointmentStatus.upcoming => _buildUpcomingButtons(
                        context: context,
                      ),
                      AppointmentStatus.completed =>
                        appointmentReview.value == null
                            ? _buildCompletedButtons(
                                context: context,
                                appointmentReview: appointmentReview,
                                tempReview: tempReview,
                              )
                            : Row(
                                children: [
                                  _buildViewDetailsButton(context: context),
                                ],
                              ),
                      AppointmentStatus.cancelled => Row(
                        children: [_buildViewDetailsButton(context: context)],
                      ),
                    },
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildUpcomingButtons({required BuildContext context}) {
    return Row(
      spacing: 10,
      children: [
        _buildViewDetailsButton(context: context),
        Expanded(child: _buildCancelButton(context: context)),
      ],
    );
  }

  Widget _buildCompletedButtons({
    required BuildContext context,
    required ValueNotifier<Review?> appointmentReview,
    required ObjectRef<Review?> tempReview,
  }) {
    return Row(
      spacing: 10,
      children: [
        _buildViewDetailsButton(context: context),

        Expanded(
          child: _buildRateDoctorButton(
            context: context,
            appointmentReview: appointmentReview,
            tempReview: tempReview,
          ),
        ),
      ],
    );
  }

  Widget _buildCancelButton({required BuildContext context}) {
    return CustomElevatedButton(
      paddingVertical: 10,
      borderRadius: 8,
      backgroundColor: AppColors.statusErrorSurface,
      onPressed: () {
        context.read<AppointmentsBloc>().add(
          CancelAppointmentEvent(appointment.id),
        );
      },
      borderSideColor: AppColors.statusError,
      child: FittedBox(
        fit: .scaleDown,
        child: Text(
          t.patientAppointments.cancelAppointment,
          style: context.medium11.statusError.rubik,
        ),
      ),
    );
  }

  Widget _buildViewDetailsButton({required BuildContext context}) {
    return Expanded(
      child: CustomElevatedButton(
        paddingVertical: 10,
        borderRadius: 8,
        backgroundColor: AppColors.white,
        onPressed: () {
          PatientAppointmentDetailsRoute(appointment).push(context);
        },
        borderSideColor: AppColors.brandPrimary,
        child: FittedBox(
          fit: .scaleDown,
          child: Text(
            t.patientAppointments.viewDetails,
            style: context.medium11.brandPrimary.rubik,
          ),
        ),
      ),
    );
  }

  Widget _buildRateDoctorButton({
    required BuildContext context,
    required ValueNotifier<Review?> appointmentReview,
    required ObjectRef<Review?> tempReview,
  }) {
    return CustomElevatedButton(
      paddingVertical: 10,
      borderRadius: 8,
      backgroundColor: AppColors.brandPrimary,
      onPressed: () {
        if (appointmentReview.value == null) {
          if (tempReview.value?.rating == 0 || tempReview.value == null) {
            SnackBarUtils.showInfoSnackBar(
              context: context,
              message: t.patientAppointments.youMustSelectAtLeastOneStar,
            );
            return;
          }
          appointmentReview.value = tempReview.value;
          context.read<AppointmentsBloc>().add(
            AddAppointmentReviewEvent(appointment, tempReview.value!),
          );
        }
      },
      borderSideColor: AppColors.brandPrimary,
      child: FittedBox(
        fit: .scaleDown,
        child: Text(
          t.patientAppointments.rateDoctor,
          style: context.medium11.white.rubik,
        ),
      ),
    );
  }

  Widget _buildListTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required BuildContext context,
  }) {
    return Row(
      spacing: 10,
      mainAxisSize: .min,
      mainAxisAlignment: .start,
      children: [
        Container(
          padding: EdgeInsets.all(7),
          decoration: BoxDecoration(
            color: AppColors.brandPrimary8,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: AppColors.brandPrimary),
        ),
        Text.rich(
          TextSpan(
            text: '$title \n',
            style: context.regular9.textSecondary.rubik,
            children: [
              TextSpan(
                text: subtitle,
                style: context.medium11.textTertiary.rubik,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

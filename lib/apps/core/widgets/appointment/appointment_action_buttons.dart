import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../generated/style_atoms.dart';
import '../../../../generated/translations.g.dart';
import '../../../features/common/appointments_management/presentation/controller/appointment_action_bloc.dart';
import '../../../features/common/appointments_management/presentation/controller/appointment_action_event.dart';
import '../../../features/common/auth/domain/entity/user/user_roles.dart';
import '../../../features/common/auth/presentation/widgets/custom_elevated_button.dart';
import '../../data/appointment/models/appointment.dart';
import '../../data/models/doctor/review.dart';
import '../../router/app_routes.dart';
import '../../theme/app_colors.dart';
import '../../utils/snack_bar_utils.dart';

class AppointmentActionButtons extends StatelessWidget {
  const AppointmentActionButtons({
    super.key,
    required this.appointment,
    required this.userRole,
    required this.appointmentReview,
    required this.tempReview,
  });

  final Appointment appointment;
  final UserRoles userRole;
  final ValueNotifier<Review?> appointmentReview;
  final ObjectRef<Review?> tempReview;

  @override
  Widget build(BuildContext context) {
    switch (userRole) {
      case UserRoles.admin:
      case UserRoles.doctor:
        if (appointment.status == AppointmentStatus.upcoming) {
          return Row(
            spacing: 10,
            children: [
              Expanded(child: _buildCancelButton(context)),
              Expanded(child: _buildMarkAsCompletedButton(context)),
            ],
          );
        }
        return Row(
          children: [
            Expanded(child: _buildViewDetailsButton(context)),
          ],
        );

      case UserRoles.patient:
        if (appointment.status == AppointmentStatus.upcoming) {
          return Row(
            spacing: 10,
            children: [
              Expanded(child: _buildViewDetailsButton(context)),
              Expanded(child: _buildCancelButton(context)),
            ],
          );
        } else if (appointment.status == AppointmentStatus.completed) {
          return ValueListenableBuilder<Review?>(
            valueListenable: appointmentReview,
            builder: (context, review, child) {
              if (review == null) {
                return Row(
                  spacing: 10,
                  children: [
                    Expanded(child: _buildViewDetailsButton(context)),
                    Expanded(child: _buildRateDoctorButton(context)),
                  ],
                );
              }
              return Row(
                children: [
                  Expanded(child: _buildViewDetailsButton(context)),
                ],
              );
            },
          );
        }
        return Row(
          children: [
            Expanded(child: _buildViewDetailsButton(context)),
          ],
        );
    }
  }

  Widget _buildCancelButton(BuildContext context) {
    return CustomElevatedButton(
      paddingVertical: 10,
      borderRadius: 8,
      backgroundColor: AppColors.statusErrorSurface,
      borderSideColor: AppColors.statusError,
      onPressed: () {
        context.read<AppointmentActionBloc>().add(
          CancelAppointmentEvent(appointment.id),
        );
      },
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          t.patientAppointments.cancelAppointment,
          style: context.medium11.statusError.rubik,
        ),
      ),
    );
  }

  Widget _buildMarkAsCompletedButton(BuildContext context) {
    return CustomElevatedButton(
      paddingVertical: 10,
      borderRadius: 8,
      backgroundColor: AppColors.brandPrimary,
      borderSideColor: AppColors.brandPrimary,
      onPressed: () {
        context.read<AppointmentActionBloc>().add(
          CompleteAppointmentEvent(appointment.id),
        );
      },
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          t.admin.appointmentsTab.markAsCompleted,
          style: context.medium11.white.rubik,
        ),
      ),
    );
  }

  Widget _buildViewDetailsButton(BuildContext context) {
    return CustomElevatedButton(
      paddingVertical: 10,
      borderRadius: 8,
      backgroundColor: AppColors.white,
      borderSideColor: AppColors.brandPrimary,
      onPressed: () {
        if (userRole == UserRoles.admin || userRole == UserRoles.doctor) {
          AdminAppointmentDetailsRoute(appointment).push(context);
        } else {
          PatientAppointmentDetailsRoute(appointment).push(context);
        }
      },
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          t.patientAppointments.viewDetails,
          style: context.medium11.brandPrimary.rubik,
        ),
      ),
    );
  }

  Widget _buildRateDoctorButton(BuildContext context) {
    return CustomElevatedButton(
      paddingVertical: 10,
      borderRadius: 8,
      backgroundColor: AppColors.brandPrimary,
      borderSideColor: AppColors.brandPrimary,
      onPressed: () {
        if (appointmentReview.value == null) {
          if (tempReview.value == null ||
              (tempReview.value?.rating ?? 0) == 0) {
            SnackBarUtils.showInfoSnackBar(
              context: context,
              message: t.patientAppointments.youMustSelectAtLeastOneStar,
            );
            return;
          }
          context.read<AppointmentActionBloc>().add(
            AddAppointmentReviewEvent(appointment, tempReview.value!),
          );
        }
      },
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          t.patientAppointments.rateDoctor,
          style: context.medium11.white.rubik,
        ),
      ),
    );
  }
}

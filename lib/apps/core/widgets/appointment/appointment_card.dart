import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../features/common/appointments_management/presentation/controller/appointment_action_bloc.dart';
import '../../../features/common/appointments_management/presentation/controller/appointment_action_state.dart';
import '../../../features/common/auth/domain/entity/user/user_roles.dart';
import '../../data/appointment/models/appointment.dart';
import '../../data/models/doctor/review.dart';
import '../../data/session/user_session_manager.dart';
import '../../di/di.dart';
import '../../presentation/controller/user/user_bloc.dart';
import '../../theme/app_colors.dart';
import '../../utils/snack_bar_utils.dart';
import '../app_container_with_shadow.dart';
import 'appointment_action_buttons.dart';
import 'appointment_details_wrap.dart';
import 'appointment_header_widget.dart';
import 'appointment_review_section.dart';

class AppointmentCard extends HookWidget {
  const AppointmentCard({super.key, required this.appointment});

  final Appointment appointment;

  @override
  Widget build(BuildContext context) {
    final appointmentReview = useValueNotifier<Review?>(appointment.review);
    final tempReview = useRef<Review?>(null);
    final isLoading = useValueNotifier<bool>(false);

    final userRole =
        context.select<UserBloc, UserRoles?>((bloc) => bloc.state.user?.role) ??
        getIt<UserSessionManager>().currentUser?.role ??
        UserRoles.patient;

    final isPatient = userRole == UserRoles.patient;

    return BlocListener<AppointmentActionBloc, AppointmentActionState>(
      listenWhen: (previous, current) {
        return (current is AppointmentActionLoading &&
                current.appointmentId == appointment.id) ||
            (current is AppointmentActionSuccess &&
                current.appointmentId == appointment.id) ||
            (current is AppointmentActionError &&
                current.appointmentId == appointment.id);
      },
      listener: (context, state) {
        if (state is AppointmentActionLoading) {
          isLoading.value = true;
        } else if (state is AppointmentActionSuccess) {
          isLoading.value = false;
          if (tempReview.value != null) {
            appointmentReview.value = tempReview.value;
            tempReview.value = null;
          }
        } else if (state is AppointmentActionError) {
          isLoading.value = false;
          appointmentReview.value = appointment.review;
          SnackBarUtils.showErrorSnackBar(
            context: context,
            message: state.message,
          );
        }
      },
      child: ValueListenableBuilder<bool>(
        valueListenable: isLoading,
        builder: (context, isLoadingValue, child) {
          return IgnorePointer(
            ignoring: isLoadingValue,
            child: Opacity(
              opacity: isLoadingValue ? 0.5 : 1.0,
              child: AppContainerWithShadow(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  spacing: 10,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppointmentHeaderWidget(
                      appointment: appointment,
                      userRole: userRole,
                    ),
                    const Divider(
                      color: AppColors.textSecondary,
                      thickness: 0.2,
                    ),
                    AppointmentDetailsWrap(
                      sessionTime: appointment.sessionTime,
                      fee: appointment.fee,
                    ),
                    if (appointment.status == AppointmentStatus.completed)
                      AppointmentReviewSection(
                        appointment: appointment,
                        isPatient: isPatient,
                        appointmentReview: appointmentReview,
                        tempReview: tempReview,
                      ),
                    AppointmentActionButtons(
                      appointment: appointment,
                      userRole: userRole,
                      appointmentReview: appointmentReview,
                      tempReview: tempReview,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

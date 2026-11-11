import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';

import '../../../../generated/style_atoms.dart';
import '../../../../generated/translations.g.dart';
import '../../../features/common/appointments_management/presentation/controller/appointment_action_bloc.dart';
import '../../../features/common/appointments_management/presentation/controller/appointment_action_event.dart';
import '../../../features/common/appointments_management/presentation/controller/appointment_action_state.dart';
import '../../../features/common/auth/domain/entity/user/user_roles.dart';
import '../../../features/common/auth/presentation/widgets/custom_elevated_button.dart';
import '../../data/appointment/models/appointment.dart';
import '../../data/models/doctor/review.dart';
import '../../data/session/user_session_manager.dart';
import '../../di/di.dart';
import '../../presentation/controller/user/user_bloc.dart';
import '../../router/app_routes.dart';
import '../../theme/app_colors.dart';
import '../../utils/snack_bar_utils.dart';
import '../app_container_with_shadow.dart';
import '../appointment_review_read_only_widget.dart';
import '../custom_cached_network_image.dart';
import 'review_input_widget.dart';

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
          final reviewWidget = _buildReviewWidget(
            isPatient: isPatient,
            appointmentReview: appointmentReview,
            tempReview: tempReview,
          );

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
                    _buildDisplayedData(context, userRole),
                    const Divider(
                      color: AppColors.textSecondary,
                      thickness: 0.2,
                    ),
                    _buildAppointmentDetails(context),
                    if (appointment.status == AppointmentStatus.completed &&
                        reviewWidget != null)
                      reviewWidget,
                    _buildActionButtons(
                      context: context,
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

  Widget _buildDisplayedData(BuildContext context, UserRoles userRole) {
    final bool isPatient = userRole == UserRoles.patient;
    final String? image = isPatient
        ? appointment.doctor.image
        : appointment.patient.image;

    return Row(
      spacing: 15,
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: CustomCachedNetworkImage.getProvider(image),
            ),
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: switch (userRole) {
              UserRoles.admin => [
                Text(
                  appointment.patient.name,
                  style: context.medium14.textTertiary.rubik,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  appointment.doctor.name,
                  style: context.regular12.textCaption.rubik,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  appointment.doctor.specialty.localizedName(),
                  style: context.light10.textSecondary.rubik,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
              UserRoles.doctor => [
                Text(
                  appointment.patient.name,
                  style: context.medium16.textTertiary.rubik,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  appointment.patient.email,
                  style: context.light14.textSecondary.rubik,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
              UserRoles.patient => [
                Text(
                  appointment.doctor.name,
                  style: context.medium16.textTertiary.rubik,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  appointment.doctor.specialty.localizedName(),
                  style: context.light14.textSecondary.rubik,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            },
          ),
        ),
        Chip(
          padding: const EdgeInsets.all(5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          side: const BorderSide(width: 0, color: AppColors.transparent),
          backgroundColor: appointment.status != AppointmentStatus.cancelled
              ? AppColors.brandPrimary20
              : AppColors.statusErrorSurface,
          avatarBoxConstraints: const BoxConstraints.tightFor(width: 15),
          avatar: Icon(
            Icons.circle,
            size: 10,
            color: appointment.status != AppointmentStatus.cancelled
                ? AppColors.brandPrimaryDark
                : AppColors.statusError,
          ),
          label: Text(
            appointment.status.name,
            style: appointment.status != AppointmentStatus.cancelled
                ? context.medium9.brandPrimaryDark.rubik
                : context.regular9.statusError.rubik,
          ),
        ),
      ],
    );
  }

  Widget _buildAppointmentDetails(BuildContext context) {
    return Wrap(
      spacing: 30,
      runSpacing: 15,
      children: [
        _buildListTile(
          icon: Icons.calendar_month_outlined,
          title: t.patientAppointments.appointmentDate,
          subtitle: DateFormat('dd MMM yyyy').format(appointment.sessionTime),
          context: context,
        ),
        _buildListTile(
          icon: Icons.access_time,
          title: t.patientAppointments.appointmentTime,
          subtitle: DateFormat('hh:mm a').format(appointment.sessionTime),
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
    );
  }

  Widget? _buildReviewWidget({
    required bool isPatient,
    required ValueNotifier<Review?> appointmentReview,
    required ObjectRef<Review?> tempReview,
  }) {
    if (!isPatient) {
      if (appointment.review != null) {
        return AppointmentReviewReadOnlyWidget(review: appointment.review!);
      }
      return null;
    }

    return ValueListenableBuilder<Review?>(
      valueListenable: appointmentReview,
      builder: (context, value, child) {
        if (value == null) {
          return ReviewInputWidget(
            onReviewChanged: (val) => tempReview.value = val,
            reviewer: appointment.patient,
          );
        }
        return AppointmentReviewReadOnlyWidget(review: value);
      },
    );
  }

  Widget _buildActionButtons({
    required BuildContext context,
    required UserRoles userRole,
    required ValueNotifier<Review?> appointmentReview,
    required ObjectRef<Review?> tempReview,
  }) {
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
        } else {
          return Row(
            children: [
              Expanded(child: _buildViewDetailsButton(context, userRole)),
            ],
          );
        }

      case UserRoles.patient:
        if (appointment.status == AppointmentStatus.upcoming) {
          return Row(
            spacing: 10,
            children: [
              Expanded(child: _buildViewDetailsButton(context, userRole)),
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
                    Expanded(child: _buildViewDetailsButton(context, userRole)),
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
              return Row(
                children: [
                  Expanded(child: _buildViewDetailsButton(context, userRole)),
                ],
              );
            },
          );
        } else {
          return Row(
            children: [
              Expanded(child: _buildViewDetailsButton(context, userRole)),
            ],
          );
        }
    }
  }

  Widget _buildCancelButton(BuildContext context) {
    return CustomElevatedButton(
      paddingVertical: 10,
      borderRadius: 8,
      backgroundColor: AppColors.statusErrorSurface,
      onPressed: () {
        context.read<AppointmentActionBloc>().add(
          CancelAppointmentEvent(appointment.id),
        );
      },
      borderSideColor: AppColors.statusError,
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
      onPressed: () {
        context.read<AppointmentActionBloc>().add(
          CompleteAppointmentEvent(appointment.id),
        );
      },
      borderSideColor: AppColors.brandPrimary,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          t.admin.appointmentsTab.markAsCompleted,
          style: context.medium11.white.rubik,
        ),
      ),
    );
  }

  Widget _buildViewDetailsButton(BuildContext context, UserRoles role) {
    return CustomElevatedButton(
      paddingVertical: 10,
      borderRadius: 8,
      backgroundColor: AppColors.white,
      onPressed: () {
        if (role == UserRoles.admin || role == UserRoles.doctor) {
          AdminAppointmentDetailsRoute(appointment).push(context);
        } else {
          PatientAppointmentDetailsRoute(appointment).push(context);
        }
      },
      borderSideColor: AppColors.brandPrimary,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          t.patientAppointments.viewDetails,
          style: context.medium11.brandPrimary.rubik,
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
      borderSideColor: AppColors.brandPrimary,
      child: FittedBox(
        fit: BoxFit.scaleDown,
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
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(7),
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

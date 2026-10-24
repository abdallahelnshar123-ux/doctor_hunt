part of '../screens/admin_appointments_tab.dart';

class AdminAppointmentCard extends HookWidget {
  const AdminAppointmentCard({super.key, required this.appointment});

  final Appointment appointment;

  @override
  Widget build(BuildContext context) {
    final isLoading = useValueNotifier<bool>(false);

    return BlocListener<AdminAppointmentsBloc, AdminAppointmentsState>(
      listenWhen: (previous, current) {
        if (current is AdminUpdateAppointmentLoadingState &&
            current.appointmentId == appointment.id) {
          return true;
        }
        if (current is AdminUpdateAppointmentSuccessState &&
            current.appointmentId == appointment.id) {
          return true;
        }
        if (current is AdminUpdateAppointmentErrorState &&
            current.appointmentId == appointment.id) {
          return true;
        }

        return false;
      },
      listener: (context, state) {
        if (state is AdminUpdateAppointmentLoadingState) {
          isLoading.value = true;
        } else if (state is AdminUpdateAppointmentSuccessState) {
          isLoading.value = false;
        } else if (state is AdminUpdateAppointmentErrorState) {
          isLoading.value = false;
          SnackBarUtils.showErrorSnackBar(
            context: context,
            message: state.message,
          );
        }
      },
      child: ValueListenableBuilder(
        valueListenable: isLoading,
        builder: (context, isLoading, child) {
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
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              fit: .cover,
                              image: CustomCachedNetworkImage.getProvider(
                                appointment.patient.image,
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
                                appointment.patient.name,
                                style: context.medium14.textTertiary.rubik,
                                overflow: .ellipsis,
                              ),
                              Text(
                                appointment.doctor.name,
                                style: context.regular12.textCaption.rubik,
                                overflow: .ellipsis,
                              ),
                              Text(
                                appointment.doctor.specialty.name,
                                style: context.light10.textSecondary.rubik,
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
                          title: t.admin.appointmentsTab.date,
                          subtitle: DateFormat(
                            'dd MMM yyyy',
                          ).format(appointment.sessionTime),
                          context: context,
                        ),
                        _buildListTile(
                          icon: Icons.access_time,
                          title: t.admin.appointmentsTab.time,
                          subtitle: DateFormat(
                            'hh:mm a',
                          ).format(appointment.sessionTime),
                          context: context,
                        ),
                        _buildListTile(
                          icon: Icons.payments_outlined,
                          title: t.admin.appointmentsTab.fee,
                          subtitle: t.patientAppointments.feeValue(
                            Fee: appointment.fee.toString(),
                          ),
                          context: context,
                        ),
                      ],
                    ),
                    ?appointment.status == AppointmentStatus.completed
                        ? appointment.review != null
                              ? AppointmentReviewReadOnlyWidget(
                                  review: appointment.review!,
                                )
                              : null
                        : null,

                    /// buttons
                    switch (appointment.status) {
                      AppointmentStatus.upcoming => _buildUpcomingButtons(
                        context: context,
                      ),
                      AppointmentStatus.completed => _buildViewDetailsButton(
                        context: context,
                      ),
                      AppointmentStatus.cancelled => _buildViewDetailsButton(
                        context: context,
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
        Expanded(child: _buildCancelButton(context: context)),
        Expanded(child: _buildMarkAsCompletedButton(context: context)),
      ],
    );
  }

  Widget _buildCancelButton({required BuildContext context}) {
    return CustomElevatedButton(
      paddingVertical: 10,
      borderRadius: 8,
      backgroundColor: AppColors.statusErrorSurface,
      onPressed: () {
        context.read<AdminAppointmentsBloc>().add(
          CancelAppointmentRequested(appointment.id),
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
    return Row(
      children: [
        Expanded(
          child: CustomElevatedButton(
            paddingVertical: 10,
            borderRadius: 8,
            backgroundColor: AppColors.white,
            onPressed: () {
              AdminAppointmentDetailsRoute(appointment).push(context);
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
        ),
      ],
    );
  }

  Widget _buildMarkAsCompletedButton({required BuildContext context}) {
    return CustomElevatedButton(
      paddingVertical: 10,
      borderRadius: 8,
      backgroundColor: AppColors.brandPrimary,
      onPressed: () {
        context.read<AdminAppointmentsBloc>().add(
          CompleteAppointmentRequested(appointment.id),
        );
      },
      borderSideColor: AppColors.brandPrimary,
      child: FittedBox(
        fit: .scaleDown,
        child: Text(
          t.admin.appointmentsTab.markAsCompleted,
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

import 'package:doctor_hunt/apps/core/theme/app_colors.dart';
import 'package:doctor_hunt/apps/core/widgets/app_container_with_shadow.dart';
import 'package:doctor_hunt/apps/core/widgets/custom_cached_network_image.dart';
import 'package:doctor_hunt/apps/features/patient/appointments_tab/data/models/appointment/appointment.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension AppointmentStatusExt on AppointmentStatus {
  String get localizedName {
    switch (this) {
      case AppointmentStatus.upcoming:
        return t.patientAppointments.upcoming;
      case AppointmentStatus.completed:
        return t.patientAppointments.completed;
      case AppointmentStatus.cancelled:
        return t.patientAppointments.canceled;
    }
  }
}

class ScheduleAppointmentCard extends StatelessWidget {
  const ScheduleAppointmentCard({super.key, required this.appointment});

  final Appointment appointment;

  @override
  Widget build(BuildContext context) {
    return AppContainerWithShadow(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: CustomCachedNetworkImage.getProvider(
                      appointment.patient.image,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appointment.patient.name,
                      style: context.medium14.textTertiary.rubik,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      appointment.patient.email,
                      style: context.regular12.textCaption.rubik,
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
                backgroundColor:
                    appointment.status != AppointmentStatus.cancelled
                    ? AppColors.brandPrimary20
                    : AppColors.statusErrorSurface,
                avatarBoxConstraints: const BoxConstraints.tightFor(width: 15),
                avatar: Icon(
                  Icons.circle,
                  color: appointment.status != AppointmentStatus.cancelled
                      ? AppColors.brandPrimary
                      : AppColors.statusError,
                  size: 15,
                ),
                label: Text(
                  appointment.status.localizedName,
                  style: context.regular12.textSecondary.rubik.copyWith(
                    color: appointment.status != AppointmentStatus.cancelled
                        ? AppColors.brandPrimary
                        : AppColors.statusError,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t.admin.appointmentsTab.date,
                    style: context.regular12.textSecondary.rubik,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    DateFormat('dd MMM, yyyy').format(appointment.sessionTime),
                    style: context.medium14.textTertiary.rubik,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t.admin.appointmentsTab.time,
                    style: context.regular12.textSecondary.rubik,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    DateFormat('hh:mm a').format(appointment.sessionTime),
                    style: context.medium14.textTertiary.rubik,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

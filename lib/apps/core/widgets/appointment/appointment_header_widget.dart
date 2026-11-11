import 'package:flutter/material.dart';

import '../../../../generated/style_atoms.dart';
import '../../../features/common/auth/domain/entity/user/user_roles.dart';
import '../../data/appointment/models/appointment.dart';
import '../custom_cached_network_image.dart';
import 'appointment_status_chip.dart';

class AppointmentHeaderWidget extends StatelessWidget {
  const AppointmentHeaderWidget({
    super.key,
    required this.appointment,
    required this.userRole,
  });

  final Appointment appointment;
  final UserRoles userRole;

  @override
  Widget build(BuildContext context) {
    final bool isPatient = userRole == UserRoles.patient;
    final String? image = isPatient
        ? appointment.doctor.image
        : appointment.patient.image;

    return Row(
      spacing: 15,
      children: [
        CustomCachedNetworkImage(
          imgUrl: image,
          width: 80,
          height: 80,
          borderRadius: BorderRadius.circular(8),
        ),
        Expanded(
          child: Column(
            spacing: 4,
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
        AppointmentStatusChip(status: appointment.status),
      ],
    );
  }
}

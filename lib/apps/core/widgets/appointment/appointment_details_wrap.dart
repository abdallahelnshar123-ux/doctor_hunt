import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../generated/translations.g.dart';
import 'appointment_info_tile.dart';

class AppointmentDetailsWrap extends StatelessWidget {
  const AppointmentDetailsWrap({
    super.key,
    required this.sessionTime,
    required this.fee,
  });

  final DateTime sessionTime;
  final double fee;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 24,
      runSpacing: 12,
      children: [
        AppointmentInfoTile(
          icon: Icons.calendar_month_outlined,
          title: t.patientAppointments.appointmentDate,
          subtitle: DateFormat('dd MMM yyyy').format(sessionTime),
        ),
        AppointmentInfoTile(
          icon: Icons.access_time,
          title: t.patientAppointments.appointmentTime,
          subtitle: DateFormat('hh:mm a').format(sessionTime),
        ),
        AppointmentInfoTile(
          icon: Icons.payments_outlined,
          title: t.patientAppointments.consultationFee,
          subtitle: t.patientAppointments.feeValue(
            Fee: fee.toString(),
          ),
        ),
      ],
    );
  }
}

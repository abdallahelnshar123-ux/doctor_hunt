import 'package:flutter/material.dart';

import '../../../../generated/style_atoms.dart';
import '../../../../generated/translations.g.dart';
import '../../data/appointment/models/appointment.dart';
import '../../theme/app_colors.dart';

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

class AppointmentStatusChip extends StatelessWidget {
  const AppointmentStatusChip({super.key, required this.status});

  final AppointmentStatus status;

  @override
  Widget build(BuildContext context) {
    final (Color backgroundColor, Color dotColor, TextStyle labelStyle) =
        switch (status) {
          AppointmentStatus.upcoming => (
            AppColors.brandPrimary20,
            AppColors.brandPrimaryDark,
            context.medium9.brandPrimaryDark.rubik,
          ),
          AppointmentStatus.completed => (
            AppColors.statusSuccessSurface,
            AppColors.brandPrimaryDark,
            context.medium9.brandPrimaryDark.rubik,
          ),
          AppointmentStatus.cancelled => (
            AppColors.statusErrorSurface,
            AppColors.statusError,
            context.regular9.statusError.rubik,
          ),
        };

    return Chip(
      padding: const EdgeInsets.all(5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      side: const BorderSide(width: 0, color: AppColors.transparent),
      backgroundColor: backgroundColor,
      avatarBoxConstraints: const BoxConstraints.tightFor(width: 15),
      avatar: Icon(
        Icons.circle,
        size: 10,
        color: dotColor,
      ),
      label: Text(
        status.localizedName,
        style: labelStyle,
      ),
    );
  }
}

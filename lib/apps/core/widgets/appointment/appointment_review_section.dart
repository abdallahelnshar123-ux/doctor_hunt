import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../data/appointment/models/appointment.dart';
import '../../data/models/doctor/review.dart';
import 'appointment_review_read_only_widget.dart';
import 'review_input_widget.dart';

class AppointmentReviewSection extends StatelessWidget {
  const AppointmentReviewSection({
    super.key,
    required this.appointment,
    required this.isPatient,
    required this.appointmentReview,
    required this.tempReview,
  });

  final Appointment appointment;
  final bool isPatient;
  final ValueNotifier<Review?> appointmentReview;
  final ObjectRef<Review?> tempReview;

  @override
  Widget build(BuildContext context) {
    if (!isPatient) {
      if (appointment.review != null) {
        return AppointmentReviewReadOnlyWidget(review: appointment.review!);
      }
      return const SizedBox.shrink();
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
}

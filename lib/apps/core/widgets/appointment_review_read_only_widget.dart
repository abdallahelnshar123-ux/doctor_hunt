import 'package:flutter/material.dart';

import '../../../generated/style_atoms.dart';
import '../data/models/doctor/review.dart';
import '../theme/app_colors.dart';

class AppointmentReviewReadOnlyWidget extends StatelessWidget {
  const AppointmentReviewReadOnlyWidget({super.key, required this.review});

  final Review review;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.reviewBg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Row(
            spacing: 5,
            children: [
              Icon(Icons.star, color: AppColors.textTertiary, size: 17),
              Text(
                '${review.rating.toString()}.0',
                style: context.regular12.textTertiary.rubik,
              ),
            ],
          ),
          ?review.comment != null
              ? Text(
                  '"${review.comment!}"',
                  style: context.regular12.textTertiary.rubik,
                )
              : null,
        ],
      ),
    );
  }
}

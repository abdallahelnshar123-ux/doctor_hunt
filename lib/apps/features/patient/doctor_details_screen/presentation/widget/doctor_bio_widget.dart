import 'package:flutter/material.dart';

import '../../../../../../generated/style_atoms.dart';
import '../../../../../../generated/translations.g.dart';

class DoctorBioWidget extends StatelessWidget {
  const DoctorBioWidget({super.key, this.bio});

  final String? bio;

  @override
  Widget build(BuildContext context) {
    final hasBio = bio != null && bio!.trim().isNotEmpty;

    return Column(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.features.patient.doctorDetailsScreen.aboutDoctor,
          style: context.medium18.textTertiary.rubik,
        ),
        Text(
          hasBio
              ? bio!.trim()
              : t.features.patient.doctorDetailsScreen.noBioAvailable,
          style: hasBio
              ? context.regular14.textSecondary.rubik.copyWith(height: 1.5)
              : context.light14.textSecondary.rubik.copyWith(
                  fontStyle: FontStyle.italic,
                  height: 1.5,
                ),
        ),
      ],
    );
  }
}

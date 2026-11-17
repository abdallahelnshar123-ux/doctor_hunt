import 'package:doctor_hunt/apps/core/widgets/app_scaffold.dart';
import 'package:doctor_hunt/apps/core/widgets/main_app_bar.dart';
import 'package:doctor_hunt/apps/core/widgets/map/clinic_location_preview_card.dart';
import 'package:doctor_hunt/apps/features/common/auth/domain/entity/user/doctor.dart';
import 'package:doctor_hunt/apps/features/patient/doctor_details_screen/presentation/widget/doctor_bio_widget.dart';
import 'package:doctor_hunt/apps/features/patient/doctor_details_screen/presentation/widget/doctor_details_card.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter/material.dart';

class PatientDoctorDetailsScreen extends StatelessWidget {
  const PatientDoctorDetailsScreen({super.key, required this.doctor});

  final DoctorEntity doctor;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Column(
        children: [
          MainAppBar(title: t.features.patient.doctorDetailsScreen.title),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                crossAxisAlignment: .start,
                spacing: 24,
                children: [
                  DoctorDetailsCard(doctor: doctor),
                  // DoctorStatisticsWidget(),
                  DoctorBioWidget(bio: doctor.bio),
                  ClinicLocationPreviewCard(
                    latitude: doctor.latitude,
                    longitude: doctor.longitude,
                    clinicAddress: doctor.clinicAddress,
                    doctorName: doctor.name,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

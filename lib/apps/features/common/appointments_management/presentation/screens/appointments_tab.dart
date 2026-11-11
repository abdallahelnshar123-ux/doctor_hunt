import 'package:flutter/material.dart';

import '../../../../../../generated/translations.g.dart';
import '../../../../../core/widgets/app_scaffold.dart';
import '../widgets/appointments_view.dart';

class AppointmentsTab extends StatelessWidget {
  const AppointmentsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      bottomSafeArea: false,
      body: Column(
        children: [
          AppBar(title: Text(t.patientAppointments.title)),
          const SizedBox(height: 10),
          const Expanded(child: AppointmentsView()),
        ],
      ),
    );
  }
}

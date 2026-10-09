import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter/material.dart';

import '../../../admin_doctors_tab/presentation/screens/admin_doctors_tab.dart';

class AdminAppointmentsTab extends StatelessWidget {
  const AdminAppointmentsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AdminAppbar(title: t.admin.appointments_tab.title),
        body: Placeholder(),
      ),
    );
  }
}

import 'package:doctor_hunt/apps/core/widgets/logout_button.dart';
import 'package:doctor_hunt/apps/core/widgets/settings_user_card.dart';
import 'package:doctor_hunt/apps/features/doctor/presentation/widgets/doctor_account_settings_widget.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter/material.dart';

class DoctorSettingsTab extends StatelessWidget {
  const DoctorSettingsTab({
    super.key,
    this.onSelectScheduleTab,
    this.onSelectProfileTab,
  });

  final VoidCallback? onSelectScheduleTab;
  final VoidCallback? onSelectProfileTab;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(t.doctor.settings.title),
          automaticallyImplyLeading: false,
          centerTitle: true,
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            const SettingsUserCard(),
            const SizedBox(height: 20),
            DoctorAccountSettingsWidget(
              onSelectScheduleTab: onSelectScheduleTab,
              onSelectProfileTab: onSelectProfileTab,
            ),
            const SizedBox(height: 40),
            const LogoutButton(),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}

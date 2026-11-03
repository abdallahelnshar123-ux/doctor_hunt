import 'package:doctor_hunt/apps/core/widgets/custom_negative_button.dart';
import 'package:doctor_hunt/apps/core/widgets/basic_user_card.dart';
import 'package:doctor_hunt/apps/features/doctor/presentation/widgets/doctor_account_settings_widget.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/dialog_utils.dart';
import '../../../common/auth/presentation/controller/auth/auth_bloc.dart';
import '../../../common/auth/presentation/controller/auth/auth_event.dart';

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
            const BasicUserCard(),
            const SizedBox(height: 20),
            DoctorAccountSettingsWidget(
              onSelectScheduleTab: onSelectScheduleTab,
              onSelectProfileTab: onSelectProfileTab,
            ),
            const SizedBox(height: 40),
            CustomNegativeButton(
              icon: Icon(Icons.logout),
              text: t.settings.logout,
              onPressed: () {
                DialogUtils.showMessage(
                  context: context,
                  message: t.settings.logoutConfirmation,
                  title: t.settings.logout,
                  posActionText: t.dialog.ok,
                  posAction: () {
                    context.read<AuthBloc>().add(LogoutRequested());
                  },
                  negActionText: t.dialog.cancel,
                );
              },
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}

import 'package:doctor_hunt/apps/core/widgets/basic_user_card.dart';
import 'package:doctor_hunt/apps/core/widgets/custom_negative_button.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/dialog_utils.dart';
import '../../../common/auth/presentation/controller/auth/auth_bloc.dart';
import '../../../common/auth/presentation/controller/auth/auth_event.dart';
import '../widget/doctor_account_settings_widget.dart';

class DoctorSettingsTab extends StatelessWidget {
  const DoctorSettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    return Column(
      spacing: 20,
      children: [
        AppBar(
          title: Text(t.features.doctor.doctorSettingsTab.title),
          titleSpacing: 20,
          toolbarHeight: 60,
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: [
              const BasicUserCard(),
              const SizedBox(height: 20),
              const DoctorAccountSettingsWidget(),
              const SizedBox(height: 40),
              CustomNegativeButton(
                icon: Icon(Icons.logout),
                text: t.core.common.logout,
                onPressed: () {
                  DialogUtils.showMessage(
                    context: context,
                    message: t.core.common.logoutConfirmation,
                    title: t.core.common.logout,
                    posActionText: t.core.dialogs.ok,
                    posAction: () {
                      context.read<AuthBloc>().add(LogoutRequested());
                    },
                    negActionText: t.core.dialogs.cancel,
                  );
                },
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ],
    );
  }
}

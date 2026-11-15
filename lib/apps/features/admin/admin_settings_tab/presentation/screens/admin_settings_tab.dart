import 'package:doctor_hunt/apps/core/presentation/controller/user/user_bloc.dart';
import 'package:doctor_hunt/apps/core/widgets/basic_user_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../generated/style_atoms.dart';
import '../../../../../../generated/translations.g.dart';
import '../../../../../core/router/app_routes.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/dialog_utils.dart';
import '../../../../../core/widgets/app_container_with_shadow.dart';
import '../../../../../core/widgets/custom_negative_button.dart';
import '../../../../../core/widgets/language_picker_popup_menu.dart';
import '../../../../common/auth/domain/entity/user/app_user.dart';
import '../../../../common/auth/presentation/controller/auth/auth_bloc.dart';
import '../../../../common/auth/presentation/controller/auth/auth_event.dart';

part '../widget/account_settings_widget.dart';

class AdminSettingsTab extends StatelessWidget {
  const AdminSettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        children: [
          BasicUserCard(),
          SizedBox(height: 20),
          AccountSettingsWidget(),
          SizedBox(height: 40),
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
        ],
      ),
    );
  }
}

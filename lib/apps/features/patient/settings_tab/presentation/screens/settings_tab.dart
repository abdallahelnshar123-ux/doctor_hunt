import 'package:doctor_hunt/apps/core/presentation/controller/user/user_bloc.dart';
import 'package:doctor_hunt/apps/core/utils/dialog_utils.dart';
import 'package:doctor_hunt/apps/core/widgets/app_scaffold.dart';
import 'package:doctor_hunt/apps/core/widgets/logout_button.dart';
import 'package:doctor_hunt/apps/core/widgets/settings_user_card.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../generated/translations.g.dart';
import '../../../../../core/router/app_routes.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../common/auth/data/models/user/my_user.dart';
import '../../../../common/auth/presentation/controller/auth/auth_bloc.dart';
import '../../../../common/auth/presentation/controller/auth/auth_state.dart';

part '../widget/account_settings_widget.dart';
part '../widget/more_option_widget.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.select<UserBloc, MyUser?>((bloc) => bloc.currentUser);
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (previous, current) =>
          current is LogoutLoadingState || current is LogoutErrorState,

      listener: (context, state) {
        if (state is LogoutLoadingState) {
          DialogUtils.showLoading(context: context);
        } else if (state is LogoutErrorState) {
          DialogUtils.hideLoading(context: context);
          DialogUtils.showMessage(
            posActionText: t.dialog.ok,
            title: t.dialog.error,
            context: context,
            message: state.message,
          );
        }
      },
      child: AppScaffold(
        bottomSafeArea: false,
        body: Column(
          children: [
            AppBar(title: Text(t.settings.title)),
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(20),
                children: [
                  SettingsUserCard(
                    onTap: () {
                      if (user == null) return;
                      PatientProfileRoute(user).push(context);
                    },
                  ),
                  SizedBox(height: 15),
                  AccountSettingsWidget(),
                  SizedBox(height: 15),
                  MoreOptionWidget(),
                  SizedBox(height: 40),
                  LogoutButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

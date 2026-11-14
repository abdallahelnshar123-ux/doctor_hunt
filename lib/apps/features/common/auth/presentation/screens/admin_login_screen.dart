import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../generated/translations.g.dart';
import '../../../../../core/router/app_routes.dart';
import '../../../../../core/utils/dialog_utils.dart';
import '../../../../../core/widgets/app_scaffold.dart';
import '../../../../../core/widgets/main_app_bar.dart';
import '../../domain/entity/user/user_roles.dart';
import '../controller/auth/auth_bloc.dart';
import '../controller/auth/auth_state.dart';
import '../widgets/role_login_form_widget.dart';

class AdminLoginScreen extends StatelessWidget {
  const AdminLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LoginWithEmailPasswordErrorState) {
          debugPrint(state.message);
          DialogUtils.showMessage(
            posActionText: t.dialog.ok,
            title: t.dialog.error,
            context: context,
            message: state.message,
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is LoginWithEmailPasswordLoadingState;

        return AppScaffold(
          isLoading: isLoading,
          resizeToAvoidBottomInset: true,
          body: Column(
            children: [
              MainAppBar(
                onPressed: () {
                  const ChooseRoleRoute().go(context);
                },
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: RoleLoginFormWidget(
                    role: UserRoles.admin,
                    subtitle: t.auth.adminSubtitle,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

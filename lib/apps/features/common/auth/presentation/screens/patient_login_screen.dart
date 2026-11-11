import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../generated/translations.g.dart';
import '../../../../../core/router/app_routes.dart';
import '../../../../../core/utils/dialog_utils.dart';
import '../../../../../core/widgets/app_scaffold.dart';
import '../../../../../core/widgets/main_app_bar.dart';
import '../controller/auth/auth_bloc.dart';
import '../controller/auth/auth_state.dart';
import '../widgets/patient_login_form_widget.dart';

class PatientLoginScreen extends StatelessWidget {
  const PatientLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LoginWithEmailPasswordErrorState) {
          debugPrint(state.message);
          DialogUtils.hideLoading(context: context);
          DialogUtils.showMessage(
            posActionText: t.dialog.ok,
            title: t.dialog.error,
            context: context,
            message: state.message,
          );
        }
        if (state is ContinueWithGoogleErrorState) {
          DialogUtils.hideLoading(context: context);
          if (!state.message.contains(t.errors.cancelledByUser)) {
            DialogUtils.showMessage(
              posActionText: t.dialog.ok,
              title: t.dialog.error,
              context: context,
              message: state.message,
            );
          }
        }
        if (state is LoginWithEmailPasswordLoadingState ||
            state is ContinueWithGoogleLoadingState) {
          DialogUtils.showLoading(context: context);
        }
        if (state is UserAuthenticatedState) {
          DialogUtils.hideLoading(context: context);
        }
      },
      child: AppScaffold(
        resizeToAvoidBottomInset: true,
        body: Column(
          children: [
            MainAppBar(
              onPressed: () {
                const ChooseRoleRoute().go(context);
              },
            ),
            const Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: PatientLoginFormWidget(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../generated/translations.g.dart';
import '../../../../../core/router/app_routes.dart';
import '../../../../../core/utils/dialog_utils.dart';
import '../../../../../core/widgets/app_scaffold.dart';
import '../../../../../core/widgets/main_app_bar.dart';
import '../controller/auth/auth_bloc.dart';
import '../controller/auth/auth_state.dart';
import '../widgets/patient_register_form_widget.dart';

class PatientRegisterScreen extends StatelessWidget {
  const PatientRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is RegisterWithEmailPasswordErrorState) {
          DialogUtils.hideLoading(context: context);
          DialogUtils.showMessage(
            posActionText: t.dialog.ok,
            title: t.dialog.error,
            context: context,
            message: state.message,
          );
        }
        if (state is RegisterWithEmailPasswordSuccessState) {
          DialogUtils.hideLoading(context: context);
          DialogUtils.showMessage(
            title: t.dialog.success,
            context: context,
            message: t.dialog.registeredSuccessfully,
            posAction: () {
              const PatientLoginRoute().go(context);
            },
            posActionText: t.dialog.ok,
          );
        }
        if (state is ContinueWithGoogleErrorState) {
          DialogUtils.hideLoading(context: context);
          if (state.message != t.errors.cancelledByUser) {
            DialogUtils.showMessage(
              posActionText: t.dialog.ok,
              title: t.dialog.error,
              context: context,
              message: state.message,
            );
          }
        }
        if (state is RegisterWithEmailPasswordLoadingState ||
            state is ContinueWithGoogleLoadingState) {
          DialogUtils.showLoading(context: context);
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
                child: PatientRegisterFormWidget(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

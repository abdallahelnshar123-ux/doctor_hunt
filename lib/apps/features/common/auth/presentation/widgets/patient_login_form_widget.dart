import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../../../generated/translations.g.dart';
import '../../../../../core/router/app_routes.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/validators.dart';
import '../../domain/entity/user/user_roles.dart';
import '../controller/auth/auth_bloc.dart';
import '../controller/auth/auth_event.dart';
import 'auth_header_widget.dart';
import 'auth_submit_button.dart';
import 'auth_text_button.dart';
import 'continue_with_google_button.dart';
import 'custom_text_password.dart';
import 'email_text_field_widget.dart';
import 'forgot_password_button.dart';

class PatientLoginFormWidget extends HookWidget {
  const PatientLoginFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();

    void onLogin() {
      FocusManager.instance.primaryFocus?.unfocus();
      if (formKey.currentState?.validate() ?? false) {
        context.read<AuthBloc>().add(
          LoginRequested(
            role: UserRoles.patient,
            email: emailController.text.trim(),
            password: passwordController.text,
          ),
        );
      }
    }

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 100),
          AuthHeaderWidget(
            title: t.features.common.auth.welcomeBack,
            subtitle: t.features.common.auth.authSubtitle,
          ),
          const SizedBox(height: 60),
          ContinueWithGoogleButton(
            onPressed: () {
              context.read<AuthBloc>().add(
                ContinueWithGoogleRequested(),
              );
            },
          ),
          const SizedBox(height: 30),
          EmailTextFieldWidget(
            controller: emailController,
            fillColor: AppColors.bgPrimary,
          ),
          const SizedBox(height: 12),
          CustomTextPassword(
            controller: passwordController,
            validator: (value) => Validators.password(value),
          ),
          const SizedBox(height: 24),
          AuthSubmitButton(
            text: t.features.common.auth.login,
            onPressed: onLogin,
          ),
          const SizedBox(height: 8),
          const ForgotPasswordButton(),
          const SizedBox(height: 8),
          AuthTextButton(
            text: t.features.common.auth.noAccount,
            onPressed: () {
              const PatientRegisterRoute().go(context);
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

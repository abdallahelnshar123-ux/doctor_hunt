import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../../../generated/translations.g.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/validators.dart';
import '../../data/models/user/my_user.dart';
import '../controller/auth/auth_bloc.dart';
import '../controller/auth/auth_event.dart';
import 'auth_header_widget.dart';
import 'auth_submit_button.dart';
import 'custom_text_password.dart';
import 'email_text_field_widget.dart';
import 'forgot_password_button.dart';

class RoleLoginFormWidget extends HookWidget {
  const RoleLoginFormWidget({
    super.key,
    required this.role,
    required this.subtitle,
  });

  final UserRoles role;
  final String subtitle;

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
            role: role,
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
            title: t.auth.welcomeBack,
            subtitle: subtitle,
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
            text: t.auth.login,
            onPressed: onLogin,
          ),
          const SizedBox(height: 8),
          const ForgotPasswordButton(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

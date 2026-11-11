import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../../../generated/style_atoms.dart';
import '../../../../../../generated/translations.g.dart';
import '../../../../../core/router/app_routes.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/snack_bar_utils.dart';
import '../../../../../core/utils/validators.dart';
import '../../../../../core/widgets/custom_text_form_field.dart';
import '../controller/auth/auth_bloc.dart';
import '../controller/auth/auth_event.dart';
import 'auth_header_widget.dart';
import 'auth_submit_button.dart';
import 'auth_terms_checkbox_widget.dart';
import 'auth_text_button.dart';
import 'continue_with_google_button.dart';
import 'custom_text_password.dart';
import 'email_text_field_widget.dart';

class PatientRegisterFormWidget extends HookWidget {
  const PatientRegisterFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final nameController = useTextEditingController();
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final isAgreedToTerms = useValueNotifier<bool>(false);

    void onRegister() {
      FocusManager.instance.primaryFocus?.unfocus();
      if (formKey.currentState?.validate() ?? false) {
        if (!isAgreedToTerms.value) {
          SnackBarUtils.showErrorSnackBar(
            context: context,
            message: t.auth.youMustAgreeToTerms,
          );
          return;
        }
        context.read<AuthBloc>().add(
          RegisterRequested(
            name: nameController.text.trim(),
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
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
            title: t.auth.joinUs,
            subtitle: t.auth.authSubtitle,
          ),
          const SizedBox(height: 60),
          ContinueWithGoogleButton(
            onPressed: () {
              context.read<AuthBloc>().add(
                ContinueWithGoogleRequested(),
              );
            },
          ),
          const SizedBox(height: 25),
          CustomTextFormField(
            controller: nameController,
            fillColor: AppColors.bgPrimary,
            filled: true,
            hintText: t.auth.username,
            hintStyle: context.light16.textSecondary.rubik,
            style: context.light16.textSecondary.rubik,
            validator: (value) => Validators.required(value),
          ),
          const SizedBox(height: 12),
          EmailTextFieldWidget(
            controller: emailController,
            fillColor: AppColors.bgPrimary,
          ),
          const SizedBox(height: 12),
          CustomTextPassword(
            controller: passwordController,
            validator: (value) => Validators.password(value),
          ),
          const SizedBox(height: 8),
          AuthTermsCheckboxWidget(isAgreedToTerms: isAgreedToTerms),
          const SizedBox(height: 24),
          AuthSubmitButton(
            text: t.auth.signUp,
            onPressed: onRegister,
          ),
          const SizedBox(height: 20),
          AuthTextButton(
            text: t.auth.haveAccount,
            onPressed: () {
              const PatientLoginRoute().go(context);
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

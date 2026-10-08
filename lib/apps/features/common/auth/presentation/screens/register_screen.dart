import 'package:doctor_hunt/apps/core/router/app_routes.dart';
import 'package:doctor_hunt/apps/core/utils/snack_bar_utils.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../../core/extensions/context_extensions.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/dialog_utils.dart';
import '../../../../../core/utils/validators.dart';
import '../../../../../core/widgets/app_scaffold.dart';
import '../../../../../core/widgets/custom_text_form_field.dart';
import '../controller/auth/auth_bloc.dart';
import '../controller/auth/auth_event.dart';
import '../controller/auth/auth_state.dart';
import '../widgets/continue_with_google_button.dart';
import '../widgets/custom_elevated_button.dart';
import '../widgets/custom_text_password.dart';
import '../widgets/email_text_field_widget.dart';

class RegisterScreen extends HookWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final nameController = useTextEditingController();
    final isAgreedToTerms = useValueNotifier<bool>(false);

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
            message: t.dialog.registered_successfully,
            posAction: () {
              const PatientLoginRoute().go(context);
            },
            posActionText: t.dialog.ok,
          );
        }
        if (state is ContinueWithGoogleErrorState) {
          DialogUtils.hideLoading(context: context);
          DialogUtils.showMessage(
            posActionText: t.dialog.ok,
            title: t.dialog.error,
            context: context,
            message: state.message,
          );
        }
        if (state is RegisterWithEmailPasswordLoadingState ||
            state is ContinueWithGoogleLoadingState) {
          DialogUtils.showLoading(context: context);
        }
      },
      child: AppScaffold(
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: formKey,
                  child: Column(
                    spacing: 8,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 150),
                      FittedBox(
                        fit: .scaleDown,
                        child: Text(
                          t.auth.join_us,
                          style: context.medium24.black.rubik,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Text(
                        t.auth.auth_subtitle,
                        style: context.regular14.textSecondary.rubik,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 60),
                      ContinueWithGoogleButton(
                        onPressed: () {
                          context.read<AuthBloc>().add(
                            ContinueWithGoogleRequested(),
                          );
                        },
                      ),
                      SizedBox(height: 25),
                      CustomTextFormField(
                        controller: nameController,
                        fillColor: AppColors.bgPrimary,
                        filled: true,
                        hintText: t.auth.username,
                        hintStyle: context.light16.textSecondary.rubik,
                        style: context.light16.textSecondary.rubik,
                        validator: (value) => Validators.required(value),
                      ),
                      EmailTextFieldWidget(
                        controller: emailController,
                        fillColor: AppColors.bgPrimary,
                      ),

                      CustomTextPassword(
                        controller: passwordController,
                        validator: (value) => Validators.password(value),
                      ),
                      _buildAgreeWithTerms(context, isAgreedToTerms),
                      SizedBox(height: 24),
                      _buildRegisterButton(
                        context,
                        formKey,
                        isAgreedToTerms,
                        nameController,
                        emailController,
                        passwordController,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 25),
              child: _buildHaveAnAccount(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHaveAnAccount(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      onPressed: () {
        FocusManager.instance.primaryFocus?.unfocus();
        const PatientLoginRoute().go(context);
      },
      child: Text(
        t.auth.have_account,
        style: context.regular14.brandPrimary.rubik,
      ),
    );
  }

  Widget _buildAgreeWithTerms(
    BuildContext context,
    ValueNotifier<bool> isAgreedToTerms,
  ) {
    return ValueListenableBuilder<bool>(
      valueListenable: isAgreedToTerms,
      builder: (context, value, child) {
        return TextButton.icon(
          icon: Icon(value ? Icons.circle : Icons.circle_outlined),
          style: ButtonStyle(
            padding: WidgetStatePropertyAll(EdgeInsets.zero),
            iconColor: WidgetStatePropertyAll(AppColors.textSecondary),
            iconSize: WidgetStatePropertyAll(25),
            textStyle: WidgetStatePropertyAll(
              context.regular12.textSecondary.rubik,
            ),
            foregroundColor: WidgetStatePropertyAll(AppColors.textSecondary),
          ),
          onPressed: () {
            isAgreedToTerms.value = !isAgreedToTerms.value;
          },
          label: Text(t.auth.agree_terms),
        );
      },
    );
  }

  Widget _buildRegisterButton(
    BuildContext context,
    GlobalKey<FormState> formKey,
    ValueNotifier<bool> isAgreedToTerms,
    TextEditingController nameController,
    TextEditingController emailController,
    TextEditingController passwordController,
  ) {
    return CustomElevatedButton(
      buttonWidth: context.width - 80,
      onPressed: () {
        FocusManager.instance.primaryFocus?.unfocus();
        if (formKey.currentState!.validate()) {
          if (!isAgreedToTerms.value) {
            SnackBarUtils.showErrorSnackBar(
              context: context,
              message: t.auth.you_must_agree_to_terms,
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
      },
      backgroundColor: AppColors.brandPrimary,
      child: Text(t.auth.sign_up, style: context.medium18.white.rubik),
    );
  }
}

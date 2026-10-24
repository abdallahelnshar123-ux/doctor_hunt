import 'package:doctor_hunt/apps/core/utils/dialog_utils.dart';
import 'package:doctor_hunt/apps/core/utils/validators.dart';
import 'package:doctor_hunt/apps/core/widgets/custom_text_form_field.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/controller/auth/auth_event.dart';
import 'package:doctor_hunt/generated/app_assets.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../../../generated/style_atoms.dart';
import '../../../../../core/theme/app_colors.dart';
import '../controller/auth/auth_bloc.dart';
import '../controller/auth/auth_state.dart';
import '../widgets/custom_elevated_button.dart';

class ForgotPasswordScreen extends HookWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController();
    final formKey = useMemoized(() => GlobalKey<FormState>());

    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (previous, current) =>
          current is ResetUSerPasswordErrorState ||
          current is ResetUserPasswordSuccessState ||
          current is ResetUSerPasswordLoadingState,
      listener: (context, state) {
        if (state is ResetUSerPasswordLoadingState) {
          DialogUtils.showLoading(context: context);
        }
        if (state is ResetUSerPasswordErrorState) {
          DialogUtils.hideLoading(context: context);
          DialogUtils.showMessage(
            posActionText: t.dialog.ok,
            title: t.dialog.error,
            context: context,
            message: state.message,
          );
        }
        if (state is ResetUserPasswordSuccessState) {
          DialogUtils.hideLoading(context: context);
          DialogUtils.showMessage(
            context: context,
            message: t.forgotPassword.successDialogMessage,
            posActionText: t.dialog.ok,
            title: t.dialog.success,
            posAction: () {
              Navigator.pop(context);
            },
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text(t.forgotPassword.title)),
        body: Form(
          key: formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Image.asset(
                  AppAssets.images.forgotPasswordImage.path,
                  fit: .cover,
                ),
              ),
              SizedBox(height: 20),
              Text(
                t.forgotPassword.description,
                style: context.regular14.textSecondary.rubik,
                textAlign: .center,
              ),
              SizedBox(height: 60),
              CustomTextFormField(
                hintText: t.forgotPassword.email,
                controller: emailController,
                validator: (value) => Validators.email(value),
              ),
              SizedBox(height: 20),
              _builtLoginSendLink(context, formKey, emailController),
            ],
          ),
        ),
      ),
    );
  }

  Widget _builtLoginSendLink(
    BuildContext context,
    GlobalKey<FormState> formKey,
    TextEditingController emailController,
  ) {
    return CustomElevatedButton(
      onPressed: () {
        if (formKey.currentState!.validate()) {
          context.read<AuthBloc>().add(
            ResetPasswordRequested(email: emailController.text.trim()),
          );
        }
      },
      backgroundColor: AppColors.brandPrimary,
      child: Text(
        t.forgotPassword.sendLink,
        style: context.medium18.white.rubik,
      ),
    );
  }
}

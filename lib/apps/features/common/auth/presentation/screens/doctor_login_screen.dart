import 'package:doctor_hunt/apps/core/extensions/context_extensions.dart';
import 'package:doctor_hunt/apps/core/router/app_routes.dart';
import 'package:doctor_hunt/apps/core/theme/app_colors.dart';
import 'package:doctor_hunt/apps/core/utils/dialog_utils.dart';
import 'package:doctor_hunt/apps/core/utils/validators.dart';
import 'package:doctor_hunt/apps/core/widgets/app_scaffold.dart';
import 'package:doctor_hunt/apps/core/widgets/main_app_bar.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/models/user/my_user.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/controller/auth/auth_bloc.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/controller/auth/auth_event.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/controller/auth/auth_state.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/widgets/custom_elevated_button.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/widgets/custom_text_password.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/widgets/email_text_field_widget.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class DoctorLoginScreen extends HookWidget {
  const DoctorLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();

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
        if (state is LoginWithEmailPasswordLoadingState) {
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
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 100),
                      Text(
                        t.auth.welcomeBack,
                        style: context.medium24.black.rubik,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        t.auth.doctorSubtitle,
                        style: context.regular14.textSecondary.rubik,
                        textAlign: TextAlign.center,
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
                      _buildLoginButton(
                        context,
                        formKey,
                        emailController,
                        passwordController,
                      ),
                      const SizedBox(height: 8),
                      _buildForgotPassword(context),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildForgotPassword(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      onPressed: () {
        FocusManager.instance.primaryFocus?.unfocus();
        const ForgotPasswordRoute().push(context);
      },
      child: Text(
        t.auth.forgotPassword,
        style: context.regular14.brandPrimary.rubik,
      ),
    );
  }

  Widget _buildLoginButton(
    BuildContext context,
    GlobalKey<FormState> formKey,
    TextEditingController emailController,
    TextEditingController passwordController,
  ) {
    return CustomElevatedButton(
      buttonWidth: context.width - 80,
      onPressed: () {
        if (formKey.currentState!.validate()) {
          context.read<AuthBloc>().add(
            LoginRequested(
              role: UserRoles.doctor,
              email: emailController.text.trim(),
              password: passwordController.text,
            ),
          );
        }
      },
      backgroundColor: AppColors.brandPrimary,
      child: Text(t.auth.login, style: context.medium18.white.rubik),
    );
  }
}

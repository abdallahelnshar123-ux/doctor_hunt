import 'package:doctor_hunt/apps/core/router/app_routes.dart';
import 'package:doctor_hunt/apps/core/widgets/app_scaffold.dart';
import 'package:doctor_hunt/apps/core/widgets/main_app_bar.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/models/user/my_user.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/widgets/auth_password_text_field_widget.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/dialog_utils.dart';
import '../controller/auth_bloc.dart';
import '../controller/auth_event.dart';
import '../controller/auth_state.dart';
import '../widgets/custom_elevated_button.dart';
import '../widgets/email_text_field_widget.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is UserAuthenticatedState) {
          DialogUtils.hideLoading(context: context);
          DialogUtils.showMessage(
            title: 'success',
            context: context,
            message: 'success',
          );

          Future.delayed(Duration(seconds: 2), () {
            if (context.mounted) {
              const AdminMainRoute().go(context);
            }
          });
        }

        if (state is LoginWithEmailPasswordErrorState) {
          debugPrint(state.message);
          DialogUtils.hideLoading(context: context);
          DialogUtils.showMessage(
            posActionText: 'ok',
            title: 'error',
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
            MainAppBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: formKey,
                  child: Column(
                    spacing: 8,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 100),
                      Text(
                        t.auth.welcome_back,
                        style: context.medium24.black.rubik,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        t.auth.admin_subtitle,
                        style: context.regular14.textSecondary.rubik,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 30),
                      EmailTextFieldWidget(
                        controller: emailController,
                        fillColor: AppColors.bgPrimary,
                      ),
                      AuthPasswordTextFieldWidget(
                        controller: passwordController,
                      ),
                      SizedBox(height: 24),
                      _builtLoginButton(),
                      _buildForgetPassword(),
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

  Widget _buildForgetPassword() {
    return TextButton(
      style: TextButton.styleFrom(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      onPressed: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Text(
        t.auth.forgot_password,
        style: context.regular14.brandPrimary.rubik,
      ),
    );
  }

  Widget _builtLoginButton() {
    return CustomElevatedButton(
      buttonWidth: MediaQuery.sizeOf(context).width - 80,
      onPressed: () {
        if (formKey.currentState?.validate() ?? false) {
          context.read<AuthBloc>().add(
            LoginRequested(
              role: UserRoles.admin,
              email: emailController.text,
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

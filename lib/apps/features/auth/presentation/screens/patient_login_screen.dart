import 'package:doctor_hunt/apps/core/router/app_routes.dart';
import 'package:doctor_hunt/apps/core/widgets/app_scaffold.dart';
import 'package:doctor_hunt/apps/features/auth/presentation/controller/auth_event.dart';
import 'package:doctor_hunt/apps/core/widgets/main_app_bar.dart';
import 'package:doctor_hunt/apps/features/auth/presentation/widgets/auth_password_text_field_widget.dart';
import 'package:doctor_hunt/apps/features/auth/presentation/widgets/continue_with_facebook_button.dart';
import 'package:doctor_hunt/apps/features/choose_role/presentation/screens/choose_role_screen.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/dialog_utils.dart';
import '../controller/auth_bloc.dart';
import '../controller/auth_state.dart';
import '../widgets/continue_with_google_button.dart';
import '../widgets/custom_elevated_button.dart';
import '../widgets/email_text_field_widget.dart';

class PatientLoginScreen extends StatefulWidget {
  const PatientLoginScreen({super.key ,});

  @override
  State<PatientLoginScreen> createState() => _PatientLoginScreenState();
}

class _PatientLoginScreenState extends State<PatientLoginScreen> {
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
    final t = Translations.of(context);
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
              state.currentUser!.role == null
                  ? const ChooseRoleRoute().go(context)
                  : const MainRoute().go(context);
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
        if (state is ContinueWithGoogleErrorState) {
          DialogUtils.hideLoading(context: context);
          if (state.message != 'Cancelled by user') {
            DialogUtils.showMessage(
              posActionText: 'ok',
              title: 'error',
              context: context,
              message: state.message,
            );
          }
        }
        if (state is LoginWithEmailPasswordLoadingState ||
            state is ContinueWithGoogleLoadingState) {
          DialogUtils.showLoading(context: context);
        }
      },
      child: AppScaffold(
        resizeToAvoidBottomInset: true,
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
                      SizedBox(height: 127),
                      Text(
                        t.auth.welcome_back,
                        style: context.medium24.black.rubik,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        t.auth.auth_subtitle,
                        style: context.regular14.textSecondary.rubik,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 70),
                      Row(
                        spacing: 15,
                        children: [
                          Expanded(
                            child: ContinueWithGoogleButton(
                              onPressed: () {
                                context.read<AuthBloc>().add(
                                  ContinueWithGoogleRequested(),
                                );
                              },
                            ),
                          ),
                          Expanded(
                            child: ContinueWithFacebookButton(onPressed: () {}),
                          ),
                        ],
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
            Padding(
              padding: EdgeInsets.only(bottom: 25),
              child: _buildDoNotHaveAccount(),
            ),
          ],
        ),
    return AppScaffold(
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
                      t.auth.auth_subtitle,
                      style: context.regular14.textSecondary.rubik,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 70),
                    Row(
                      spacing: 15,
                      children: [
                        Expanded(
                          child: ContinueWithGoogleButton(onPressed: () {}),
                        ),
                        Expanded(
                          child: ContinueWithFacebookButton(onPressed: () {}),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    EmailTextFieldWidget(
                      controller: emailController,
                      fillColor: AppColors.bgPrimary,
                    ),
                    AuthPasswordTextFieldWidget(controller: passwordController),
                    SizedBox(height: 24),
                    _builtLoginButton(),
                    _buildForgetPassword(),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 25),
            child: _buildDoNotHaveAccount(),
          ),
        ],
      ),
    );
  }

  Widget _buildForgetPassword() {
    final t = Translations.of(context);
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

  Widget _buildDoNotHaveAccount() {
    final t = Translations.of(context);
    return TextButton(
      style: TextButton.styleFrom(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      onPressed: () {
        FocusManager.instance.primaryFocus?.unfocus();
        const RegisterRoute().go(context);
      },
      child: Text(
        t.auth.no_account,
        style: context.regular14.brandPrimary.rubik,
      ),
    );
  }

  Widget _builtLoginButton() {
    final t = Translations.of(context);
    return CustomElevatedButton(
      buttonWidth: MediaQuery.sizeOf(context).width - 80,
      onPressed: () {
        if (formKey.currentState?.validate() ?? false) {
          context.read<AuthBloc>().add(
            LoginRequested(
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

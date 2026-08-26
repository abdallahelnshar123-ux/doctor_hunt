import 'package:doctor_hunt/apps/core/router/app_routes.dart';
import 'package:doctor_hunt/apps/features/auth/presentation/widgets/username_text_field_widget.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../widgets/auth_password_text_field_widget.dart';
import '../widgets/continue_with_facebook_button.dart';
import '../widgets/continue_with_google_button.dart';
import '../widgets/custom_elevated_button.dart';
import '../widgets/email_text_field_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
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
                        'Join us to start searching',
                        style: context.medium24.black.rubik,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Text(
                      'You can search course, apply course and find'
                      ' scholarship for abroad studies',
                      style: context.regular14.textSecondary.rubik,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 60),
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
                    SizedBox(height: 25),
                    UsernameTextFieldWidget(
                      controller: nameController,
                      fillColor: AppColors.bgPrimary,
                    ),
                    EmailTextFieldWidget(
                      controller: emailController,
                      fillColor: AppColors.bgPrimary,
                    ),

                    AuthPasswordTextFieldWidget(controller: passwordController),
                    _buildAgreeWithTerms(),
                    SizedBox(height: 24),
                    _buildRegisterButton(),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 25),
            child: _buildHaveAnAccount(),
          ),
        ],
      ),
    );
  }

  Widget _buildHaveAnAccount() {
    return TextButton(
      style: TextButton.styleFrom(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      onPressed: () {
        FocusManager.instance.primaryFocus?.unfocus();
        const LoginRoute().go(context);
      },
      child: Text(
        'Have an account? Log in',
        style: context.regular14.brandPrimary.rubik,
      ),
    );
  }

  Widget _buildAgreeWithTerms() {
    return Row(
      spacing: 10,
      children: [
        CircleAvatar(backgroundColor: AppColors.textSecondary, radius: 7),
        Expanded(
          child: FittedBox(
            fit: .scaleDown,
            child: Text(
              'I agree with the Terms of Service & Privacy Policy',
              style: context.regular12.textSecondary.rubik,
              overflow: .ellipsis,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRegisterButton() {
    return CustomElevatedButton(
      buttonWidth: MediaQuery.sizeOf(context).width - 80,
      onPressed: () {
        if (formKey.currentState!.validate()) {}
      },
      backgroundColor: AppColors.brandPrimary,
      child: Text("Sign up", style: context.medium18.white.rubik),
    );
  }
}

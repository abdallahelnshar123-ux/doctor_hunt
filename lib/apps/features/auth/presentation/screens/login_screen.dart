import 'package:doctor_hunt/apps/core/utils/app_routes.dart';
import 'package:doctor_hunt/apps/core/utils/app_styles.dart';
import 'package:doctor_hunt/apps/core/widgets/app_scaffold.dart';
import 'package:doctor_hunt/apps/features/auth/presentation/widgets/auth_password_text_field_widget.dart';
import 'package:doctor_hunt/apps/features/auth/presentation/widgets/continue_with_facebook_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/app_colors.dart';
import '../widgets/continue_with_google_button.dart';
import '../widgets/custom_elevated_button.dart';
import '../widgets/email_text_field_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
    return AppScaffold(
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Form(
                key: formKey,
                child: Column(
                  spacing: 8.h,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 127.h),
                    Text(
                      'Welcome back',
                      style: AppStyles.rubikMedium24(AppColors.black),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'You can search course, apply course and find scholarship '
                      'for abroad studies',
                      style: AppStyles.rubikRegular14(AppColors.textSecondary),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 70.h),
                    Row(
                      spacing: 15.w,
                      children: [
                        Expanded(
                          child: ContinueWithGoogleButton(onPressed: () {}),
                        ),
                        Expanded(
                          child: ContinueWithFacebookButton(onPressed: () {}),
                        ),
                      ],
                    ),
                    SizedBox(height: 30.h),
                    EmailTextFieldWidget(
                      controller: emailController,
                      fillColor: AppColors.bgPrimary,
                    ),
                    AuthPasswordTextFieldWidget(controller: passwordController),
                    SizedBox(height: 24.h),
                    _builtLoginButton(),
                    _buildForgetPassword(),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 25.h),
            child: _buildDoNotHaveAccount(),
          ),
        ],
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
        "Forgot password",
        style: AppStyles.rubikRegular14(AppColors.brandPrimary),
      ),
    );
  }

  Widget _buildDoNotHaveAccount() {
    return TextButton(
      style: TextButton.styleFrom(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      onPressed: () {
        FocusManager.instance.primaryFocus?.unfocus();
        context.goNamed(AppRoutes.registerRouteName);
      },
      child: Text(
        "Don’t have an account? Join us",
        style: AppStyles.rubikRegular14(AppColors.brandPrimary),
      ),
    );
  }

  Widget _builtLoginButton() {
    return CustomElevatedButton(
      buttonWidth: 1.sw-80.w,
      onPressed: () {
        if (formKey.currentState!.validate()) {}
      },
      backgroundColor: AppColors.brandPrimary,
      child: Text("Login", style: AppStyles.rubikMedium18(AppColors.white)),
    );
  }
}

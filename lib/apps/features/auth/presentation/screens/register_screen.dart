import 'package:doctor_hunt/apps/core/utils/app_routes.dart';
import 'package:doctor_hunt/apps/features/auth/presentation/widgets/username_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
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
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Form(
                key: formKey,
                child: Column(
                  spacing: 8.h,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 150.h),
                    FittedBox(
                      fit: .scaleDown,
                      child: Text(
                        'Join us to start searching',
                        style: AppStyles.rubikMedium24(AppColors.black),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Text(
                      'You can search course, apply course and find'
                      ' scholarship for abroad studies',
                      style: AppStyles.rubikRegular14(AppColors.textSecondary),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 60.h),
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
                    SizedBox(height: 25.h),
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
                    SizedBox(height: 24.h),
                    _buildRegisterButton(),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 25.h),
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
        context.goNamed(AppRoutes.loginRouteName);
      },
      child: Text(
        'Have an account? Log in',
        style: AppStyles.rubikRegular14(AppColors.brandPrimary),
      ),
    );
  }

  Widget _buildAgreeWithTerms() {
    return Row(
      spacing: 10,
      children: [
        CircleAvatar(backgroundColor: AppColors.textSecondary, radius: 7.r),
        Expanded(
          child: FittedBox(
            fit: .scaleDown,
            child: Text(
              'I agree with the Terms of Service & Privacy Policy',
              style: AppStyles.rubikRegular12(AppColors.textSecondary),
              overflow: .ellipsis,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRegisterButton() {
    return CustomElevatedButton(
      buttonWidth: 1.sw - 80.w,
      onPressed: () {
        if (formKey.currentState!.validate()) {}
      },
      backgroundColor: AppColors.brandPrimary,
      child: Text("Sign up", style: AppStyles.rubikMedium18(AppColors.white)),
    );
  }
}

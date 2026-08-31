import 'package:doctor_hunt/apps/core/router/app_routes.dart';
import 'package:doctor_hunt/apps/features/auth/presentation/controller/user_event.dart';
import 'package:doctor_hunt/apps/features/auth/presentation/widgets/username_text_field_widget.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/dialog_utils.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../controller/user_bloc.dart';
import '../controller/user_state.dart';
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
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return BlocListener<UserBloc, UserState>(
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
              const MainRoute().go(context);
            }
          });
        }

        if (state is RegisterWithEmailPasswordErrorState) {
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
          DialogUtils.showMessage(
            posActionText: 'ok',
            title: 'error',
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
                      Row(
                        spacing: 15,
                        children: [
                          Expanded(
                            child: ContinueWithGoogleButton(
                              onPressed: () {
                                context.read<UserBloc>().add(
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
                      SizedBox(height: 25),
                      UsernameTextFieldWidget(
                        controller: nameController,
                        fillColor: AppColors.bgPrimary,
                      ),
                      EmailTextFieldWidget(
                        controller: emailController,
                        fillColor: AppColors.bgPrimary,
                      ),

                      AuthPasswordTextFieldWidget(
                        controller: passwordController,
                      ),
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
      ),
    );

    // return AppScaffold(
    //   body: Column(
    //     children: [
    //       Expanded(
    //         child: SingleChildScrollView(
    //           padding: EdgeInsets.symmetric(horizontal: 20),
    //           child: Form(
    //             key: formKey,
    //             child: Column(
    //               spacing: 8,
    //               crossAxisAlignment: CrossAxisAlignment.center,
    //               children: [
    //                 SizedBox(height: 150),
    //                 FittedBox(
    //                   fit: .scaleDown,
    //                   child: Text(
    //                     t.auth.join_us,
    //                     style: context.medium24.black.rubik,
    //                     textAlign: TextAlign.center,
    //                   ),
    //                 ),
    //                 Text(
    //                   t.auth.auth_subtitle,
    //                   style: context.regular14.textSecondary.rubik,
    //                   textAlign: TextAlign.center,
    //                 ),
    //                 SizedBox(height: 60),
    //                 Row(
    //                   spacing: 15,
    //                   children: [
    //                     Expanded(
    //                       child: ContinueWithGoogleButton(onPressed: () {}),
    //                     ),
    //                     Expanded(
    //                       child: ContinueWithFacebookButton(onPressed: () {}),
    //                     ),
    //                   ],
    //                 ),
    //                 SizedBox(height: 25),
    //                 UsernameTextFieldWidget(
    //                   controller: nameController,
    //                   fillColor: AppColors.bgPrimary,
    //                 ),
    //                 EmailTextFieldWidget(
    //                   controller: emailController,
    //                   fillColor: AppColors.bgPrimary,
    //                 ),
    //
    //                 AuthPasswordTextFieldWidget(controller: passwordController),
    //                 _buildAgreeWithTerms(),
    //                 SizedBox(height: 24),
    //                 _buildRegisterButton(),
    //               ],
    //             ),
    //           ),
    //         ),
    //       ),
    //       Padding(
    //         padding: EdgeInsets.only(bottom: 25),
    //         child: _buildHaveAnAccount(),
    //       ),
    //     ],
    //   ),
    // );
  }

  Widget _buildHaveAnAccount() {
    final t = Translations.of(context);
    return TextButton(
      style: TextButton.styleFrom(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      onPressed: () {
        FocusManager.instance.primaryFocus?.unfocus();
        const LoginRoute().go(context);
      },
      child: Text(
        t.auth.have_account,
        style: context.regular14.brandPrimary.rubik,
      ),
    );
  }

  Widget _buildAgreeWithTerms() {
    final t = Translations.of(context);
    return Row(
      spacing: 10,
      children: [
        Icon(Icons.circle, color: AppColors.textSecondary, size: 15),
        Expanded(
          child: FittedBox(
            fit: .scaleDown,
            child: Text(
              t.auth.agree_terms,
              style: context.regular12.textSecondary.rubik,
              overflow: .ellipsis,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRegisterButton() {
    final t = Translations.of(context);
    return CustomElevatedButton(
      buttonWidth: MediaQuery.sizeOf(context).width - 80,
      onPressed: () {
        if (formKey.currentState!.validate()) {
          context.read<UserBloc>().add(
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

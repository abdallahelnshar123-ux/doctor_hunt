import 'package:doctor_hunt/apps/core/router/app_routes.dart';
import 'package:doctor_hunt/apps/core/theme/app_colors.dart';
import 'package:doctor_hunt/apps/core/widgets/app_scaffold.dart';
import 'package:doctor_hunt/apps/features/auth/presentation/widgets/custom_elevated_button.dart';
import 'package:doctor_hunt/apps/features/choose_role/presentation/widget/role_widget.dart';
import 'package:doctor_hunt/generated/app_assets.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChooseRoleScreen extends StatefulWidget {
  const ChooseRoleScreen({super.key});

  @override
  State<ChooseRoleScreen> createState() => _ChooseRoleScreenState();
}

class _ChooseRoleScreenState extends State<ChooseRoleScreen> {
  final ValueNotifier<AppRoles?> selectedRole = ValueNotifier<AppRoles?>(null);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: AppScaffold(
        body: Padding(
          padding: EdgeInsets.fromLTRB(20, 50.h, 20, 32.h),
          child: Column(
            crossAxisAlignment: .center,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    spacing: 16.h,
                    crossAxisAlignment: .center,
                    children: [
                      SvgPicture.asset(
                        AppAssets.icons.appLogo.path,
                        width: 70.w,
                      ),
                      Text(
                        'Doctor Hunt',
                        style: context.bold24.textPrimary.rubik,
                        textAlign: .center,
                      ),
                      SizedBox(height: 25.h),
                      Text(
                        'Choose your role',
                        style: context.extraLight28.textDark.plusJakartaSans,
                        textAlign: .center,
                      ),
                      Text(
                        'The selected role determines the experience and '
                        'available features.',
                        style: context.regular14.textCaption.plusJakartaSans,
                        textAlign: .center,
                      ),
                      SizedBox(height: 16.h),
                      ValueListenableBuilder(
                        valueListenable: selectedRole,
                        builder: (BuildContext context, value, Widget? child) {
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (selectedRole.value == AppRoles.admin) {
                                    return;
                                  }
                                  selectedRole.value = AppRoles.admin;
                                },

                                child: RoleWidget.admin(
                                  roleIcon: AppAssets.icons.adminIcon.path,
                                  selected:
                                      selectedRole.value == AppRoles.admin,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (selectedRole.value == AppRoles.patient) {
                                    return;
                                  }
                                  selectedRole.value = AppRoles.patient;
                                },
                                child: RoleWidget.patient(
                                  roleIcon: AppAssets.icons.patientIcon.path,
                                  selected:
                                      selectedRole.value == AppRoles.patient,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              CustomElevatedButton(
                buttonWidth: double.infinity,
                backgroundColor: AppColors.brandPrimary,
                onPressed: () {
                  const HomeRoute().go(context);
                },
                child: Text(
                  'Continue',
                  style: context.medium18.bgPrimary.rubik,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum AppRoles { admin, patient }

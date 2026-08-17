import 'package:doctor_hunt/apps/core/utils/app_assets.dart';
import 'package:doctor_hunt/apps/core/utils/app_colors.dart';
import 'package:doctor_hunt/apps/core/utils/app_styles.dart';
import 'package:doctor_hunt/apps/core/widgets/app_scaffold.dart';
import 'package:doctor_hunt/apps/features/auth/presentation/widgets/custom_elevated_button.dart';
import 'package:doctor_hunt/apps/features/choose_role/presentation/widget/role_widget.dart';
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
                      SvgPicture.asset(AppAssets.appLogo, width: 70.w),
                      Text(
                        'Doctor Hunt',
                        style: AppStyles.rubikBold25(AppColors.textPrimary),
                        textAlign: .center,
                      ),
                      SizedBox(height: 25.h),
                      Text(
                        'Choose your role',
                        style: AppStyles.jakartaELight28(AppColors.textDark),
                        textAlign: .center,
                      ),
                      Text(
                        'The selected role determines the experience and '
                        'available features.',
                        style: AppStyles.jakartaRegular14(
                          AppColors.textCaption,
                        ),
                        textAlign: .center,
                      ),SizedBox(height: 16.h,),
                      ValueListenableBuilder(
                        valueListenable: selectedRole,
                        builder: (BuildContext context, value, Widget? child) {
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (selectedRole.value == AppRoles.admin)
                                    return;
                                  selectedRole.value = AppRoles.admin;
                                },

                                child: RoleWidget.admin(
                                  selected:
                                      selectedRole.value == AppRoles.admin,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (selectedRole.value == AppRoles.patient)
                                    return;
                                  selectedRole.value = AppRoles.patient;
                                },
                                child: RoleWidget.patient(
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
                onPressed: () {},
                child: Text(
                  'Continue',
                  style: AppStyles.rubikMedium18(AppColors.bgPrimary),
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

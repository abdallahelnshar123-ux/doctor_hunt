import 'package:doctor_hunt/apps/core/utils/app_assets.dart';
import 'package:doctor_hunt/apps/core/utils/app_colors.dart';
import 'package:doctor_hunt/apps/core/utils/app_styles.dart';
import 'package:doctor_hunt/apps/features/choose_role/presentation/screens/choose_role_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RoleWidget extends StatelessWidget {
  const RoleWidget({
    super.key,
    required this.role,
    required this.roleDescription,
    required this.roleIcon,
    required this.roleTitle,
    required this.selected,
  });

  const RoleWidget.admin({
    super.key,
    this.role = AppRoles.admin,
    this.roleDescription =
        'Manage doctors, appointments, users, and the platform.',
    this.roleIcon = AppAssets.adminIcon,
    this.roleTitle = 'Admin',
    required this.selected,
  });

  const RoleWidget.patient({
    super.key,
    this.role = AppRoles.patient,
    this.roleDescription =
        'Find doctors, book appointments, and manage your medical records.',
    this.roleIcon = AppAssets.patientIcon,
    this.roleTitle = 'Patient',
    required this.selected,
  });

  final AppRoles role;
  final String roleTitle;
  final String roleDescription;
  final String roleIcon;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.w),
      padding: EdgeInsets.all(16.w),
      width: .infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.w),
        border: BoxBorder.all(
          color: selected ? AppColors.brandPrimaryDark : AppColors.borderMuted,
          width: selected ? 2 : 1,
        ),
      ),
      child: Row(
        spacing: 20.w,
        crossAxisAlignment: .start,
        children: [
          SvgPicture.asset(
            roleIcon,
            colorFilter: ColorFilter.mode(
              selected ? AppColors.brandPrimaryDark : AppColors.textCaption,
              .srcIn,
            ),

          ),
          Expanded(
            child: Text.rich(
              textAlign: .start,
              TextSpan(
                text: '$roleTitle\n',
                style: AppStyles.jakartaSBold20(AppColors.textDark),
                children: [TextSpan(text: roleDescription , style: AppStyles.jakartaRegular14(AppColors.textCaption))],
              ),
            ),
          ),
          Icon(Icons.check_circle, color:selected ?  AppColors.brandPrimaryDark : AppColors.transparent),
        ],
      ),
    );
  }
}

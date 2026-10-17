import 'package:doctor_hunt/apps/core/theme/app_colors.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../auth/data/models/user/my_user.dart';

class RoleWidget extends StatelessWidget {
  const RoleWidget({
    super.key,
    required this.role,
    required this.roleDescription,
    required this.roleIcon,
    required this.roleTitle,
  });

  const RoleWidget.admin({
    super.key,
    this.role = UserRoles.admin,
    required this.roleDescription,
    required this.roleIcon,
    required this.roleTitle,
  });

  const RoleWidget.patient({
    super.key,
    this.role = UserRoles.patient,
    required this.roleDescription,
    required this.roleIcon,
    required this.roleTitle,
  });

  final UserRoles role;
  final String roleTitle;
  final String roleDescription;
  final String roleIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      width: .infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: BoxBorder.all(color: AppColors.borderMuted),
      ),
      child: Row(
        spacing: 20,
        crossAxisAlignment: .center,
        children: [
          SvgPicture.asset(
            roleIcon,
            colorFilter: ColorFilter.mode(AppColors.textCaption, .srcIn),
          ),
          Expanded(
            child: Text.rich(
              textAlign: .start,
              TextSpan(
                text: '$roleTitle\n',
                style: context.semiBold20.textDark.plusJakartaSans,
                children: [
                  TextSpan(
                    text: roleDescription,
                    style: context.regular14.textCaption.plusJakartaSans,
                  ),
                ],
              ),
            ),
          ),
          Icon(Icons.arrow_forward_ios_rounded, color: AppColors.textMuted),
        ],
      ),
    );
  }
}

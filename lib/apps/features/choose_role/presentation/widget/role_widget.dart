import 'package:doctor_hunt/apps/core/theme/app_colors.dart';
import 'package:doctor_hunt/apps/features/choose_role/presentation/screens/choose_role_screen.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:flutter/material.dart';
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
    required this.roleDescription,
    required this.roleIcon,
    required this.roleTitle,
    required this.selected,
  });

  const RoleWidget.patient({
    super.key,
    this.role = AppRoles.patient,
    required this.roleDescription,
    required this.roleIcon,
    required this.roleTitle,
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
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      width: .infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: BoxBorder.all(
          color: selected ? AppColors.brandPrimaryDark : AppColors.borderMuted,
          width: selected ? 2 : 1,
        ),
      ),
      child: Row(
        spacing: 20,
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
          Icon(
            Icons.check_circle,
            color: selected
                ? AppColors.brandPrimaryDark
                : AppColors.transparent,
          ),
        ],
      ),
    );
  }
}

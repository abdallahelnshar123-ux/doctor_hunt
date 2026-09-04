import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_container_with_shadow.dart';

class StatuesWidget extends StatelessWidget {
  const StatuesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppContainerWithShadow(
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: buildListTile(
                title: 'Total doctors',
                number: '15',
                context: context,
              ),
            ),
            VerticalDivider(
              indent: 10,
              endIndent: 10,
              thickness: 1,
              color: AppColors.textSecondary,
            ),
            Expanded(
              child: buildListTile(
                title: 'Active',
                number: '15',
                context: context,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildListTile({
    required String title,
    required String number,
    required BuildContext context,
  }) {
    return ListTile(
      titleTextStyle: context.semiBold12.textSecondary.rubik,
      subtitleTextStyle: context.semiBold18.brandPrimaryDark.rubik,
      leading: CircleAvatar(
        backgroundColor: AppColors.brandPrimary20,
        child: Icon(Icons.person_2_outlined, color: AppColors.brandPrimaryDark),
      ),
      title: FittedBox(
        alignment: .centerLeft,
        fit: .scaleDown,
        child: Text(title, textAlign: .start),
      ),
      subtitle: Text(number),
    );
  }
}

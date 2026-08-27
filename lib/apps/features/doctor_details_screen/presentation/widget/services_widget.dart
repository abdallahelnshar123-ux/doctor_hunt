import 'package:doctor_hunt/apps/core/theme/app_colors.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter/material.dart';

class ServicesWidget extends StatelessWidget {
  const ServicesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final servicesList = t.doctor_details.services_list;
    return Column(
      crossAxisAlignment: .start,
      children: [
        Text(
          t.doctor_details.services,
          style: context.medium18.textTertiary.rubik,
        ),
        ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) => Text.rich(
            TextSpan(
              text: '${index + 1}.  ',
              style: context.medium12.brandPrimary.rubik,
              children: [
                TextSpan(
                  text: servicesList[index],
                  style: context.medium12.textSecondary.rubik,
                ),
              ],
            ),
          ),
          itemCount: servicesList.length,
          separatorBuilder: (BuildContext context, int index) => Divider(
            color: AppColors.borderSubtle,
            thickness: 0.8,
            height: 30,
          ),
        ),
      ],
    );
  }
}

// Removed static servicesList as it's now in translations

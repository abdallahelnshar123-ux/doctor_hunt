import 'package:doctor_hunt/apps/core/utils/app_colors.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:flutter/material.dart';

class ServicesWidget extends StatelessWidget {
  const ServicesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Text('Services', style: context.medium18.textTertiary.rubik),
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

const List<String> servicesList = [
  'Patient care should be the number one priority.',
  'If you run your practice you know how frustrating.',
  'That’s why some of appointment reminder system.',
];

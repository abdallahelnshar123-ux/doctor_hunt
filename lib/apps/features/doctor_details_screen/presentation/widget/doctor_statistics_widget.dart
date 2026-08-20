import 'package:doctor_hunt/apps/core/utils/app_colors.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorStatisticsWidget extends StatelessWidget {
  const DoctorStatisticsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.bgPrimary,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withAlpha(20),
            blurRadius: 25,
            spreadRadius: 0.5,
            offset: const Offset(0, 0),
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        spacing: 10,
        mainAxisAlignment: .center,
        children: [
          _statisticsWidget(context: context, title: 'Running', number: '100'),
          _statisticsWidget(context: context, title: 'Ongoing', number: '500'),
          _statisticsWidget(context: context, title: 'Patient', number: '700'),
        ],
      ),
    );
  }
}

Widget _statisticsWidget({
  required BuildContext context,
  required String title,
  required String number,
}) {
  return Expanded(
    child: Container(
      padding: EdgeInsets.all(10),
      height: 84.h,
      decoration: BoxDecoration(
        color: AppColors.grayMid,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: .start,
        spacing: 1,
        crossAxisAlignment: .center,
        children: [
          FittedBox(
            fit: .scaleDown,
            child: Text(number, style: context.medium18.textTertiary.rubik),
          ),
          FittedBox(
            fit: .scaleDown,
            child: Text(title, style: context.light12.textSecondary.rubik),
          ),
        ],
      ),
    ),
  );
}

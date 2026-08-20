import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'live_doctors_item.dart';

class LiveDoctorsWidget extends StatelessWidget {
  const LiveDoctorsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 20,
      mainAxisSize: .min,
      mainAxisAlignment: .start,
      crossAxisAlignment: .start,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 20),
          child: Text(
            'Live Doctors',
            style: context.medium18.textTertiary.rubik,
          ),
        ),
        SizedBox(
          height: 165.w,
          width: double.infinity,
          child: ListView.separated(
            // physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => const LiveDoctorsItem(),
            separatorBuilder: (context, index) => const SizedBox(width: 15),
            itemCount: 10,
            scrollDirection: .horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
          ),
        ),
      ],
    );
  }
}

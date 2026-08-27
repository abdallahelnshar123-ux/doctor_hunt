import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter/material.dart';

import 'live_doctors_item.dart';

class LiveDoctorsWidget extends StatelessWidget {
  const LiveDoctorsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return Column(
      mainAxisSize: .min,
      mainAxisAlignment: .start,
      crossAxisAlignment: .start,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 20),
          child: Text(
            t.home.live_doctors,
            style: context.medium18.textTertiary.rubik,
          ),
        ),
        SizedBox(
          height: 200,
          width: double.infinity,
          child: ListView.separated(
            itemBuilder: (context, index) => const LiveDoctorsItem(),
            separatorBuilder: (context, index) => const SizedBox(width: 15),
            itemCount: 10,
            scrollDirection: .horizontal,
            padding: const EdgeInsets.all(20),
          ),
        ),
      ],
    );
  }
}

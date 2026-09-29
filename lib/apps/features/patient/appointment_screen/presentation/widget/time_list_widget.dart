import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../../core/theme/app_colors.dart';

class TimeListWidget extends HookWidget {
  final List<String> list;

  const TimeListWidget({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    final selectedIndex = useState<int?>(null);

    return SizedBox(
      height: 100,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: .horizontal,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            selectedIndex.value = index;
          },
          child: Container(
            height: double.infinity,
            alignment: .center,
            padding: EdgeInsetsGeometry.all(20),
            decoration: BoxDecoration(
              shape: .circle,
              color: selectedIndex.value == index
                  ? AppColors.brandPrimary
                  : AppColors.brandPrimary8,
            ),
            child: Text(
              list[index],
              textAlign: .center,
              style: selectedIndex.value == index
                  ? context.medium14.white.rubik
                  : context.regular12.brandPrimary.rubik,
            ),
          ),
        ),

        separatorBuilder: (context, index) => SizedBox(width: 8),
        itemCount: list.length,
      ),
    );
  }
}

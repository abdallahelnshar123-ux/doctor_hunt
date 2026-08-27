import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class TimeListWidget extends StatefulWidget {
  final List<String> list;

  const TimeListWidget({super.key, required this.list});

  @override
  State<TimeListWidget> createState() => _TimeListWidgetState();
}

class _TimeListWidgetState extends State<TimeListWidget> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: .horizontal,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () => setState(() {
            selectedIndex = index;
          }),
          child: Container(
            height: double.infinity,
            alignment: .center,
            padding: EdgeInsetsGeometry.all(20),
            decoration: BoxDecoration(
              shape: .circle,
              color: selectedIndex == index
                  ? AppColors.brandPrimary
                  : AppColors.brandPrimary8,
            ),
            child: Text(
              widget.list[index],
              textAlign: .center,
              style: selectedIndex == index
                  ? context.medium14.white.rubik
                  : context.regular12.brandPrimary.rubik,
            ),
          ),
        ),

        separatorBuilder: (context, index) => SizedBox(width: 8),
        itemCount: widget.list.length,
      ),
    );
  }
}

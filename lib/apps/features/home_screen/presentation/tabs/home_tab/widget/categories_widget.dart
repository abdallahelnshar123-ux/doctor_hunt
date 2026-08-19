import 'package:doctor_hunt/apps/core/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 90.h,
      child: ListView.separated(
        itemBuilder: (context, index) => Image.asset(categoriesList[index ]),
        separatorBuilder: (context, index) => const SizedBox(width: 15),
        itemCount: categoriesList.length,
        scrollDirection: .horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
      ),
    );
  }
}

const List<String> categoriesList = [
  AppAssets.categoryIcon1,
  AppAssets.categoryIcon2,
  AppAssets.categoryIcon3,
  AppAssets.categoryIcon4,
];

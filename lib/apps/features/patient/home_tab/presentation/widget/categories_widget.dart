import 'package:doctor_hunt/generated/app_assets.dart';
import 'package:flutter/material.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 90,
      child: ListView.separated(
        itemBuilder: (context, index) => Image.asset(categoriesList[index]),
        separatorBuilder: (context, index) => const SizedBox(width: 15),
        itemCount: categoriesList.length,
        scrollDirection: .horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
      ),
    );
  }
}

List<String> categoriesList = [
  AppAssets.images.categoryImage1.path,
  AppAssets.images.categoryImage2.path,
  AppAssets.images.categoryImage3.path,
  AppAssets.images.categoryImage4.path,
];

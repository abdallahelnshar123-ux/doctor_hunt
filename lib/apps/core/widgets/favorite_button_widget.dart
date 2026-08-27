import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class FavoriteButtonWidget extends StatelessWidget {
  const FavoriteButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Icon(Icons.favorite, color: AppColors.badge, size: 20),
    );
  }
}

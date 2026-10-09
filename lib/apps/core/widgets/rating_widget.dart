import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../generated/app_assets.dart';

class RatingWidget extends StatelessWidget {
  const RatingWidget({
    super.key,
    required this.rating,
    this.starSize,
    this.gap,
  });

  final double rating;
  final double? starSize;
  final double? gap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: gap ?? 4,
      mainAxisAlignment: .start,
      children: [
        ...List.generate(
          5,
          (index) => SvgPicture.asset(
            index >= rating.toInt()
                ? AppAssets.icons.starIconUnrated.path
                : AppAssets.icons.starIconRated.path,
            width: starSize ?? 12,
          ),
        ),
        SizedBox(width: 5),
        Text(rating.toString(), style: context.regular10.textSecondary.rubik),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../generated/app_assets.dart';
import '../../../generated/style_atoms.dart';
import '../extensions/context_extensions.dart';

class MainEmptyListWidget extends StatelessWidget {
  const MainEmptyListWidget({super.key, this.title});

  final String? title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: context.width - 100,
          height: context.width - 100,
          child: Lottie.asset(
            AppAssets.lottie.emptyState.path,
            frameRate: .max,
          ),
        ),
        Text(title ?? '', style: context.regular16.textSecondary.rubik),
      ],
    );
  }
}

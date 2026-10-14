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
    return Center(
      child: Column(
        children: [
          Lottie.asset(
            AppAssets.lottie.emptyState.path,
            width: context.width - 100,
          ),
          Text(title ??'', style: context.regular14.textSecondary.rubik),
        ],
      ),
    );
  }
}

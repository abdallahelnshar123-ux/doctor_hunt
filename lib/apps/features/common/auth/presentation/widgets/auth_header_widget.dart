import 'package:flutter/material.dart';

import '../../../../../../generated/style_atoms.dart';

class AuthHeaderWidget extends StatelessWidget {
  const AuthHeaderWidget({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            title,
            style: context.medium24.black.rubik,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: context.regular14.textSecondary.rubik,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

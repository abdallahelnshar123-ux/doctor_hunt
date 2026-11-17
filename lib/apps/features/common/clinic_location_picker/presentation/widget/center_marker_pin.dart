import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';

class CenterMarkerPin extends StatelessWidget {
  const CenterMarkerPin({super.key});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.location_on_rounded,
              size: 46,
              color: AppColors.brandPrimary,
            ),
            Container(
              width: 8,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.black.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            // Balance bottom spacing so the pin tip rests at the absolute screen center
            const SizedBox(height: 23),
          ],
        ),
      ),
    );
  }
}

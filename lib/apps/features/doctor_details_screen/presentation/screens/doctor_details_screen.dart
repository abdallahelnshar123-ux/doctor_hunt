import 'package:doctor_hunt/apps/core/utils/app_assets.dart';
import 'package:doctor_hunt/apps/core/widgets/app_scaffold.dart';
import 'package:doctor_hunt/apps/core/widgets/main_app_bar.dart';
import 'package:doctor_hunt/apps/features/doctor_details_screen/presentation/widget/doctor_details_card.dart';
import 'package:doctor_hunt/apps/features/doctor_details_screen/presentation/widget/doctor_statistics_widget.dart';
import 'package:doctor_hunt/apps/features/doctor_details_screen/presentation/widget/services_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';

class DoctorDetailsScreen extends StatelessWidget {
  const DoctorDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: AppScaffold(
        body: Column(
          children: [
            MainAppBar(title: 'Doctor Details'),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Column(
                  spacing: 24.h,
                  children: [
                    DoctorDetailsCard(),
                    DoctorStatisticsWidget(),
                    ServicesWidget(),
                    Container(
                      padding: EdgeInsetsDirectional.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.bgPrimary,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.black.withAlpha(20),
                            blurRadius: 25,
                            spreadRadius: 0.5,
                            offset: const Offset(0, 0),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Image.asset(
                        AppAssets.testImageMap,
                        width: double.infinity,
                        fit: .cover,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

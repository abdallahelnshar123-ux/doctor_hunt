import 'package:doctor_hunt/apps/core/utils/app_assets.dart';
import 'package:doctor_hunt/apps/core/utils/app_colors.dart';
import 'package:doctor_hunt/apps/core/widgets/app_scaffold.dart';
import 'package:doctor_hunt/apps/core/widgets/search_text_field_widget.dart';
import 'package:doctor_hunt/apps/features/home_screen/presentation/widget/live_doctors_widget.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: AppScaffold(
        appBar: _customAppBar(context: context),
        body: Column(
          spacing: 20,
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 60.h,
                  decoration: BoxDecoration(
                    color: AppColors.brandPrimary,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20.r),
                      bottomRight: Radius.circular(20.r),
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: SearchTextFieldWidget(),
                ),
              ],
            ),
            Expanded(child: Column(children: [const LiveDoctorsWidget()])),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _customAppBar({required BuildContext context}) {
    return AppBar(
      toolbarHeight: 90.h,
      backgroundColor: AppColors.brandPrimary,
      title: Text.rich(
        TextSpan(
          text: 'Hi Handwerker!\n',
          style: context.light20.bgPrimary.rubik,
          children: [
            TextSpan(
              text: 'Find Your Doctor',
              style: context.bold24.bgPrimary.rubik,
            ),
          ],
        ),
      ),
      actionsPadding: EdgeInsets.only(right: 20),
      actions: [
        CircleAvatar(
          foregroundImage: AssetImage(AppAssets.userAvatar),
          radius: 30.r,
        ),
      ],
    );
  }
}

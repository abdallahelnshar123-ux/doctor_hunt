import 'package:doctor_hunt/apps/core/theme/app_colors.dart';
import 'package:doctor_hunt/apps/core/widgets/app_container_with_shadow.dart';
import 'package:doctor_hunt/apps/core/widgets/app_scaffold.dart';
import 'package:doctor_hunt/apps/core/widgets/search_text_field_widget.dart';
import 'package:doctor_hunt/apps/features/admin_doctors_tab/presentation/widget/statues_widget.dart';
import 'package:doctor_hunt/generated/app_assets.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';

class AdminDoctorsTab extends StatelessWidget {
  const AdminDoctorsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.brandPrimary,
        isExtended: true,

        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(12)
        // ),
        onPressed: () {},
        child: Icon(Icons.add, color: AppColors.white),
      ),
      body: Column(
        spacing: 15,
        children: [
          AppBar(title: Text('Doctors'), centerTitle: true),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SearchTextFieldWidget(hintText: 'Search doctors'),
          ),
          StatuesWidget(),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.all(20),
              itemBuilder: (context, index) => AppContainerWithShadow(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.white,
                ),
                child: Row(
                  spacing: 15,
                  children: [
                    Container(
                      width: context.width * 0.18,
                      height: context.width * 0.18,
                      decoration: BoxDecoration(
                        shape: .circle,
                        image: DecorationImage(
                          fit: .cover,
                          image: AssetImage(
                            AppAssets.images.testDoctorImage.path,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: .start,
                        children: [
                          Text(
                            'Dr.abdallah',
                            style: context.medium16.textTertiary.rubik,
                          ),
                          Text(
                            'Specialty',
                            style: context.medium12.textSecondary.rubik,
                          ),
                          Chip(
                            padding: EdgeInsets.all(5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            side: BorderSide(
                              width: 0,
                              color: AppColors.transparent,
                            ),
                            backgroundColor: AppColors.brandPrimary20,
                            label: Text(
                              'Active',
                              style: context.medium10.brandPrimaryDark.rubik,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.more_vert_rounded),
                    ),
                  ],
                ),

                // ListTile(
                //   contentPadding: EdgeInsets.symmetric(
                //     horizontal: 15,
                //     vertical: 10,
                //   ),
                //   horizontalTitleGap: 10,
                //   leading:
                //       // Image.asset(AppAssets.images.testDoctorImage.path,width: double.infinity,),
                //       Container(
                //         width: context.width * 0.2,
                //         height: context.width * 0.2,
                //         decoration: BoxDecoration(
                //           color: Colors.cyan,
                //           shape: .circle,
                //           image: DecorationImage(
                //             fit: .cover,
                //             image: AssetImage(
                //               AppAssets.images.testDoctorImage.path,
                //             ),
                //           ),
                //         ),
                //       ),
                //   title: Column(
                //     crossAxisAlignment: .start,
                //     children: [
                //       Text(
                //         'Dr.abdallah',
                //         style: context.medium16.textTertiary.rubik,
                //       ),
                //       Text(
                //         'Specialty',
                //         style: context.medium12.textSecondary.rubik,
                //       ),
                //     ],
                //   ),
                //   subtitle: Align(
                //     alignment: .centerLeft,
                //     child: Chip(
                //       padding: EdgeInsets.all(5),
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(30),
                //       ),
                //       side: BorderSide(width: 0, color: AppColors.transparent),
                //       backgroundColor: AppColors.brandPrimary20,
                //       label: Text(
                //         'Active',
                //         style: context.medium10.brandPrimaryDark.rubik,
                //       ),
                //     ),
                //   ),
                //   trailing: Icon(Icons.more_vert_rounded),
                // ),
              ),
              separatorBuilder: (context, index) => SizedBox(height: 10),
              itemCount: 15,
            ),
          ),
        ],
      ),
    );
  }
}

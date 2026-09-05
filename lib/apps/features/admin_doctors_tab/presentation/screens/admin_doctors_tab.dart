import 'package:doctor_hunt/apps/core/router/app_routes.dart';
import 'package:doctor_hunt/apps/core/theme/app_colors.dart';
import 'package:doctor_hunt/apps/core/widgets/app_container_with_shadow.dart';
import 'package:doctor_hunt/apps/core/widgets/app_scaffold.dart';
import 'package:doctor_hunt/apps/core/widgets/search_text_field_widget.dart';
import 'package:doctor_hunt/generated/app_assets.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';

part '../widget/doctor_card.dart';
part '../widget/statues_widget.dart';

class AdminDoctorsTab extends StatelessWidget {
  const AdminDoctorsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.brandPrimary,

        onPressed: () {
          const AddDoctorRoute().push(context);
        },
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
              itemBuilder: (context, index) => DoctorCard(),
              separatorBuilder: (context, index) => SizedBox(height: 10),
              itemCount: 15,
            ),
          ),
        ],
      ),
    );
  }
}

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

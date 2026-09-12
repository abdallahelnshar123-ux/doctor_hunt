import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_hunt/apps/core/extensions/context_extensions.dart';
import 'package:doctor_hunt/apps/core/theme/app_colors.dart';
import 'package:doctor_hunt/apps/core/utils/snack_bar_utils.dart';
import 'package:doctor_hunt/apps/core/widgets/app_container_with_shadow.dart';
import 'package:doctor_hunt/apps/core/widgets/search_text_field_widget.dart';
import 'package:doctor_hunt/apps/features/admin/add_doctor_screen/presentation/controller/doctor_bloc.dart';
import 'package:doctor_hunt/generated/app_assets.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/router/app_routes.dart';
import '../../../add_doctor_screen/data/models/doctor/doctor.dart';
import '../widget/admin_doctors_shimmer.dart';
import '../widget/tab_bar_widget.dart';

part '../widget/custom_appbar.dart';
part '../widget/doctor_card.dart';
part '../widget/statues_widget.dart';

class AdminDoctorsTab extends StatelessWidget {
  const AdminDoctorsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: CustomAppbar(),
        resizeToAvoidBottomInset: false,
        floatingActionButton: TextButton.icon(
          onPressed: () {
            const AddDoctorRoute().push(context);
          },
          label: Text(
            t.admin.doctors_tab.add_doctor,
            style: context.regular12.white.rubik,
          ),
          icon: Icon(Icons.add_rounded, fontWeight: .w700),
          style: TextButton.styleFrom(
            backgroundColor: AppColors.brandPrimary,

            iconColor: AppColors.white,
            iconSize: 20,
            padding: EdgeInsets.all(15),
          ),
        ),
        body: Column(
          spacing: 15,
          children: [
            StatuesWidget(),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SearchTextFieldWidget(
                hintText: t.admin.doctors_tab.search_doctors,
                borderRadius: 12,
              ),
            ),
            BlocConsumer<DoctorBloc, DoctorState>(
              buildWhen: (previous, current) =>
                  current is GetDoctorsSuccessState ||
                  current is GetDoctorsLoadingState,
              builder: (context, state) {
                if (state is GetDoctorsSuccessState) {
                  if (state.doctors.isEmpty &&
                      state.selectedSpecialty == t.admin.doctors_tab.all) {
                    return Expanded(
                      child: _noDoctorFoundWidget(context: context),
                    );
                  }
                  return Expanded(
                    child: Column(
                      mainAxisSize: .min,
                      children: [
                        DefaultTabController(
                          length: state.specialtyCounts.length,
                          child: TabBar(
                            overlayColor: WidgetStatePropertyAll(
                              AppColors.transparent,
                            ),
                            onTap: (index) {
                              final specialty =
                                  state.specialtyCounts[index].keys.first;
                              context.read<DoctorBloc>().add(
                                FilterDoctorsRequested(specialty),
                              );
                            },
                            tabAlignment: TabAlignment.start,
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            isScrollable: true,
                            dividerColor: AppColors.transparent,
                            indicatorColor: AppColors.transparent,
                            labelPadding: EdgeInsets.symmetric(
                              horizontal: context.width * 0.01,
                            ),
                            tabs: state.specialtyCounts.map((map) {
                              final label = map.keys.first;
                              final number = map.values.first;
                              return TabBarWidget(
                                isSelected: state.selectedSpecialty == label,
                                number: number,
                                label: label,
                              );
                            }).toList(),
                          ),
                        ),
                        Expanded(
                          child: state.doctors.isEmpty
                              ? _noDoctorFoundWidget(context: context)
                              : ListView.separated(
                                  padding: EdgeInsets.all(20),
                                  itemBuilder: (context, index) =>
                                      DoctorCard(doctor: state.doctors[index]),
                                  separatorBuilder: (context, index) =>
                                      SizedBox(height: 10),
                                  itemCount: state.doctors.length,
                                ),
                        ),
                      ],
                    ),
                  );
                }
                return Expanded(child: AdminDoctorsShimmer());
              },
              listenWhen: (previous, current) =>
                  current is GetDoctorsErrorState,
              listener: (context, state) {
                if (state is GetDoctorsErrorState) {
                  SnackBarUtils.showErrorSnackBar(
                    context: context,
                    message: state.message,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _noDoctorFoundWidget({required BuildContext context}) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(40, 70, 40, 40),
      children: [
        Image.asset(
          AppAssets.images.noDoctorsFoundImage.path,
          width: context.width / 4,
          height: context.width / 4,
          fit: .fitHeight,
        ),
        Text(
          t.admin.doctors_tab.no_doctors_found,
          style: context.bold16.textPrimary.rubik.copyWith(height: 2),
          textAlign: .center,
        ),
        Text(
          t.admin.doctors_tab.no_doctors_description,
          style: context.regular12.textSecondary.rubik,
          textAlign: .center,
        ),
      ],
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

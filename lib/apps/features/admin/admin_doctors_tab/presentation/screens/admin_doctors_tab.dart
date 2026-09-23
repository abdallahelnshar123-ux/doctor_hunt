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

import '../../../../../core/data/models/doctor/doctor.dart';
import '../../../../../core/router/app_routes.dart';
import '../../../../common/auth/domain/entity/user/my_user.dart';
import '../../../../common/auth/presentation/controller/auth_bloc.dart';
import '../../../../common/auth/presentation/controller/auth_state.dart';
import '../widget/admin_doctors_shimmer.dart';
import '../widget/tab_bar_widget.dart';

part '../widget/custom_appbar.dart';
part '../widget/doctor_card.dart';
part '../widget/status_widget.dart';

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
            StatusWidget(),

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
                  if (state.allDoctors.isEmpty ||
                      (state.filteredDoctors?.isEmpty ?? false)) {
                    return Expanded(
                      child: _noDoctorFoundWidget(context: context),
                    );
                  }
                  return Expanded(
                    child: Column(
                      mainAxisSize: .min,
                      children: [
                        DefaultTabController(
                          length: state.specialtyCounts.length + 1,
                          child: TabBar(
                            overlayColor: WidgetStatePropertyAll(
                              AppColors.transparent,
                            ),
                            onTap: (index) {
                              if (index == 0) {
                                context.read<DoctorBloc>().add(
                                  FilterDoctorsRequested(null),
                                );
                              } else {
                                final specialty =
                                    state.specialtyCounts[index - 1].keys.first;
                                context.read<DoctorBloc>().add(
                                  FilterDoctorsRequested(specialty),
                                );
                              }
                            },
                            tabAlignment: TabAlignment.start,
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            isScrollable: true,
                            dividerColor: AppColors.transparent,
                            indicatorColor: AppColors.transparent,
                            labelPadding: EdgeInsets.symmetric(
                              horizontal: context.width * 0.01,
                            ),
                            tabs: [
                              TabBarWidget(
                                isSelected: state.selectedSpecialty == null,
                                number: state.allDoctors.length,
                                label: t.admin.doctors_tab.all,
                              ),
                              ...state.specialtyCounts.map((map) {
                                final label = map.keys.first.name;
                                final number = map.values.first;
                                return TabBarWidget(
                                  isSelected:
                                      state.selectedSpecialty?.name == label,
                                  number: number,
                                  label: label,
                                );
                              }),
                            ],
                          ),
                        ),
                        Expanded(
                          child:
                              state.allDoctors.isEmpty &&
                                  (state.filteredDoctors?.isEmpty ?? false)
                              ? _noDoctorFoundWidget(context: context)
                              : ListView.separated(
                                  padding: EdgeInsets.all(20),
                                  itemBuilder: (context, index) =>
                                      GestureDetector(
                                        onTap: () {
                                          AdminDoctorDetailsRoute(
                                            _buildDoctorsList(
                                              allDoctors: state.allDoctors,
                                              filteredDoctors:
                                                  state.filteredDoctors,
                                            )[index],
                                          ).push(context);
                                        },
                                        child: DoctorCard(
                                          doctor: _buildDoctorsList(
                                            allDoctors: state.allDoctors,
                                            filteredDoctors:
                                                state.filteredDoctors,
                                          )[index],
                                        ),
                                      ),
                                  separatorBuilder: (context, index) =>
                                      SizedBox(height: 10),
                                  itemCount: _buildDoctorsList(
                                    allDoctors: state.allDoctors,
                                    filteredDoctors: state.filteredDoctors,
                                  ).length,
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

  List<Doctor> _buildDoctorsList({
    required List<Doctor> allDoctors,
    required List<Doctor>? filteredDoctors,
  }) {
    if (filteredDoctors == null) {
      return allDoctors;
    }
    return filteredDoctors;
  }
}

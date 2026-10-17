import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_hunt/apps/core/extensions/context_extensions.dart';
import 'package:doctor_hunt/apps/core/presentation/controller/user/user_bloc.dart';
import 'package:doctor_hunt/apps/core/theme/app_colors.dart';
import 'package:doctor_hunt/apps/core/utils/snack_bar_utils.dart';
import 'package:doctor_hunt/apps/core/widgets/app_container_with_shadow.dart';
import 'package:doctor_hunt/apps/core/widgets/custom_cached_network_image.dart';
import 'package:doctor_hunt/apps/core/widgets/rating_widget.dart';
import 'package:doctor_hunt/apps/core/widgets/search_text_field_widget.dart';
import 'package:doctor_hunt/generated/app_assets.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../../core/data/models/doctor/doctor.dart';
import '../../../../../core/router/app_routes.dart';
import '../../../../common/auth/data/models/user/my_user.dart';
import '../controller/admin_doctors_bloc.dart';
import '../widget/admin_doctors_shimmer.dart';
import '../widget/tab_bar_widget.dart';

part '../widget/admin_appbar.dart';
part '../widget/doctor_card.dart';
part '../widget/doctors_widget.dart';
part '../widget/status_widget.dart';

class AdminDoctorsTab extends HookWidget {
  const AdminDoctorsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final searchFocusNode = useFocusNode();
    final searchController = useTextEditingController();
    useListenable(searchFocusNode);
    useListenable(searchController);

    return SafeArea(
      top: false,
      child: GestureDetector(
        onTap: () {
          searchFocusNode.unfocus();
          searchController.clear();
          context.read<AdminDoctorsBloc>().add(AdminSearchDoctorsRequested(''));
          context.read<AdminDoctorsBloc>().add(
            const AdminFilterDoctorsRequested(null),
          );
        },
        child: Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.endContained,
          appBar: AdminAppbar(title: t.admin.main.doctors),
          resizeToAvoidBottomInset: false,
          floatingActionButton: searchFocusNode.hasFocus
              ? null
              : _buildFloatingActionButton(context),
          body: Column(
            spacing: 15,
            children: [
              StatusWidget(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Builder(
                  builder: (context) {
                    return SearchTextFieldWidget(
                      hintText: t.admin.doctors_tab.search_doctors,
                      borderRadius: 12,
                      focusNode: searchFocusNode,
                      controller: searchController,
                      onChanged: (value) {
                        final userBloc = context.read<UserBloc>();
                        final userState = userBloc.state;
                        if (userState.isAuthenticated &&
                            userState.user != null) {
                          context.read<AdminDoctorsBloc>().add(
                            AdminSearchDoctorsRequested(value),
                          );
                        }
                      },
                    );
                  },
                ),
              ),
              if (searchFocusNode.hasFocus)
                _buildSearchResults(searchController.text.trim())
              else
                DoctorsWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchResults(String query) {
    return Expanded(
      child: BlocBuilder<AdminDoctorsBloc, AdminDoctorsState>(
        builder: (context, state) {
          if (state is AdminDoctorsSuccess) {
            if (query.isNotEmpty) {
              if (state.searchDoctors.isEmpty) {
                return ListView(
                  padding: const EdgeInsets.fromLTRB(40, 70, 40, 40),
                  children: [
                    Text(
                      t.admin.doctors_tab.no_doctors_found,
                      style: context.bold16.textPrimary.rubik.copyWith(
                        height: 2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      t
                          .admin
                          .doctors_tab
                          .no_doctor_name_or_specialty_match_search,
                      style: context.regular12.textSecondary.rubik,
                      textAlign: TextAlign.center,
                    ),
                  ],
                );
              }
              return ListView.separated(
                padding: EdgeInsets.all(20),
                itemBuilder: (context, index) {
                  final doctor = state.searchDoctors[index];
                  return GestureDetector(
                    onTap: () {
                      AdminDoctorDetailsRoute(doctor).push(context);
                    },
                    child: DoctorCard(doctor: doctor),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(height: 10),
                itemCount: state.searchDoctors.length,
              );
            }
            if (state.allDoctors.isEmpty) {
              return ListView(
                padding: const EdgeInsets.fromLTRB(40, 70, 40, 40),
                children: [
                  Text(
                    t.admin.doctors_tab.no_doctors,
                    style: context.bold16.textPrimary.rubik.copyWith(height: 2),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    t.admin.doctors_tab.no_doctors_to_search_add_some,
                    style: context.regular12.textSecondary.rubik,
                    textAlign: TextAlign.center,
                  ),
                ],
              );
            }
            return ListView.separated(
              padding: EdgeInsets.all(20),
              itemBuilder: (context, index) {
                final doctor = state.allDoctors[index];
                return GestureDetector(
                  onTap: () {
                    AdminDoctorDetailsRoute(doctor).push(context);
                  },
                  child: DoctorCard(doctor: doctor),
                );
              },
              separatorBuilder: (context, index) => SizedBox(height: 10),
              itemCount: state.allDoctors.length,
            );
          } else if (state is AdminDoctorsError) {
            return Center(
              child: Text(
                state.message,
                style: context.bold16.statusError.rubik,
              ),
            );
          }

          return AdminDoctorsShimmer();
        },
      ),
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return TextButton.icon(
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
    );
  }
}

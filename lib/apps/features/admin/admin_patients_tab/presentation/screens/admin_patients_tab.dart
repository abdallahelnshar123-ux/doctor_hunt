import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_hunt/apps/core/widgets/basic_user_card.dart';
import 'package:doctor_hunt/apps/core/widgets/main_empty_list_widget.dart';
import 'package:doctor_hunt/apps/features/admin/admin_patients_tab/presentation/controller/admin_patients_bloc.dart';
import 'package:doctor_hunt/apps/features/admin/admin_patients_tab/presentation/controller/admin_patient_action_bloc.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../../../generated/style_atoms.dart';
import '../../../../../../generated/app_assets.dart';
import '../../../../../core/di/di.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/snack_bar_utils.dart';
import '../../../../../core/widgets/account_status_switch_tile.dart';
import '../../../../../core/widgets/custom_text_form_field.dart';
import '../../../../common/auth/domain/entity/user/patient.dart';

part '../../widget/patient_details_bottom_sheet_content.dart';

class AdminPatientsTab extends HookWidget {
  const AdminPatientsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = useTextEditingController();

    return BlocProvider(
      create: (context) => getIt<AdminPatientActionBloc>(),
      child: Builder(
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              spacing: 15,
              children: [
                Row(
                  spacing: 15,
                  children: [
                    Expanded(
                      child: CustomTextFormField(
                        controller: searchController,
                        prefixIcon: const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Icon(Icons.search),
                        ),
                        hintText: t.admin.patientsTab.searchHint,
                        onChanged: (val) {
                          context.read<AdminPatientsBloc>().add(
                            AdminSearchPatientsRequested(val),
                          );
                        },
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.refresh),
                      onPressed: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        searchController.clear();
                        context.read<AdminPatientsBloc>().add(
                          AdminGetPatientsRequested(),
                        );
                      },
                    ),
                  ],
                ),
                Expanded(
                  child: BlocConsumer<AdminPatientsBloc, AdminPatientsState>(
                    listener: (context, state) {
                      if (state is AdminPatientsSuccess &&
                          state.errorMessage != null) {
                        SnackBarUtils.showErrorSnackBar(
                          message: state.errorMessage!,
                          context: context,
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is AdminPatientsError) {
                        return Center(
                          child: Text(
                            state.message,
                            style: context.bold16.textPrimary.rubik,
                            textAlign: TextAlign.center,
                          ),
                        );
                      } else if (state is AdminPatientsSuccess) {
                        final patients = state.displayPatients;

                        if (patients.isEmpty) {
                          return MainEmptyListWidget(
                            title: t.admin.patientsTab.noPatients,
                          );
                        }

                        return _buildPatientsList(context, patients);
                      }
                      return const Center(child: CircularProgressIndicator());
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildActiveChip(BuildContext context, bool isActive) {
    return Chip(
      padding: const EdgeInsets.all(5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      side: const BorderSide(width: 0, color: AppColors.transparent),
      backgroundColor: isActive
          ? AppColors.brandPrimary20
          : AppColors.statusErrorSurface,
      avatarBoxConstraints: const BoxConstraints.tightFor(width: 15),
      avatar: Icon(
        Icons.circle,
        size: 10,
        color: isActive ? AppColors.brandPrimaryDark : AppColors.statusError,
      ),
      label: Text(
        isActive ? t.admin.doctorsTab.active : t.admin.doctorsTab.inactive,
        style: isActive
            ? context.medium10.brandPrimaryDark.rubik
            : context.regular10.statusError.rubik,
      ),
    );
  }

  Widget _buildPatientsList(
    BuildContext context,
    List<PatientEntity> patients,
  ) {
    return SafeArea(
      child: ListView.separated(
        itemCount: patients.length,
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          final patient = patients[index];
          return InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () {
              _showPatientDetailsBottomSheet(context, patient);
            },
            child: BasicUserCard(
              outerUser: patient,
              trailing: _buildActiveChip(context, !patient.disabled),
            ),
          );
        },
      ),
    );
  }

  void _showPatientDetailsBottomSheet(
    BuildContext parentContext,
    PatientEntity patient,
  ) {
    final actionBloc = parentContext.read<AdminPatientActionBloc>();
    final patientsBloc = parentContext.read<AdminPatientsBloc>();

    showModalBottomSheet(
      context: parentContext,
      isScrollControlled: true,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return _PatientDetailsBottomSheetContent(
          patient: patient,
          actionBloc: actionBloc,
          patientsBloc: patientsBloc,
        );
      },
    );
  }
}

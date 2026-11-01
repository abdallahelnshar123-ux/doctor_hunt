import 'package:doctor_hunt/apps/core/widgets/main_empty_list_widget.dart';
import 'package:doctor_hunt/apps/core/widgets/basic_user_card.dart';
import 'package:doctor_hunt/apps/features/admin/admin_doctors_tab/presentation/screens/admin_doctors_tab.dart';
import 'package:doctor_hunt/apps/features/admin/admin_patients_tab/presentation/controller/admin_patients_bloc.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../../../generated/style_atoms.dart';
import '../../../../../core/utils/snack_bar_utils.dart';
import '../../../../../core/widgets/custom_text_form_field.dart';
import '../../../../common/auth/domain/entity/user/patient.dart';

class AdminPatientsTab extends HookWidget {
  const AdminPatientsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = useTextEditingController();

    return Scaffold(
      appBar: AdminAppbar(title: t.admin.patientsTab.title),
      body: Padding(
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
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(12.0),
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
                        textAlign: .center,
                      ),
                    );
                  } else if (state is AdminPatientsSuccess) {
                    final patients = state.displayPatients;

                    if (patients.isEmpty) {
                      return MainEmptyListWidget(
                        title: t.admin.patientsTab.noPatients,
                      );
                    }

                    return _buildPatientsList(patients, false);
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPatientsList(List<PatientEntity> patients, bool isLoading) {
    return Stack(
      children: [
        SafeArea(
          child: ListView.separated(
            itemCount: patients.length,
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              return BasicUserCard(outerUser: patients[index]);
            },
          ),
        ),
        if (isLoading)
          const Positioned(
            top: 10,
            left: 0,
            right: 0,
            child: Center(child: CircularProgressIndicator()),
          ),
      ],
    );
  }
}

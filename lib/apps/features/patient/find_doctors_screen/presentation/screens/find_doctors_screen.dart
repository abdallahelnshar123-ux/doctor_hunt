import 'package:doctor_hunt/apps/core/widgets/app_scaffold.dart';
import 'package:doctor_hunt/apps/core/widgets/main_app_bar.dart';
import 'package:doctor_hunt/apps/core/widgets/search_text_field_widget.dart';
import 'package:doctor_hunt/apps/features/patient/home_tab/presentation/controller/patient_doctors_bloc.dart';
import 'package:doctor_hunt/apps/features/patient/main_screen/widget/doctor_card_wide.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/router/app_routes.dart';

class FindDoctorsScreen extends StatelessWidget {
  const FindDoctorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Column(
        children: [
          MainAppBar(title: t.doctorDetails.findDoctors),
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
                  child: SearchTextFieldWidget(
                    onChanged: (query) {
                      context.read<PatientDoctorsBloc>().add(
                        SearchPatientDoctorsRequested(query),
                      );
                    },
                    onTapOutside: (_) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                  ),
                ),
                Expanded(
                  child: BlocBuilder<PatientDoctorsBloc, PatientDoctorsState>(
                    builder: (context, state) {
                      if (state is PatientDoctorsSuccess) {
                        final displayList = (state.searchQuery?.isEmpty ?? true)
                            ? state.doctors
                            : state.searchResults;

                        if (displayList.isEmpty) {
                          return Center(
                            child: Text(
                              t.admin.doctorsTab.noDoctorsFound,
                              style: context.medium16.textTertiary.rubik,
                            ),
                          );
                        }

                        return ListView.separated(
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              PatientDoctorDetailsRoute(
                                displayList[index],
                              ).push(context);
                            },
                            child: DoctorCardWide(doctor: displayList[index]),
                          ),
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 15),
                          itemCount: displayList.length,
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                        );
                      }
                      return const Center(child: CircularProgressIndicator());
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

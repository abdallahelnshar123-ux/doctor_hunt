import 'package:doctor_hunt/apps/core/widgets/app_scaffold.dart';
import 'package:doctor_hunt/apps/core/widgets/main_app_bar.dart';
import 'package:doctor_hunt/apps/core/widgets/search_text_field_widget.dart';
import 'package:doctor_hunt/apps/features/find_doctors_screen/presentation/widget/doctor_card.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter/material.dart';

class FindDoctorsScreen extends StatelessWidget {
  const FindDoctorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Column(
        children: [
          MainAppBar(
            title: Translations.of(context).doctor_details.find_doctors,
          ),
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
                  child: SearchTextFieldWidget(),
                ),
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) => DoctorCard(),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                    itemCount: 10,
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
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

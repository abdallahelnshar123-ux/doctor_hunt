import 'package:doctor_hunt/apps/core/widgets/search_text_field_widget.dart';
import 'package:doctor_hunt/apps/features/patient/favourite_tab/presentation/widget/favourite_doctor_card.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter/material.dart';

import '../../../../../core/widgets/app_scaffold.dart';

class FavoriteTab extends StatelessWidget {
  const FavoriteTab({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      bottomSafeArea: false,
      body: Column(
        spacing: 10,
        children: [
          AppBar(title: Text(t.home.favourite_doctors)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SearchTextFieldWidget(),
          ),
          Expanded(
            child: SafeArea(
              top: false,
              child: GridView.builder(
                padding: EdgeInsets.all(20),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 180 / 160,
                  mainAxisExtent: 280,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) =>
                    const FavouriteDoctorCard(doctorId: '1'),
                itemCount: 16,
              ),
            ),
          ),
          // SizedBox(height: 20,)
          // SizedBox(
          //   width: double.infinity,
          //   height: 450,
          //   child:
          // ),
          // TopRatedDoctorsWidget(),
        ],
      ),
    );
  }
}

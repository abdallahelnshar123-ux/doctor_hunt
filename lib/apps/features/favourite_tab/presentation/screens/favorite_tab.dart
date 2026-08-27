import 'package:doctor_hunt/apps/core/widgets/search_text_field_widget.dart';
import 'package:doctor_hunt/apps/features/favourite_tab/presentation/widget/favourite_doctor_card.dart';
import 'package:doctor_hunt/apps/features/main_screen/widget/feature_doctors_widget.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/app_scaffold.dart';
import '../../../../core/widgets/main_app_bar.dart';

class FavoriteTab extends StatelessWidget {
  const FavoriteTab({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: ListView(
        children: [
          MainAppBar(title: Translations.of(context).home.favourite_doctors),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 30, 20, 5),
            child: SearchTextFieldWidget(),
          ),
          SizedBox(
            width: double.infinity,
            height: 450,
            child: GridView.builder(
              padding: EdgeInsets.all(20),
              scrollDirection: .horizontal,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 160 / 180,
                mainAxisExtent: 160,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) => const FavouriteDoctorCard(),
              itemCount: 16,
            ),
          ),
          FeatureDoctorsWidget(),
        ],
      ),
    );
  }
}

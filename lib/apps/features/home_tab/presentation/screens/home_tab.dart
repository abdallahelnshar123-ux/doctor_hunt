import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_hunt/apps/core/theme/app_colors.dart';
import 'package:doctor_hunt/apps/core/widgets/app_scaffold.dart';
import 'package:doctor_hunt/apps/core/widgets/search_text_field_widget.dart';
import 'package:doctor_hunt/apps/features/auth/presentation/controller/auth_bloc.dart';
import 'package:doctor_hunt/generated/app_assets.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../main_screen/widget/feature_doctors_widget.dart';
import '../widget/categories_widget.dart';
import '../widget/live_doctors_widget.dart';
import '../widget/popular_doctors_widget.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: _customAppBar(context: context),
      body: Column(
        spacing: 20,
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                  color: AppColors.brandPrimary,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: SearchTextFieldWidget(),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                spacing: 20,
                children: [
                  const LiveDoctorsWidget(),
                  const CategoriesWidget(),
                  const PopularDoctorsWidget(),
                  const FeatureDoctorsWidget(),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _customAppBar({required BuildContext context}) {
    final t = Translations.of(context);
    var currentUser = context.read<AuthBloc>().currentUser;
    return AppBar(
      toolbarHeight: 90,
      backgroundColor: AppColors.brandPrimary,
      title: Text.rich(
        TextSpan(
          text: t.home.welcome(Name: currentUser?.name ?? ''),
          style: context.light20.bgPrimary.rubik,
          children: [
            TextSpan(
              text: '\n${t.home.find_doctor}',
              style: context.bold24.bgPrimary.rubik,
            ),
          ],
        ),
      ),
      actionsPadding: EdgeInsets.only(right: 20),
      actions: [
        CircleAvatar(
          foregroundImage:
              currentUser!.image == null || currentUser.image!.isEmpty
              ? AssetImage(AppAssets.images.fallbackUserImage.path)
              : CachedNetworkImageProvider(currentUser.image ?? ''),
          radius: 30,
        ),
      ],
    );
  }
}

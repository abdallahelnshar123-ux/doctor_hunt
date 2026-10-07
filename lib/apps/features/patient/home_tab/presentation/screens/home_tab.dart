import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_hunt/apps/core/extensions/context_extensions.dart';
import 'package:doctor_hunt/apps/core/theme/app_colors.dart';
import 'package:doctor_hunt/apps/core/widgets/app_container_with_shadow.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/controller/user_bloc.dart';
import 'package:doctor_hunt/generated/app_assets.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/router/app_routes.dart';
import '../../../../common/auth/data/models/user/my_user.dart';
import '../widget/categories_widget.dart';
import '../widget/popular_doctors_widget.dart';
import '../widget/top_rated_doctors_widget.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              _buildSearchButton(context: context),
            ],
          ),
          Expanded(
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  spacing: 20,
                  children: [
                    const CategoriesWidget(),
                    const PopularDoctorsWidget(),
                    const TopRatedDoctorsWidget(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchButton({required BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: AppContainerWithShadow(
        child: TextButton.icon(
          icon: Icon(Icons.search),
          style: ButtonStyle(
            alignment: .centerLeft,
            fixedSize: WidgetStatePropertyAll(Size(context.width - 40, 65)),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            padding: WidgetStatePropertyAll(EdgeInsets.all(16)),
            backgroundColor: WidgetStatePropertyAll(AppColors.white),
            iconColor: WidgetStatePropertyAll(AppColors.textSecondary),
            iconSize: WidgetStatePropertyAll(20),
            textStyle: WidgetStatePropertyAll(context.regular14.rubik),
            foregroundColor: WidgetStatePropertyAll(AppColors.textSecondary),
          ),

          onPressed: () {
            const FindDoctorsRoute().push(context);
          },
          label: Text(t.home.search),
        ),
      ),
    );
  }

  PreferredSizeWidget _customAppBar({required BuildContext context}) {
    final user = context.select<UserBloc, MyUser?>((bloc) => bloc.currentUser);
    return AppBar(
      toolbarHeight: 90,
      backgroundColor: AppColors.brandPrimary,
      title: Text.rich(
        TextSpan(
          text: t.home.welcome(Name: user?.name ?? ''),
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
          foregroundImage: (user?.image?.isNotEmpty ?? false)
              ? CachedNetworkImageProvider(user!.image!)
              : AssetImage(AppAssets.images.fallbackUserImage.path),
          radius: 30,
        ),
      ],
    );
  }
}

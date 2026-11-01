import 'package:doctor_hunt/apps/core/presentation/controller/user/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../generated/style_atoms.dart';
import '../../features/common/auth/domain/entity/user/app_user.dart';
import '../theme/app_colors.dart';
import 'app_container_with_shadow.dart';
import 'custom_cached_network_image.dart';

class BasicUserCard extends StatelessWidget {
  const BasicUserCard({super.key, this.onTap , this.outerUser});

  final void Function()? onTap;
  final AppUserEntity? outerUser ;

  @override
  Widget build(BuildContext context) {
    final user = outerUser ??  context.select<UserBloc, AppUserEntity?>((bloc) => bloc.currentUser);
    return AppContainerWithShadow(
      clipBehavior: .antiAlias,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Material(
        color: AppColors.transparent,
        child: ListTile(
          contentPadding: EdgeInsets.all(16),
          onTap: onTap,
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: AppColors.shimmerBaseColor,
            backgroundImage: CustomCachedNetworkImage.getProvider(user?.image),
          ),
          titleTextStyle: context.bold16.textPrimary.rubik,
          subtitleTextStyle: context.regular12.textSecondary.rubik,
          title: Text(user?.name ?? '-', textAlign: .start),
          subtitle: Text(user?.email ?? '-'),
        ),
      ),
    );
  }
}

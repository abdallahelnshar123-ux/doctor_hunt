import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../generated/style_atoms.dart';
import '../../features/common/auth/data/models/user/my_user.dart';
import '../../features/common/auth/presentation/controller/user/user_bloc.dart';
import '../theme/app_colors.dart';
import 'app_container_with_shadow.dart';
import 'custom_cached_network_image.dart';

class SettingsUserCard extends StatelessWidget {
  const SettingsUserCard({super.key, this.onTap});

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final user = context.select<UserBloc, MyUser?>((bloc) => bloc.currentUser);
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

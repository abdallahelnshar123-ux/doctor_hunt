import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_hunt/apps/core/widgets/app_container_with_shadow.dart';
import 'package:doctor_hunt/apps/core/widgets/app_scaffold.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/controller/auth_event.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../generated/translations.g.dart';
import '../../../../../core/router/app_routes.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../common/auth/data/models/user/my_user.dart';
import '../../../../common/auth/presentation/controller/auth_bloc.dart';
import '../../../../common/auth/presentation/controller/auth_state.dart';

part '../widget/account_settings_widget.dart';
part '../widget/more_option_widget.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.select<AuthBloc, MyUser?>((bloc) {
      final authState = bloc.state;
      return authState is UserAuthenticatedState ? authState.currentUser : null;
    });
    return AppScaffold(
      body: Column(
        children: [
          AppBar(title: Text(t.settings.title)),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(20),
              children: [
                AppContainerWithShadow(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16),
                    onTap: () {
                      if (user == null) return;
                      PatientProfileRoute(user).push(context);
                    },
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: CachedNetworkImageProvider(
                        user?.image ?? '',
                      ),
                    ),
                    titleTextStyle: context.bold16.textPrimary.rubik,
                    subtitleTextStyle: context.regular12.textSecondary.rubik,
                    title: Text(user?.name ?? '-', textAlign: .start),
                    subtitle: Text(user?.email ?? '-'),
                  ),
                ),
                SizedBox(height: 15),
                AccountSettingsWidget(),
                SizedBox(height: 15),
                MoreOptionWidget(),
                SizedBox(height: 40),
                _buildLogoutButton(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return TextButton.icon(
      icon: Icon(Icons.logout),
      style: ButtonStyle(
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        padding: WidgetStatePropertyAll(EdgeInsets.all(16)),
        backgroundColor: WidgetStatePropertyAll(AppColors.statusErrorSurface),
        iconColor: WidgetStatePropertyAll(AppColors.statusError),
        iconSize: WidgetStatePropertyAll(20),
        textStyle: WidgetStatePropertyAll(context.semiBold14.statusError.rubik),
        foregroundColor: WidgetStatePropertyAll(AppColors.statusError),
      ),

      onPressed: () {
        context.read<AuthBloc>().add(LogoutRequested());
      },
      label: Text(t.settings.logout),
    );
  }
}

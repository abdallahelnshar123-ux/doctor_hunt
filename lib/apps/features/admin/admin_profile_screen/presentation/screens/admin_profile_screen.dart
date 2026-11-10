import 'dart:io';

import 'package:doctor_hunt/apps/core/data/user/repo/user_repository.dart';
import 'package:doctor_hunt/apps/core/di/di.dart';
import 'package:doctor_hunt/apps/core/failure/failure.dart';
import 'package:doctor_hunt/apps/core/presentation/controller/user/user_bloc.dart';
import 'package:doctor_hunt/apps/core/presentation/controller/user/user_state.dart';
import 'package:doctor_hunt/apps/core/router/app_routes.dart';
import 'package:doctor_hunt/apps/core/utils/dialog_utils.dart';
import 'package:doctor_hunt/apps/core/utils/snack_bar_utils.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../common/auth/domain/entity/user/app_user.dart';
import '../widget/admin_profile_avatar_widget.dart';
import '../widget/admin_profile_form_widget.dart';

class AdminProfileScreen extends HookWidget {
  const AdminProfileScreen({super.key, required this.user});

  final AppUserEntity user;

  @override
  Widget build(BuildContext context) {
    final selectedImageNotifier = useValueNotifier<File?>(null);

    return BlocListener<UserBloc, UserState>(
      listenWhen: (previous, current) =>
          current is UserLoadingState ||
          (previous is UserLoadingState &&
              (current is UserDataState || current is UserErrorState)),
      listener: (context, state) {
        if (state is UserLoadingState) {
          DialogUtils.showLoading(context: context);
        } else if (state is UserErrorState) {
          DialogUtils.hideLoading(context: context);
          SnackBarUtils.showErrorSnackBar(
            context: context,
            message: state.message,
          );
        } else if (state is UserDataState) {
          DialogUtils.hideLoading(context: context);
          SnackBarUtils.showSuccessSnackBar(
            context: context,
            message: t.profile.dataWasUpdatedSuccessfully,
          );
          const AdminMainRoute().go(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(t.admin.profileScreen.title),
          centerTitle: true,
        ),
        body: Column(
          children: [
            const SizedBox(height: 40),
            AdminProfileAvatarWidget(
              user: user,
              selectedImageNotifier: selectedImageNotifier,
              onCameraTap: () async {
                final result = await getIt<UserRepository>().pickUserImage();
                result.fold(
                  (failure) {
                    if (failure is! CancelledByUserFailure) {
                      SnackBarUtils.showErrorSnackBar(
                        context: context,
                        message: failure.message,
                      );
                    }
                  },
                  (image) {
                    selectedImageNotifier.value = image;
                  },
                );
              },
            ),
            Expanded(
              child: AdminProfileFormWidget(
                user: user,
                selectedImageNotifier: selectedImageNotifier,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

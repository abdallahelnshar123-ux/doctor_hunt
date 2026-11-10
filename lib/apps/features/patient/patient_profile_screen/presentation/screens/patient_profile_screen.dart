import 'dart:io';

import 'package:doctor_hunt/apps/core/data/user/repo/user_repository.dart';
import 'package:doctor_hunt/apps/core/di/di.dart';
import 'package:doctor_hunt/apps/core/failure/failure.dart';
import 'package:doctor_hunt/apps/core/presentation/controller/user/user_bloc.dart';
import 'package:doctor_hunt/apps/core/presentation/controller/user/user_state.dart';
import 'package:doctor_hunt/apps/core/router/app_routes.dart';
import 'package:doctor_hunt/apps/core/theme/app_colors.dart';
import 'package:doctor_hunt/apps/core/utils/dialog_utils.dart';
import 'package:doctor_hunt/apps/core/utils/snack_bar_utils.dart';
import 'package:doctor_hunt/apps/core/widgets/app_scaffold.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../../core/widgets/main_app_bar.dart';
import '../../../../../core/widgets/main_profile_avatar_widget.dart';
import '../../../../common/auth/domain/entity/user/app_user.dart';
import '../widget/patient_profile_form_widget.dart';

class PatientProfileScreen extends HookWidget {
  const PatientProfileScreen({super.key, required this.user});

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
          const PatientMainRoute().go(context);
        }
      },
      child: AppScaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MainAppBar(
              backgroundColor: AppColors.brandPrimary,
              title: t.profile.title,
              titleStyle: context.bold18.white.rubik,
            ),
            MainProfileAvatarWidget(
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
              child: PatientProfileFormWidget(
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

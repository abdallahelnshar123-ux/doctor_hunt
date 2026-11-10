import 'dart:io';

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
import '../controller/patient_profile_bloc.dart';
import '../widget/patient_profile_form_widget.dart';

class PatientProfileScreen extends HookWidget {
  const PatientProfileScreen({super.key, required this.user});

  final AppUserEntity user;

  @override
  Widget build(BuildContext context) {
    final selectedImageNotifier = useValueNotifier<File?>(null);

    return BlocListener<PatientProfileBloc, PatientProfileState>(
      listenWhen: (previous, current) =>
          current is PatientProfileLoading ||
          current is PatientProfileUpdateSuccess ||
          current is PatientProfileUpdateError ||
          current is PickPatientImageErrorState ||
          current is PickPatientImageSuccessState,
      listener: (context, state) {
        if (state is PatientProfileLoading) {
          DialogUtils.showLoading(context: context);
        }
        if (state is PatientProfileUpdateError) {
          DialogUtils.hideLoading(context: context);
          SnackBarUtils.showErrorSnackBar(
            context: context,
            message: state.message,
          );
        }
        if (state is PickPatientImageErrorState) {
          SnackBarUtils.showErrorSnackBar(
            context: context,
            message: state.message,
          );
        }
        if (state is PickPatientImageSuccessState) {
          selectedImageNotifier.value = state.image;
        }
        if (state is PatientProfileUpdateSuccess) {
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
              onCameraTap: () {
                context.read<PatientProfileBloc>().add(
                  const PickPatientProfileImageRequested(),
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

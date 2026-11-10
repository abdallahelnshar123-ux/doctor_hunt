import 'dart:io';

import 'package:doctor_hunt/apps/core/router/app_routes.dart';
import 'package:doctor_hunt/apps/core/theme/app_colors.dart';
import 'package:doctor_hunt/apps/core/utils/dialog_utils.dart';
import 'package:doctor_hunt/apps/core/utils/snack_bar_utils.dart';
import 'package:doctor_hunt/apps/core/widgets/app_scaffold.dart';
import 'package:doctor_hunt/apps/core/widgets/main_app_bar.dart';
import 'package:doctor_hunt/apps/core/widgets/main_profile_avatar_widget.dart';
import 'package:doctor_hunt/apps/features/common/auth/domain/entity/user/doctor.dart';
import 'package:doctor_hunt/apps/features/doctor/doctor_profile_screen/controller/doctor_profile_bloc.dart';
import 'package:doctor_hunt/apps/features/doctor/doctor_profile_screen/controller/doctor_profile_event.dart';
import 'package:doctor_hunt/apps/features/doctor/doctor_profile_screen/controller/doctor_profile_state.dart';
import 'package:doctor_hunt/apps/features/doctor/doctor_profile_screen/widget/doctor_profile_form_widget.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class DoctorProfileScreen extends HookWidget {
  const DoctorProfileScreen({super.key, required this.user});

  final DoctorEntity user;

  @override
  Widget build(BuildContext context) {
    final selectedImageNotifier = useValueNotifier<File?>(null);

    return BlocListener<DoctorProfileBloc, DoctorProfileState>(
      listenWhen: (previous, current) =>
          current is UpdateDoctorDetailsLoading ||
          current is UpdateDoctorDetailsSuccess ||
          current is UpdateDoctorDetailsError ||
          current is PickDoctorUpdateImageErrorState ||
          current is PickDoctorUpdateImageSuccessState,
      listener: (context, state) {
        if (state is UpdateDoctorDetailsLoading) {
          DialogUtils.showLoading(context: context);
        }
        if (state is UpdateDoctorDetailsError) {
          DialogUtils.hideLoading(context: context);
          SnackBarUtils.showErrorSnackBar(
            context: context,
            message: state.message,
          );
        }
        if (state is PickDoctorUpdateImageErrorState) {
          SnackBarUtils.showErrorSnackBar(
            context: context,
            message: state.message,
          );
        }
        if (state is PickDoctorUpdateImageSuccessState) {
          selectedImageNotifier.value = state.image;
        }
        if (state is UpdateDoctorDetailsSuccess) {
          DialogUtils.hideLoading(context: context);
          SnackBarUtils.showSuccessSnackBar(
            context: context,
            message: t.profile.dataWasUpdatedSuccessfully,
          );
          // context.read<AuthBloc>().add(CheckAuthStatusRequested());
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
                context.read<DoctorProfileBloc>().add(
                  const PickDoctorUpdateImageRequested(),
                );
              },
            ),
            Expanded(
              child: DoctorProfileFormWidget(
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

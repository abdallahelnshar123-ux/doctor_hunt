import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_hunt/apps/core/theme/app_colors.dart';
import 'package:doctor_hunt/apps/core/utils/snack_bar_utils.dart';
import 'package:doctor_hunt/apps/core/utils/validators.dart';
import 'package:doctor_hunt/apps/core/widgets/custom_text_form_field.dart';
import 'package:doctor_hunt/apps/features/doctor/doctor_onboarding_screen/controller/doctor_onboarding_bloc.dart';
import 'package:doctor_hunt/apps/features/doctor/doctor_onboarding_screen/controller/doctor_onboarding_state.dart';
import 'package:doctor_hunt/generated/app_assets.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../controller/doctor_onboarding_event.dart';

class DoctorOnboardingProfileTab extends StatelessWidget {
  const DoctorOnboardingProfileTab({
    super.key,
    required this.formKey,
    required this.phoneController,
    required this.feeController,
    required this.selectedImage,
    this.initialImageUrl,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController phoneController;
  final TextEditingController feeController;
  final ObjectRef<File?> selectedImage;
  final String? initialImageUrl;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            _buildAvatarPicker(context),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                context.read<DoctorOnboardingBloc>().add(
                  PickDoctorOnboardingImageRequested(),
                );
              },
              child: Text(
                selectedImage.value != null ||
                        (initialImageUrl != null && initialImageUrl!.isNotEmpty)
                    ? t.doctor.onboarding.changePhoto
                    : t.doctor.onboarding.choosePhoto,
                style: context.medium14.brandPrimary.rubik,
              ),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                t.doctor.onboarding.phoneNumber,
                style: context.bold14.textTertiary.rubik,
              ),
            ),
            const SizedBox(height: 8),
            CustomTextFormField(
              controller: phoneController,
              fillColor: AppColors.bgPrimary,
              filled: true,
              keyboardType: TextInputType.phone,
              hintText: t.doctor.onboarding.phoneHint,
              hintStyle: context.light16.textSecondary.rubik,
              style: context.medium16.textTertiary.rubik,
              validator: (value) => Validators.phone(value),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                t.doctor.onboarding.consultationFee,
                style: context.bold14.textTertiary.rubik,
              ),
            ),
            const SizedBox(height: 8),
            CustomTextFormField(
              controller: feeController,
              fillColor: AppColors.bgPrimary,
              filled: true,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              hintText: t.doctor.onboarding.feeHint,
              hintStyle: context.light16.textSecondary.rubik,
              style: context.medium16.textTertiary.rubik,
              validator: (value) => Validators.required(value),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatarPicker(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Container(
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(shape: BoxShape.circle),
            width: 120,
            height: 120,
            alignment: Alignment.center,
            child: BlocConsumer<DoctorOnboardingBloc, DoctorOnboardingState>(
              listener: (context, state) {
                if (state is PickDoctorOnboardingImageErrorState) {
                  SnackBarUtils.showErrorSnackBar(
                    context: context,
                    message: state.message,
                  );
                }
              },
              buildWhen: (previous, current) =>
                  current is PickDoctorOnboardingImageSuccessState,
              builder: (context, state) {
                if (state is PickDoctorOnboardingImageSuccessState) {
                  selectedImage.value = state.image;
                  return Image.file(
                    state.image,
                    fit: BoxFit.cover,
                    width: 120,
                    height: 120,
                  );
                }
                if (selectedImage.value != null) {
                  return Image.file(
                    selectedImage.value!,
                    fit: BoxFit.cover,
                    width: 120,
                    height: 120,
                  );
                }
                if (initialImageUrl != null && initialImageUrl!.isNotEmpty) {
                  return CachedNetworkImage(
                    imageUrl: initialImageUrl!,
                    fit: BoxFit.cover,
                    width: 120,
                    height: 120,
                  );
                }
                return Image.asset(
                  AppAssets.images.fallbackUserImage.path,
                  fit: BoxFit.cover,
                  width: 120,
                  height: 120,
                );
              },
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: () {
                context.read<DoctorOnboardingBloc>().add(
                  PickDoctorOnboardingImageRequested(),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: AppColors.brandPrimary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.camera_alt,
                  color: AppColors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

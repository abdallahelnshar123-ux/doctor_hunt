import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_hunt/apps/core/presentation/controller/user/user_bloc.dart';
import 'package:doctor_hunt/apps/core/theme/app_colors.dart';
import 'package:doctor_hunt/apps/core/utils/dialog_utils.dart';
import 'package:doctor_hunt/apps/core/utils/snack_bar_utils.dart';
import 'package:doctor_hunt/apps/core/utils/validators.dart';
import 'package:doctor_hunt/apps/core/widgets/app_container_with_shadow.dart';
import 'package:doctor_hunt/apps/core/widgets/custom_text_form_field.dart';
import 'package:doctor_hunt/apps/features/admin/add_doctor_screen/presentation/widget/specialty_dropdown_widget.dart';
import 'package:doctor_hunt/apps/features/common/auth/domain/entity/user/app_user.dart';
import 'package:doctor_hunt/apps/features/common/auth/domain/entity/user/doctor.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/widgets/custom_elevated_button.dart';
import 'package:doctor_hunt/apps/features/doctor/presentation/controller/update_doctor_details_bloc.dart';
import 'package:doctor_hunt/apps/features/doctor/presentation/controller/update_doctor_details_event.dart';
import 'package:doctor_hunt/apps/features/doctor/presentation/controller/update_doctor_details_state.dart';
import 'package:doctor_hunt/generated/app_assets.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';

class UpdateDoctorDetailsScreen extends HookWidget {
  const UpdateDoctorDetailsScreen({
    super.key,
    this.showAppBar = true,
    this.automaticallyImplyLeading = true,
  });

  final bool showAppBar;
  final bool automaticallyImplyLeading;

  @override
  Widget build(BuildContext context) {
    final user = context.select<UserBloc, AppUserEntity?>(
      (bloc) => bloc.currentUser,
    );
    final doctor = user is DoctorEntity ? user : null;

    final nameController = useTextEditingController(text: doctor?.name ?? '');
    final feeController = useTextEditingController(
      text: doctor?.consultationFee.toString() ?? '',
    );
    final isActive = useValueNotifier(doctor?.active ?? true);
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final selectedImage = useRef<File?>(null);
    final selectedSpecialty = useRef<Specialty>(
      doctor?.specialty ?? Specialty.cardiologists,
    );

    return BlocListener<UpdateDoctorDetailsBloc, UpdateDoctorDetailsState>(
      listenWhen: (previous, current) =>
          current is UpdateDoctorDetailsSuccess ||
          current is UpdateDoctorDetailsError ||
          current is UpdateDoctorDetailsLoading,
      listener: (context, state) {
        if (state is UpdateDoctorDetailsSuccess) {
          DialogUtils.hideLoading(context: context);
          SnackBarUtils.showSuccessSnackBar(
            context: context,
            message: t.admin.updateDoctorDetails.doctorWasUpdatedSuccessfully,
          );
        }
        if (state is UpdateDoctorDetailsError) {
          debugPrint(state.message);
          DialogUtils.hideLoading(context: context);
          DialogUtils.showMessage(
            posActionText: t.dialog.ok,
            title: t.dialog.error,
            context: context,
            message: state.message,
          );
        }
        if (state is UpdateDoctorDetailsLoading) {
          DialogUtils.showLoading(context: context);
        }
      },
      child: Scaffold(
        appBar: showAppBar
            ? AppBar(
                title: Text(t.admin.updateDoctorDetails.editDoctor),
                automaticallyImplyLeading: automaticallyImplyLeading,
                centerTitle: true,
              )
            : null,
        body: Form(
          key: formKey,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              buildChangeImage(context, selectedImage, doctor?.image),
              _buildChangePhotoButton(context),
              const SizedBox(height: 20),
              _buildText(
                context: context,
                text: t.admin.addDoctorScreen.doctorName,
              ),
              CustomTextFormField(
                controller: nameController,
                fillColor: AppColors.bgPrimary,
                filled: true,
                hintText: t.admin.addDoctorScreen.nameExample,
                hintStyle: context.light16.textSecondary.rubik,
                style: context.medium16.textTertiary.rubik,
                validator: (value) => Validators.required(value),
              ),
              _buildText(
                context: context,
                text: t.admin.addDoctorScreen.specialty,
              ),
              SpecialtyDropdownWidget(
                initialSelection: doctor?.specialty ?? Specialty.cardiologists,
                selectedSpecialty: (value) => selectedSpecialty.value = value,
              ),
              _buildText(
                context: context,
                text: t.admin.addDoctorScreen.consultationFee,
              ),
              CustomTextFormField(
                controller: feeController,
                fillColor: AppColors.bgPrimary,
                filled: true,
                keyboardType: TextInputType.number,
                hintText: t.admin.addDoctorScreen.feeExample,
                hintStyle: context.light16.textSecondary.rubik,
                style: context.medium16.textTertiary.rubik,
                validator: (value) => Validators.required(value),
              ),
              const SizedBox(height: 20),
              _buildStatusWidget(context, isActive),
              const SizedBox(height: 40),
              CustomElevatedButton(
                backgroundColor: AppColors.brandPrimary,
                onPressed: () => _onUpdateDetailsPressed(
                  context,
                  formKey,
                  nameController,
                  feeController,
                  selectedImage,
                  selectedSpecialty,
                  isActive,
                  doctor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.check_rounded, color: AppColors.white, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      t.admin.updateDoctorDetails.saveChanges,
                      style: context.semiBold16.white.rubik,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChangePhotoButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        context.read<UpdateDoctorDetailsBloc>().add(
          PickDoctorUpdateImageRequested(),
        );
      },
      child: Text(
        t.admin.updateDoctorDetails.changePhoto,
        style: context.medium12.brandPrimary.rubik,
      ),
    );
  }

  Widget buildChangeImage(
    BuildContext context,
    ObjectRef<File?> selectedImage,
    String? currentImageUrl,
  ) {
    return Center(
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(shape: BoxShape.circle),
        width: 120,
        height: 120,
        alignment: Alignment.center,
        child: BlocConsumer<UpdateDoctorDetailsBloc, UpdateDoctorDetailsState>(
          listener: (context, state) {
            if (state is PickDoctorUpdateImageErrorState) {
              SnackBarUtils.showErrorSnackBar(
                context: context,
                message: state.message,
              );
            }
          },
          buildWhen: (previous, current) =>
              current is PickDoctorUpdateImageSuccessState,
          builder: (context, state) {
            if (state is PickDoctorUpdateImageSuccessState) {
              selectedImage.value = state.image;
              return Image.file(state.image, fit: BoxFit.cover, width: 120, height: 120);
            }
            if (currentImageUrl != null && currentImageUrl.isNotEmpty) {
              return CachedNetworkImage(
                imageUrl: currentImageUrl,
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
    );
  }

  Widget _buildStatusWidget(
    BuildContext context,
    ValueNotifier<bool> isActive,
  ) {
    return ValueListenableBuilder(
      valueListenable: isActive,
      builder: (context, value, child) {
        return AppContainerWithShadow(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: ListTile(
            leading: SvgPicture.asset(
              AppAssets.icons.switchIcon.path,
              fit: BoxFit.scaleDown,
              colorFilter: const ColorFilter.mode(
                AppColors.brandPrimary,
                BlendMode.srcIn,
              ),
            ),
            title: Text(t.admin.updateDoctorDetails.doctorStatues),
            titleTextStyle: context.semiBold14.textPrimary.rubik,
            subtitle: Text(
              value
                  ? t.admin.updateDoctorDetails.activeAndAvailable
                  : t.admin.updateDoctorDetails.inactive,
            ),
            subtitleTextStyle: context.regular12.textSecondary.rubik,
            trailing: Switch(
              value: value,
              onChanged: (val) {
                isActive.value = val;
              },
              activeThumbColor: AppColors.white,
              activeTrackColor: AppColors.brandPrimary,
            ),
            contentPadding: EdgeInsets.zero,
          ),
        );
      },
    );
  }

  void _onUpdateDetailsPressed(
    BuildContext context,
    GlobalKey<FormState> formKey,
    TextEditingController nameController,
    TextEditingController feeController,
    ObjectRef<File?> selectedImage,
    ObjectRef<Specialty> selectedSpecialty,
    ValueNotifier<bool> isActive,
    DoctorEntity? doctor,
  ) {
    FocusManager.instance.primaryFocus?.unfocus();
    if (formKey.currentState!.validate()) {
      context.read<UpdateDoctorDetailsBloc>().add(
        UpdateDoctorDetailsRequested(
          image: selectedImage.value,
          name: nameController.text.trim(),
          specialty: selectedSpecialty.value,
          active: isActive.value,
          consultationFee:
              double.tryParse(feeController.text.trim()) ??
              doctor?.consultationFee,
        ),
      );
    }
  }

  Widget _buildText({required BuildContext context, required String text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Text(text, style: context.semiBold14.textTertiary.rubik),
    );
  }
}

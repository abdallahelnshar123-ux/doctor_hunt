import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_hunt/apps/core/router/app_routes.dart';
import 'package:doctor_hunt/apps/core/theme/app_colors.dart';
import 'package:doctor_hunt/apps/core/utils/snack_bar_utils.dart';
import 'package:doctor_hunt/apps/features/admin/update_doctor_details_screen/presentation/controller/update_doctor_details_bloc.dart';
import 'package:doctor_hunt/generated/app_assets.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../generated/style_atoms.dart';
import '../../../../../core/data/models/doctor/doctor.dart';
import '../../../../../core/utils/dialog_utils.dart';
import '../../../../../core/utils/validators.dart';
import '../../../../../core/widgets/app_container_with_shadow.dart';
import '../../../../../core/widgets/custom_text_form_field.dart';
import '../../../../common/auth/presentation/widgets/custom_elevated_button.dart';
import '../../../add_doctor_screen/presentation/widget/specialty_dropdown_widget.dart';

class UpdateDoctorDetailsScreen extends HookWidget {
  const UpdateDoctorDetailsScreen({super.key, required this.doctor});

  final Doctor doctor;

  @override
  Widget build(BuildContext context) {
    final nameController = useTextEditingController(text: doctor.name);
    final feeController = useTextEditingController(
      text: doctor.consultationFee.toString(),
    );
    final isActive = useValueNotifier(doctor.active);
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final selectedImage = useRef<File?>(null);
    final selectedSpecialty = useRef<Specialty>(doctor.specialty);

    return BlocListener<UpdateDoctorDetailsBloc, UpdateDoctorDetailsState>(
      listenWhen: (previous, current) =>
          current is UpdateDoctorDetailsSuccess ||
          current is UpdateDoctorDetailsError ||
          current is UpdateDoctorDetailsLoading ||
          current is DeleteDoctorFromEditLoading ||
          current is DeleteDoctorFromEditError ||
          current is DeleteDoctorFromEditSuccess,
      listener: (context, state) {
        if (state is DeleteDoctorFromEditSuccess) {
          DialogUtils.hideLoading(context: context);
          SnackBarUtils.showSuccessSnackBar(
            context: context,
            message: t.admin.doctor_details_screen.doctor_deleted_successfully,
          );
          const AdminMainRoute().go(context);
        }
        if (state is DeleteDoctorFromEditError) {
          debugPrint(state.message);
          DialogUtils.hideLoading(context: context);
          DialogUtils.showMessage(
            posActionText: t.dialog.ok,
            title: t.dialog.error,
            context: context,
            message: state.message,
          );
        }
        if (state is DeleteDoctorFromEditLoading) {
          DialogUtils.showLoading(context: context);
        }
        if (state is UpdateDoctorDetailsSuccess) {
          DialogUtils.hideLoading(context: context);
          SnackBarUtils.showSuccessSnackBar(
            context: context,
            message:
                t.admin.update_doctor_details.doctor_was_updated_successfully,
          );
          const AdminMainRoute().go(context);
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
        appBar: AppBar(
          title: Text(t.admin.update_doctor_details.edit_doctor),
          centerTitle: true,
        ),
        body: Form(
          key: formKey,
          child: ListView(
            padding: EdgeInsets.all(20),
            children: [
              buildChangeImage(context, selectedImage),
              _buildChangePhotoButton(context),
              SizedBox(height: 20),
              _buildText(
                context: context,
                text: t.admin.add_doctor_screen.doctor_name,
              ),
              CustomTextFormField(
                controller: nameController,
                fillColor: AppColors.bgPrimary,
                filled: true,
                hintText: t.admin.add_doctor_screen.name_example,
                hintStyle: context.light16.textSecondary.rubik,
                style: context.medium16.textTertiary.rubik,
                validator: (value) => Validators.required(value),
              ),
              _buildText(
                context: context,
                text: t.admin.add_doctor_screen.specialty,
              ),
              SpecialtyDropdownWidget(
                initialSelection: doctor.specialty,
                selectedSpecialty: (value) => selectedSpecialty.value = value,
              ),
              _buildText(
                context: context,
                text: t.admin.add_doctor_screen.consultation_fee,
              ),
              CustomTextFormField(
                controller: feeController,
                fillColor: AppColors.bgPrimary,
                filled: true,
                keyboardType: TextInputType.number,
                hintText: t.admin.add_doctor_screen.fee_example,
                hintStyle: context.light16.textSecondary.rubik,
                style: context.medium16.textTertiary.rubik,
                validator: (value) => Validators.required(value),
              ),
              SizedBox(height: 20),
              _buildStatusWidget(context, isActive),
              SizedBox(height: 60),
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
                ),
                child: Row(
                  spacing: 8,
                  mainAxisAlignment: .center,
                  children: [
                    Icon(Icons.check_rounded, color: AppColors.white, size: 20),
                    Text(
                      t.admin.update_doctor_details.save_changes,
                      style: context.semiBold16.white.rubik,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              _buildDeleteButton(context),
              SizedBox(height: 10),
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
        t.admin.update_doctor_details.change_photo,
        style: context.medium12.brandPrimary.rubik,
      ),
    );
  }

  Widget buildChangeImage(
    BuildContext context,
    ObjectRef<File?> selectedImage,
  ) {
    return Container(
      clipBehavior: .antiAlias,
      decoration: BoxDecoration(shape: .circle),
      width: 120,
      height: 120,
      alignment: .center,
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
            return Image.file(state.image, fit: .fitHeight);
          }
          return CachedNetworkImage(
            imageUrl: doctor.imageUrl ?? '',
            fit: .fitHeight,
          );
        },
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
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: ListTile(
            leading: SvgPicture.asset(
              AppAssets.icons.switchIcon.path,
              fit: BoxFit.scaleDown,
              colorFilter: ColorFilter.mode(
                AppColors.brandPrimary,
                BlendMode.srcIn,
              ),
            ),
            title: Text(t.admin.update_doctor_details.doctor_statues),
            titleTextStyle: context.semiBold14.textPrimary.rubik,
            subtitle: Text(
              value
                  ? t.admin.update_doctor_details.active_and_available
                  : t.admin.update_doctor_details.inactive,
            ),
            subtitleTextStyle: context.regular12.textSecondary.rubik,
            trailing: Switch(
              value: value,

              onChanged: (val) {
                isActive.value = val;
              },
              activeThumbColor: AppColors.white,
              activeTrackColor: AppColors.brandPrimary,
              thumbIcon: WidgetStateProperty.resolveWith<Icon?>((
                Set<WidgetState> states,
              ) {
                if (states.contains(WidgetState.selected)) {
                  return Icon(
                    Icons.check_rounded,
                    color: AppColors.brandPrimary,
                  );
                }
                return null;
              }),
            ),
            contentPadding: EdgeInsets.all(0),
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
  ) {
    FocusManager.instance.primaryFocus?.unfocus();
    if (formKey.currentState!.validate()) {
      context.read<UpdateDoctorDetailsBloc>().add(
        UpdateDoctorDetailsRequested(
          image: selectedImage.value,
          doctor: Doctor(
            id: doctor.id,
            name: nameController.text.trim(),
            adminId: doctor.adminId,
            specialty: selectedSpecialty.value,
            active: isActive.value,
            imageUrl: doctor.imageUrl,
            consultationFee:
                double.tryParse(feeController.text.trim()) ??
                doctor.consultationFee,
            rating: doctor.rating,
          ),
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

  Widget _buildDeleteButton(BuildContext context) {
    return TextButton.icon(
      icon: Icon(Icons.delete_outline_rounded),
      style: ButtonStyle(
        iconColor: WidgetStatePropertyAll(AppColors.statusError),
        iconSize: WidgetStatePropertyAll(20),
        textStyle: WidgetStatePropertyAll(context.semiBold14.statusError.rubik),
        foregroundColor: WidgetStatePropertyAll(AppColors.statusError),
      ),

      onPressed: () {
        context.read<UpdateDoctorDetailsBloc>().add(
          DeleteDoctorRequested(doctorId: doctor.id),
        );
      },
      label: Text(t.admin.update_doctor_details.delete_doctor),
    );
  }
}

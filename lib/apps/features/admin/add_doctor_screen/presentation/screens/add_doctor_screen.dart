import 'dart:io';

import 'package:doctor_hunt/apps/core/router/app_routes.dart';
import 'package:doctor_hunt/apps/core/theme/app_colors.dart';
import 'package:doctor_hunt/apps/core/utils/snack_bar_utils.dart';
import 'package:doctor_hunt/apps/features/admin/add_doctor_screen/presentation/controller/doctor_bloc.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/controller/user/user_bloc.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../../core/data/models/doctor/doctor.dart';
import '../../../../../core/utils/dialog_utils.dart';
import '../../../../../core/utils/validators.dart';
import '../../../../../core/widgets/custom_text_form_field.dart';
import '../../../../common/auth/data/models/user/my_user.dart';
import '../../../../common/auth/presentation/widgets/custom_elevated_button.dart';
import '../widget/specialty_dropdown_widget.dart';

class AddDoctorScreen extends HookWidget {
  const AddDoctorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = useTextEditingController();
    final feeController = useTextEditingController();
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final selectedImage = useRef<File?>(null);
    final selectedSpecialty = useRef<Specialty?>(null);
    final user = context.select<UserBloc, MyUser?>((bloc) => bloc.currentUser);
    return BlocListener<DoctorBloc, DoctorState>(
      listenWhen: (previous, current) =>
          current is AddDoctorLoadingState ||
          current is AddDoctorErrorState ||
          current is AddDoctorSuccessState ||
          current is PickDoctorImageErrorState ||
          current is PickDoctorImageSuccessState,
      listener: (context, state) {
        if (state is PickDoctorImageSuccessState) {
          selectedImage.value = state.image;
        }
        if (state is AddDoctorSuccessState) {
          DialogUtils.hideLoading(context: context);
          SnackBarUtils.showSuccessSnackBar(
            context: context,
            message: t.create_doctor.doctor_added_successfully,
          );
          const AdminMainRoute().go(context);
        }
        if (state is AddDoctorErrorState) {
          debugPrint(state.message);
          DialogUtils.hideLoading(context: context);
          DialogUtils.showMessage(
            posActionText: t.dialog.ok,
            title: t.dialog.error,
            context: context,
            message: state.message,
          );
        }
        if (state is AddDoctorLoadingState) {
          DialogUtils.showLoading(context: context);
        }
        if (state is PickDoctorImageErrorState) {
          SnackBarUtils.showErrorSnackBar(
            context: context,
            message: state.message,
          );
        }
      },

      child: Scaffold(
        appBar: AppBar(title: Text(t.create_doctor.title)),
        body: Form(
          key: formKey,
          child: ListView(
            padding: EdgeInsets.all(20),
            children: [
              buildUploadImage(context),
              TextButton(
                onPressed: () {
                  context.read<DoctorBloc>().add(PickDoctorImageRequested());
                },
                child: Text(
                  t.create_doctor.add_photo,
                  style: context.medium12.brandPrimary.rubik,
                ),
              ),
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
                hintStyle: context.light14.textSecondary.rubik,
                style: context.light16.textSecondary.rubik,
                validator: (value) => Validators.required(value),
              ),
              _buildText(
                context: context,
                text: t.admin.add_doctor_screen.specialty,
              ),
              SpecialtyDropdownWidget(
                selectedSpecialty: (value) {
                  selectedSpecialty.value = value;
                },
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
                hintStyle: context.light14.textSecondary.rubik,
                style: context.light16.textSecondary.rubik,
                validator: (value) => Validators.required(value),
              ),

              SizedBox(height: 40),
              _buildCreateDoctorButton(
                context: context,
                formKey: formKey,
                nameController: nameController,
                feeController: feeController,
                selectedImage: selectedImage,
                selectedSpecialty: selectedSpecialty,
                user: user,
              ),
              // CustomElevatedButton(
              //   backgroundColor: AppColors.brandPrimary,
              //   onPressed: () {
              //     FocusManager.instance.primaryFocus?.unfocus();
              //     var adminId = user?.id ?? '';
              //     if (formKey.currentState!.validate()) {
              //       if (selectedImage.value == null) {
              //         SnackBarUtils.showInfoSnackBar(
              //           context: context,
              //           message: t.create_doctor.you_must_pick_doctor_image,
              //         );
              //         return;
              //       }
              //       context.read<DoctorBloc>().add(
              //         AddDoctorRequested(
              //           name: nameController.text.trim(),
              //           specialty: selectedSpecialty.value!,
              //           image: selectedImage.value!,
              //           adminId: adminId,
              //           consultationFee:
              //               double.tryParse(feeController.text.trim()) ?? 0.0,
              //         ),
              //       );
              //     }
              //   },
              //   child: Text(
              //     t.admin.add_doctor_screen.create_doctor,
              //     style: context.medium18.white.rubik,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildText({required BuildContext context, required String text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Text(text, style: context.semiBold14.textTertiary.rubik),
    );
  }

  Widget _buildCreateDoctorButton({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required TextEditingController nameController,
    required TextEditingController feeController,
    required ObjectRef<File?> selectedImage,
    required ObjectRef<Specialty?> selectedSpecialty,
    required MyUser? user,
  }) {
    return CustomElevatedButton(
      backgroundColor: AppColors.brandPrimary,
      onPressed: () {
        FocusManager.instance.primaryFocus?.unfocus();
        var adminId = user?.id ?? '';
        if (formKey.currentState!.validate()) {
          if (selectedImage.value == null) {
            SnackBarUtils.showInfoSnackBar(
              context: context,
              message: t.create_doctor.you_must_pick_doctor_image,
            );
            return;
          }
          context.read<DoctorBloc>().add(
            AddDoctorRequested(
              name: nameController.text.trim(),
              specialty: selectedSpecialty.value!,
              image: selectedImage.value!,
              adminId: adminId,
              consultationFee:
                  double.tryParse(feeController.text.trim()) ?? 0.0,
            ),
          );
        }
      },
      child: Text(
        t.admin.add_doctor_screen.create_doctor,
        style: context.medium18.white.rubik,
      ),
    );
  }

  Widget buildUploadImage(BuildContext context) {
    return Container(
      clipBehavior: .antiAlias,
      decoration: BoxDecoration(shape: .circle),
      width: 120,
      height: 120,
      alignment: .center,
      child: BlocBuilder<DoctorBloc, DoctorState>(
        buildWhen: (previous, current) =>
            current is PickDoctorImageSuccessState,
        builder: (context, state) {
          if (state is PickDoctorImageSuccessState) {
            return Image.file(state.image, fit: .fitHeight);
          }
          return DottedBorder(
            options: CircularDottedBorderOptions(
              padding: EdgeInsets.all(40),
              stackFit: .loose,
              strokeCap: .round,
              dashPattern: const [10, 5],
              color: AppColors.borderMuted,
              strokeWidth: 2,
            ),

            child: Icon(
              Icons.image_outlined,
              size: 35,
              color: AppColors.textSecondary,
            ),
          );
        },
      ),
    );
  }
}

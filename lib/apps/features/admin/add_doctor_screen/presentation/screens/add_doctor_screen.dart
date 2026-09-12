import 'dart:io';

import 'package:doctor_hunt/apps/core/theme/app_colors.dart';
import 'package:doctor_hunt/apps/core/utils/snack_bar_utils.dart';
import 'package:doctor_hunt/apps/core/widgets/username_text_field_widget.dart';
import 'package:doctor_hunt/apps/features/admin/add_doctor_screen/presentation/controller/doctor_bloc.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/controller/auth_bloc.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../generated/style_atoms.dart';
import '../../../../../core/utils/dialog_utils.dart';
import '../../../../common/auth/presentation/widgets/custom_elevated_button.dart';
import '../../data/models/doctor/doctor.dart';
import '../widget/specialty_dropdown_widget.dart';

class AddDoctorScreen extends StatefulWidget {
  const AddDoctorScreen({super.key});

  @override
  State<AddDoctorScreen> createState() => _AddDoctorScreenState();
}

class _AddDoctorScreenState extends State<AddDoctorScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController specialtyController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  File? selectedImage;

  @override
  Widget build(BuildContext context) {
    return BlocListener<DoctorBloc, DoctorState>(
      listenWhen: (previous, current) =>
          current is AddDoctorLoadingState ||
          current is AddDoctorErrorState ||
          current is AddDoctorSuccessState,
      listener: (context, state) {
        if (state is AddDoctorSuccessState) {
          DialogUtils.hideLoading(context: context);
          SnackBarUtils.showSuccessSnackBar(
            context: context,
            message: t.create_doctor.doctor_added_successfully,
          );
          context.pop();
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
              SizedBox(height: 40),
              UsernameTextFieldWidget(
                controller: nameController,
                fillColor: AppColors.bgPrimary,
                hintText: t.admin.add_doctor_screen.enter_name,
              ),
              SizedBox(height: 20),
              SpecialtyDropdownWidget(controller: specialtyController),
              SizedBox(height: 50),
              SizedBox(height: 50),
              CustomElevatedButton(
                backgroundColor: AppColors.brandPrimary,
                onPressed: () {
                  var adminId = context.read<AuthBloc>().currentUser!.id;

                  debugPrint('============================');
                  debugPrint(adminId);
                  debugPrint('============================');
                  if (formKey.currentState!.validate()) {
                    if (selectedImage == null) {
                      SnackBarUtils.showInfoSnackBar(
                        context: context,
                        message: t.create_doctor.you_must_pick_doctor_image,
                      );
                      return;
                    }
                    context.read<DoctorBloc>().add(
                      AddDoctorRequested(
                        name: nameController.text.trim(),
                        specialty: Specialties.values.firstWhere(
                          (element) => element.name == specialtyController.text,
                        ),
                        image: selectedImage!,
                        adminId: adminId,
                      ),
                    );
                  }
                },
                child: Text(
                  t.admin.add_doctor_screen.create_doctor,
                  style: context.medium18.white.rubik,
                ),
              ),
            ],
          ),
        ),
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
      child: BlocConsumer<DoctorBloc, DoctorState>(
        listener: (context, state) {
          if (state is PickDoctorImageErrorState) {
            SnackBarUtils.showErrorSnackBar(
              context: context,
              message: state.message,
            );
          }
        },
        buildWhen: (previous, current) =>
            current is PickDoctorImageSuccessState,
        builder: (context, state) {
          if (state is PickDoctorImageSuccessState) {
            selectedImage = state.image;
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

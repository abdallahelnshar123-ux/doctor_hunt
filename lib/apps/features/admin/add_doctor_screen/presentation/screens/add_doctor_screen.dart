import 'package:doctor_hunt/apps/core/presentation/controller/user/user_bloc.dart';
import 'package:doctor_hunt/apps/core/router/app_routes.dart';
import 'package:doctor_hunt/apps/core/theme/app_colors.dart';
import 'package:doctor_hunt/apps/core/utils/snack_bar_utils.dart';
import 'package:doctor_hunt/apps/features/admin/add_doctor_screen/presentation/controller/add_doctors_bloc.dart';
import 'package:doctor_hunt/apps/features/admin/add_doctor_screen/presentation/widget/add_specialty_dialog.dart';
import 'package:doctor_hunt/apps/features/common/specialties/data/models/specialty_model.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../../core/utils/dialog_utils.dart';
import '../../../../../core/utils/validators.dart';
import '../../../../../core/widgets/custom_text_form_field.dart';
import '../../../../common/auth/domain/entity/user/app_user.dart';
import '../../../../common/auth/presentation/widgets/custom_elevated_button.dart';
import '../../../../common/auth/presentation/widgets/custom_text_password.dart';
import '../widget/specialty_dropdown_widget.dart';

part '../widget/add_specialty_button.dart';

class AddDoctorScreen extends HookWidget {
  const AddDoctorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = useTextEditingController();
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final selectedSpecialty = useRef<SpecialtyModel?>(null);
    final user = context.select<UserBloc, AppUserEntity?>(
      (bloc) => bloc.currentUser,
    );
    return BlocListener<AddDoctorsBloc, AddDoctorsState>(
      listenWhen: (previous, current) =>
          current is AddDoctorLoadingState ||
          current is AddDoctorErrorState ||
          current is AddDoctorSuccessState,
      listener: (context, state) {
        if (state is AddDoctorSuccessState) {
          DialogUtils.hideLoading(context: context);
          SnackBarUtils.showSuccessSnackBar(
            context: context,
            message: t.createDoctor.doctorAddedSuccessfully,
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
      },

      child: Scaffold(
        appBar: AppBar(title: Text(t.createDoctor.title)),
        body: Form(
          key: formKey,
          child: ListView(
            padding: EdgeInsets.all(20),
            children: [
              SizedBox(height: 20),
              _buildText(
                context: context,
                text: t.admin.addDoctorScreen.doctorName,
              ),
              CustomTextFormField(
                controller: nameController,
                fillColor: AppColors.bgPrimary,
                filled: true,
                hintText: t.admin.addDoctorScreen.nameExample,
                hintStyle: context.light14.textSecondary.rubik,
                style: context.light16.textSecondary.rubik,
                validator: (value) => Validators.required(value),
              ),
              _buildText(context: context, text: t.admin.addDoctorScreen.email),
              CustomTextFormField(
                controller: emailController,
                fillColor: AppColors.bgPrimary,
                filled: true,
                keyboardType: TextInputType.emailAddress,
                hintText: t.admin.addDoctorScreen.emailExample,
                hintStyle: context.light14.textSecondary.rubik,
                style: context.light16.textSecondary.rubik,
                validator: (value) => Validators.email(value),
              ),
              _buildText(
                context: context,
                text: t.admin.addDoctorScreen.password,
              ),
              CustomTextPassword(
                controller: passwordController,
                fillColor: AppColors.bgPrimary,
                filled: true,
                hintText: t.admin.addDoctorScreen.passwordExample,
                hintStyle: context.light14.textSecondary.rubik,
                style: context.light16.textSecondary.rubik,
                validator: (value) => Validators.password(value),
              ),
              _buildText(
                context: context,
                text: t.admin.addDoctorScreen.specialty,
              ),
              Row(
                spacing: 15,
                children: [
                  Expanded(
                    child: SpecialtyDropdownWidget(
                      selectedSpecialty: (value) {
                        selectedSpecialty.value = value;
                      },
                    ),
                  ),
                  const AddSpecialtyButton(),
                ],
              ),
              SizedBox(height: 40),
              _buildCreateDoctorButton(
                context: context,
                formKey: formKey,
                nameController: nameController,
                emailController: emailController,
                passwordController: passwordController,
                selectedSpecialty: selectedSpecialty,
                user: user,
              ),
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
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required ObjectRef<SpecialtyModel?> selectedSpecialty,
    required AppUserEntity? user,
  }) {
    return CustomElevatedButton(
      backgroundColor: AppColors.brandPrimary,
      onPressed: () {
        FocusManager.instance.primaryFocus?.unfocus();
        var adminId = user?.id ?? '';
        if (formKey.currentState!.validate()) {
          if (selectedSpecialty.value == null) {
            SnackBarUtils.showInfoSnackBar(
              context: context,
              message: t.admin.addDoctorScreen.selectSpecialty,
            );
            return;
          }
          context.read<AddDoctorsBloc>().add(
            AddDoctorRequested(
              name: nameController.text.trim(),
              email: emailController.text.trim(),
              password: passwordController.text,
              specialty: selectedSpecialty.value!,
              adminId: adminId,
            ),
          );
        }
      },
      child: Text(
        t.admin.addDoctorScreen.createDoctor,
        style: context.medium18.white.rubik,
      ),
    );
  }
}

import 'dart:io';

import 'package:doctor_hunt/apps/core/theme/app_colors.dart';
import 'package:doctor_hunt/apps/core/utils/validators.dart';
import 'package:doctor_hunt/apps/core/widgets/custom_text_form_field.dart';
import 'package:doctor_hunt/apps/features/common/auth/domain/entity/user/admin.dart';
import 'package:doctor_hunt/apps/features/common/auth/domain/entity/user/app_user.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/widgets/custom_elevated_button.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:doctor_hunt/apps/core/presentation/controller/user/user_bloc.dart';
import 'package:doctor_hunt/apps/core/presentation/controller/user/user_event.dart';

class AdminProfileFormWidget extends HookWidget {
  const AdminProfileFormWidget({
    super.key,
    required this.user,
    required this.selectedImageNotifier,
  });

  final AppUserEntity user;
  final ValueNotifier<File?> selectedImageNotifier;

  @override
  Widget build(BuildContext context) {
    final nameController = useTextEditingController(text: user.name);
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final hasChanges = useValueNotifier<bool>(false);

    useEffect(() {
      void checkForChanges() {
        final isNameChanged = nameController.text.trim() != user.name;
        final isImageChanged = selectedImageNotifier.value != null;
        hasChanges.value = isNameChanged || isImageChanged;
      }

      nameController.addListener(checkForChanges);
      selectedImageNotifier.addListener(checkForChanges);

      return () {
        nameController.removeListener(checkForChanges);
        selectedImageNotifier.removeListener(checkForChanges);
      };
    }, [user]);

    return Form(
      key: formKey,
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              Text(
                t.admin.profileScreen.fullName,
                style: context.semiBold12.textPrimary.rubik,
              ),
              CustomTextFormField(
                controller: nameController,
                prefixIcon: const Icon(
                  Icons.person_2_outlined,
                  color: AppColors.textSecondary,
                ),
                hintText: t.admin.profileScreen.fullName,
                hintStyle: context.regular12.textSecondary.rubik,
                validator: (value) => Validators.required(value),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              Text(
                t.admin.profileScreen.emailAddress,
                style: context.semiBold12.textPrimary.rubik,
              ),
              CustomTextFormField(
                initialValue: user.email,
                prefixIcon: const Icon(
                  Icons.email_outlined,
                  color: AppColors.textSecondary,
                ),
                readOnly: true,
                style: context.regular16.textSecondary.rubik,
                filled: true,
                fillColor: AppColors.borderMuted,
              ),
            ],
          ),
          const SizedBox(height: 50),
          ValueListenableBuilder<bool>(
            valueListenable: hasChanges,
            builder: (context, showButton, child) {
              return Visibility(
                visible: showButton,
                child: CustomElevatedButton(
                  backgroundColor: AppColors.brandPrimary,
                  onPressed: () => _onSavePressed(
                    context: context,
                    formKey: formKey,
                    nameController: nameController,
                  ),
                  child: Row(
                    spacing: 8,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.check_rounded,
                        color: AppColors.white,
                        size: 20,
                      ),
                      Text(
                        t.admin.updateDoctorDetails.saveChanges,
                        style: context.semiBold16.white.rubik,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _onSavePressed({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required TextEditingController nameController,
  }) {
    FocusManager.instance.primaryFocus?.unfocus();
    if (formKey.currentState?.validate() ?? false) {
      final updatedUser = AdminEntity(
        name: nameController.text.trim(),
        email: user.email,
        id: user.id,
        provider: user.provider,
        image: user.image,
        phone: user.phone,
      );
      context.read<UserBloc>().add(
        UpdateUserProfileEvent(
          user: updatedUser,
          image: selectedImageNotifier.value,
        ),
      );
    }
  }
}

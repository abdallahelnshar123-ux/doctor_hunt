import 'dart:io';

import 'package:doctor_hunt/apps/core/utils/validators.dart';
import 'package:doctor_hunt/apps/core/widgets/profile_save_button.dart';
import 'package:doctor_hunt/apps/core/widgets/profile_text_form_widget.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../common/auth/domain/entity/user/app_user.dart';
import '../../../../common/auth/domain/entity/user/patient.dart';
import '../controller/patient_profile_bloc.dart';

class PatientProfileFormWidget extends HookWidget {
  const PatientProfileFormWidget({
    super.key,
    required this.user,
    required this.selectedImageNotifier,
  });

  final AppUserEntity user;
  final ValueNotifier<File?> selectedImageNotifier;

  @override
  Widget build(BuildContext context) {
    final nameController = useTextEditingController(text: user.name);
    final phoneController = useTextEditingController(text: user.phone ?? '');
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final hasChanges = useValueNotifier<bool>(false);

    useEffect(() {
      void checkForChanges() {
        final isNameChanged = nameController.text.trim() != user.name;
        final isPhoneChanged =
            phoneController.text.trim() != (user.phone ?? '');
        final isImageChanged = selectedImageNotifier.value != null;
        hasChanges.value = isNameChanged || isPhoneChanged || isImageChanged;
      }

      nameController.addListener(checkForChanges);
      phoneController.addListener(checkForChanges);
      selectedImageNotifier.addListener(checkForChanges);

      return () {
        nameController.removeListener(checkForChanges);
        phoneController.removeListener(checkForChanges);
        selectedImageNotifier.removeListener(checkForChanges);
      };
    }, [user]);

    return Form(
      key: formKey,
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        children: [
          const SizedBox(height: 10),
          ProfileTextFormWidget(
            label: t.profile.name,
            controller: nameController,
            validator: (value) => Validators.required(value),
          ),
          const SizedBox(height: 10),
          ProfileTextFormWidget(
            hintText: t.profile.addPhoneNumber,
            label: t.profile.phone,
            controller: phoneController,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return null;
              }
              return Validators.phone(value);
            },
          ),
          const SizedBox(height: 50),
          ProfileSaveButton(
            onPressed: () => _onSavePressed(
              context: context,
              formKey: formKey,
              nameController: nameController,
              phoneController: phoneController,
            ),
            valueListenable: hasChanges,
          ),
          // ValueListenableBuilder<bool>(
          //   valueListenable: hasChanges,
          //   builder: (context, showButton, child) {
          //     return Visibility(
          //       visible: showButton,
          //       child: CustomElevatedButton(
          //         backgroundColor: AppColors.brandPrimary,
          //         onPressed: () =>
          //             _onSavePressed(
          //               context: context,
          //               formKey: formKey,
          //               nameController: nameController,
          //               phoneController: phoneController,
          //             ),
          //         child: Row(
          //           spacing: 8,
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [
          //             const Icon(
          //               Icons.check_rounded,
          //               color: AppColors.white,
          //               size: 20,
          //             ),
          //             Text(
          //               t.admin.updateDoctorDetails.saveChanges,
          //               style: context.semiBold16.white.rubik,
          //             ),
          //           ],
          //         ),
          //       ),
          //     );
          //   },
          // ),
        ],
      ),
    );
  }

  void _onSavePressed({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required TextEditingController nameController,
    required TextEditingController phoneController,
  }) {
    FocusManager.instance.primaryFocus?.unfocus();
    if (formKey.currentState?.validate() ?? false) {
      final updatedUser = PatientEntity(
        name: nameController.text.trim(),
        email: user.email,
        phone: phoneController.text.trim(),
        id: user.id,
        provider: user.provider,
        image: user.image,
        favDoctors: (user as PatientEntity).favDoctors,
        disabled: (user as PatientEntity).disabled,
      );
      context.read<PatientProfileBloc>().add(
        PatientProfileUpdateRequested(
          user: updatedUser,
          image: selectedImageNotifier.value,
        ),
      );
    }
  }
}

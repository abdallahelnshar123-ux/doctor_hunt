import 'dart:io';

import 'package:doctor_hunt/apps/core/utils/validators.dart';
import 'package:doctor_hunt/apps/core/widgets/profile_save_button.dart';
import 'package:doctor_hunt/apps/core/widgets/profile_text_form_widget.dart';
import 'package:doctor_hunt/apps/features/common/auth/domain/entity/user/doctor.dart';
import 'package:doctor_hunt/apps/features/common/specialties/data/models/specialty_model.dart';
import 'package:doctor_hunt/apps/core/presentation/controller/user/user_bloc.dart';
import 'package:doctor_hunt/apps/core/presentation/controller/user/user_event.dart';
import 'package:doctor_hunt/apps/features/doctor/doctor_profile_screen/widget/profile_dropdown_widget.dart';
import 'package:doctor_hunt/apps/features/doctor/doctor_profile_screen/widget/profile_status_widget.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class DoctorProfileFormWidget extends HookWidget {
  const DoctorProfileFormWidget({
    super.key,
    required this.user,
    required this.selectedImageNotifier,
  });

  final DoctorEntity user;
  final ValueNotifier<File?> selectedImageNotifier;

  @override
  Widget build(BuildContext context) {
    final nameController = useTextEditingController(text: user.name);
    final feeController = useTextEditingController(
      text: user.consultationFee.toString(),
    );
    final phoneController = useTextEditingController(text: user.phone ?? '');
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final hasChanges = useValueNotifier<bool>(false);
    final selectedSpecialty = useValueNotifier<SpecialtyModel>(user.specialty);
    final isActive = useValueNotifier<bool>(user.active);

    useEffect(() {
      void checkForChanges() {
        final isNameChanged = nameController.text.trim() != user.name;
        final isPhoneChanged =
            phoneController.text.trim() != (user.phone ?? '');
        final isFeeChanged =
            feeController.text.trim() != user.consultationFee.toString();
        final isSpecialtyChanged =
            selectedSpecialty.value.id != user.specialty.id;
        final isImageChanged = selectedImageNotifier.value != null;
        final isStatusChanged = isActive.value != user.active;

        hasChanges.value =
            isNameChanged ||
            isPhoneChanged ||
            isFeeChanged ||
            isSpecialtyChanged ||
            isImageChanged ||
            isStatusChanged;
      }

      nameController.addListener(checkForChanges);
      phoneController.addListener(checkForChanges);
      feeController.addListener(checkForChanges);
      selectedSpecialty.addListener(checkForChanges);
      isActive.addListener(checkForChanges);
      selectedImageNotifier.addListener(checkForChanges);

      return () {
        nameController.removeListener(checkForChanges);
        phoneController.removeListener(checkForChanges);
        feeController.removeListener(checkForChanges);
        selectedSpecialty.removeListener(checkForChanges);
        isActive.removeListener(checkForChanges);
        selectedImageNotifier.removeListener(checkForChanges);
      };
    }, [user]);

    return Form(
      key: formKey,
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        children: [
          const SizedBox(height: 20),
          ProfileTextFormWidget(
            label: t.profile.name,
            controller: nameController,
            validator: (value) => Validators.required(value),
          ),
          const SizedBox(height: 20),
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
          const SizedBox(height: 20),
          ProfileDropdownWidget(
            label: t.doctor.profile.speciality,
            initialSpeciality: selectedSpecialty.value.id,
            selectedSpeciality: selectedSpecialty,
          ),
          const SizedBox(height: 20),
          ProfileTextFormWidget(
            hintText: t.doctor.profile.fee,
            label: t.doctor.profile.fee,
            controller: feeController,
            validator: (value) => Validators.required(value),
          ),
          const SizedBox(height: 20),
          ProfileStatusWidget(
            isActive: isActive,
            onChanged: (value) => isActive.value = value,
          ),
          const SizedBox(height: 50),
          ProfileSaveButton(
            onPressed: () => _onSavePressed(
              context: context,
              formKey: formKey,
              nameController: nameController,
              phoneController: phoneController,
              feeController: feeController,
              selectedSpecialty: selectedSpecialty,
              isActive: isActive,
            ),
            valueListenable: hasChanges,
          ),
        ],
      ),
    );
  }

  void _onSavePressed({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required TextEditingController nameController,
    required TextEditingController phoneController,
    required TextEditingController feeController,
    required ValueNotifier<SpecialtyModel> selectedSpecialty,
    required ValueNotifier<bool> isActive,
  }) {
    FocusManager.instance.primaryFocus?.unfocus();
    if (formKey.currentState?.validate() ?? false) {
      final updatedUser = user.copyWith(
        name: nameController.text.trim(),
        phone: phoneController.text.trim(),
        specialty: selectedSpecialty.value,
        consultationFee: double.tryParse(feeController.text.trim()),
        active: isActive.value,
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

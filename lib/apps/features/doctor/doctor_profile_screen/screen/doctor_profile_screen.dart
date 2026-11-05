import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_hunt/apps/core/extensions/context_extensions.dart';
import 'package:doctor_hunt/apps/core/router/app_routes.dart';
import 'package:doctor_hunt/apps/core/theme/app_colors.dart';
import 'package:doctor_hunt/apps/core/utils/dialog_utils.dart';
import 'package:doctor_hunt/apps/core/utils/snack_bar_utils.dart';
import 'package:doctor_hunt/apps/core/widgets/app_scaffold.dart';
import 'package:doctor_hunt/apps/features/common/auth/domain/entity/user/doctor.dart';
import 'package:doctor_hunt/apps/features/doctor/doctor_profile_screen/controller/doctor_profile_bloc.dart';
import 'package:doctor_hunt/apps/features/doctor/doctor_profile_screen/controller/doctor_profile_event.dart';
import 'package:doctor_hunt/apps/features/doctor/doctor_profile_screen/widget/profile_dropdown_widget.dart';
import 'package:doctor_hunt/apps/features/doctor/doctor_profile_screen/widget/profile_status_widget.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../../../../generated/app_assets.dart';
import '../../../../../../../generated/style_atoms.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/main_app_bar.dart';
import '../../../../core/widgets/profile_text_form_widget.dart';
import '../../../common/auth/presentation/widgets/custom_elevated_button.dart';
import '../../../common/specialties/data/models/specialty_model.dart';
import '../controller/doctor_profile_state.dart';

class DoctorProfileScreen extends HookWidget {
  const DoctorProfileScreen({super.key, required this.user});

  final DoctorEntity user;

  @override
  Widget build(BuildContext context) {
    final nameController = useTextEditingController(text: user.name);
    final feeController = useTextEditingController(
      text: user.consultationFee.toString(),
    );
    final phoneController = useTextEditingController(text: user.phone ?? '');
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final selectedImage = useRef<File?>(null);
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
        final isImageChanged = selectedImage.value != null;
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

      return () {
        nameController.removeListener(checkForChanges);
        phoneController.removeListener(checkForChanges);
        feeController.removeListener(checkForChanges);
        selectedSpecialty.removeListener(checkForChanges);
        isActive.removeListener(checkForChanges);
      };
    }, [user]);

    return BlocListener<DoctorProfileBloc, DoctorProfileState>(
      listenWhen: (previous, current) =>
          current is UpdateDoctorDetailsLoading ||
          current is UpdateDoctorDetailsSuccess ||
          current is UpdateDoctorDetailsError ||
          current is PickDoctorUpdateImageErrorState,
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
            _buildImageWidget(selectedImage, hasChanges),
            _buildProfileForm(
              context: context,
              formKey: formKey,
              nameController: nameController,
              phoneController: phoneController,
              feeController: feeController,
              hasChanges: hasChanges,
              selectedImage: selectedImage,
              selectedSpecialty: selectedSpecialty,
              isActive: isActive,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageWidget(
    ObjectRef<File?> selectedImage,
    ValueNotifier<bool> hasChanges,
  ) {
    return Container(
      padding: const EdgeInsets.all(15),
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: AppColors.brandPrimary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: BlocConsumer<DoctorProfileBloc, DoctorProfileState>(
        listenWhen: (previous, current) =>
            current is PickDoctorUpdateImageSuccessState,
        listener: (context, state) {
          if (state is PickDoctorUpdateImageSuccessState) {
            selectedImage.value = state.image;
            hasChanges.value = true;
          }
        },
        builder: (context, state) {
          final imageFile = selectedImage.value;
          ImageProvider avatarImage;
          if (imageFile != null) {
            avatarImage = FileImage(imageFile);
          } else if (user.image != null && user.image!.isNotEmpty) {
            avatarImage = CachedNetworkImageProvider(user.image!);
          } else {
            avatarImage = AssetImage(AppAssets.images.fallbackUserImage.path);
          }

          return GestureDetector(
            onTap: () {
              context.read<DoctorProfileBloc>().add(
                const PickDoctorUpdateImageRequested(),
              );
            },
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  width: context.width * 0.4,
                  height: context.width * 0.4,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.brandPrimary20,
                    image: DecorationImage(
                      image: avatarImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.profileBlack,
                  ),
                  child: const Icon(
                    Icons.camera_alt_rounded,
                    color: AppColors.white,
                    size: 20,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileForm({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required TextEditingController nameController,
    required TextEditingController phoneController,
    required TextEditingController feeController,
    required ValueNotifier<bool> hasChanges,
    required ObjectRef<File?> selectedImage,
    required ValueNotifier<SpecialtyModel> selectedSpecialty,
    required ValueNotifier<bool> isActive,
  }) {
    return Expanded(
      child: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          children: [
            Text(
              t.profile.personalInformation,
              style: context.medium18.textPrimary.rubik,
            ),
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
              label: t.doctor.doctorProfileScreen.speciality,
              initialSpeciality: selectedSpecialty.value.id,
              selectedSpeciality: selectedSpecialty,
            ),
            const SizedBox(height: 20),
            ProfileTextFormWidget(
              hintText: t.doctor.doctorProfileScreen.fee,
              label: t.doctor.doctorProfileScreen.fee,
              controller: feeController,
              validator: (value) => Validators.required(value),
            ),
            const SizedBox(height: 20),
            ProfileStatusWidget(
              isActive: isActive,
              onChanged: (value) => isActive.value = value,
            ),
            const SizedBox(height: 50),
            ValueListenableBuilder<bool>(
              valueListenable: hasChanges,
              builder: (context, showButton, child) {
                return Visibility(
                  visible: showButton,
                  child: CustomElevatedButton(
                    backgroundColor: AppColors.brandPrimary,
                    onPressed: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      if (formKey.currentState?.validate() ?? false) {
                        final updatedUser = user.copyWith(
                          name: nameController.text.trim(),
                          phone: phoneController.text.trim(),
                          specialty: selectedSpecialty.value,
                          consultationFee: double.tryParse(
                            feeController.text.trim(),
                          ),
                          active: isActive.value,
                        );
                        context.read<DoctorProfileBloc>().add(
                          UpdateDoctorDetailsRequested(
                            updatedDoctor: updatedUser,
                            image: selectedImage.value,
                          ),
                        );
                      }
                    },
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
      ),
    );
  }
}

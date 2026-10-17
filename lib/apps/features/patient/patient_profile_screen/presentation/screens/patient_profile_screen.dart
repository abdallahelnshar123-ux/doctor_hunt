import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_hunt/apps/core/extensions/context_extensions.dart';
import 'package:doctor_hunt/apps/core/router/app_routes.dart';
import 'package:doctor_hunt/apps/core/theme/app_colors.dart';
import 'package:doctor_hunt/apps/core/utils/dialog_utils.dart';
import 'package:doctor_hunt/apps/core/utils/snack_bar_utils.dart';
import 'package:doctor_hunt/apps/core/widgets/app_container_with_shadow.dart';
import 'package:doctor_hunt/apps/core/widgets/app_scaffold.dart';
import 'package:doctor_hunt/apps/core/widgets/custom_text_form_field.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/models/user/my_user.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/controller/auth/auth_bloc.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../../../generated/app_assets.dart';
import '../../../../../../generated/style_atoms.dart';
import '../../../../../core/utils/validators.dart';
import '../../../../../core/widgets/main_app_bar.dart';
import '../../../../common/auth/presentation/controller/auth/auth_event.dart';
import '../../../../common/auth/presentation/widgets/custom_elevated_button.dart';
import '../controller/patient_profile_bloc.dart';

part '../widget/text_form_widget.dart';

class PatientProfileScreen extends HookWidget {
  const PatientProfileScreen({super.key, required this.user});

  final MyUser user;

  @override
  Widget build(BuildContext context) {
    final nameController = useTextEditingController(text: user.name);
    final phoneController = useTextEditingController(text: user.phone ?? '');
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final selectedImage = useRef<File?>(null);
    final hasChanges = useValueNotifier<bool>(false);

    useEffect(() {
      void checkForChanges() {
        final isNameChanged = nameController.text.trim() != user.name;
        final isPhoneChanged =
            phoneController.text.trim() != (user.phone ?? '');
        final isImageChanged = selectedImage.value != null;
        hasChanges.value = isNameChanged || isPhoneChanged || isImageChanged;
      }

      nameController.addListener(checkForChanges);
      phoneController.addListener(checkForChanges);

      return () {
        nameController.removeListener(checkForChanges);
        phoneController.removeListener(checkForChanges);
      };
    }, [user]);

    return BlocListener<PatientProfileBloc, PatientProfileState>(
      listenWhen: (previous, current) =>
          current is PatientProfileLoading ||
          current is PatientProfileUpdateSuccess ||
          current is PatientProfileUpdateError ||
          current is PickPatientImageErrorState,
      listener: (context, state) {
        if (state is PatientProfileLoading) {
          DialogUtils.showLoading(context: context);
        }
        if (state is PatientProfileUpdateError) {
          DialogUtils.hideLoading(context: context);
          SnackBarUtils.showErrorSnackBar(
            context: context,
            message: state.message,
          );
        }
        if (state is PickPatientImageErrorState) {
          SnackBarUtils.showErrorSnackBar(
            context: context,
            message: state.message,
          );
        }
        if (state is PatientProfileUpdateSuccess) {
          DialogUtils.hideLoading(context: context);
          SnackBarUtils.showSuccessSnackBar(
            context: context,
            message: t.profile.data_was_updated_successfully,
          );
          context.read<AuthBloc>().add(CheckAuthStatusRequested());
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
              hasChanges: hasChanges,
              selectedImage: selectedImage,
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
      child: BlocConsumer<PatientProfileBloc, PatientProfileState>(
        listenWhen: (previous, current) =>
            current is PickPatientImageSuccessState,
        listener: (context, state) {
          if (state is PickPatientImageSuccessState) {
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
              context.read<PatientProfileBloc>().add(
                const PickPatientProfileImageRequested(),
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
    required ValueNotifier<bool> hasChanges,
    required ObjectRef<File?> selectedImage,
  }) {
    return Expanded(
      child: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          children: [
            Text(
              t.profile.personal_information,
              style: context.medium18.textPrimary.rubik,
            ),
            const SizedBox(height: 10),
            TextFormWidget(
              label: t.profile.name,
              controller: nameController,
              validator: (value) => Validators.required(value),
            ),
            const SizedBox(height: 10),
            TextFormWidget(
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
                        );
                        context.read<PatientProfileBloc>().add(
                          PatientProfileUpdateRequested(
                            user: updatedUser,
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
                          t.admin.update_doctor_details.save_changes,
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

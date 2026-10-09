import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_hunt/apps/core/extensions/context_extensions.dart';
import 'package:doctor_hunt/apps/core/router/app_routes.dart';
import 'package:doctor_hunt/apps/core/theme/app_colors.dart';
import 'package:doctor_hunt/apps/core/utils/dialog_utils.dart';
import 'package:doctor_hunt/apps/core/utils/snack_bar_utils.dart';
import 'package:doctor_hunt/apps/core/widgets/app_container_with_shadow.dart';
import 'package:doctor_hunt/apps/core/widgets/custom_text_form_field.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/models/user/my_user.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/controller/auth/auth_bloc.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../../../generated/app_assets.dart';
import '../../../../../../generated/style_atoms.dart';
import '../../../../common/auth/presentation/controller/auth/auth_event.dart';
import '../../../../common/auth/presentation/widgets/custom_elevated_button.dart';
import '../controller/admin_profile_bloc.dart';

part '../widget/text_form_widget.dart';

class AdminProfileScreen extends HookWidget {
  const AdminProfileScreen({super.key, required this.user});

  final MyUser user;

  @override
  Widget build(BuildContext context) {
    final nameController = useTextEditingController(text: user.name);
    // final phoneController = useTextEditingController(text: user.phone ?? '');
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final selectedImage = useRef<File?>(null);
    final hasChanges = useValueNotifier<bool>(false);

    useEffect(() {
      void checkForChanges() {
        final isNameChanged = nameController.text.trim() != user.name;
        // final isPhoneChanged =
        //     phoneController.text.trim() != (user.phone ?? '');
        final isImageChanged = selectedImage.value != null;
        hasChanges.value = isNameChanged || isImageChanged;
      }

      nameController.addListener(checkForChanges);
      // phoneController.addListener(checkForChanges);

      return () {
        nameController.removeListener(checkForChanges);
        // phoneController.removeListener(checkForChanges);
      };
    }, [user]);

    return BlocListener<AdminProfileBloc, AdminProfileState>(
      listenWhen: (previous, current) =>
          current is AdminProfileLoading ||
          current is AdminProfileUpdateSuccess ||
          current is AdminProfileUpdateError ||
          current is PickAdminImageErrorState,
      listener: (context, state) {
        if (state is AdminProfileLoading) {
          DialogUtils.showLoading(context: context);
        }
        if (state is AdminProfileUpdateError) {
          DialogUtils.hideLoading(context: context);
          SnackBarUtils.showErrorSnackBar(
            context: context,
            message: state.message,
          );
        }
        if (state is PickAdminImageErrorState) {
          SnackBarUtils.showErrorSnackBar(
            context: context,
            message: state.message,
          );
        }
        if (state is AdminProfileUpdateSuccess) {
          DialogUtils.hideLoading(context: context);
          SnackBarUtils.showSuccessSnackBar(
            context: context,
            message: t.profile.data_was_updated_successfully,
          );
          context.read<AuthBloc>().add(CheckAuthStatusRequested());
          const AdminMainRoute().go(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(t.admin.profile_screen.title),
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // MainAppBar(
            //   backgroundColor: AppColors.brandPrimary,
            //   title: t.profile.title,
            //   titleStyle: context.bold18.white.rubik,
            // ),
            SizedBox(height: 40),
            _buildImageWidget(selectedImage, hasChanges),
            _buildProfileForm(
              context: context,
              formKey: formKey,
              nameController: nameController,
              // phoneController: phoneController,
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
    return BlocConsumer<AdminProfileBloc, AdminProfileState>(
      listenWhen: (previous, current) => current is PickAdminImageSuccessState,
      listener: (context, state) {
        if (state is PickAdminImageSuccessState) {
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
            context.read<AdminProfileBloc>().add(
              const PickAdminProfileImageRequested(),
            );
          },
          child: Center(
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  width: context.width * 0.35,
                  height: context.width * 0.35,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.brandPrimary20,
                    border: Border.all(color: AppColors.brandPrimary, width: 2),
                    image: DecorationImage(
                      image: avatarImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  // margin: const EdgeInsets.only(bottom: 0),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.white, width: 2),

                    color: AppColors.brandPrimary,
                  ),
                  child: const Icon(
                    Icons.camera_alt_rounded,
                    color: AppColors.white,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildProfileForm({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required TextEditingController nameController,
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
              t.admin.profile_screen.full_name,
              style: context.semiBold12.textPrimary.rubik,
            ),
            const SizedBox(height: 10),
            CustomTextFormField(
              controller: nameController,
              prefixIcon: Icon(Icons.person_2_outlined,color: AppColors.textSecondary),
              hintText: t.admin.profile_screen.full_name,
              hintStyle: context.regular12.textSecondary.rubik,
            ),
            // TextFormWidget(
            //   label: t.profile.name,
            //   controller: nameController,
            //   validator: (value) => Validators.required(value),
            // ),
            const SizedBox(height: 10),

            // TextFormWidget(
            //   label: t.profile.phone,
            //   controller: phoneController,
            //   validator: (value) {
            //     if (value == null || value.trim().isEmpty) {
            //       return null;
            //     }
            //     return Validators.phone(value);
            //   },
            // ),
            Text(
              t.admin.profile_screen.email_address,
              style: context.semiBold12.textPrimary.rubik,
            ),
            const SizedBox(height: 10),
            CustomTextFormField(
              initialValue: user.email,
              prefixIcon: Icon(Icons.email_outlined,color: AppColors.textSecondary,),
              readOnly: true,
              style: context.regular16.textSecondary.rubik,
              filled: true,
              fillColor: AppColors.borderMuted,
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
                          // phone: phoneController.text.trim(),
                        );
                        context.read<AdminProfileBloc>().add(
                          AdminProfileUpdateRequested(
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

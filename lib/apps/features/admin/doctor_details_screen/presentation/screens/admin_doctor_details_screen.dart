import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_hunt/apps/core/router/app_routes.dart';
import 'package:doctor_hunt/apps/core/theme/app_colors.dart';
import 'package:doctor_hunt/apps/core/widgets/app_container_with_shadow.dart';
import 'package:doctor_hunt/apps/core/data/models/doctor/doctor.dart';
import 'package:doctor_hunt/apps/features/admin/doctor_details_screen/presentation/controller/admin_doctor_action_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../generated/app_assets.dart';
import '../../../../../../generated/style_atoms.dart';
import '../../../../../../generated/translations.g.dart';
import '../../../../../core/extensions/context_extensions.dart';
import '../../../../../core/utils/dialog_utils.dart';
import '../../../../../core/utils/snack_bar_utils.dart';
import '../../../../common/auth/presentation/widgets/custom_elevated_button.dart';

class AdminDoctorDetailsScreen extends StatefulWidget {
  const AdminDoctorDetailsScreen({super.key, required this.doctor});

  final Doctor doctor;

  @override
  State<AdminDoctorDetailsScreen> createState() =>
      _AdminDoctorDetailsScreenState();
}

class _AdminDoctorDetailsScreenState extends State<AdminDoctorDetailsScreen> {
  late final ValueNotifier<bool> isActive = ValueNotifier(widget.doctor.active);

  @override
  void dispose() {
    isActive.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AdminDoctorActionBloc, AdminDoctorActionState>(
      listenWhen: (previous, current) =>
          current is DeleteDoctorSuccess ||
          current is DeleteDoctorError ||
          current is DeleteDoctorLoading ||
          current is ToggleDoctorActiveStatusSuccess ||
          current is ToggleDoctorActiveStatusError,
      listener: (context, state) {
        if (state is DeleteDoctorSuccess) {
          DialogUtils.hideLoading(context: context);
          SnackBarUtils.showSuccessSnackBar(
            context: context,
            message: t.admin.doctor_details_screen.doctor_deleted_successfully,
          );
          context.pop();
        }
        if (state is DeleteDoctorError) {
          debugPrint(state.message);
          DialogUtils.hideLoading(context: context);
          DialogUtils.showMessage(
            posActionText: t.dialog.ok,
            title: t.dialog.error,
            context: context,
            message: state.message,
          );
        }
        if (state is DeleteDoctorLoading) {
          DialogUtils.showLoading(context: context);
        }
        if (state is ToggleDoctorActiveStatusSuccess) {
          isActive.value = !isActive.value;
        }
        if (state is ToggleDoctorActiveStatusError) {
          SnackBarUtils.showErrorSnackBar(
            context: context,
            message: state.message,
          );
        }
      },

      child: Scaffold(
        appBar: AppBar(
          title: Text(t.admin.doctor_details_screen.doctor_details),
          centerTitle: true,
        ),
        body: ListView(
          padding: EdgeInsets.all(20),
          children: [
            Center(
              child: Stack(
                alignment: .bottomRight,
                children: [
                  Container(
                    width: context.width * 0.3,
                    height: context.width * 0.3,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.brandPrimary20,
                      image: DecorationImage(
                        image: widget.doctor.imageUrl != null
                            ? CachedNetworkImageProvider(
                                widget.doctor.imageUrl!,
                              )
                            : AssetImage(
                                AppAssets.images.fallbackUserImage.path,
                              ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.brandPrimary,
                    ),
                    child: Icon(
                      Icons.verified,
                      color: AppColors.white,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Text(
              widget.doctor.name,
              style: context.bold24.textPrimary.rubik,
              textAlign: .center,
            ),
            Text(
              widget.doctor.specialty.name,
              style: context.medium14.textSecondary.rubik,
              textAlign: .center,
            ),
            ValueListenableBuilder(
              valueListenable: isActive,
              builder: (context, value, child) {
                return Chip(
                  padding: EdgeInsets.all(5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  side: BorderSide(width: 0, color: AppColors.transparent),
                  backgroundColor: value
                      ? AppColors.bgSurfaceLight
                      : AppColors.statusErrorSurface,
                  avatarBoxConstraints: .tightFor(width: 15),
                  avatar: Icon(
                    Icons.circle,
                    size: 10,
                    color: value
                        ? AppColors.brandPrimaryDark
                        : AppColors.statusError,
                  ),
                  label: Text(
                    value
                        ? t.admin.doctors_tab.active
                        : t.admin.doctors_tab.inactive,
                    style: value
                        ? context.medium10.brandPrimaryDark.rubik
                        : context.regular10.statusError.rubik,
                  ),
                );
              },
            ),
            SizedBox(height: 40),

            AppContainerWithShadow(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  _buildInfoCard(
                    context,
                    value: widget.doctor.specialty.name,
                    title: t.admin.doctor_details_screen.specialty,
                    icon: AppAssets.icons.medicalIcon.path,
                    trailing: Chip(
                      padding: EdgeInsets.all(5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      side: BorderSide(width: 0, color: AppColors.transparent),
                      backgroundColor: AppColors.bgSurfaceLight,
                      avatarBoxConstraints: .tightFor(width: 15),

                      //CR Bug: Hardcoded 't.admin.doctor_details_screen.heart_care' displays heart care specialty regardless of the doctor's actual specialty.
                      label: Text(
                        t.admin.doctor_details_screen.heart_care,
                        style: context.medium12.brandPrimary.rubik,
                      ),
                    ),
                  ),
                  Divider(color: AppColors.textSecondary),
                  //CR Copy-Paste Defect: Status switch card reuses specialty title and value instead of doctor status strings.
                  _buildInfoCard(
                    context,
                    value: widget.doctor.specialty.name,
                    title: t.admin.doctor_details_screen.specialty,
                    icon: AppAssets.icons.switchIcon.path,
                    trailing: ValueListenableBuilder(
                      valueListenable: isActive,
                      builder: (context, value, child) {
                        return Switch(
                          value: value,

                          onChanged: (value) {
                            context.read<AdminDoctorActionBloc>().add(
                              ToggleDoctorActiveStatusRequested(
                                doctorId: widget.doctor.id,
                                active: value,
                              ),
                            );
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
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 50),
            CustomElevatedButton(
              backgroundColor: AppColors.brandPrimary,
              onPressed: () {
                AdminUpdateDoctorDetailsRoute(widget.doctor).push(context);
              },
              child: Row(
                spacing: 8,
                mainAxisAlignment: .center,
                children: [
                  Icon(Icons.edit_outlined, color: AppColors.white, size: 20),
                  Text(
                    t.admin.doctor_details_screen.edit_doctor,
                    style: context.semiBold16.white.rubik,
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            TextButton.icon(
              icon: Icon(Icons.delete_outline_rounded),
              style: ButtonStyle(
                iconColor: WidgetStatePropertyAll(AppColors.statusError),
                iconSize: WidgetStatePropertyAll(20),
                textStyle: WidgetStatePropertyAll(
                  context.semiBold14.statusError.rubik,
                ),
                foregroundColor: WidgetStatePropertyAll(AppColors.statusError),
              ),

              onPressed: () {
                context.read<AdminDoctorActionBloc>().add(
                  DeleteDoctorRequested(doctorId: widget.doctor.id),
                );
              },
              label: Text(t.admin.doctor_details_screen.delete_doctor),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context, {
    required String value,
    required String title,
    required String icon,
    required Widget trailing,
  }) {
    return ListTile(
      leading: SvgPicture.asset(
        icon,
        fit: BoxFit.scaleDown,
        colorFilter: ColorFilter.mode(AppColors.brandPrimary, BlendMode.srcIn),
      ),
      title: Text(title),
      titleTextStyle: context.regular12.textSecondary.rubik,
      subtitle: Text(value),
      subtitleTextStyle: context.semiBold14.textPrimary.rubik,
      trailing: trailing,
      contentPadding: EdgeInsets.all(0),
    );
  }
}

//CR Dead Code: Remove 104 lines of commented-out legacy code.
// Widget buildUploadImage(BuildContext context) {
//   return Container(
//     clipBehavior: .antiAlias,
//     decoration: BoxDecoration(shape: .circle),
//     width: 120,
//     height: 120,
//     alignment: .center,
//     child: BlocConsumer<DoctorBloc, DoctorState>(
//       listener: (context, state) {
//         if (state is PickDoctorImageErrorState) {
//           SnackBarUtils.showErrorSnackBar(
//             context: context,
//             message: state.message,
//           );
//         }
//       },
//       buildWhen: (previous, current) =>
//           current is PickDoctorImageSuccessState,
//       builder: (context, state) {
//         if (state is PickDoctorImageSuccessState) {
//           return Image.file(state.image, fit: .fitHeight);
//         }
//         return DottedBorder(
//           options: CircularDottedBorderOptions(
//             padding: EdgeInsets.all(40),
//             stackFit: .loose,
//             strokeCap: .round,
//             dashPattern: const [10, 5],
//             color: AppColors.borderMuted,
//             strokeWidth: 2,
//           ),
//
//           child: Icon(
//             Icons.image_outlined,
//             size: 35,
//             color: AppColors.textSecondary,
//           ),
//         );
//       },
//     ),
//   );
// }
/*
GestureDetector(
                      onTap: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        showAvatarBottomSheet();
                      },
                      child: Center(
                        child: Stack(
                          alignment: .topRight,
                          children: [
                            ValueListenableBuilder<String?>(
                              valueListenable: avatar,
                              builder:
                                  (BuildContext context, value, Widget? child) {
                                    var avatarPath = userAvatars[value];
                                    return Container(
                                      width: context.width * 0.3,
                                      height: context.width * 0.3,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: context.easyColor(
                                          lColor: AppColors.primary,
                                          dColor: AppColors.backgroundLight,
                                        ),
                                      ),
                                      child: avatarPath != null
                                          ? ClipOval(
                                              child: SvgPicture.asset(
                                                avatarPath,
                                                fit: BoxFit.cover,
                                              ),
                                            )
                                          : Icon(
                                              Icons.person,
                                              size: context.width * 0.2,
                                              color: AppColors.backgroundDark,
                                            ),
                                    );
                                  },
                            ),
                            Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.lightGreen,
                                border: Border.all(
                                  width: 3,
                                  color: AppColors.backgroundDark,
                                ),
                              ),
                              child: Icon(
                                Icons.edit,
                                color: AppColors.surfaceDark,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

 */

import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_hunt/apps/core/data/models/doctor/doctor.dart';
import 'package:doctor_hunt/apps/core/router/app_routes.dart';
import 'package:doctor_hunt/apps/core/theme/app_colors.dart';
import 'package:doctor_hunt/apps/core/widgets/app_container_with_shadow.dart';
import 'package:doctor_hunt/apps/features/admin/doctor_details_screen/presentation/controller/admin_doctor_action_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../generated/app_assets.dart';
import '../../../../../../generated/style_atoms.dart';
import '../../../../../../generated/translations.g.dart';
import '../../../../../core/extensions/context_extensions.dart';
import '../../../../../core/utils/dialog_utils.dart';
import '../../../../../core/utils/snack_bar_utils.dart';
import '../../../../common/auth/presentation/widgets/custom_elevated_button.dart';

part '../widget/details_widget.dart';

class AdminDoctorDetailsScreen extends HookWidget {
  const AdminDoctorDetailsScreen({super.key, required this.doctor});

  final Doctor doctor;

  @override
  Widget build(BuildContext context) {
    final isActive = useValueNotifier(doctor.active);

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
            _buildDoctorImageWidget(context),
            SizedBox(height: 10),
            Text(
              doctor.name,
              style: context.bold24.textPrimary.rubik,
              textAlign: .center,
            ),
            Text(
              doctor.specialty.name,
              style: context.medium14.textSecondary.rubik,
              textAlign: .center,
            ),
            _buildActiveChip(context, isActive),
            SizedBox(height: 40),
            DetailsWidget(doctor: doctor, isActive: isActive),
            SizedBox(height: 50),
            CustomElevatedButton(
              backgroundColor: AppColors.brandPrimary,
              onPressed: () {
                AdminUpdateDoctorDetailsRoute(doctor).push(context);
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
            _buildDeleteDoctorButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildDeleteDoctorButton(BuildContext context) {
    return TextButton.icon(
      icon: Icon(Icons.delete_outline_rounded),
      style: ButtonStyle(
        iconColor: WidgetStatePropertyAll(AppColors.statusError),
        iconSize: WidgetStatePropertyAll(20),
        textStyle: WidgetStatePropertyAll(context.semiBold14.statusError.rubik),
        foregroundColor: WidgetStatePropertyAll(AppColors.statusError),
      ),

      onPressed: () {
        context.read<AdminDoctorActionBloc>().add(
          DeleteDoctorRequested(doctorId: doctor.id),
        );
      },
      label: Text(t.admin.doctor_details_screen.delete_doctor),
    );
  }

  Widget _buildActiveChip(BuildContext context, ValueNotifier<bool> isActive) {
    return ValueListenableBuilder(
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
            color: value ? AppColors.brandPrimaryDark : AppColors.statusError,
          ),
          label: Text(
            value ? t.admin.doctors_tab.active : t.admin.doctors_tab.inactive,
            style: value
                ? context.medium10.brandPrimaryDark.rubik
                : context.regular10.statusError.rubik,
          ),
        );
      },
    );
  }

  Widget _buildDoctorImageWidget(BuildContext context) {
    return Center(
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
                image: doctor.imageUrl != null
                    ? CachedNetworkImageProvider(doctor.imageUrl!)
                    : AssetImage(AppAssets.images.fallbackUserImage.path),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(7),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.brandPrimary,
            ),
            child: Icon(Icons.verified, color: AppColors.white, size: 20),
          ),
        ],
      ),
    );
  }
}

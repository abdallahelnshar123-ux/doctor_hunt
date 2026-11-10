import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_hunt/apps/core/theme/app_colors.dart';
import 'package:doctor_hunt/apps/core/widgets/account_status_switch_tile.dart';
import 'package:doctor_hunt/apps/core/widgets/app_container_with_shadow.dart';
import 'package:doctor_hunt/apps/core/widgets/rating_widget.dart';
import 'package:doctor_hunt/apps/features/admin/doctor_details_screen/presentation/controller/admin_doctor_action_bloc.dart';
import 'package:doctor_hunt/apps/features/common/auth/domain/entity/user/doctor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../generated/app_assets.dart';
import '../../../../../../generated/style_atoms.dart';
import '../../../../../../generated/translations.g.dart';
import '../../../../../core/extensions/context_extensions.dart';
import '../../../../../core/utils/snack_bar_utils.dart';

part '../widget/details_widget.dart';
part '../widget/doctor_details_widget.dart';

class AdminDoctorDetailsScreen extends HookWidget {
  const AdminDoctorDetailsScreen({super.key, required this.doctor});

  final DoctorEntity doctor;

  @override
  Widget build(BuildContext context) {
    final isActive = useValueNotifier(!doctor.disabled);
    return Scaffold(
      appBar: AppBar(
        title: Text(t.admin.doctorDetailsScreen.doctorDetails),
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
          _buildActiveChip(context: context, isActive: isActive),
          const SizedBox(height: 40),
          DoctorDetailsWidget(
            doctor: doctor,
            isActiveChip: (value) => isActive.value = value,
          ),
        ],
      ),
    );
  }

  Widget _buildActiveChip({
    required BuildContext context,
    required ValueNotifier<bool> isActive,
  }) {
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
            value ? t.admin.doctorsTab.enabled : t.admin.doctorsTab.disabled,
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
                image: doctor.image != null
                    ? CachedNetworkImageProvider(doctor.image!)
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

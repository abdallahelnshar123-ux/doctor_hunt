import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_hunt/apps/core/extensions/context_extensions.dart';
import 'package:doctor_hunt/apps/core/theme/app_colors.dart';
import 'package:doctor_hunt/apps/core/utils/snack_bar_utils.dart';
import 'package:doctor_hunt/apps/core/widgets/app_container_with_shadow.dart';
import 'package:doctor_hunt/apps/core/widgets/search_text_field_widget.dart';
import 'package:doctor_hunt/apps/features/admin/add_doctor_screen/presentation/controller/doctor_bloc.dart';
import 'package:doctor_hunt/generated/app_assets.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/data/models/doctor/doctor.dart';
import '../../../../../core/router/app_routes.dart';
import '../../../../common/auth/data/models/user/my_user.dart';
import '../../../../common/auth/presentation/controller/auth_bloc.dart';
import '../../../../common/auth/presentation/controller/auth_event.dart';
import '../../../../common/auth/presentation/controller/auth_state.dart';
import '../widget/admin_doctors_shimmer.dart';
import '../widget/tab_bar_widget.dart';

part '../widget/custom_appbar.dart';
part '../widget/doctor_card.dart';
part '../widget/doctors_widget.dart';
part '../widget/status_widget.dart';

class AdminDoctorsTab extends StatelessWidget {
  const AdminDoctorsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: CustomAppbar(),
        resizeToAvoidBottomInset: false,
        floatingActionButton: _buildFloatingActionButton(context),
        body: Column(
          spacing: 15,
          children: [
            StatusWidget(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SearchTextFieldWidget(
                hintText: t.admin.doctors_tab.search_doctors,
                borderRadius: 12,
              ),
            ),
            DoctorsWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return TextButton.icon(
      onPressed: () {
        const AddDoctorRoute().push(context);
      },
      label: Text(
        t.admin.doctors_tab.add_doctor,
        style: context.regular12.white.rubik,
      ),
      icon: Icon(Icons.add_rounded, fontWeight: .w700),
      style: TextButton.styleFrom(
        backgroundColor: AppColors.brandPrimary,

        iconColor: AppColors.white,
        iconSize: 20,
        padding: EdgeInsets.all(15),
      ),
    );
  }
}

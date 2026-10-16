import 'package:doctor_hunt/apps/core/presentation/controller/user/user_bloc.dart';
import 'package:doctor_hunt/apps/core/widgets/settings_user_card.dart';
import 'package:doctor_hunt/apps/features/admin/admin_doctors_tab/presentation/screens/admin_doctors_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../generated/style_atoms.dart';
import '../../../../../../generated/translations.g.dart';
import '../../../../../core/router/app_routes.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/app_container_with_shadow.dart';
import '../../../../../core/widgets/logout_button.dart';
import '../../../../common/auth/data/models/user/my_user.dart';

part '../widget/account_settings_widget.dart';

class AdminSettingsTab extends StatelessWidget {
  const AdminSettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AdminAppbar(title: t.admin.main.settings),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          children: [
            SettingsUserCard(),
            SizedBox(height: 20),
            AccountSettingsWidget(),
            SizedBox(height: 40),
            LogoutButton(),
          ],
        ),
      ),
    );
  }
}

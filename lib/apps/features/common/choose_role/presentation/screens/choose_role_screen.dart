import 'package:doctor_hunt/apps/core/router/app_routes.dart';
import 'package:doctor_hunt/apps/core/widgets/app_scaffold.dart';
import 'package:doctor_hunt/generated/app_assets.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../auth/data/models/user/my_user.dart';
import '../../../auth/presentation/controller/auth_bloc.dart';
import '../widget/role_widget.dart';

class ChooseRoleScreen extends StatefulWidget {
  const ChooseRoleScreen({super.key});

  @override
  State<ChooseRoleScreen> createState() => _ChooseRoleScreenState();
}

class _ChooseRoleScreenState extends State<ChooseRoleScreen> {
  late var currentUser = context.read<AuthBloc>().currentUser;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 50, 20, 32),
        child: Column(
          crossAxisAlignment: .center,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  spacing: 15,
                  crossAxisAlignment: .center,
                  children: [
                    SvgPicture.asset(AppAssets.icons.appLogo.path, width: 70),
                    Text(
                      t.choose_role.title,
                      style: context.bold24.textPrimary.rubik,
                      textAlign: .center,
                    ),
                    SizedBox(height: 25),
                    Text(
                      t.choose_role.role_selection,
                      style: context.extraLight28.textDark.plusJakartaSans,
                      textAlign: .center,
                    ),
                    GestureDetector(
                      onTap: () {
                        context.read<AuthBloc>().selectedRole =
                            UserRoles.patient;
                        const PatientLoginRoute().push(context);
                      },
                      child: RoleWidget(
                        roleTitle: t.choose_role.patient.title,
                        roleDescription: t.choose_role.patient.description,
                        roleIcon: AppAssets.icons.patientIcon.path,
                        role: UserRoles.patient,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        context.read<AuthBloc>().selectedRole = UserRoles.admin;

                        const AdminLoginRoute().push(context);
                      },
                      child: RoleWidget(
                        roleTitle: t.choose_role.admin.title,
                        roleDescription: t.choose_role.admin.description,
                        roleIcon: AppAssets.icons.adminIcon.path,
                        role: UserRoles.admin,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

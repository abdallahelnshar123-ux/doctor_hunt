import 'package:doctor_hunt/apps/core/router/app_routes.dart';
import 'package:doctor_hunt/apps/core/widgets/app_scaffold.dart';
import 'package:doctor_hunt/apps/features/choose_role/presentation/widget/role_widget.dart';
import 'package:doctor_hunt/generated/app_assets.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChooseRoleScreen extends StatefulWidget {
  const ChooseRoleScreen({super.key});

  @override
  State<ChooseRoleScreen> createState() => _ChooseRoleScreenState();
}

class _ChooseRoleScreenState extends State<ChooseRoleScreen> {
  // final ValueNotifier<AppRoles?> selectedRole = ValueNotifier<AppRoles?>(null);

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return AppScaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 50, 20, 32),
        child: Column(
          crossAxisAlignment: .center,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  spacing: 16,
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
                    // Text(
                    //   t.choose_role.subtitle,
                    //   style: context.regular14.textCaption.plusJakartaSans,
                    //   textAlign: .center,
                    // ),
                    SizedBox(height: 16),
                    GestureDetector(
                      onTap: () {
                        // if (selectedRole.value == AppRoles.patient) {
                        //   return;
                        // }
                        // selectedRole.value = AppRoles.patient;
                        const PatientLoginRoute().push(context);
                      },
                      child: RoleWidget(
                        roleTitle: t.choose_role.patient.title,
                        roleDescription: t.choose_role.patient.description,
                        roleIcon: AppAssets.icons.patientIcon.path,
                        // selected:
                        // selectedRole.value == AppRoles.patient,
                        role: AppRoles.patient,
                      ),
                    ),
                    // GestureDetector(
                    //   onTap: () {
                    //     // if (selectedRole.value == AppRoles.doctor) {
                    //     //   return;
                    //     // }
                    //     // selectedRole.value = AppRoles.admin;
                    //
                    //     const LoginRoute(role: AppRoles.doctor).push(context);
                    //   },
                    //
                    //   child: RoleWidget(
                    //     roleTitle: t.choose_role.doctor.title,
                    //     roleDescription:
                    //     t.choose_role.doctor.description,
                    //     roleIcon: AppAssets.icons.adminIcon.path,
                    //     // selected: selectedRole.value == AppRoles.admin,
                    //     role: AppRoles.admin,
                    //   ),
                    // ),
                    GestureDetector(
                      onTap: () {
                        // if (selectedRole.value == AppRoles.admin) {
                        //   return;
                        // }
                        // selectedRole.value = AppRoles.admin;

                        const AdminLoginRoute().push(context);
                      },

                      child: RoleWidget(
                        roleTitle: t.choose_role.admin.title,
                        roleDescription: t.choose_role.admin.description,
                        roleIcon: AppAssets.icons.adminIcon.path,
                        // selected: selectedRole.value == AppRoles.admin,
                        role: AppRoles.admin,
                      ),
                    ),
                    // ValueListenableBuilder(
                    //   valueListenable: selectedRole,
                    //   builder: (BuildContext context, value, Widget? child) {
                    //     return Column(
                    //       children: [
                    //
                    //       ],
                    //     );
                    //   },
                    // ),
                  ],
                ),
              ),
            ),
            // CustomElevatedButton(
            //   buttonWidth: double.infinity,
            //   backgroundColor: AppColors.brandPrimary,
            //   onPressed: () {
            //     const MainRoute().go(context);
            //   },
            //   child: Text(
            //     t.choose_role.kContinue,
            //     style: context.medium18.bgPrimary.rubik,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

enum AppRoles { admin, patient, doctor }

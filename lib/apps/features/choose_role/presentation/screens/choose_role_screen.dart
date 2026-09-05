import 'package:doctor_hunt/apps/core/router/app_routes.dart';
import 'package:doctor_hunt/apps/core/widgets/app_scaffold.dart';
import 'package:doctor_hunt/apps/features/auth/presentation/controller/auth_bloc.dart';
import 'package:doctor_hunt/apps/features/choose_role/presentation/widget/role_widget.dart';
import 'package:doctor_hunt/generated/app_assets.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChooseRoleScreen extends StatefulWidget {
  const ChooseRoleScreen({super.key});

  @override
  State<ChooseRoleScreen> createState() => _ChooseRoleScreenState();
}

class _ChooseRoleScreenState extends State<ChooseRoleScreen> {
  // final ValueNotifier<UserRoles?> selectedRole = ValueNotifier<UserRoles?>(
  //   null,
  // );
  late var currentUser = context.read<AuthBloc>().currentUser;

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
                        const PatientLoginRoute().push(context);
                      },
                      child: RoleWidget(
                        roleTitle: t.choose_role.patient.title,
                        roleDescription: t.choose_role.patient.description,
                        roleIcon: AppAssets.icons.patientIcon.path,
                        // selected: selectedRole.value == AppRoles.admin,
                        role: AppRoles.patient,
                      ),
                    ),
                    // SizedBox(height: 16),
                    GestureDetector(
                      onTap: () {
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
                  ],
                ),
              ),
            ),
            // CustomElevatedButton(
            //   buttonWidth: double.infinity,
            //   backgroundColor: AppColors.brandPrimary,
            //   onPressed: () {
            //     context.read<ChooseRoleBloc>().add(
            //       UpdateUserRoleRequested(
            //         user: currentUser!.copyWith(role: selectedRole
            //             .value),
            //       ),
            //     );
            //   },
            //   child: Text(
            //     t.choose_role,
            //     style: context.medium18.bgPrimary.rubik,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

enum AppRoles { admin, patient }

//
// BlocProvider(
// create: (context) => getIt<ChooseRoleBloc>(),
// child: BlocConsumer<ChooseRoleBloc, ChooseRoleState>(
// listener: (context, state) {
// if (state is UpdateUserRoleSuccess) {
// DialogUtils.hideLoading(context: context);
// DialogUtils.showMessage(
// title: 'Success',
// context: context,
// message: "All set up",
// posAction: () {
// const MainRoute().go(context);
// },
// posActionText: "Ok",
// );
//
// // Future.delayed(Duration(seconds: 2), () {
// //   if (context.mounted) {
// //     const MainRoute().go(context);
// //   }
// // });
// }
//
// if (state is UpdateUserRoleError) {
// debugPrint(state.message);
// DialogUtils.hideLoading(context: context);
// DialogUtils.showMessage(
// posActionText: 'ok',
// title: 'error',
// context: context,
// message: state.message,
// );
// }
//
// if (state is UpdateUserRoleLoading) {
// DialogUtils.showLoading(context: context);
// }
// },
// builder: (context, state) => AppScaffold(
// body: Padding(
// padding: EdgeInsets.fromLTRB(20, 50, 20, 32),
// child: Column(
// crossAxisAlignment: .center,
// children: [
// Expanded(
// child: SingleChildScrollView(
// child: Column(
// spacing: 16,
// crossAxisAlignment: .center,
// children: [
// SvgPicture.asset(
// AppAssets.icons.appLogo.path,
// width: 70,
// ),
// Text(
// t.choose_role.title,
// style: context.bold24.textPrimary.rubik,
// textAlign: .center,
// ),
// SizedBox(height: 25),
// Text(
// t.choose_role.role_selection,
// style: context.extraLight28.textDark.plusJakartaSans,
// textAlign: .center,
// ),
// // Text(
// //   t.choose_role.subtitle,
// //   style: context.regular14.textCaption.plusJakartaSans,
// //   textAlign: .center,
// // ),
// SizedBox(height: 16),
// GestureDetector(
// onTap: () {
// // if (selectedRole.value == AppRoles.patient) {
// //   return;
// // }
// // selectedRole.value = AppRoles.patient;
// const PatientLoginRoute().push(context);
// },
// child: RoleWidget(
// roleTitle: t.choose_role.patient.title,
// roleDescription: t.choose_role.patient.description,
// roleIcon: AppAssets.icons.patientIcon.path,
// // selected:
// // selectedRole.value == AppRoles.patient,
// role: UserRoles.patient,
// ),
// ),
// // GestureDetector(
// //   onTap: () {
// //     // if (selectedRole.value == AppRoles.doctor) {
// //     //   return;
// //     // }
// //     // selectedRole.value = AppRoles.admin;
// //
// //     const LoginRoute(role: AppRoles.doctor).push(context);
// //   },
// //
// //   child: RoleWidget(
// //     roleTitle: t.choose_role.doctor.title,
// //     roleDescription:
// //     t.choose_role.doctor.description,
// //     roleIcon: AppAssets.icons.adminIcon.path,
// //     // selected: selectedRole.value == AppRoles.admin,
// //     role: AppRoles.admin,
// //   ),
// // ),
// GestureDetector(
// onTap: () {
// // if (selectedRole.value == AppRoles.admin) {
// //   return;
// // }
// // selectedRole.value = AppRoles.admin;
//
// const AdminLoginRoute().push(context);
// },
//
// child: RoleWidget(
// roleTitle: t.choose_role.admin.title,
// roleDescription: t.choose_role.admin.description,
// roleIcon: AppAssets.icons.adminIcon.path,
// // selected:
// // selectedRole.value ==
// //     UserRoles.admin,
// role: UserRoles.admin,
// ),
// ),
// GestureDetector(
// onTap: () {
// if (selectedRole.value == UserRoles.patient) {
// return;
// }
// selectedRole.value = UserRoles.patient;
// },
// child: RoleWidget(
// roleTitle: t.choose_role.patient.title,
// roleDescription: t.choose_role.patient.description,
// roleIcon: AppAssets.icons.patientIcon.path,
// // selected:
// // selectedRole.value ==
// //     UserRoles.patient,
// role: UserRoles.patient,
// ),
// ),
// ],
// ),
// ),
// ),
// ],
// ),
// ),
// ),
//
// // CustomElevatedButton(
// //   buttonWidth: double.infinity,
// //   backgroundColor: AppColors.brandPrimary,
// //   onPressed: () {
// //     const MainRoute().go(context);
// //   },
// //   child: Text(
// //     t.choose_role.kContinue,
// //     style: context.medium18.bgPrimary.rubik,
// //   ),
// // ),
// ),
// );

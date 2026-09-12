import 'package:doctor_hunt/apps/core/di/di.dart';
import 'package:doctor_hunt/apps/features/admin/add_doctor_screen/presentation/controller/doctor_bloc.dart';
import 'package:doctor_hunt/apps/features/admin/add_doctor_screen/presentation/screens/add_doctor_screen.dart';
import 'package:doctor_hunt/apps/features/admin/admin_main_screen/presentation/screens/admin_main_screen.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/screens/patient_login_screen.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/screens/register_screen.dart';
import 'package:doctor_hunt/apps/features/common/choose_role/presentation/screens/choose_role_screen.dart';
import 'package:doctor_hunt/apps/features/common/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:doctor_hunt/apps/features/patient/appointment_screen/presentation/screens/appointment_screen.dart';
import 'package:doctor_hunt/apps/features/patient/doctor_details_screen/presentation/screens/doctor_details_screen.dart';
import 'package:doctor_hunt/apps/features/patient/find_doctors_screen/presentation/screens/find_doctors_screen.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/controller/auth_bloc.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/models/user/my_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/common/auth/presentation/screens/admin_login_screen.dart';
import '../../features/patient/main_screen/presentation/screens/main_screen.dart';

part 'app_routes.g.dart';

@TypedGoRoute<AdminLoginRoute>(path: '/admin_login')
class AdminLoginRoute extends GoRouteData with $AdminLoginRoute {
  const AdminLoginRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return AdminLoginScreen();
  }
}

@TypedGoRoute<PatientLoginRoute>(path: '/patient_login')
class PatientLoginRoute extends GoRouteData with $PatientLoginRoute {
  const PatientLoginRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return PatientLoginScreen();
  }
}

@TypedGoRoute<RegisterRoute>(path: '/register')
class RegisterRoute extends GoRouteData with $RegisterRoute {
  const RegisterRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const RegisterScreen();
  }
}

@TypedGoRoute<MainRoute>(path: '/main')
class MainRoute extends GoRouteData with $MainRoute {
  const MainRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const MainScreen();
  }
}

@TypedGoRoute<AdminMainRoute>(path: '/admin_main')
class AdminMainRoute extends GoRouteData with $AdminMainRoute {
  const AdminMainRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final user = context.read<AuthBloc>().currentUser;
    return BlocProvider(
      create: (context) => getIt<DoctorBloc>()
        ..add(GetDoctorsRequested(
          userId: user?.id ?? '',
          role: user?.role ?? UserRoles.admin,
        )),
      child: const AdminMainScreen(),
    );
  }
}

@TypedGoRoute<AddDoctorRoute>(path: '/add_doctor')
class AddDoctorRoute extends GoRouteData with $AddDoctorRoute {
  const AddDoctorRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => getIt<DoctorBloc>(),
      child: AddDoctorScreen(),
    );
  }
}

@TypedGoRoute<OnboardingRoute>(path: '/onboarding')
class OnboardingRoute extends GoRouteData with $OnboardingRoute {
  const OnboardingRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const OnboardingScreen();
  }
}

@TypedGoRoute<ChooseRoleRoute>(path: '/')
class ChooseRoleRoute extends GoRouteData with $ChooseRoleRoute {
  const ChooseRoleRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ChooseRoleScreen();
  }
}

@TypedGoRoute<FindDoctorRoute>(path: '/fined_doctor')
class FindDoctorRoute extends GoRouteData with $FindDoctorRoute {
  const FindDoctorRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const FindDoctorsScreen();
  }
}

@TypedGoRoute<DoctorDetailsRoute>(path: '/doctor_details')
class DoctorDetailsRoute extends GoRouteData with $DoctorDetailsRoute {
  const DoctorDetailsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const DoctorDetailsScreen();
  }
}

@TypedGoRoute<AppointmentRoute>(path: '/appointment')
class AppointmentRoute extends GoRouteData with $AppointmentRoute {
  const AppointmentRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AppointmentScreen();
  }
}

final appRouter = GoRouter(routes: $appRoutes);

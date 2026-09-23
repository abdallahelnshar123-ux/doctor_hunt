import 'package:doctor_hunt/apps/core/data/models/doctor/doctor.dart';
import 'package:doctor_hunt/apps/core/di/di.dart';
import 'package:doctor_hunt/apps/features/admin/add_doctor_screen/presentation/controller/doctor_bloc.dart';
import 'package:doctor_hunt/apps/features/admin/add_doctor_screen/presentation/screens/add_doctor_screen.dart';
import 'package:doctor_hunt/apps/features/admin/admin_main_screen/presentation/screens/admin_main_screen.dart';
import 'package:doctor_hunt/apps/features/admin/doctor_details_screen/presentation/controller/admin_doctor_action_bloc.dart';
import 'package:doctor_hunt/apps/features/admin/update_doctor_details_screen/presentation/controller/update_doctor_details_bloc.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/controller/auth_bloc.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/screens/patient_login_screen.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/screens/register_screen.dart';
import 'package:doctor_hunt/apps/features/common/choose_role/presentation/screens/choose_role_screen.dart';
import 'package:doctor_hunt/apps/features/common/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:doctor_hunt/apps/features/patient/appointment_screen/presentation/screens/appointment_screen.dart';
import 'package:doctor_hunt/apps/features/patient/doctor_details_screen/presentation/screens/doctor_details_screen.dart';
import 'package:doctor_hunt/apps/features/patient/find_doctors_screen/presentation/screens/find_doctors_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/admin/doctor_details_screen/presentation/screens/admin_doctor_details_screen.dart';
import '../../features/admin/update_doctor_details_screen/presentation/screens/update_doctor_details_screen.dart';
import '../../features/common/auth/domain/entity/user/my_user.dart';
import '../../features/common/auth/presentation/controller/auth_state.dart';
import '../../features/common/auth/presentation/screens/admin_login_screen.dart';
import '../../features/patient/main_screen/presentation/screens/patient_main_screen.dart';

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

@TypedGoRoute<PatientMainRoute>(path: '/patient_main')
class PatientMainRoute extends GoRouteData with $PatientMainRoute {
  const PatientMainRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final user = context.select<AuthBloc, MyUser?>((bloc) {
      final authState = bloc.state;
      return authState is UserAuthenticatedState ? authState.currentUser : null;
    });
    return BlocProvider(
      create: (context) => getIt<DoctorBloc>()
        ..add(
          GetDoctorsRequested(
            userId: user?.id ?? '',
            role: user?.role ?? UserRoles.patient,
          ),
        ),
      child: const PatientMainScreen(),
    );
  }
}

@TypedGoRoute<AdminMainRoute>(path: '/admin_main')
class AdminMainRoute extends GoRouteData with $AdminMainRoute {
  const AdminMainRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final user = context.select<AuthBloc, MyUser?>((bloc) {
      final authState = bloc.state;
      return authState is UserAuthenticatedState ? authState.currentUser : null;
    });
    return BlocProvider(
      create: (context) => getIt<DoctorBloc>()
        ..add(
          GetDoctorsRequested(
            userId: user?.id ?? '',
            role: user?.role ?? UserRoles.admin,
          ),
        ),
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

@TypedGoRoute<FindDoctorRoute>(path: '/find_doctor')
class FindDoctorRoute extends GoRouteData with $FindDoctorRoute {
  const FindDoctorRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const FindDoctorsScreen();
  }
}

@TypedGoRoute<PatientDoctorDetailsRoute>(path: '/patient_doctor_details')
class PatientDoctorDetailsRoute extends GoRouteData
    with $PatientDoctorDetailsRoute {
  const PatientDoctorDetailsRoute(this.$extra);

  final Doctor $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return PatientDoctorDetailsScreen(doctor: $extra);
  }
}

@TypedGoRoute<AdminDoctorDetailsRoute>(path: '/admin_doctor_details')
class AdminDoctorDetailsRoute extends GoRouteData
    with $AdminDoctorDetailsRoute {
  const AdminDoctorDetailsRoute(this.$extra);

  final Doctor $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => getIt<AdminDoctorActionBloc>(),
      child: AdminDoctorDetailsScreen(doctor: $extra),
    );
  }
}

@TypedGoRoute<AdminUpdateDoctorDetailsRoute>(
  path: '/admin_update_doctor_details',
)
class AdminUpdateDoctorDetailsRoute extends GoRouteData
    with $AdminUpdateDoctorDetailsRoute {
  const AdminUpdateDoctorDetailsRoute(this.$extra);

  final Doctor $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => getIt<UpdateDoctorDetailsBloc>(),
      child: UpdateDoctorDetailsScreen(doctor: $extra),
    );
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

final appRouter = GoRouter(
  routes: $appRoutes,
  initialLocation: '/',
  redirect: (context, state) {
    final authState = context.read<AuthBloc>().state;
    final isLoggedIn = authState is UserAuthenticatedState;

    final protectedRoutes = ['/patient_main', '/admin_main', '/add_doctor'];

    if (protectedRoutes.contains(state.matchedLocation) && !isLoggedIn) {
      return '/'; // todo: change this to choose_role later
    }

    if (isLoggedIn &&
        (state.matchedLocation == '/' ||
            state.matchedLocation == '/patient_login' ||
            state.matchedLocation == '/admin_login')) {
      final user = authState.currentUser;
      return user.role == UserRoles.admin ? '/admin_main' : '/patient_main';
    }

    return null;
  },
);

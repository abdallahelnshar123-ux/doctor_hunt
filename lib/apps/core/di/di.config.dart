// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:get_it/get_it.dart' as _i174;
import 'package:google_sign_in/google_sign_in.dart' as _i116;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../features/admin/add_doctor_screen/data/repo/doctor_repository.dart'
    as _i932;
import '../../features/admin/add_doctor_screen/data/service/doctor_firestore_service.dart'
    as _i353;
import '../../features/admin/add_doctor_screen/presentation/controller/add_doctors_bloc.dart'
    as _i233;
import '../../features/admin/admin_appointments_tab/presentation/controller/admin_appointments_bloc.dart'
    as _i995;
import '../../features/admin/admin_doctors_tab/presentation/controller/admin_doctors_bloc.dart'
    as _i900;
import '../../features/admin/admin_profile_screen/presentation/controller/admin_profile_bloc.dart'
    as _i90;
import '../../features/admin/doctor_availability_screen/presentation/controller/doctor_availability_bloc.dart'
    as _i821;
import '../../features/admin/doctor_details_screen/presentation/controller/admin_doctor_action_bloc.dart'
    as _i879;
import '../../features/admin/update_doctor_details_screen/presentation/controller/update_doctor_details_bloc.dart'
    as _i514;
import '../../features/common/auth/data/repo/auth_repository.dart' as _i959;
import '../../features/common/auth/data/service/firebase_services/auth_service.dart'
    as _i114;
import '../../features/common/auth/data/service/firebase_services/user_firestore_service.dart'
    as _i749;
import '../../features/common/auth/data/use_case/login_use_case.dart' as _i594;
import '../../features/common/auth/presentation/controller/auth/auth_bloc.dart'
    as _i613;
import '../../features/common/auth/presentation/controller/user/user_bloc.dart'
    as _i15;
import '../../features/patient/appointments_tab/data/service/review_batch_firestore_service.dart'
    as _i129;
import '../../features/patient/appointments_tab/presentation/controller/appointments_bloc.dart'
    as _i365;
import '../../features/patient/favourite_tab/presentation/controller/favourite_doctors_bloc.dart'
    as _i670;
import '../../features/patient/home_tab/presentation/controller/patient_doctors_bloc.dart'
    as _i486;
import '../../features/patient/patient_profile_screen/data/repo/user_repository.dart'
    as _i96;
import '../../features/patient/patient_profile_screen/presentation/controller/patient_profile_bloc.dart'
    as _i495;
import '../../features/patient/select_time_screen/data/repo/appointment_repository.dart'
    as _i707;
import '../../features/patient/select_time_screen/data/service/appointment_firestore_service.dart'
    as _i772;
import '../../features/patient/select_time_screen/data/use_case/generate_doctor_slots_use_case.dart'
    as _i485;
import '../../features/patient/select_time_screen/data/use_case/get_available_slots_use_case.dart'
    as _i921;
import '../../features/patient/select_time_screen/presentation/controller/select_time_bloc.dart'
    as _i137;
import '../data/image_service/image_service.dart' as _i181;
import '../data/session/user_session_manager.dart' as _i583;
import '../data/shared_prefs/local_storage_module.dart' as _i63;
import '../data/shared_prefs/user_pref.dart' as _i708;
import '../network/cloudinary/cloudinary_config.dart' as _i619;
import '../network/cloudinary/cloudinary_service.dart' as _i417;
import 'firebase_module.dart' as _i616;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final localStorageModule = _$LocalStorageModule();
    final firebaseModule = _$FirebaseModule();
    final cloudinaryConfig = _$CloudinaryConfig();
    gh.factory<_i181.ImageService>(() => _i181.ImageService());
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => localStorageModule.sharedPreferences,
      preResolve: true,
    );
    gh.factory<_i670.FavouriteDoctorsBloc>(() => _i670.FavouriteDoctorsBloc());
    gh.factory<_i485.GenerateDoctorSlotsUseCase>(
      () => _i485.GenerateDoctorSlotsUseCase(),
    );
    gh.singleton<_i59.FirebaseAuth>(() => firebaseModule.firebaseAuth);
    gh.singleton<_i974.FirebaseFirestore>(() => firebaseModule.firestore);
    gh.singleton<_i116.GoogleSignIn>(() => firebaseModule.googleSignIn);
    gh.factory<String>(
      () => cloudinaryConfig.uploadPreset,
      instanceName: 'upload_preset',
    );
    gh.lazySingleton<_i353.DoctorFirestoreService>(
      () => _i353.DoctorFirestoreService(gh<_i974.FirebaseFirestore>()),
    );
    gh.lazySingleton<_i749.UserFirestoreService>(
      () => _i749.UserFirestoreService(gh<_i974.FirebaseFirestore>()),
    );
    gh.factory<String>(
      () => cloudinaryConfig.cloudName,
      instanceName: 'cloud_name',
    );
    gh.lazySingleton<_i708.UserPrefs>(
      () => _i708.UserPrefs(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i114.AuthService>(
      () =>
          _i114.AuthService(gh<_i59.FirebaseAuth>(), gh<_i116.GoogleSignIn>()),
    );
    gh.factory<_i129.ReviewBatchFirestoreService>(
      () => _i129.ReviewBatchFirestoreService(gh<_i974.FirebaseFirestore>()),
    );
    gh.factory<_i772.AppointmentFirestoreService>(
      () => _i772.AppointmentFirestoreService(gh<_i974.FirebaseFirestore>()),
    );
    gh.factory<_i417.CloudinaryService>(
      () => _i417.CloudinaryService(
        cloudName: gh<String>(instanceName: 'cloud_name'),
        uploadPreset: gh<String>(instanceName: 'upload_preset'),
      ),
    );
    gh.factory<_i932.DoctorRepository>(
      () => _i932.DoctorRepository(
        firestoreService: gh<_i353.DoctorFirestoreService>(),
        cloudinaryService: gh<_i417.CloudinaryService>(),
        imageService: gh<_i181.ImageService>(),
      ),
    );
    gh.lazySingleton<_i583.UserSessionManager>(
      () => _i583.UserSessionManager(gh<_i708.UserPrefs>()),
    );
    gh.factory<_i233.AddDoctorsBloc>(
      () => _i233.AddDoctorsBloc(gh<_i932.DoctorRepository>()),
    );
    gh.factory<_i900.AdminDoctorsBloc>(
      () => _i900.AdminDoctorsBloc(gh<_i932.DoctorRepository>()),
    );
    gh.factory<_i821.DoctorAvailabilityBloc>(
      () => _i821.DoctorAvailabilityBloc(gh<_i932.DoctorRepository>()),
    );
    gh.factory<_i879.AdminDoctorActionBloc>(
      () => _i879.AdminDoctorActionBloc(gh<_i932.DoctorRepository>()),
    );
    gh.factory<_i514.UpdateDoctorDetailsBloc>(
      () => _i514.UpdateDoctorDetailsBloc(gh<_i932.DoctorRepository>()),
    );
    gh.factory<_i486.PatientDoctorsBloc>(
      () => _i486.PatientDoctorsBloc(gh<_i932.DoctorRepository>()),
    );
    gh.factory<_i707.AppointmentRepository>(
      () => _i707.AppointmentRepository(
        gh<_i772.AppointmentFirestoreService>(),
        gh<_i129.ReviewBatchFirestoreService>(),
      ),
    );
    gh.factory<_i365.AppointmentsBloc>(
      () => _i365.AppointmentsBloc(
        gh<_i707.AppointmentRepository>(),
        gh<_i583.UserSessionManager>(),
      ),
    );
    gh.lazySingleton<_i959.AuthRepository>(
      () => _i959.AuthRepository(
        gh<_i114.AuthService>(),
        gh<_i749.UserFirestoreService>(),
      ),
    );
    gh.factory<_i995.AdminAppointmentsBloc>(
      () => _i995.AdminAppointmentsBloc(
        gh<_i707.AppointmentRepository>(),
        gh<_i583.UserSessionManager>(),
      ),
    );
    gh.factory<_i96.UserRepository>(
      () => _i96.UserRepository(
        gh<_i749.UserFirestoreService>(),
        gh<_i417.CloudinaryService>(),
        gh<_i181.ImageService>(),
        gh<_i708.UserPrefs>(),
      ),
    );
    gh.factory<_i921.GetAvailableSlotsUseCase>(
      () => _i921.GetAvailableSlotsUseCase(
        gh<_i707.AppointmentRepository>(),
        gh<_i485.GenerateDoctorSlotsUseCase>(),
      ),
    );
    gh.factory<_i594.LoginUseCase>(
      () => _i594.LoginUseCase(gh<_i959.AuthRepository>()),
    );
    gh.factory<_i90.AdminProfileBloc>(
      () => _i90.AdminProfileBloc(
        gh<_i96.UserRepository>(),
        gh<_i583.UserSessionManager>(),
      ),
    );
    gh.factory<_i495.PatientProfileBloc>(
      () => _i495.PatientProfileBloc(
        gh<_i96.UserRepository>(),
        gh<_i583.UserSessionManager>(),
      ),
    );
    gh.lazySingleton<_i15.UserBloc>(
      () => _i15.UserBloc(
        gh<_i959.AuthRepository>(),
        gh<_i583.UserSessionManager>(),
      ),
    );
    gh.lazySingleton<_i613.AuthBloc>(
      () => _i613.AuthBloc(
        gh<_i959.AuthRepository>(),
        gh<_i594.LoginUseCase>(),
        gh<_i583.UserSessionManager>(),
      ),
    );
    gh.factory<_i137.SelectTimeBloc>(
      () => _i137.SelectTimeBloc(
        gh<_i921.GetAvailableSlotsUseCase>(),
        gh<_i707.AppointmentRepository>(),
        gh<_i583.UserSessionManager>(),
      ),
    );
    return this;
  }
}

class _$LocalStorageModule extends _i63.LocalStorageModule {}

class _$FirebaseModule extends _i616.FirebaseModule {}

class _$CloudinaryConfig extends _i619.CloudinaryConfig {}

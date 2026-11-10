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

import '../../features/admin/add_doctor_screen/presentation/controller/add_doctors_bloc.dart'
    as _i233;
import '../../features/admin/admin_appointments_tab/presentation/controller/admin_appointments_bloc.dart'
    as _i995;
import '../../features/admin/admin_doctors_tab/presentation/controller/admin_doctors_bloc.dart'
    as _i900;
import '../../features/admin/admin_patients_tab/data/repo/admin_patients_repository.dart'
    as _i218;
import '../../features/admin/admin_patients_tab/data/service/admin_patients_remote_data_source.dart'
    as _i43;
import '../../features/admin/admin_patients_tab/presentation/controller/admin_patient_action_bloc.dart'
    as _i710;
import '../../features/admin/admin_patients_tab/presentation/controller/admin_patients_bloc.dart'
    as _i101;
import '../../features/admin/doctor_details_screen/presentation/controller/admin_doctor_action_bloc.dart'
    as _i879;
import '../../features/common/auth/data/data_source/remote/auth_remote_data_source.dart'
    as _i377;
import '../../features/common/auth/data/data_source/remote/impl/auth_remote_data_source_impl.dart'
    as _i1015;
import '../../features/common/auth/data/repository/auth_repository_impl.dart'
    as _i953;
import '../../features/common/auth/data/service/firebase_services/auth_service.dart'
    as _i114;
import '../../features/common/auth/data/service/firebase_services/user_firestore_service.dart'
    as _i749;
import '../../features/common/auth/data/use_case/login_use_case.dart' as _i594;
import '../../features/common/auth/domain/repository/auth_repository.dart'
    as _i747;
import '../../features/common/auth/presentation/controller/auth/auth_bloc.dart'
    as _i613;
import '../../features/common/specialties/data/repo/specialty_repository.dart'
    as _i195;
import '../../features/common/specialties/data/service/specialty_service.dart'
    as _i596;
import '../../features/common/specialties/presentation/controller/specialties_bloc.dart'
    as _i642;
import '../../features/doctor/appointments_tab/presentation/controller/appointments_bloc.dart'
    as _i487;
import '../../features/doctor/data/data_source/remote/doctor_remote_data_source.dart'
    as _i1021;
import '../../features/doctor/data/data_source/remote/impl/doctor_remote_data_source_impl.dart'
    as _i34;
import '../../features/doctor/data/repository/doctor_repository_impl.dart'
    as _i819;
import '../../features/doctor/doctor_avaiability_screen/controller/doctor_availability_bloc.dart'
    as _i1037;
import '../../features/doctor/doctor_onboarding_screen/controller/doctor_onboarding_bloc.dart'
    as _i601;
import '../../features/doctor/domain/repository/doctor_repository.dart'
    as _i849;
import '../../features/doctor/schedule_tab/presentation/controller/doctor_schedule_bloc.dart'
    as _i86;
import '../../features/patient/appointments_tab/data/service/review_batch_firestore_service.dart'
    as _i129;
import '../../features/patient/appointments_tab/presentation/controller/appointments_bloc.dart'
    as _i365;
import '../../features/patient/favourite_tab/presentation/controller/favourite_doctors_bloc.dart'
    as _i670;
import '../../features/patient/home_tab/presentation/controller/patient_doctors_bloc.dart'
    as _i486;
import '../../features/patient/select_time_screen/data/use_case/generate_doctor_slots_use_case.dart'
    as _i485;
import '../../features/patient/select_time_screen/data/use_case/get_available_slots_use_case.dart'
    as _i921;
import '../../features/patient/select_time_screen/presentation/controller/select_time_bloc.dart'
    as _i137;
import '../data/appointment/repo/appointment_repository.dart' as _i148;
import '../data/appointment/service/appointment_firestore_service.dart'
    as _i550;
import '../data/image_service/image_service.dart' as _i181;
import '../data/session/user_session_manager.dart' as _i583;
import '../data/shared_prefs/local_storage_module.dart' as _i63;
import '../data/shared_prefs/user_pref.dart' as _i708;
import '../data/user/repo/user_repository.dart' as _i1046;
import '../network/cloudinary/cloudinary_config.dart' as _i619;
import '../network/cloudinary/cloudinary_service.dart' as _i417;
import '../presentation/controller/user/user_bloc.dart' as _i985;
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
    gh.factory<_i670.FavouriteDoctorsBloc>(() => _i670.FavouriteDoctorsBloc());
    gh.factory<_i485.GenerateDoctorSlotsUseCase>(
      () => _i485.GenerateDoctorSlotsUseCase(),
    );
    await gh.singletonAsync<_i460.SharedPreferences>(
      () => localStorageModule.sharedPreferences,
      preResolve: true,
    );
    gh.lazySingleton<_i59.FirebaseAuth>(() => firebaseModule.firebaseAuth);
    gh.lazySingleton<_i974.FirebaseFirestore>(() => firebaseModule.firestore);
    gh.lazySingleton<_i116.GoogleSignIn>(() => firebaseModule.googleSignIn);
    gh.factory<String>(() => cloudinaryConfig.apiKey, instanceName: 'api_key');
    gh.factory<String>(
      () => cloudinaryConfig.uploadPreset,
      instanceName: 'upload_preset',
    );
    gh.lazySingleton<_i749.UserFirestoreService>(
      () => _i749.UserFirestoreService(gh<_i974.FirebaseFirestore>()),
    );
    gh.factory<String>(
      () => cloudinaryConfig.apiSecret,
      instanceName: 'api_secret',
    );
    gh.factory<String>(
      () => cloudinaryConfig.cloudName,
      instanceName: 'cloud_name',
    );
    gh.lazySingleton<_i708.UserPrefs>(
      () => _i708.UserPrefs(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i1021.DoctorRemoteDataSource>(
      () => _i34.DoctorRemoteDataSourceImpl(gh<_i974.FirebaseFirestore>()),
    );
    gh.lazySingleton<_i377.AuthRemoteDataSource>(
      () => _i1015.AuthRemoteDataSourceImpl(
        gh<_i59.FirebaseAuth>(),
        gh<_i116.GoogleSignIn>(),
        gh<_i974.FirebaseFirestore>(),
      ),
    );
    gh.lazySingleton<_i747.AuthRepository>(
      () => _i953.AuthRepositoryImpl(gh<_i377.AuthRemoteDataSource>()),
    );
    gh.lazySingleton<_i114.AuthService>(
      () =>
          _i114.AuthService(gh<_i59.FirebaseAuth>(), gh<_i116.GoogleSignIn>()),
    );
    gh.factory<_i550.AppointmentFirestoreService>(
      () => _i550.AppointmentFirestoreService(gh<_i974.FirebaseFirestore>()),
    );
    gh.factory<_i129.ReviewBatchFirestoreService>(
      () => _i129.ReviewBatchFirestoreService(gh<_i974.FirebaseFirestore>()),
    );
    gh.lazySingleton<_i43.AdminPatientsRemoteDataSource>(
      () => _i43.AdminPatientsRemoteDataSource(gh<_i974.FirebaseFirestore>()),
    );
    gh.lazySingleton<_i596.SpecialtyService>(
      () => _i596.SpecialtyService(gh<_i974.FirebaseFirestore>()),
    );
    gh.factory<_i417.CloudinaryService>(
      () => _i417.CloudinaryService(
        cloudName: gh<String>(instanceName: 'cloud_name'),
        uploadPreset: gh<String>(instanceName: 'upload_preset'),
        apiKey: gh<String>(instanceName: 'api_key'),
        apiSecret: gh<String>(instanceName: 'api_secret'),
      ),
    );
    gh.factory<_i148.AppointmentRepository>(
      () => _i148.AppointmentRepository(
        gh<_i550.AppointmentFirestoreService>(),
        gh<_i129.ReviewBatchFirestoreService>(),
      ),
    );
    gh.lazySingleton<_i218.AdminPatientsRepository>(
      () => _i218.AdminPatientsRepository(
        gh<_i43.AdminPatientsRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i583.UserSessionManager>(
      () => _i583.UserSessionManager(gh<_i708.UserPrefs>()),
    );
    gh.lazySingleton<_i195.SpecialtyRepository>(
      () => _i195.SpecialtyRepository(gh<_i596.SpecialtyService>()),
    );
    gh.factory<_i594.LoginUseCase>(
      () => _i594.LoginUseCase(gh<_i747.AuthRepository>()),
    );
    gh.factory<_i710.AdminPatientActionBloc>(
      () => _i710.AdminPatientActionBloc(gh<_i218.AdminPatientsRepository>()),
    );
    gh.factory<_i101.AdminPatientsBloc>(
      () => _i101.AdminPatientsBloc(gh<_i218.AdminPatientsRepository>()),
    );
    gh.lazySingleton<_i849.DoctorRepository>(
      () => _i819.DoctorRepositoryImpl(
        gh<_i1021.DoctorRemoteDataSource>(),
        gh<_i417.CloudinaryService>(),
        gh<_i181.ImageService>(),
      ),
    );
    gh.factory<_i1046.UserRepository>(
      () => _i1046.UserRepository(
        gh<_i749.UserFirestoreService>(),
        gh<_i417.CloudinaryService>(),
        gh<_i181.ImageService>(),
        gh<_i708.UserPrefs>(),
      ),
    );
    gh.factory<_i233.AddDoctorsBloc>(
      () => _i233.AddDoctorsBloc(gh<_i849.DoctorRepository>()),
    );
    gh.factory<_i900.AdminDoctorsBloc>(
      () => _i900.AdminDoctorsBloc(gh<_i849.DoctorRepository>()),
    );
    gh.factory<_i879.AdminDoctorActionBloc>(
      () => _i879.AdminDoctorActionBloc(gh<_i849.DoctorRepository>()),
    );
    gh.factory<_i486.PatientDoctorsBloc>(
      () => _i486.PatientDoctorsBloc(gh<_i849.DoctorRepository>()),
    );
    gh.factory<_i921.GetAvailableSlotsUseCase>(
      () => _i921.GetAvailableSlotsUseCase(
        gh<_i148.AppointmentRepository>(),
        gh<_i485.GenerateDoctorSlotsUseCase>(),
      ),
    );
    gh.factory<_i487.AppointmentsBloc>(
      () => _i487.AppointmentsBloc(
        gh<_i148.AppointmentRepository>(),
        gh<_i583.UserSessionManager>(),
        gh<_i849.DoctorRepository>(),
      ),
    );
    gh.factory<_i365.AppointmentsBloc>(
      () => _i365.AppointmentsBloc(
        gh<_i148.AppointmentRepository>(),
        gh<_i583.UserSessionManager>(),
        gh<_i849.DoctorRepository>(),
      ),
    );
    gh.factory<_i995.AdminAppointmentsBloc>(
      () => _i995.AdminAppointmentsBloc(
        gh<_i148.AppointmentRepository>(),
        gh<_i583.UserSessionManager>(),
      ),
    );
    gh.lazySingleton<_i613.AuthBloc>(
      () => _i613.AuthBloc(
        gh<_i747.AuthRepository>(),
        gh<_i594.LoginUseCase>(),
        gh<_i583.UserSessionManager>(),
      ),
    );
    gh.factory<_i86.DoctorScheduleBloc>(
      () => _i86.DoctorScheduleBloc(
        gh<_i148.AppointmentRepository>(),
        gh<_i583.UserSessionManager>(),
      ),
    );
    gh.lazySingleton<_i642.SpecialtiesBloc>(
      () => _i642.SpecialtiesBloc(gh<_i195.SpecialtyRepository>()),
    );
    gh.factory<_i1037.DoctorAvailabilityBloc>(
      () => _i1037.DoctorAvailabilityBloc(
        gh<_i849.DoctorRepository>(),
        gh<_i583.UserSessionManager>(),
      ),
    );
    gh.factory<_i601.DoctorOnboardingBloc>(
      () => _i601.DoctorOnboardingBloc(
        gh<_i849.DoctorRepository>(),
        gh<_i583.UserSessionManager>(),
      ),
    );
    gh.lazySingleton<_i985.UserBloc>(
      () => _i985.UserBloc(
        gh<_i747.AuthRepository>(),
        gh<_i583.UserSessionManager>(),
        gh<_i1046.UserRepository>(),
      ),
    );
    gh.factory<_i137.SelectTimeBloc>(
      () => _i137.SelectTimeBloc(
        gh<_i921.GetAvailableSlotsUseCase>(),
        gh<_i148.AppointmentRepository>(),
        gh<_i583.UserSessionManager>(),
      ),
    );
    return this;
  }
}

class _$LocalStorageModule extends _i63.LocalStorageModule {}

class _$FirebaseModule extends _i616.FirebaseModule {}

class _$CloudinaryConfig extends _i619.CloudinaryConfig {}

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
import '../../features/admin/add_doctor_screen/presentation/controller/doctor_bloc.dart'
    as _i546;
import '../../features/common/auth/data/repo/auth_repository_impl.dart'
    as _i809;
import '../../features/common/auth/data/service/firebase_services/auth_service.dart'
    as _i114;
import '../../features/common/auth/data/service/firebase_services/user_firestore_service.dart'
    as _i749;
import '../../features/common/auth/data/use_case/login_use_case.dart' as _i594;
import '../../features/common/auth/presentation/controller/auth_bloc.dart'
    as _i669;
import '../data/image_service/image_service.dart' as _i181;
import '../data/shared_prefs/local_storage_module.dart' as _i63;
import '../data/shared_prefs/user_pref.dart' as _i708;
import '../network/cloudinary/cloudinary_config.dart' as _i619;
import '../network/cloudinary/cloudinary_service_impl.dart' as _i638;
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
    gh.factory<_i638.CloudinaryService>(
      () => _i638.CloudinaryService(
        cloudName: gh<String>(instanceName: 'cloud_name'),
        uploadPreset: gh<String>(instanceName: 'upload_preset'),
      ),
    );
    gh.factory<_i809.AuthRepository>(
      () => _i809.AuthRepository(
        gh<_i114.AuthService>(),
        gh<_i749.UserFirestoreService>(),
        gh<_i708.UserPrefs>(),
      ),
    );
    gh.factory<_i932.DoctorRepository>(
      () => _i932.DoctorRepository(
        firestoreService: gh<_i353.DoctorFirestoreService>(),
        cloudinaryService: gh<_i638.CloudinaryService>(),
        imageService: gh<_i181.ImageService>(),
      ),
    );
    gh.factory<_i594.LoginUseCase>(
      () => _i594.LoginUseCase(gh<_i809.AuthRepository>()),
    );
    gh.lazySingleton<_i669.AuthBloc>(
      () =>
          _i669.AuthBloc(gh<_i809.AuthRepository>(), gh<_i594.LoginUseCase>()),
    );
    gh.factory<_i546.DoctorBloc>(
      () => _i546.DoctorBloc(gh<_i932.DoctorRepository>()),
    );
    return this;
  }
}

class _$LocalStorageModule extends _i63.LocalStorageModule {}

class _$FirebaseModule extends _i616.FirebaseModule {}

class _$CloudinaryConfig extends _i619.CloudinaryConfig {}

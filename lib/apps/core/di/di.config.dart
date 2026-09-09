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

import '../../features/common/auth/data/repo/auth_repository_impl.dart'
    as _i809;
import '../../features/common/auth/data/service/firebase_services/auth_service.dart'
    as _i114;
import '../../features/common/auth/data/service/firebase_services/firestore_service.dart'
    as _i277;
import '../../features/common/auth/data/use_case/login_use_case.dart' as _i594;
import '../../features/common/auth/presentation/controller/auth_bloc.dart'
    as _i669;
import '../data/local_storage_module.dart' as _i44;
import '../data/user_pref.dart' as _i216;
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
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => localStorageModule.sharedPreferences,
      preResolve: true,
    );
    gh.singleton<_i59.FirebaseAuth>(() => firebaseModule.firebaseAuth);
    gh.singleton<_i974.FirebaseFirestore>(() => firebaseModule.firestore);
    gh.singleton<_i116.GoogleSignIn>(() => firebaseModule.googleSignIn);
    gh.lazySingleton<_i277.FirestoreService>(
      () => _i277.FirestoreService(gh<_i974.FirebaseFirestore>()),
    );
    gh.lazySingleton<_i216.UserPrefs>(
      () => _i216.UserPrefs(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i114.AuthService>(
      () =>
          _i114.AuthService(gh<_i59.FirebaseAuth>(), gh<_i116.GoogleSignIn>()),
    );
    gh.factory<_i809.AuthRepository>(
      () => _i809.AuthRepository(
        gh<_i114.AuthService>(),
        gh<_i277.FirestoreService>(),
        gh<_i216.UserPrefs>(),
      ),
    );
    gh.factory<_i594.LoginUseCase>(
      () => _i594.LoginUseCase(gh<_i809.AuthRepository>()),
    );
    gh.lazySingleton<_i669.AuthBloc>(
      () => _i669.AuthBloc(
        gh<_i809.AuthRepository>(),
        loginUseCase: gh<_i594.LoginUseCase>(),
      ),
    );
    return this;
  }
}

class _$LocalStorageModule extends _i44.LocalStorageModule {}

class _$FirebaseModule extends _i616.FirebaseModule {}

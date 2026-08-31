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
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:google_sign_in/google_sign_in.dart' as _i116;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../features/auth/data/repo/auth_repository_impl.dart' as _i607;
import '../../features/auth/data/service/firebase_services/firebase_auth_service.dart'
    as _i172;
import '../../features/auth/data/service/firebase_services/firebase_module.dart'
    as _i508;
import '../../features/auth/data/service/firebase_services/firestore_service.dart'
    as _i555;
import '../../features/auth/presentation/controller/user_bloc.dart' as _i244;
import '../data_bases/cache/local_storage.dart' as _i1020;
import '../data_bases/cache/local_storage_module.dart' as _i2;
import '../data_bases/cache/secure_storage/secure_storage_utils.dart' as _i229;
import '../data_bases/cache/shared_prefs/shared_prefs_utils.dart' as _i264;
import '../data_sources/local/on_boarding/impl/on_boarding_local_data_source_impl.dart'
    as _i442;
import '../data_sources/local/on_boarding/on_boarding_local_data_source.dart'
    as _i221;
import '../data_sources/local/user/impl/user_local_data_source_impl.dart'
    as _i181;
import '../data_sources/local/user/user_local_data_source.dart' as _i509;
import '../data_sources/remote/auth/auth_remote_data_source.dart' as _i502;
import '../data_sources/remote/auth/impl/auth_remote_data_source_impl.dart'
    as _i90;
import '../data_sources/remote/user/impl/user_remote_data_source_impl.dart'
    as _i706;
import '../data_sources/remote/user/user_remote_data_source.dart' as _i612;

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
    gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => localStorageModule.secureStorage,
    );
    gh.lazySingleton<_i555.FirestoreService>(
      () => _i555.FirestoreService(gh<_i974.FirebaseFirestore>()),
    );
    gh.factory<_i612.UserRemoteDataSource>(
      () => _i706.UserRemoteDataSourceImpl(gh<_i555.FirestoreService>()),
    );
    gh.lazySingleton<_i229.SecureStorageUtils>(
      () => _i229.SecureStorageUtils(gh<_i558.FlutterSecureStorage>()),
    );
    gh.lazySingleton<_i264.SharedPrefsUtils>(
      () => _i264.SharedPrefsUtils(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i172.FirebaseAuthService>(
      () => _i172.FirebaseAuthService(
        gh<_i59.FirebaseAuth>(),
        gh<_i116.GoogleSignIn>(),
      ),
    );
    gh.lazySingleton<_i1020.LocalStorage>(
      () => _i1020.LocalStorage(
        gh<_i264.SharedPrefsUtils>(),
        gh<_i229.SecureStorageUtils>(),
      ),
    );
    gh.factory<_i509.UserLocalDataSource>(
      () => _i181.UserLocalDataSourceImpl(gh<_i1020.LocalStorage>()),
    );
    gh.factory<_i221.OnBoardingLocalDataSource>(
      () => _i442.OnBoardingLocalDataSourceImpl(gh<_i1020.LocalStorage>()),
    );
    gh.factory<_i502.AuthRemoteDataSource>(
      () => _i90.AuthRemoteDataSourceImpl(gh<_i172.FirebaseAuthService>()),
    );
    gh.factory<_i607.AuthRepository>(
      () => _i607.AuthRepository(
        gh<_i502.AuthRemoteDataSource>(),
        gh<_i612.UserRemoteDataSource>(),
        gh<_i509.UserLocalDataSource>(),
      ),
    );
    gh.lazySingleton<_i244.UserBloc>(
      () => _i244.UserBloc(gh<_i607.AuthRepository>()),
    );
    return this;
  }
}

class _$LocalStorageModule extends _i2.LocalStorageModule {}

class _$FirebaseModule extends _i508.FirebaseModule {}

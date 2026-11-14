import 'package:doctor_hunt/apps/core/presentation/controller/user/user_bloc.dart';
import 'package:doctor_hunt/apps/core/theme/app_theme.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/controller/auth/auth_bloc.dart';
import 'package:doctor_hunt/apps/features/common/specialties/presentation/controller/specialties_bloc.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import 'apps/core/data/shared_prefs/user_pref.dart';
import 'apps/core/di/di.dart';
import 'apps/core/router/app_routes.dart';
import 'apps/features/common/appointments_management/presentation/controller/appointment_action_bloc.dart';
import 'firebase_options.dart';

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Future.wait([
    Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),
    initializeDateFormatting(),
  ]);

  await configureDependencies();
  final savedLanguage = getIt<UserPrefs>().getSavedLanguage();
  LocaleSettings.setLocaleRaw(savedLanguage);
  Intl.defaultLocale = savedLanguage;
  LocaleSettings.getLocaleStream().listen((locale) {
    Intl.defaultLocale = locale.languageCode;
  });
  FlutterNativeSplash.remove();

  runApp(
    TranslationProvider(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => getIt<AuthBloc>()),
          BlocProvider(create: (context) => getIt<UserBloc>()),
          BlocProvider(create: (context) => getIt<SpecialtiesBloc>()),
          BlocProvider(create: (context) => getIt<AppointmentActionBloc>()),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      locale: TranslationProvider.of(context).flutterLocale,
      supportedLocales: AppLocaleUtils.supportedLocales,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      theme: AppTheme.lightTheme,
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
    );
  }
}

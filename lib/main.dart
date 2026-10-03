import 'package:doctor_hunt/apps/core/theme/app_theme.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/controller/auth_bloc.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'apps/core/data/shared_prefs/user_pref.dart';
import 'apps/core/di/di.dart';
import 'apps/core/router/app_routes.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  configureDependencies();
  runApp(
    TranslationProvider(
      child: BlocProvider(
        // lazy: false,
        create: (context) => getIt<AuthBloc>(),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = createRouter(
      authBloc: getIt<AuthBloc>(),
      userPrefs: getIt<UserPrefs>(),
    );

    return MaterialApp.router(
      theme: AppTheme.lightTheme,
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}

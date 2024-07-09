import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'app/core/firebase_api/notification_service.dart';
import 'app/utils/app_constants.dart';
import 'app/utils/app_go_router.dart';
import 'app/utils/extensions.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await NotificationService().initMessaging();
  await NotificationService.init();
  tz.initializeTimeZones();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      builder: (context, child) {
        return LayoutBuilder(
          builder: (context, constraints) {
            return OrientationBuilder(
              builder: (context, orientation) {
                Responsive().init(constraints, orientation);
                return MaterialApp.router(
                  title: 'ClanOfPets',
                  theme: ThemeData(
                    fontFamily: GoogleFonts.roboto().fontFamily,
                    appBarTheme: const AppBarTheme(
                      surfaceTintColor: AppConstants.white,
                    ),
                    colorScheme: ColorScheme.fromSeed(
                      seedColor: AppConstants.appPrimaryColor,
                    ),
                  ),
                  debugShowCheckedModeBanner: false,
                  routeInformationProvider:
                      AppRouter.router.routeInformationProvider,
                  routeInformationParser:
                      AppRouter.router.routeInformationParser,
                  routerDelegate: AppRouter.router.routerDelegate,
                );
              },
            );
          },
        );
      },
    );
  }
}

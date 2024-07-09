import 'dart:io';

import 'package:clan_of_pets/app/module/home/view%20model/home_provider.dart';
import 'package:clan_of_pets/app/module/onboarding/view/no_internet_screen.dart';
import 'package:clan_of_pets/app/utils/app_go_router.dart';
import 'package:clan_of_pets/app/utils/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/string_const.dart';
import '../../../utils/extensions.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    initialize();
  }

  Future<void> initialize() async {
    final check = await checking();
    String userToken = await StringConst.getUserToken();
    String role = await StringConst.getUserRole();
    Future.delayed(
      const Duration(milliseconds: 4000),
      () {
        if (check) {
          if (userToken.isNotEmpty && role == "temporaryParent") {
            context.read<HomeProvider>().getPetFn();
            context.pushReplacementNamed(AppRouter.petProfile);
          } else if (userToken.isNotEmpty) {
            context.pushReplacementNamed(AppRouter.bottomNavBarWidget);
          } else {
            context.pushReplacementNamed(AppRouter.onboardingScreen);
          }
        } else {
          Routes.push(
              context: context, screen: const NoInternetScreen(), exit: () {});
        }
      },
    );
  }

  bool checkingButton = false;
  Future<bool> checking() async {
    checkingButton = true;
    try {
      final result = await InternetAddress.lookup('www.google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        debugPrint('connected');
        checkingButton = false;
        return true;
      }
      checkingButton = false;
      return false;
    } on SocketException catch (_) {
      debugPrint('not connected');
      checkingButton = false;
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: Responsive.height * 100,
        width: Responsive.width * 100,
        child: Image.asset(
          "assets/images/splashScreen.gif",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

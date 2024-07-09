import 'package:clan_of_pets/app/module/home/view/bottom_nav_screen.dart';
import 'package:clan_of_pets/app/module/onboarding/view/onboarding_screen.dart';
import 'package:clan_of_pets/app/module/onboarding/view/splash_screen.dart';
import 'package:clan_of_pets/app/module/pet%20profile/view/pet_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';

import '../core/string_const.dart';
import '../module/auth/view/login_screen.dart';
import '../module/community/community details/view/post_details_how_vie_link.dart';

class AppRouter {
  static const String initial = '/';
  static const String communityPostScreenVieLink = '/post/:id';
  static const String login = '/login';
  static const String petProfile = '/petProfile';
  static const String bottomNavBarWidget = '/bottomNavBarWidget';
  static const String onboardingScreen = '/onboardingScreen';

// GoRouter configuration
  static final _router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        name: initial,
        path: initial,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        name: login,
        path: login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        name: petProfile,
        path: petProfile,
        builder: (context, state) => const PetProfileScreen(),
      ),
      GoRoute(
        name: bottomNavBarWidget,
        path: bottomNavBarWidget,
        builder: (context, state) => const BottomNavBarWidget(),
      ),
      GoRoute(
        name: onboardingScreen,
        path: onboardingScreen,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/post/:id',
        builder: (context, state) {
          debugPrint("path is ${state.uri.path}");
          StringConst.addDeepLinkUrl(url: state.uri.path);

          return CommunityPostDetailsScreen(
            url: state.uri.path,
            isFromLogin: false,
          );
        },
        redirect: (context, state) async {
          const FlutterSecureStorage storage = FlutterSecureStorage();
          String? token = await storage.read(key: StringConst.token);
          await storage.write(
              key: StringConst.deepLinkUrl, value: state.uri.path);
          String? url = await storage.read(key: StringConst.deepLinkUrl);
          debugPrint("deepLinkUrl is $url");
          debugPrint("token is $token");
          if (token == null) {
            return AppRouter.login;
          }
          return null; // no redirect needed
        },
      ),
    ],
  );
  static GoRouter get router => _router;
}

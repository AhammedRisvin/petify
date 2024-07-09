import 'package:clan_of_pets/app/module/onboarding/view/splash_screen.dart';
import 'package:clan_of_pets/app/utils/app_router.dart';
import 'package:flutter/material.dart';

import '../../../utils/app_constants.dart';
import '../../../utils/app_images.dart';
import '../../../utils/extensions.dart';

class NoInternetScreen extends StatefulWidget {
  const NoInternetScreen({super.key});

  @override
  State<NoInternetScreen> createState() => _NoInternetScreenState();
}

class _NoInternetScreenState extends State<NoInternetScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.white,
      body: SizedBox(
        width: Responsive.width * 100,
        height: Responsive.height * 100,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                opacity: const AlwaysStoppedAnimation(.7),
                AppImages.paymentFailed404,
                width: Responsive.width / 2,
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                "No internet connection!",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    // color: const Color.fromARGB(255, 31, 31, 31),
                    fontWeight: FontWeight.w800,
                    fontSize: 18),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                "Please check your internet connect and try again",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: AppConstants.appPrimaryColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 14),
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                width: Responsive.width * 100,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(234, 234, 78, 67),
                  ),
                  onPressed: () {
                    Routes.push(
                      context: context,
                      screen: const SplashScreen(),
                      exit: () {},
                    );
                  },
                  child: Text(
                    "Try again",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: AppConstants.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

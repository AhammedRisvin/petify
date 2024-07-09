import 'package:flutter/material.dart';

import '../../../utils/app_constants.dart';
import '../../../utils/app_images.dart';

class OnboardingProvider extends ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  List<Widget> buildIndicators(int length, int currentIndex) {
    List<Widget> indicators = [];
    for (int i = 0; i < length; i++) {
      indicators.add(
        Container(
          width: currentIndex == i ? 30.0 : 5.0,
          height: 10.0,
          margin: const EdgeInsets.symmetric(horizontal: 5.0),
          decoration: currentIndex == i
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppConstants.white)
              : const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppConstants.subTextGrey,
                ),
        ),
      );
    }
    return indicators;
  }

  List<OnboardingScreen> screens = [
    OnboardingScreen(
      imagePath: AppImages.onboardingGif1,
      text: 'Connect With your\n Community',
      subtext:
          "Create your pets profile and ensure that your best friends\nare always by your side",
      bgColor: const Color(0xff6B7FDD),
    ),
    OnboardingScreen(
      imagePath: AppImages.onboardingGif2,
      text:
          'Add Your Pet \n                                                                  ',
      subtext:
          "Create your pets profile and ensure that your best friends\n are always by your side",
      bgColor: const Color(0xffEBB862),
    ),
    OnboardingScreen(
      imagePath: AppImages.onboardingGif3,
      text: 'Buy Pet Products or\nBook Pet Service',
      subtext:
          "Create your pets profile and ensure that your best friends\n are always by your side",
      bgColor: const Color(0xffFB9078),
    ),
  ];
}

class OnboardingScreen {
  final String imagePath;
  final String text;
  final String subtext;
  final Color bgColor;

  OnboardingScreen(
      {required this.imagePath,
      required this.text,
      required this.subtext,
      required this.bgColor});
}

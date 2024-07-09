import 'package:clan_of_pets/app/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../helpers/common_widget.dart';
import '../../../helpers/size_box.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_router.dart';
import '../../auth/view/login_screen.dart';
import '../view model/onboarding_provider.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (_) => OnboardingProvider(),
        child: const OnboardingPage(),
      ),
    );
  }
}

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  PageController controller = PageController();
  int index = 0;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<OnboardingProvider>(context);
    final screens = provider.screens;
    final isLastScreen = provider.currentIndex == screens.length - 1;
    // final currentScreen = screens[provider.currentIndex];

    return Scaffold(
      backgroundColor: const Color(0xff151515),
      body: Stack(
        children: [
          PageView.builder(
            itemCount: screens.length,
            controller: controller,
            itemBuilder: (context, index) {
              final data = provider.screens[index];
              return Container(
                color: data.bgColor,
                child: Column(
                  children: [
                    SizeBoxH(Responsive.height * 6),
                    SizedBox(
                      width: Responsive.width * 100,
                      height: Responsive.height * 50,
                      child: Image.asset(
                        data.imagePath,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizeBoxH(Responsive.height * 6.5),
                    SizedBox(
                      width: Responsive.width * 100,
                      height: Responsive.height * 9,
                      child: commonTextWidget(
                        color: AppConstants.white,
                        text: data.text,
                        fontSize: 23,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizeBoxH(Responsive.height * 1.2),
                    SizedBox(
                      width: Responsive.width * 95,
                      child: commonTextWidget(
                        color: AppConstants.white,
                        text: data.subtext,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            },
            onPageChanged: (index) {
              this.index = index;
              provider.setCurrentIndex(index);
            },
          ),
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: provider.buildIndicators(
                      screens.length, provider.currentIndex),
                ),
                SizeBoxH(Responsive.height * 6.5),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      isLastScreen
                          ? const SizedBox.shrink()
                          : CommonInkwell(
                              onTap: () {
                                Routes.pushRemoveUntil(
                                  context: context,
                                  screen: const LoginScreen(),
                                );
                              },
                              child: Container(
                                  height: 40,
                                  width: 90,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    border:
                                        Border.all(color: AppConstants.white),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: const Center(
                                    child: commonTextWidget(
                                      color: AppConstants.white,
                                      text: "Skip",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )),
                            ),
                      CommonInkwell(
                        onTap: () {
                          if (index < 2) {
                            controller.animateToPage(index + 1,
                                duration: const Duration(milliseconds: 100),
                                curve: Curves.bounceIn);
                          } else {
                            Routes.pushRemoveUntil(
                              context: context,
                              screen: const LoginScreen(),
                            );
                          }
                        },
                        child: Container(
                            height: 40,
                            width: 90,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(color: AppConstants.white),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Center(
                              child: commonTextWidget(
                                color: AppConstants.white,
                                text: "Continue",
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

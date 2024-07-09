import 'package:clan_of_pets/app/helpers/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../helpers/size_box.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_images.dart';
import '../../../utils/extensions.dart';
import '../view model/home_provider.dart';

class BottomNavBarWidget extends StatefulWidget {
  const BottomNavBarWidget({super.key});

  @override
  State<BottomNavBarWidget> createState() => _BottomNavBarWidgetState();
}

class _BottomNavBarWidgetState extends State<BottomNavBarWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.white,
      body: Consumer<HomeProvider>(
        builder: (context, value, child) => Center(
          child: value.widgetOptions.elementAt(value.selectedIndex),
        ),
      ),
      bottomNavigationBar: Card(
        color: AppConstants.white,
        margin: const EdgeInsets.all(0),
        surfaceTintColor: Colors.transparent,
        shadowColor: AppConstants.black,
        elevation: 4,
        shape: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AppConstants.black10,
          ),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(25),
            topLeft: Radius.circular(25),
          ),
        ),
        child: Container(
          height: Responsive.height * 8.2,
          width: Responsive.width * 100,
          decoration: const BoxDecoration(
            color: AppConstants.greyContainerBg,
          ),
          child: Consumer<HomeProvider>(
            builder: (context, value, child) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  enableFeedback: false,
                  focusColor: Colors.transparent,
                  onPressed: () {
                    value.onItemTapped(index: 0);
                  },
                  icon: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: value.selectedIndex == 0
                            ? BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 4,
                                style: BorderStyle.solid)
                            : BorderSide.none,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        value.selectedIndex == 0
                            ? Image.asset(
                                AppImages.homeTapped,
                                height: Responsive.height * 2.5,
                                width: Responsive.width * 6,
                                fit: BoxFit.fill,
                              )
                            : Image.asset(
                                AppImages.homeUntapped,
                                height: Responsive.height * 2.5,
                                width: Responsive.width * 6,
                                fit: BoxFit.fill,
                              ),
                        SizeBoxH(Responsive.height * .5),
                        commonTextWidget(
                          text: 'Home',
                          color: value.selectedIndex == 0
                              ? AppConstants.appPrimaryColor
                              : AppConstants.black,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  enableFeedback: false,
                  onPressed: () {
                    value.onItemTapped(index: 1);
                  },
                  icon: Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: value.selectedIndex == 1
                                ? BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    width: 4,
                                    style: BorderStyle.solid)
                                : BorderSide.none)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        value.selectedIndex == 1
                            ? Image.asset(
                                AppImages.serviceTapped,
                                height: Responsive.height * 2.5,
                                width: Responsive.width * 6,
                                fit: BoxFit.fill,
                              )
                            : Image.asset(
                                AppImages.serviceUntapped,
                                height: Responsive.height * 2.5,
                                width: Responsive.width * 6,
                                fit: BoxFit.fill,
                              ),
                        SizeBoxH(Responsive.height * .5),
                        commonTextWidget(
                          text: 'Services',
                          color: value.selectedIndex == 1
                              ? Theme.of(context).primaryColor
                              : AppConstants.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  enableFeedback: false,
                  onPressed: () {
                    value.onItemTapped(index: 2);
                  },
                  icon: Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: value.selectedIndex == 2
                                ? BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    width: 4,
                                    style: BorderStyle.solid)
                                : BorderSide.none)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        value.selectedIndex == 2
                            ? Image.asset(
                                AppImages.communityTapped,
                                height: Responsive.height * 2.5,
                                width: Responsive.width * 6,
                                fit: BoxFit.fill,
                              )
                            : Image.asset(
                                AppImages.socializeUntapped,
                                height: Responsive.height * 2.5,
                                width: Responsive.width * 6,
                                fit: BoxFit.fill,
                              ),
                        SizeBoxH(Responsive.height * .5),
                        commonTextWidget(
                          text: 'Community',
                          letterSpacing: -0.1,
                          color: value.selectedIndex == 2
                              ? Theme.of(context).primaryColor
                              : AppConstants.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  enableFeedback: false,
                  onPressed: () {
                    value.onItemTapped(index: 3);
                  },
                  icon: Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: value.selectedIndex == 3
                                ? BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    width: 4,
                                    style: BorderStyle.solid)
                                : BorderSide.none)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        value.selectedIndex == 3
                            ? Image.asset(
                                AppImages.blogTapped,
                                height: Responsive.height * 2.5,
                                width: Responsive.width * 6,
                                fit: BoxFit.fill,
                              )
                            : Image.asset(
                                AppImages.blogUntapped,
                                height: Responsive.height * 2.5,
                                width: Responsive.width * 6,
                                fit: BoxFit.fill,
                              ),
                        SizeBoxH(Responsive.height * .5),
                        commonTextWidget(
                          text: 'Blog',
                          color: value.selectedIndex == 3
                              ? Theme.of(context).primaryColor
                              : AppConstants.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  enableFeedback: false,
                  onPressed: () {
                    value.onItemTapped(index: 4);
                  },
                  icon: Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: value.selectedIndex == 4
                                ? BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    width: 4,
                                    style: BorderStyle.solid)
                                : BorderSide.none)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        value.selectedIndex == 4
                            ? Image.asset(
                                AppImages.profileTapped,
                                height: Responsive.height * 2.5,
                                width: Responsive.width * 6,
                                fit: BoxFit.fill,
                              )
                            : Image.asset(
                                AppImages.profileUntapped,
                                height: Responsive.height * 2.5,
                                width: Responsive.width * 6,
                                fit: BoxFit.fill,
                              ),
                        SizeBoxH(Responsive.height * .5),
                        commonTextWidget(
                          text: 'Profile',
                          color: value.selectedIndex == 4
                              ? Theme.of(context).primaryColor
                              : AppConstants.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: deprecated_member_use

import 'package:clan_of_pets/app/helpers/size_box.dart';
import 'package:clan_of_pets/app/module/user%20profile/view/view_profile_screen.dart';
import 'package:clan_of_pets/app/utils/app_images.dart';
import 'package:clan_of_pets/app/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/string_const.dart';
import '../../../helpers/common_widget.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_router.dart';
import '../../home/widget/common_grey_widget.dart';
import '../../widget/confirmation_widget.dart';
import 'privacy_policy.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.white,
      appBar: AppBar(
        backgroundColor: AppConstants.white,
        title: const commonTextWidget(
          text: "Settings",
          color: AppConstants.black,
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
        leading: IconButton(
          onPressed: () {
            Routes.back(context: context);
          },
          style: const ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(
              AppConstants.greyContainerBg,
            ),
          ),
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 19,
            color: AppConstants.appPrimaryColor,
          ),
        ),
      ),
      body: Container(
        height: Responsive.height * 100,
        width: Responsive.width * 100,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const commonTextWidget(
              color: AppConstants.black40,
              text: "General",
              letterSpacing: -0.2,
              fontSize: 16,
            ),
            SizeBoxH(Responsive.height * 1.5),
            Card(
              elevation: 5,
              shadowColor: AppConstants.greyContainerBg,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: const BorderSide(
                  color: AppConstants.greyContainerBg,
                  width: 1,
                ),
              ),
              child: Container(
                width: Responsive.width * 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppConstants.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SettingsListTileWidget(
                      title: "My Profile",
                      icon: AppImages.settingsMyProfile,
                      bgColor: const Color(0xffFFEAD7),
                      onTap: () {
                        Routes.push(
                          context: context,
                          screen: const ViewProfileScreen(),
                          exit: () {},
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizeBoxH(Responsive.height * 2.5),
            const commonTextWidget(
              color: AppConstants.black40,
              text: "Privacy Details",
              letterSpacing: -0.2,
              fontSize: 16,
            ),
            SizeBoxH(Responsive.height * 1.5),
            Card(
              elevation: 5,
              shadowColor: AppConstants.greyContainerBg,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: const BorderSide(
                  color: AppConstants.greyContainerBg,
                  width: 1,
                ),
              ),
              child: Container(
                width: Responsive.width * 100,
                height: Responsive.height * 32.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppConstants.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SettingsListTileWidget(
                      title: "App help",
                      icon: AppImages.settingsAppHelp,
                      bgColor: const Color(0xffEDEBFF),
                      onTap: () async {
                        const phoneNumber = '+91 8921633521';
                        const phoneUrl = 'tel:$phoneNumber';

                        if (await canLaunch(phoneUrl)) {
                          await launch(phoneUrl);
                        } else {
                          throw 'Could not launch $phoneUrl';
                        }
                      },
                    ),
                    SettingsListTileWidget(
                      title: "Privacy Policy",
                      icon: AppImages.settingsPrivacy,
                      bgColor: const Color(0xffFFE6EC),
                      onTap: () {
                        Routes.push(
                          context: context,
                          screen: const PrivacyPolicyAndTermsAndConditionScreen(
                            isFromPrivacyPolicy: true,
                          ),
                          exit: () {},
                        );
                      },
                    ),
                    SettingsListTileWidget(
                      title: "Terms and Condition",
                      icon: AppImages.settingsTerms,
                      bgColor: const Color(0xffFBE6FF),
                      onTap: () {
                        Routes.push(
                          context: context,
                          screen: const PrivacyPolicyAndTermsAndConditionScreen(
                            isFromPrivacyPolicy: false,
                          ),
                          exit: () {},
                        );
                      },
                    ),
                    SettingsListTileWidget(
                      title: "Share a friend",
                      icon: AppImages.settingsRefer,
                      bgColor: const Color(0xffE5F3FC),
                      onTap: () {
                        Share.share(
                          'https://play.google.com/store/apps/details?id=com.owpmf.clanofpetsdemo',
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            CommonButton(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => ConfirmationWidget(
                    image: AppImages.logoutPng,
                    title: "LOGOUT",
                    message: "Are you sure you want to logout ?",
                    onTap: () {
                      StringConst.logout(
                        context: context,
                      );
                    },
                  ),
                );
              },
              isIconShow: true,
              isFullRoundedButton: true,
              text: "Logout",
              size: 14,
              bgColor: const Color(0xffFFCACD),
              textColor: const Color(0xffEE5158),
              borderColor: const Color(0xffFFCACD),
              width: Responsive.width * 100,
              height: 50,
              isFromLogout: true,
            ),
            SizeBoxH(Responsive.height * 5),
          ],
        ),
      ),
    );
  }
}

class SettingsListTileWidget extends StatelessWidget {
  final bool isNotification;
  final String title;
  final Color bgColor;
  final String icon;
  final void Function() onTap;
  const SettingsListTileWidget({
    super.key,
    this.isNotification = false,
    required this.title,
    required this.bgColor,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(
        title,
        style: const TextStyle(
          color: AppConstants.black,
          letterSpacing: -0.4,
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ),
      contentPadding: const EdgeInsets.only(
        left: 30,
        right: 20,
      ),
      leading: CommonGreyContainer(
        height: Responsive.height * 4,
        width: Responsive.width * 8,
        borderRadius: BorderRadius.circular(11),
        imageHeight: 16,
        image: icon,
        bgColor: bgColor,
      ),
      trailing: isNotification
          ? SizedBox(
              width: Responsive.width * 5,
              child: Transform.scale(
                scale: 0.8,
                child: Switch(
                  value: isNotification,
                  onChanged: (value) {},
                  activeColor: AppConstants.appPrimaryColor,
                  inactiveThumbColor: AppConstants.appPrimaryColor,
                  inactiveTrackColor: AppConstants.greyContainerBg,
                ),
              ),
            )
          : const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 14,
              color: AppConstants.black,
            ),
    );
  }
}

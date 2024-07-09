import 'package:clan_of_pets/app/helpers/common_widget.dart';
import 'package:clan_of_pets/app/helpers/size_box.dart';
import 'package:clan_of_pets/app/module/home/widget/common_grey_widget.dart';
import 'package:clan_of_pets/app/module/widget/confirmation_widget.dart';
import 'package:clan_of_pets/app/utils/app_constants.dart';
import 'package:clan_of_pets/app/utils/app_images.dart';
import 'package:clan_of_pets/app/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/string_const.dart';
import '../../../utils/app_router.dart';
import '../../lostgem/view/lost_gem.dart';
import '../../pet profile/view/myappointment/appointment.dart';
import '../../settings/view/settings_screen.dart';
import '../../user profile/view/view_profile_screen.dart';
import '../view model/home_provider.dart';
import '../widget/custom_app_bar.dart';
import 'home_screen.dart';
import 'switch_account_screen.dart';
import 'wallet_screen.dart';

class DrawerScreen extends StatefulWidget {
  final String userName;
  final String image;
  const DrawerScreen({super.key, required this.userName, required this.image});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HomeProvider>().getUserRole();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.appPrimaryColor,
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            height: Responsive.height * 100,
            width: Responsive.width * 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  AppImages.drawerBgGif,
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: AppConstants.transparent,
                  title: CustomAppBar(
                    color: AppConstants.white,
                    bgColor: AppConstants.transparent,
                    onTap: () {},
                    title: widget.userName.isEmpty == true
                        ? "User"
                        : widget.userName,
                    subtitle: "Work name",
                    isFromDrawer: true,
                    image: widget.image.isEmpty == true
                        ? "https://expertphotography.b-cdn.net/wp-content/uploads/2018/10/cool-profile-pictures-retouching-1.jpg"
                        : widget.image,
                  ),
                  actions: [
                    Selector<HomeProvider, String>(
                      selector: (p0, p1) => p1.userRole,
                      builder: (context, value, child) => value == "coParent"
                          ? const SizedBox.shrink()
                          : CommonInkwell(
                              onTap: () {
                                Routes.push(
                                  context: context,
                                  screen: const ViewProfileScreen(),
                                  exit: () {},
                                );
                              },
                              child: const CommonBannerButtonWidget(
                                bgColor: AppConstants.white,
                                text: "View Profile",
                                fontSize: 10,
                                borderColor: Colors.transparent,
                                textColor: AppConstants.appPrimaryColor,
                                width: 80,
                                height: 28,
                              ),
                            ),
                    ),
                    const SizeBoxV(10)
                  ],
                ),
                SizeBoxH(Responsive.height * 18.5),
                DrawerRowWidget(
                  image: AppImages.drawerServiceIcon,
                  title: "Services",
                  onTap: () {
                    Routes.back(context: context);
                    context.read<HomeProvider>().onItemTapped(index: 1);
                  },
                ),
                SizeBoxH(Responsive.height * 2.8),
                DrawerRowWidget(
                  image: AppImages.drawerAppoinmentsIcon,
                  title: "My Appointments",
                  onTap: () {
                    Routes.push(
                      context: context,
                      screen: const MyAppointmentScreen(),
                      exit: () {},
                    );
                  },
                ),
                SizeBoxH(Responsive.height * 2.8),
                DrawerRowWidget(
                  image: AppImages.drawerMyPetsIcon,
                  onTap: () {
                    Routes.back(context: context);
                    context.read<HomeProvider>().onItemTapped(index: 4);
                  },
                  title: "My Pets",
                ),
                SizeBoxH(Responsive.height * 2.8),
                DrawerRowWidget(
                  image: AppImages.drawerLostGemIcon,
                  onTap: () {
                    Routes.push(
                      context: context,
                      screen: const LostGemScreen(),
                      exit: () {},
                    );
                  },
                  title: "Lost gems",
                ),
                SizeBoxH(Responsive.height * 2.8),
                DrawerRowWidget(
                  image: AppImages.drawerWalletIcon,
                  onTap: () {
                    Routes.push(
                      context: context,
                      screen: const WalletScreen(),
                      exit: () {},
                    );
                  },
                  title: "Wallet",
                ),
                SizeBoxH(Responsive.height * 2.8),
                DrawerRowWidget(
                  image: AppImages.drawerSwitchAccountIcon,
                  onTap: () {
                    Routes.push(
                      context: context,
                      screen: const SwitchAccountScreen(),
                      exit: () {},
                    );
                  },
                  title: "Switch Account",
                ),
                SizeBoxH(Responsive.height * 2.8),
                DrawerRowWidget(
                  image: AppImages.drawerSettingsIcon,
                  onTap: () {
                    Routes.push(
                      context: context,
                      screen: const SettingsScreen(),
                      exit: () {},
                    );
                  },
                  title: "Settings",
                ),
                SizeBoxH(Responsive.height * 2.8),
                DrawerRowWidget(
                  image: AppImages.drawerServiceIcon,
                  onTap: () {
                    showAdaptiveDialog(
                      context: context,
                      builder: (context) => ConfirmationWidget(
                        image: AppImages.deletePng,
                        title: "DELETE ACCOUNT",
                        message:
                            "Are you sure you want to delete your account ?",
                        onTap: () {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Your account will be deleted soon, Thank you for being with us.",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                  title: "Delete Account",
                ),
                const Spacer(),
                DrawerRowWidget(
                  image: AppImages.drawerLogoutIcon,
                  title: "Logout",
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => ConfirmationWidget(
                        image: AppImages.logoutPng,
                        title: "LOGOUT",
                        message: "Are you sure you want to logout ?",
                        onTap: () {
                          StringConst.logout(context: context);
                        },
                      ),
                    );
                  },
                ),
                const SizeBoxH(20)
              ],
            ),
          ),
          Positioned(
            top: Responsive.height * 100 / 2 - Responsive.height * 30,
            left: Responsive.width * 70,
            child: Transform.rotate(
              angle: -3.14 / 11,
              child: GestureDetector(
                onTap: () {
                  Routes.back(context: context);
                },
                child: Container(
                  height: Responsive.height * 71,
                  width: Responsive.width * 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DrawerRowWidget extends StatelessWidget {
  final String image;
  final String title;
  final void Function() onTap;
  const DrawerRowWidget({
    super.key,
    required this.image,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CommonInkwell(
      onTap: onTap,
      child: Row(
        children: [
          CommonGreyContainer(
            height: 40,
            width: 40,
            bgColor: AppConstants.white.withOpacity(0.4),
            borderRadius: BorderRadius.circular(100),
            imageHeight: 18,
            image: image,
          ),
          const SizeBoxV(25),
          commonTextWidget(
            color: AppConstants.white,
            text: title,
            fontSize: 16,
          ),
        ],
      ),
    );
  }
}

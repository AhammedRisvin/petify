import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:clan_of_pets/app/helpers/common_widget.dart';
import 'package:clan_of_pets/app/helpers/size_box.dart';
import 'package:clan_of_pets/app/module/Pet%20services/view_model/services_provider.dart';
import 'package:clan_of_pets/app/module/adopt_a_pet/view/adopt_a_pet_home_screen.dart';
import 'package:clan_of_pets/app/module/home/view%20model/home_provider.dart';
import 'package:clan_of_pets/app/module/home/view/drawer_screen.dart';
import 'package:clan_of_pets/app/module/user%20profile/view%20model/profile_provider.dart';
import 'package:clan_of_pets/app/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/app_images.dart';
import '../../../utils/app_router.dart';
import '../../../utils/extensions.dart';
import '../../Dating/view/dating_homescreen.dart';
import '../../Pet services/view/service_form_screen.dart';
import '../widget/add_new_pet_carousal_widget.dart';
import '../widget/common_grey_widget.dart';
import '../widget/custom_app_bar.dart';
import '../widget/home_carousal_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    this.onTap,
  });

  final void Function()? onTap;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HomeProvider>().getPetFn();
    context.read<EditController>().getUserProfileDetailsFn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.white,
      appBar: AppBar(
        backgroundColor: AppConstants.white,
        automaticallyImplyLeading: false,
        title: Consumer<EditController>(
          builder: (context, value, child) => CustomAppBar(
            color: AppConstants.appPrimaryColor,
            bgColor: AppConstants.white,
            onTap: () {},
            title: "Welcome Back",
            subtitle: value.getUserProfileModel.details?.firstName == null ||
                    value.getUserProfileModel.details?.firstName?.isEmpty ==
                        true
                ? "User"
                : value.getUserProfileModel.details?.firstName ?? "",
            image: value.getUserProfileModel.details?.profile == null ||
                    value.getUserProfileModel.details?.profile?.isEmpty == true
                ? "https://expertphotography.b-cdn.net/wp-content/uploads/2018/10/cool-profile-pictures-retouching-1.jpg"
                : value.getUserProfileModel.details?.profile ?? "",
          ),
        ),
        actions: [
          const SizeBoxV(10),
          Consumer<EditController>(
            builder: (context, value, child) => CommonGreyContainer(
              borderRadius: BorderRadius.circular(100),
              height: 30,
              width: 30,
              onTap: () {
                Routes.push(
                  context: context,
                  screen: DrawerScreen(
                    userName:
                        value.getUserProfileModel.details?.firstName ?? "",
                    image: value.getUserProfileModel.details?.profile ?? "",
                  ),
                  exit: () {},
                );
              }, //widget.onTap
              image: AppImages.moreIcon,
              imageHeight: 12,
            ),
          ),
          const SizeBoxV(10),
        ],
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child:
            // context.read<HomeProvider>().getPetModel.pets == null
            //     ? EmptyScreenWidget(
            //         text: "Server is Busy, please try again later",
            //         image: AppImages.noAppoinmentImage,
            //         height: Responsive.height * 80)
            //     :
            Column(
          children: [
            const SizeBoxH(18),
            Consumer<HomeProvider>(
              builder: (context, provider, child) => CarouselSlider.builder(
                options: CarouselOptions(
                    height: Responsive.height * 22,
                    viewportFraction: .95,
                    initialPage: 0,
                    enableInfiniteScroll: false,
                    reverse: false,
                    autoPlay: true,
                    pageSnapping: false,
                    autoPlayInterval: const Duration(seconds: 5),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 400),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    enlargeFactor: 0,
                    scrollDirection: Axis.horizontal,
                    scrollPhysics: const ClampingScrollPhysics(),
                    onPageChanged: (index, reason) {}),
                itemCount: provider.getPetModel.pets?.length ?? 0,
                itemBuilder:
                    (BuildContext context, int itemIndex, int pageViewIndex) {
                  var petData = provider.getPetModel.pets?[itemIndex];
                  if (petData?.name != null) {
                    return HomeCarousalWidget(
                      petData: petData,
                      index: itemIndex,
                    );
                  } else {
                    return const AddNewPetCarousalWidget();
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Consumer<ServiceProvider>(
                builder: (context, provider, child) => Column(
                  children: [
                    const SizeBoxH(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const commonTextWidget(
                          color: AppConstants.black,
                          text: "Pet Services",
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          letterSpacing: 0.2,
                        ),
                        CommonInkwell(
                          onTap: () {
                            context.read<HomeProvider>().onItemTapped(index: 1);
                          },
                          child: const Row(
                            children: [
                              commonTextWidget(
                                color: AppConstants.black,
                                text: "See all",
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                              SizeBoxV(5),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 12,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizeBoxH(Responsive.height * 1),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: Responsive.height * 0.095,
                      ),
                      itemCount: provider.serviceImages.length,
                      itemBuilder: (context, index) {
                        final image = provider.serviceImages[index];
                        final name = provider.serviceNames[index];
                        return CommonInkwell(
                          onTap: () {
                            log("widget.title$name");
                            if (name == 'Dating') {
                              Routes.push(
                                context: context,
                                screen: const DatingHomeScreen(),
                                exit: () {},
                              );
                            } else if (name == 'Community') {
                              context
                                  .read<HomeProvider>()
                                  .onItemTapped(index: 2);
                            } else {
                              Routes.push(
                                context: context,
                                screen: ServiceFormScreen(title: name),
                                exit: () {},
                              );
                            }
                          },
                          child: Column(
                            children: [
                              Container(
                                height: Responsive.height * 10,
                                width: Responsive.width * 20,
                                padding: const EdgeInsets.all(10),
                                margin: const EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0xffF3F3F5),
                                ),
                                child: Image.asset(
                                  image,
                                ),
                              ),
                              commonTextWidget(
                                color: AppConstants.black,
                                text: name,
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    SizeBoxH(Responsive.height * 1.8),
                    CommonInkwell(
                      onTap: () {
                        Routes.push(
                          context: context,
                          screen: const AdoptAPetHomeScreen(),
                          exit: () {},
                        );
                      },
                      child: Container(
                        width: Responsive.width * 100,
                        height: Responsive.height * 22,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: const DecorationImage(
                            image: AssetImage(
                              "assets/images/bottomBannerHome.png",
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    SizeBoxH(Responsive.height * 2),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CommonBannerButtonWidget extends StatelessWidget {
  final Color bgColor;
  final Color textColor;
  final Color borderColor;
  final double width;
  final String text;
  final double fontSize;
  final void Function()? onTap;
  final double height;
  final double? radius;
  const CommonBannerButtonWidget({
    super.key,
    required this.bgColor,
    required this.text,
    required this.borderColor,
    required this.textColor,
    required this.width,
    this.height = 35,
    this.onTap,
    this.fontSize = 14,
    this.radius = 100,
  });

  @override
  Widget build(BuildContext context) {
    return CommonInkwell(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? 8),
          color: bgColor,
          border: Border.all(
            color: borderColor,
          ),
        ),
        child: Center(
          child: commonTextWidget(
            color: textColor,
            text: text,
            fontSize: fontSize,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.3,
          ),
        ),
      ),
    );
  }
}

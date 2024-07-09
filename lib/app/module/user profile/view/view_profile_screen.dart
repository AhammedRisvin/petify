import 'package:clan_of_pets/app/helpers/size_box.dart';
import 'package:clan_of_pets/app/module/home/view/home_screen.dart';
import 'package:clan_of_pets/app/utils/app_constants.dart';
import 'package:clan_of_pets/app/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../helpers/common_widget.dart';
import '../../../utils/app_images.dart';
import '../../../utils/app_router.dart';
import '../../../utils/extensions.dart';
import '../../pet profile/view/pet_profile_screen.dart';
import '../view model/profile_provider.dart';
import 'add co-parent && add temporary access/add_co_parent_and_add_temp_access.dart';
import 'co_parent_listing_screen.dart';
import 'edit_profile_screen.dart';

class ViewProfileScreen extends StatefulWidget {
  const ViewProfileScreen({super.key});

  @override
  State<ViewProfileScreen> createState() => _ViewProfileScreenState();
}

class _ViewProfileScreenState extends State<ViewProfileScreen> {
  @override
  void initState() {
    super.initState();
    context.read<EditController>().getUserProfileDetailsFn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.white,
      body: Consumer<EditController>(
        builder: (context, provider, child) {
          if (provider.getUserProfileStatus == GetUserProfileStatus.loading) {
            return const Center(
              child: SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: AppConstants.appPrimaryColor,
                ),
              ),
            );
          } else {
            return provider.getUserProfileStatus == GetUserProfileStatus.loaded
                ? Column(
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                            height: Responsive.height * 35,
                            width: Responsive.width * 100,
                            child: Column(
                              children: [
                                commonNetworkImage(
                                  url: provider.getUserProfileModel.details
                                                  ?.coverImage ==
                                              null ||
                                          provider.getUserProfileModel.details
                                                  ?.coverImage?.isEmpty ==
                                              true
                                      ? "https://plus.unsplash.com/premium_photo-1676479610722-1f855a4f0cac?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8ZG9nJTIwcHJvZmlsZSUyMHBpY3R1cmV8ZW58MHx8MHx8fDA="
                                      : provider.getUserProfileModel.details
                                              ?.coverImage ??
                                          "",
                                  height: Responsive.height * 21,
                                  width: Responsive.width * 100,
                                  isTopCurved: false,
                                  isBottomCurved: false,
                                  isBorder: true,
                                ),
                                SizeBoxH(Responsive.height * 1.3),
                                provider.getUserProfileModel.details
                                            ?.firstName ==
                                        ""
                                    ? const SizedBox.shrink()
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          CommonBannerButtonWidget(
                                            onTap: () {
                                              if ((provider.getUserProfileModel
                                                          .details?.pets ??
                                                      0) >
                                                  0) {
                                                Routes.push(
                                                    context: context,
                                                    screen:
                                                        const AddCoParentOrAddTempAccessScreen(
                                                      isAddCoParent: true,
                                                    ),
                                                    exit: () {});
                                              } else {
                                                toast(context,
                                                    title:
                                                        "Add Pet to continue",
                                                    backgroundColor:
                                                        Colors.red);
                                              }
                                            },
                                            bgColor:
                                                AppConstants.appPrimaryColor,
                                            text: "Add Co - parent",
                                            borderColor: Colors.transparent,
                                            textColor: AppConstants.white,
                                            width: 100,
                                            height: 28,
                                            fontSize: 9,
                                          ),
                                          SizeBoxV(Responsive.width * 33),
                                          CommonBannerButtonWidget(
                                            onTap: () {
                                              if ((provider.getUserProfileModel
                                                          .details?.pets ??
                                                      0) >
                                                  0) {
                                                context
                                                    .read<EditController>()
                                                    .getPetsFun();
                                                Routes.push(
                                                    context: context,
                                                    screen:
                                                        const AddCoParentOrAddTempAccessScreen(
                                                      isAddCoParent: false,
                                                    ),
                                                    exit: () {});
                                              } else {
                                                toast(context,
                                                    title:
                                                        "Add Pet to continue",
                                                    backgroundColor:
                                                        Colors.red);
                                              }
                                            },
                                            bgColor:
                                                AppConstants.appPrimaryColor,
                                            text: "Temporary Access",
                                            borderColor: Colors.transparent,
                                            textColor: AppConstants.white,
                                            width: 100,
                                            height: 28,
                                            fontSize: 9,
                                          ),
                                        ],
                                      ),
                                SizeBoxH(Responsive.height * 2),
                                commonTextWidget(
                                  color: AppConstants.black,
                                  text: provider.getUserProfileModel.details
                                          ?.firstName ??
                                      "",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                ),
                                // SizeBoxH(Responsive.height * 0.5),
                                commonTextWidget(
                                  color: AppConstants.black,
                                  text: provider.getUserProfileModel.details
                                          ?.lastName ??
                                      "",
                                  fontSize: 14,
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: Responsive.height * 15,
                            left: Responsive.width * 37.5,
                            right: Responsive.width * 37.5,
                            child: CircleAvatar(
                              radius: 47,
                              backgroundColor: AppConstants.white,
                              child: provider.getUserProfileModel.details
                                              ?.profile ==
                                          null ||
                                      provider.getUserProfileModel.details
                                              ?.profile?.isEmpty ==
                                          true
                                  ? const commonNetworkImage(
                                      url:
                                          "https://cdn.pixabay.com/photo/2017/11/14/13/06/kitty-2948404_640.jpg",
                                      height: 85,
                                      width: 85,
                                      radius: 100,
                                    )
                                  : commonNetworkImage(
                                      url: provider.getUserProfileModel.details
                                              ?.profile ??
                                          "",
                                      height: 85,
                                      width: 85,
                                      radius: 100,
                                    ),
                            ),
                          ),
                          Positioned(
                              top: 50,
                              left: 10,
                              right: 10,
                              child: SizedBox(
                                width: Responsive.width * 100,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      child: Row(
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              Routes.back(context: context);
                                            },
                                            style: const ButtonStyle(
                                              backgroundColor:
                                                  WidgetStatePropertyAll(
                                                AppConstants.greyContainerBg2,
                                              ),
                                            ),
                                            icon: const Icon(
                                              Icons.arrow_back_ios_new,
                                              size: 19,
                                              color:
                                                  AppConstants.appPrimaryColor,
                                            ),
                                          ),
                                          const SizeBoxV(10),
                                          const commonTextWidget(
                                            color: AppConstants.white,
                                            text: "Profile",
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ],
                                      ),
                                    ),
                                    provider.getUserProfileModel.details
                                                ?.firstName ==
                                            ""
                                        ? const SizedBox.shrink()
                                        : SizedBox(
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  height: 35,
                                                  child: ElevatedButton.icon(
                                                    style: ElevatedButton.styleFrom(
                                                        elevation: 0,
                                                        backgroundColor:
                                                            AppConstants
                                                                .greyContainerBg2,
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8)),
                                                    onPressed: () {
                                                      provider.getUserProfileModel.link
                                                                      ?.isEmpty ==
                                                                  true ||
                                                              provider.getUserProfileModel
                                                                      .link ==
                                                                  null
                                                          ? toast(context,
                                                              title: "No  link")
                                                          : Share.share(
                                                              provider.getUserProfileModel
                                                                      .link ??
                                                                  "",
                                                            );
                                                    },
                                                    icon: Image.asset(
                                                      "assets/images/shareIcon.png",
                                                      height: 12,
                                                    ),
                                                    label:
                                                        const commonTextWidget(
                                                      align: TextAlign.start,
                                                      color: AppConstants
                                                          .appPrimaryColor,
                                                      text: "Share",
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                                const SizeBoxV(10),
                                                CommonInkwell(
                                                  onTap: () {
                                                    Routes.push(
                                                      context: context,
                                                      screen: EditProfileScreen(
                                                        data: provider
                                                            .getUserProfileModel
                                                            .details,
                                                        isEdit: true,
                                                      ),
                                                      exit: () {},
                                                    );
                                                  },
                                                  child: CircleAvatar(
                                                    radius: 16,
                                                    backgroundColor:
                                                        AppConstants
                                                            .greyContainerBg2,
                                                    child: Image.asset(
                                                      "assets/images/editProfileIcon.png",
                                                      height: 16,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                  ],
                                ),
                              )),
                        ],
                      ),
                      SizeBoxH(Responsive.height * 2),
                      provider.getUserProfileModel.details?.firstName == ""
                          ? Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Card(
                                elevation: 3, // Increase the elevation value
                                shadowColor: AppConstants.greyContainerBg,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side: const BorderSide(
                                    color: AppConstants.greyContainerBg,
                                    width: 1,
                                  ),
                                ),
                                child: CommonInkwell(
                                  onTap: () {
                                    Routes.push(
                                        context: context,
                                        screen: const EditProfileScreen(
                                          isEdit: false,
                                        ),
                                        exit: () {});
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: AppConstants.white,
                                    ),
                                    width: Responsive.width * 100,
                                    height: Responsive.height * 50,
                                    child: const Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.add,
                                            size: 50,
                                            color: AppConstants.appPrimaryColor,
                                          ),
                                          SizeBoxH(10),
                                          commonTextWidget(
                                            color: AppConstants.black,
                                            text: "Add your details",
                                            fontSize: 18,
                                            fontWeight: FontWeight.w800,
                                            align: TextAlign.center,
                                            maxLines: 2,
                                            overFlow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Card(
                                elevation: 3, // Increase the elevation value
                                shadowColor: AppConstants.greyContainerBg,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side: const BorderSide(
                                    color: AppConstants.greyContainerBg,
                                    width: 1,
                                  ),
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: AppConstants.white,
                                  ),
                                  // height: Responsive.height * 42,
                                  width: Responsive.width * 100,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ProfileCommonListTileWidget(
                                        onTap: () {},
                                        image: AppImages.aboutMeIcon,
                                        title: "About  me",
                                        isTrailingShow: false,
                                        isFromProfile: true,
                                        subTitle: provider.getUserProfileModel
                                                .details?.firstName ??
                                            "",
                                      ),
                                      const SizeBoxH(15),
                                      ProfileCommonListTileWidget(
                                        onTap: () {},
                                        title: "Nationality",
                                        image: AppImages.nationalityIcon,
                                        isTrailingShow: false,
                                        isFromProfile: true,
                                        subTitle: provider.getUserProfileModel
                                                .details?.nationality ??
                                            "",
                                      ),
                                      const SizeBoxH(15),
                                      ProfileCommonListTileWidget(
                                        onTap: () {},
                                        title: "Residence",
                                        image: AppImages.ResidenceIcon,
                                        isTrailingShow: false,
                                        isFromProfile: true,
                                        subTitle: provider.getUserProfileModel
                                                .details?.city ??
                                            "",
                                      ),
                                      const SizeBoxH(15),
                                      ProfileCommonListTileWidget(
                                        onTap: () {},
                                        title: "Language",
                                        image: AppImages.languageIcon,
                                        isTrailingShow: false,
                                        isFromProfile: true,
                                        subTitle: provider.getUserProfileModel
                                                .details?.language ??
                                            "",
                                      ),
                                      const SizeBoxH(15),
                                      ProfileCommonListTileWidget(
                                        onTap: () {},
                                        title: "Pet I Have",
                                        image: AppImages.petIhaveIcon,
                                        isTrailingShow: false,
                                        isFromProfile: true,
                                        subTitle: provider.getUserProfileModel
                                                .details?.pets
                                                .toString() ??
                                            "",
                                      ),
                                      const SizeBoxH(15),
                                      ProfileCommonListTileWidget(
                                        onTap: () {
                                          if ((provider.getUserProfileModel
                                                      .details?.coParents ??
                                                  0) >
                                              0) {
                                            Routes.push(
                                              context: context,
                                              screen:
                                                  const CoParentListingScreen(
                                                isFromCoParent: true,
                                              ),
                                              exit: () {},
                                            );
                                          } else {
                                            toast(context,
                                                title: "Add Co-parents",
                                                backgroundColor: Colors.red);
                                          }
                                        },
                                        title: "Co-parents",
                                        image: AppImages.petIhaveIcon,
                                        isTrailingShow: true,
                                        isFromProfile: true,
                                        subTitle: provider.getUserProfileModel
                                                .details?.coParents
                                                .toString() ??
                                            "",
                                      ),
                                      const SizeBoxH(15),
                                      ProfileCommonListTileWidget(
                                        onTap: () {
                                          if ((provider
                                                      .getUserProfileModel
                                                      .details
                                                      ?.temporaryParents ??
                                                  0) >
                                              0) {
                                            Routes.push(
                                              context: context,
                                              screen:
                                                  const CoParentListingScreen(
                                                isFromCoParent: false,
                                              ),
                                              exit: () {},
                                            );
                                          } else {
                                            toast(context,
                                                title: "Add Temporary Access",
                                                backgroundColor: Colors.red);
                                          }
                                        },
                                        title: "Temporary Access",
                                        image: AppImages.petIhaveIcon,
                                        isTrailingShow: true,
                                        isFromProfile: true,
                                        subTitle: provider.getUserProfileModel
                                                .details?.temporaryParents
                                                .toString() ??
                                            "",
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                    ],
                  )
                : const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Something went wrong. Please try again later."),
                    ],
                  );
          }
        },
      ),
    );
  }
}

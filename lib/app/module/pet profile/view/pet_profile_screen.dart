import 'package:clan_of_pets/app/helpers/common_widget.dart';
import 'package:clan_of_pets/app/helpers/size_box.dart';
import 'package:clan_of_pets/app/module/home/view/home_screen.dart';
import 'package:clan_of_pets/app/module/home/widget/common_grey_widget.dart';
import 'package:clan_of_pets/app/module/pet%20profile/view%20model/pet_profile_provider.dart';
import 'package:clan_of_pets/app/module/widget/confirmation_widget.dart';
import 'package:clan_of_pets/app/utils/app_constants.dart';
import 'package:clan_of_pets/app/utils/app_images.dart';
import 'package:clan_of_pets/app/utils/app_router.dart';
import 'package:clan_of_pets/app/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/string_const.dart';
import '../../home/view model/home_provider.dart';
import '../../home/view/add_new_pet.dart';
import '../widget/pet_profile_empty_screen.dart';
import 'achievements/achievements_home_screen.dart';
import 'clinicremarks/clinic_remarks_home.dart';
import 'dewarmingtracker/dewarming_tracker_page.dart';
import 'documents/pet_documents_screen.dart';
import 'events/events_screen.dart';
import 'expence/expence_tracker.dart';
import 'growth tracker/growth_tracker_screen.dart';
import 'myappointment/appointment.dart';
import 'vaccination/vaccination_screen.dart';

class PetProfileScreen extends StatefulWidget {
  const PetProfileScreen({super.key});

  @override
  State<PetProfileScreen> createState() => _PetProfileScreenState();
}

class _PetProfileScreenState extends State<PetProfileScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HomeProvider>().getUserRole();
    context.read<HomeProvider>().getPetIndex();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, provider, child) {
        return provider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : Scaffold(
                backgroundColor: AppConstants.white,
                body: provider.pets.isEmpty
                    ? PetProfileEmptyScreen(
                        onTap: () {
                          Routes.push(
                            context: context,
                            screen: const AddNewPetScreen(
                              isEdit: false,
                            ),
                            exit: () {
                              provider.getPetIndex();
                            },
                          );
                        },
                      )
                    : SingleChildScrollView(
                        physics: const ScrollPhysics(),
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                SizedBox(
                                  height: Responsive.height * 38,
                                  width: Responsive.width * 100,
                                  child: Column(
                                    children: [
                                      commonNetworkImage(
                                        url: provider.pets[provider.petIndex]
                                                .coverImage ??
                                            "https://cdn.pixabay.com/photo/2017/11/14/13/06/kitty-2948404_640.jpg",
                                        height: Responsive.height * 28,
                                        width: Responsive.width * 100,
                                        isTopCurved: false,
                                      ),
                                      const SizeBoxH(15),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizeBoxV(Responsive.width * 15),
                                          Flexible(
                                            child: Consumer<HomeProvider>(
                                              builder:
                                                  (context, provider, child) {
                                                return DropdownButtonHideUnderline(
                                                  child: DropdownButton<String>(
                                                    items: provider.pets
                                                        .map(
                                                          (e) =>
                                                              DropdownMenuItem(
                                                            value: e.id,
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                commonTextWidget(
                                                                  color:
                                                                      AppConstants
                                                                          .black,
                                                                  text: e.name
                                                                          ?.capitalizeFirstLetter() ??
                                                                      "",
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                                commonTextWidget(
                                                                  color:
                                                                      AppConstants
                                                                          .black,
                                                                  text: (e.breed?.length ??
                                                                              0) >
                                                                          12
                                                                      ? e.breed?.substring(
                                                                              0,
                                                                              12) ??
                                                                          ""
                                                                      : e.breed ??
                                                                          "",
                                                                  maxLines: 1,
                                                                  fontSize: 10,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                        .toList(),
                                                    value: provider
                                                        .pets[provider.petIndex]
                                                        .id,
                                                    onChanged: (value) {
                                                      StringConst.setPetId(
                                                        pet: value ?? "",
                                                      );

                                                      provider.setPetIndex(
                                                          value: value ?? '');
                                                    },
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(
                                              right: 10,
                                            ),
                                            width: 110,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              // color: AppConstants.greyContainerBg,
                                            ),
                                            child: Center(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizeBoxH(
                                                      Responsive.height * 0.5),
                                                  const commonTextWidget(
                                                    color: AppConstants
                                                        .appPrimaryColor,
                                                    text: "Joined",
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                  commonTextWidget(
                                                    color: AppConstants.black,
                                                    text: context
                                                        .read<HomeProvider>()
                                                        .formatDate(
                                                          provider
                                                                  .pets[provider
                                                                      .petIndex]
                                                                  .createdAt ??
                                                              DateTime.now(),
                                                        ),
                                                    fontSize: 13,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Positioned(
                                  top: Responsive.height * 23.5,
                                  left: Responsive.width * 4,
                                  child: CircleAvatar(
                                    radius: 40,
                                    backgroundColor: Colors.white,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        color: Colors.white,
                                      ),
                                      child: commonNetworkImage(
                                        url: provider.pets[provider.petIndex]
                                                .image ??
                                            "https://cdn.pixabay.com/photo/2017/11/14/13/06/kitty-2948404_640.jpg",
                                        height: 72,
                                        width: 72,
                                        radius: 100,
                                      ),
                                    ),
                                  ),
                                ),
                                provider.userRole == "temporaryParent"
                                    ? const SizedBox.shrink()
                                    : Positioned(
                                        top: 30,
                                        right: Responsive.width * 4,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            CommonInkwell(
                                              onTap: () {
                                                Routes.push(
                                                    context: context,
                                                    screen:
                                                        const AddNewPetScreen(
                                                      isEdit: false,
                                                    ),
                                                    exit: () {
                                                      provider.getPetIndex();
                                                    });
                                              },
                                              child: Container(
                                                height: 30,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  border: Border.all(
                                                    color: AppConstants
                                                        .appPrimaryColor,
                                                  ),
                                                ),
                                                child: const Row(
                                                  children: [
                                                    Icon(
                                                      Icons.add,
                                                      color: AppConstants
                                                          .appPrimaryColor,
                                                    ),
                                                    commonTextWidget(
                                                      color: AppConstants
                                                          .appPrimaryColor,
                                                      text: "Add new pet",
                                                      fontSize: 10,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        )),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 15),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const commonTextWidget(
                                        color: AppConstants.black,
                                        text: "Basic Info",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          CommonInkwell(
                                            onTap: () {
                                              context
                                                  .read<PetProfileProvider>()
                                                  .captureScreenShot(
                                                    data: provider.pets[
                                                        provider.petIndex],
                                                    context: context,
                                                  );
                                            },
                                            child: Container(
                                              height: 30,
                                              width: 100,
                                              padding: const EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                color: AppConstants
                                                    .greyContainerBg,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  const commonTextWidget(
                                                    color: AppConstants
                                                        .subTextGrey,
                                                    text: "Share",
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  const SizeBoxV(5),
                                                  Image.asset(
                                                    AppImages
                                                        .communityBlackShare,
                                                    color: AppConstants
                                                        .subTextGrey,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizeBoxV(10),
                                          CommonInkwell(
                                            onTap: () {
                                              Routes.push(
                                                context: context,
                                                screen: AddNewPetScreen(
                                                  isEdit: true,
                                                  data: provider
                                                      .pets[provider.petIndex],
                                                ),
                                                exit: () {},
                                              );
                                            },
                                            child: Container(
                                              height: 30,
                                              width: 80,
                                              padding: const EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                color: AppConstants
                                                    .appPrimaryColor,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  const SizeBoxV(5),
                                                  const commonTextWidget(
                                                    color: AppConstants.white,
                                                    text: "Edit",
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  const SizeBoxV(5),
                                                  Image.asset(
                                                    AppImages.editPenWhite,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  SizeBoxH(Responsive.height * 2),
                                  Container(
                                    width: Responsive.width * 100,
                                    padding: const EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: AppConstants.greyContainerBg,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            ProfileCommonRowWidget(
                                              image: AppImages.copId,
                                              text: "COP id",
                                              subText: provider
                                                      .pets[provider.petIndex]
                                                      .copId ??
                                                  "",
                                            ),
                                            ProfileCommonRowWidget(
                                              image: AppImages.copId,
                                              text: "Micro chip id ",
                                              subText: provider
                                                      .pets[provider.petIndex]
                                                      .chipId ??
                                                  "",
                                            ),
                                          ],
                                        ),
                                        const SizeBoxH(10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            ProfileCommonRowWidget(
                                              image: AppImages.speciesIcon,
                                              text: "Species",
                                              subText: provider
                                                      .pets[provider.petIndex]
                                                      .species ??
                                                  "",
                                            ),
                                            ProfileCommonRowWidget(
                                              image: AppImages.breedIcon,
                                              text: "Breed",
                                              subText: provider
                                                      .pets[provider.petIndex]
                                                      .breed ??
                                                  "",
                                            ),
                                          ],
                                        ),
                                        const SizeBoxH(10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            ProfileCommonRowWidget(
                                              image: AppImages.sexIcon,
                                              text: "Sex",
                                              subText: provider
                                                      .pets[provider.petIndex]
                                                      .sex ??
                                                  "",
                                            ),
                                            ProfileCommonRowWidget(
                                              image: AppImages.birthDateIcon,
                                              text: "Birth Date",
                                              subText: context
                                                  .read<HomeProvider>()
                                                  .formatDate2(
                                                    provider
                                                            .pets[provider
                                                                .petIndex]
                                                            .birthDate ??
                                                        DateTime.now(),
                                                  ),
                                            ),
                                          ],
                                        ),
                                        const SizeBoxH(10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            ProfileCommonRowWidget(
                                              image: AppImages.wweightIcon,
                                              text: "Weight",
                                              subText:
                                                  "${provider.pets[provider.petIndex].weight} Kg",
                                            ),
                                            ProfileCommonRowWidget(
                                              image: AppImages.heightIcon,
                                              text: "Height",
                                              subText:
                                                  "${provider.pets[provider.petIndex].height} cm",
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizeBoxH(Responsive.height * 4),
                                  Card(
                                    elevation:
                                        5, // Increase the elevation value
                                    shadowColor: AppConstants.greyContainerBg,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      side: const BorderSide(
                                        color: AppConstants.greyContainerBg,
                                        width: 1,
                                      ),
                                    ),
                                    child: Container(
                                      color: AppConstants.white,
                                      padding: const EdgeInsets.all(15),
                                      width: Responsive.width * 100,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          ProfileCommonListTileWidget(
                                            onTap: () {
                                              Routes.push(
                                                context: context,
                                                screen:
                                                    const VaccinationHomeScreen(),
                                                exit: () {},
                                              );
                                            },
                                            image: AppImages.vaccinationIcon,
                                            title: "Vaccination Tracker",
                                          ),
                                          const SizeBoxH(20),
                                          ProfileCommonListTileWidget(
                                            onTap: () {
                                              Routes.push(
                                                context: context,
                                                screen: GrowthTrackerScreen(
                                                    data: provider.pets[
                                                        provider.petIndex]),
                                                exit: () {},
                                              );
                                            },
                                            title: "Growth Tracker",
                                            image: AppImages.growthIcon,
                                          ),
                                          const SizeBoxH(20),
                                          ProfileCommonListTileWidget(
                                            onTap: () {
                                              Routes.push(
                                                context: context,
                                                screen:
                                                    const ExpenceTrackerSCreen(),
                                                exit: () {},
                                              );
                                            },
                                            title: "Expense Tracker",
                                            image: AppImages.expenseTrackerIcon,
                                          ),
                                          const SizeBoxH(20),
                                          ProfileCommonListTileWidget(
                                            onTap: () {
                                              Routes.push(
                                                context: context,
                                                screen:
                                                    const PetDocumentsScreen(),
                                                exit: () {},
                                              );
                                            },
                                            title: "Documents",
                                            image: AppImages.documentIcon,
                                          ),
                                          const SizeBoxH(20),
                                          ProfileCommonListTileWidget(
                                            onTap: () {
                                              Routes.push(
                                                context: context,
                                                screen: const EventsScreen(),
                                                exit: () {},
                                              );
                                            },
                                            title: "Events",
                                            image: AppImages.eventIcon,
                                          ),
                                          const SizeBoxH(20),
                                          ProfileCommonListTileWidget(
                                            onTap: () {
                                              Routes.push(
                                                context: context,
                                                screen:
                                                    const MyAppointmentScreen(),
                                                exit: () {},
                                              );
                                            },
                                            title: "My Appointments",
                                            image: AppImages.myappoinmentIcon,
                                          ),
                                          const SizeBoxH(20),
                                          ProfileCommonListTileWidget(
                                            onTap: () {
                                              Routes.push(
                                                context: context,
                                                screen:
                                                    const DewarmingTrackerScreen(),
                                                exit: () {},
                                              );
                                            },
                                            title: "Deworming Tracker",
                                            image:
                                                AppImages.dewarmingTrackrIcon,
                                          ),
                                          const SizeBoxH(20),
                                          ProfileCommonListTileWidget(
                                            onTap: () {
                                              Routes.push(
                                                context: context,
                                                screen:
                                                    const AchievementsHomeScreen(),
                                                exit: () {},
                                              );
                                            },
                                            title: "Achievements",
                                            image: AppImages
                                                .achievementTrackerIcon,
                                          ),
                                          const SizeBoxH(20),
                                          Visibility(
                                            visible: provider.userRole !=
                                                "temporaryParent",
                                            child: ProfileCommonListTileWidget(
                                              onTap: () {
                                                Routes.push(
                                                  context: context,
                                                  screen:
                                                      const GroomingHistoryScreen(),
                                                  exit: () {},
                                                );
                                              },
                                              title: "Clinic Remarks",
                                              image: AppImages.clinicRemarkIcon,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizeBoxH(20),
                                  Visibility(
                                    visible:
                                        provider.userRole == "temporaryParent",
                                    child: Column(
                                      children: [
                                        CommonButton(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  ConfirmationWidget(
                                                image: AppImages.deletePng,
                                                title: "LOGOUT",
                                                message:
                                                    "Are you sure you want to logout ?",
                                                onTap: () {
                                                  StringConst.logout(
                                                      context: context);
                                                },
                                              ),
                                            );
                                          },
                                          text: "Logout",
                                          width: Responsive.width * 100,
                                          height: Responsive.height * 6,
                                        ),
                                        const SizeBoxH(20),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
              );
      },
    );
  }
}

class ProfileCommonListTileWidget extends StatelessWidget {
  final void Function() onTap;
  final String image;
  final String title;
  final String subTitle;
  final bool isTrailingShow;
  final bool isFromProfile;
  const ProfileCommonListTileWidget(
      {super.key,
      required this.onTap,
      required this.image,
      required this.title,
      this.isTrailingShow = true,
      this.isFromProfile = false,
      this.subTitle = ""});

  @override
  Widget build(BuildContext context) {
    return CommonInkwell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: Responsive.width * 75,
            child: Row(
              children: [
                CommonGreyContainer(
                  height: Responsive.height * 5,
                  width: Responsive.width * 10,
                  borderRadius: BorderRadius.circular(12),
                  imageHeight: 17,
                  image: image,
                ),
                const SizeBoxV(10),
                isFromProfile
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          commonTextWidget(
                            color: AppConstants.black,
                            text: title,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          SizeBoxH(Responsive.height * 0.1),
                          commonTextWidget(
                            color: AppConstants.subTextGrey,
                            text: subTitle,
                            fontSize: 12,
                          ),
                        ],
                      )
                    : commonTextWidget(
                        color: AppConstants.black,
                        text: title,
                      ),
              ],
            ),
          ),
          isTrailingShow
              ? const Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                  color: AppConstants.black40,
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}

class ProfileCommonRowWidget extends StatelessWidget {
  final String image;
  final String text;
  final String subText;
  const ProfileCommonRowWidget({
    super.key,
    required this.image,
    required this.text,
    required this.subText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Responsive.width * 40,
      child: Row(
        children: [
          Container(
            height: Responsive.height * 6,
            width: Responsive.width * 12,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppConstants.white,
            ),
            child: Image.asset(
              image,
              height: 18,
            ),
          ),
          const SizeBoxV(10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                commonTextWidget(
                  color: AppConstants.black,
                  text: text,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                const SizeBoxH(4),
                commonTextWidget(
                  maxLines: 2,
                  color: AppConstants.black,
                  text: subText,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.5,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CommonAppBarWidget extends StatelessWidget {
  const CommonAppBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: CommonGreyContainer(
        height: 20,
        width: 20,
        image: AppImages.backButton,
        borderRadius: BorderRadius.circular(100),
        imageHeight: 20,
      ),
      title: const commonTextWidget(
        color: AppConstants.white,
        text: "Profile",
        fontSize: 18,
      ),
      actions: [
        const CommonBannerButtonWidget(
          bgColor: Colors.transparent,
          text: "+ Add new Pet",
          width: 120,
          borderColor: AppConstants.appPrimaryColor,
          textColor: AppConstants.appPrimaryColor,
        ),
        const SizeBoxV(5),
        CommonGreyContainer(
          height: 30,
          width: 30,
          image: AppImages.editPen,
          borderRadius: BorderRadius.circular(100),
          imageHeight: 20,
        ),
        const SizeBoxV(5),
      ],
    );
  }
}

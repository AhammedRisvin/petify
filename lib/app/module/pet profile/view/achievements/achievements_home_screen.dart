import 'package:clan_of_pets/app/module/home/view/notification_scree.dart';
import 'package:clan_of_pets/app/module/pet%20profile/view%20model/pet_profile_provider.dart';
import 'package:clan_of_pets/app/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../helpers/common_widget.dart';
import '../../../../helpers/size_box.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_router.dart';
import '../../../../utils/extensions.dart';
import '../../../widget/empty_screen.dart';
import '../../model/get_pet_achievements_model.dart';
import 'create_achievements.dart';

class AchievementsHomeScreen extends StatefulWidget {
  const AchievementsHomeScreen({super.key});

  @override
  State<AchievementsHomeScreen> createState() => _AchievementsHomeScreenState();
}

class _AchievementsHomeScreenState extends State<AchievementsHomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PetProfileProvider>().getAchievementsFun();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.white,
      appBar: AppBar(
        backgroundColor: AppConstants.white,
        title: const commonTextWidget(
          text: "Achievements",
          color: AppConstants.black,
          fontSize: 15,
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
        actions: [
          SizedBox(
            height: 35,
            child: IconButton(
                style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: AppConstants.greyContainerBg,
                    padding: const EdgeInsets.all(8)),
                onPressed: () {
                  Routes.push(
                    context: context,
                    screen: const NotificationScreen(),
                    exit: () {},
                  );
                },
                icon: Image.asset(
                  AppImages.bellIcon,
                  height: 14,
                  width: 12,
                )),
          ),
          SizeBoxV(Responsive.width * 3),
        ],
      ),
      body: Container(
        height: Responsive.height * 100,
        width: Responsive.width * 100,
        margin: const EdgeInsets.all(15),
        child: Selector<PetProfileProvider, int>(
          selector: (p0, p1) => p1.getAchievementsModelStatus,
          builder: (context, getAchievementsModelStatus, child) =>
              getAchievementsModelStatus == 0
                  ? Shimmer.fromColors(
                      baseColor: AppConstants.shimmerbaseColor!,
                      highlightColor: AppConstants.shimmerhighlightColor!,
                      child: ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 3,
                          separatorBuilder: (context, index) =>
                              const SizeBoxH(20),
                          itemBuilder: (context, index) => AchievementWidget(
                                achievement: Achievment(
                                    date: DateTime.now(),
                                    id: "gagghadghgh",
                                    name: "Pet name",
                                    organisation: "dajsghksg",
                                    venue: "fgsdjhf"),
                              )))
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          Selector<PetProfileProvider, GetAchievementsModel>(
                            selector: (p0, p1) => p1.getAchievementsModel,
                            builder: (context, getAchievementsModel, child) =>
                                getAchievementsModel.achievments?.isEmpty ??
                                        true
                                    ? EmptyScreenWidget(
                                        text: "No Achievements data found",
                                        image: AppImages.noAppoinmentImage,
                                        height: Responsive.height * 70,
                                      )
                                    : ListView.separated(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: getAchievementsModel
                                                .achievments?.length ??
                                            0,
                                        separatorBuilder: (context, index) =>
                                            const SizeBoxH(10),
                                        itemBuilder: (context, index) {
                                          var achievement =
                                              getAchievementsModel.achievments?[
                                                  (getAchievementsModel
                                                              .achievments
                                                              ?.length ??
                                                          0) -
                                                      1 -
                                                      index];
                                          return AchievementWidget(
                                            achievement: achievement,
                                          );
                                        }),
                          ),
                          SizeBoxH(Responsive.height * 4),
                          CommonButton(
                              onTap: () {
                                Routes.push(
                                  context: context,
                                  screen: CreateAchievementScreen(),
                                  exit: () {},
                                );
                              },
                              text: '+ Create New',
                              width: Responsive.width * 100,
                              size: 14,
                              isFullRoundedButton: true,
                              height: 40)
                        ],
                      ),
                    ),
        ),
      ),
    );
  }
}

class AchievementWidget extends StatelessWidget {
  final Achievment? achievement;
  const AchievementWidget({
    super.key,
    this.achievement,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Responsive.height * 19,
      child: Stack(
        children: [
          Container(
            height: Responsive.height * 17.5,
            width: Responsive.width * 100,
            decoration: const BoxDecoration(
              color: Color(0xffF2F2F2),
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 30,
                  height: Responsive.height * 17.5,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: AppConstants.appPrimaryColor),
                ),
                SizedBox(
                  height: Responsive.height * 17.5,
                  width: Responsive.width * 82,
                  child: Row(
                    children: [
                      Container(
                        width: 136,
                        height: 113,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: AppConstants.black.withOpacity(.25),
                                offset: const Offset(0, 2),
                                blurRadius: 4)
                          ],
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(18),
                          ),
                        ),
                        child: Center(
                            child: Image.asset(
                          AppImages.achievementImage,
                          height: 63,
                          width: 105,
                        )),
                      ),
                      const SizeBoxV(15),
                      SizedBox(
                        width: Responsive.width * 44,
                        height: 113,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            AchievementRowContentWidget(
                              image: AppImages.achievementIcon,
                              text: achievement?.name ?? '',
                            ),
                            AchievementRowContentWidget(
                              image: AppImages.achievementVenueIcon,
                              text: achievement?.venue ?? '',
                            ),
                            AchievementRowContentWidget(
                              image: AppImages.achievementOrganisationIcon,
                              text: achievement?.organisation ?? '',
                            ),
                            AchievementRowContentWidget(
                              image: AppImages.calenderPrimaryIcon,
                              text: context
                                  .watch<PetProfileProvider>()
                                  .getachievementformateDateFun(
                                      achievement?.date.toString() ?? ''),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            right: 30,
            child: CommonInkwell(
              onTap: () => context
                  .read<PetProfileProvider>()
                  .deleteAchievementFn(
                      context: context, id: achievement?.id ?? ''),
              child: Container(
                height: 32,
                width: 32,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: AppConstants.black.withOpacity(.15),
                          offset: const Offset(0, 2),
                          blurRadius: 4)
                    ],
                    border: Border.all(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(30),
                    color: AppConstants.appPrimaryColor),
                child: Center(
                  child: Image.asset(
                    AppImages.deleteIcon,
                    height: 13,
                    width: 13,
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

class AchievementRowContentWidget extends StatelessWidget {
  final String image;
  final String text;
  const AchievementRowContentWidget({
    super.key,
    required this.image,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          image,
          height: 19,
          width: 19,
          fit: BoxFit.contain,
        ),
        const SizeBoxV(8),
        Expanded(
          child: commonTextWidget(
            align: TextAlign.start,
            text: text,
            overFlow: TextOverflow.ellipsis,
            color: AppConstants.black,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

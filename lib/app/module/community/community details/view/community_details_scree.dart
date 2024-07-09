// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'dart:async';

import 'package:clan_of_pets/app/core/string_const.dart';
import 'package:clan_of_pets/app/module/community/community%20home/provider/community_home_provider.dart';
import 'package:clan_of_pets/app/module/community/view%20model/Community_provider.dart';
import 'package:clan_of_pets/app/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/server_client_services.dart';
import '../../../../helpers/common_widget.dart';
import '../../../../helpers/size_box.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/app_router.dart';
import '../../../home/view/home_screen.dart';
import '../../../widget/empty_screen.dart';
import '../../chat/view/chat_view.dart';
import '../../community admin/view/community_admin_profile_screen.dart';
import '../../community home/model/get_community_home_model.dart';
import '../../create feed/view/create_feed_screen.dart';
import '../../widget/community_appbar_container_widget.dart';
import '../../widget/community_card_widget.dart';
import '../model/get_community_details_model.dart';
import '../provider/community_details_provider.dart';
import 'widgets/community_tab_widget.dart';

class CommunityDetailsScreen extends StatefulWidget {
  final String? communityFeedId;
  final String? communityShareLink;
  const CommunityDetailsScreen(
      {super.key, this.communityFeedId, this.communityShareLink});

  @override
  State<CommunityDetailsScreen> createState() => _CommunityDetailsScreenState();
}

class _CommunityDetailsScreenState extends State<CommunityDetailsScreen> {
  final StreamController<GetCommunityDetailsModel> feedDetailsStreamController =
      StreamController();
  final feedDetailsScrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    feedDetailsScrollController.addListener(onScroll);
    fetchPosts(pageNum: 1);
  }

  int feedDetailsCurrentPage = 1;
  int feedDetailsStatus = 0;
  bool isFeedDetailsListEnded = false;
  List<LatestFeed> communityFeeds = [];
  Future<void> fetchPosts({int pageNum = 0}) async {
    try {
      feedDetailsStatus = 0;
      isFeedDetailsListEnded = false;
      String page = '';
      if (pageNum != 0) {
        page = pageNum.toString();
      } else {
        page = feedDetailsCurrentPage.toString();
      }
      List response =
          await ServerClient.get("${widget.communityShareLink}?page=$page");
      if (response.first >= 200 && response.first < 300) {
        if (pageNum != 0) {
          communityFeeds.clear();

          GetCommunityDetailsModel getCommunityHomeModel =
              GetCommunityDetailsModel.fromJson(response.last);
          feedDetailsStreamController.add(getCommunityHomeModel);
          communityFeeds
              .addAll(getCommunityHomeModel.message?.feedsWithDetails ?? []);

          feedDetailsCurrentPage = 2;
        } else {
          final getModel = GetCommunityDetailsModel.fromJson(response.last);
          if (getModel.message?.feedsWithDetails?.isEmpty ?? true) {
            isFeedDetailsListEnded = true;
          }
          feedDetailsStreamController.add(getModel);
          communityFeeds.addAll(getModel.message?.feedsWithDetails ?? []);

          feedDetailsCurrentPage++;
        }
      } else {
        communityFeeds = [];
      }
    } finally {
      setState(() {
        feedDetailsStatus = 1;
        isFeedDetailsListEnded = true;
      });
    }
  }

  @override
  void dispose() {
    feedDetailsStreamController.close();
    feedDetailsScrollController.dispose();
    super.dispose();
  }

  void onScroll() {
    if (feedDetailsScrollController.position.pixels >=
        feedDetailsScrollController.position.maxScrollExtent) {
      fetchPosts();
    }
  }

  double loadMoreThreshold = 300.0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        communityFeeds.clear();
        return true;
      },
      child: Scaffold(
        backgroundColor: AppConstants.white,
        body: StreamBuilder(
            stream: feedDetailsStreamController.stream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text('Something went wrong'),
                );
              }
              if (!snapshot.hasData) {
                if (feedDetailsStatus == 0) {
                  return const Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(
                        color: AppConstants.appPrimaryColor,
                      ),
                    ),
                  );
                } else {
                  return Scaffold(
                    backgroundColor: AppConstants.white,
                    appBar: AppBar(
                      leading: IconButton(
                          onPressed: () {
                            Routes.back(context: context);
                          },
                          icon: const Icon(Icons.arrow_back)),
                      backgroundColor: AppConstants.white,
                    ),
                    body: Center(
                      child: Image.asset(
                        AppImages.noCommunityImage,
                        height: Responsive.height * 30,
                        width: Responsive.width * 40,
                      ),
                    ),
                  );
                }
              }

              return SingleChildScrollView(
                controller: feedDetailsScrollController,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        commonNetworkImage(
                          url: snapshot.data?.message?.groupDetails
                                  ?.groupCoverImage ??
                              "",
                          height: Responsive.height * 32,
                          width: Responsive.width * 100,
                          isTopCurved: false,
                        ),
                        Positioned(
                          child: AppBar(
                            backgroundColor: Colors.transparent,
                            title: commonTextWidget(
                              overFlow: TextOverflow.ellipsis,
                              text: snapshot
                                      .data?.message?.groupDetails?.groupName ??
                                  "Community",
                              color: AppConstants.black,
                              fontSize: 18,
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
                                size: 18,
                                color: AppConstants.appPrimaryColor,
                              ),
                            ),
                            actions: [
                              CommunityAppBarContainer(
                                title: "Create feeds",
                                icon: AppImages.petsAddIcon,
                                onTap: () {
                                  Routes.push(
                                    context: context,
                                    screen: CreateFeedScreen(
                                      communityId: widget.communityFeedId,
                                    ),
                                    exit: () {
                                      fetchPosts(pageNum: 1);
                                    },
                                  );
                                },
                                width: 110,
                              ),
                              const SizeBoxV(10),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SingleChildScrollView(
                      padding:
                          const EdgeInsetsDirectional.symmetric(horizontal: 16),
                      physics: const NeverScrollableScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizeBoxH(14),
                          Stack(
                            children: [
                              SizedBox(
                                // color: Colors.amber,
                                width: Responsive.width * 100,
                                height: Responsive.height * 7,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CommonInkwell(
                                      onTap: () {
                                        if (snapshot.data?.message?.groupDetails
                                                ?.isAdmin ==
                                            true) {
                                          Routes.push(
                                            context: context,
                                            screen: CommunityAdminProfileScreen(
                                              communityId: snapshot.data
                                                  ?.message?.groupDetails?.id,
                                            ),
                                            exit: () => fetchPosts(),
                                          );
                                        } else {
                                          toast(context,
                                              title:
                                                  "You'r not admin this community",
                                              backgroundColor: Colors.red);
                                        }
                                      },
                                      child: commonNetworkImage(
                                        url: snapshot
                                                .data
                                                ?.message
                                                ?.groupDetails
                                                ?.groupProfileImage ??
                                            "https://cdn.pixabay.com/photo/2017/11/14/13/06/kitty-2948404_640.jpg",
                                        height: 50,
                                        width: 50,
                                        isTopCurved: true,
                                        radius: 100,
                                      ),
                                    ),
                                    snapshot.data?.message?.groupDetails
                                                ?.isAdmin ==
                                            true
                                        ? const SizedBox.shrink()
                                        : Selector<CommunityDetailsProvider,
                                            bool>(
                                            selector: (p0, p1) =>
                                                p1.isLeftGroup,
                                            builder:
                                                (context, isLeftGroup, child) =>
                                                    CommonBannerButtonWidget(
                                              onTap: () {
                                                if (isLeftGroup == false) {
                                                  context
                                                      .read<
                                                          CommunityDetailsProvider>()
                                                      .communityLeftFun(
                                                        context: context,
                                                        communityId: snapshot
                                                                .data
                                                                ?.message
                                                                ?.groupDetails
                                                                ?.id ??
                                                            "",
                                                        function: () {},
                                                      );
                                                } else {
                                                  context
                                                      .read<
                                                          CommunityDetailsProvider>()
                                                      .communityJoinFun(
                                                        communityId: snapshot
                                                                .data
                                                                ?.message
                                                                ?.groupDetails
                                                                ?.id ??
                                                            '',
                                                        context: context,
                                                        function: () {},
                                                      );
                                                }
                                              },
                                              bgColor: isLeftGroup == false
                                                  ? AppConstants.white
                                                  : AppConstants
                                                      .appPrimaryColor,
                                              text: isLeftGroup == false
                                                  ? "Joined"
                                                  : "Join",
                                              borderColor:
                                                  AppConstants.appPrimaryColor,
                                              textColor: isLeftGroup == false
                                                  ? AppConstants.appPrimaryColor
                                                  : AppConstants.white,
                                              width: 80,
                                              height: 30,
                                              fontSize: 14,
                                            ),
                                          ),
                                  ],
                                ),
                              ),
                              Positioned(
                                  top: 5,
                                  left: 65,
                                  child: SizedBox(
                                    width: Responsive.width * 54,
                                    child: commonTextWidget(
                                      align: TextAlign.start,
                                      overFlow: TextOverflow.ellipsis,
                                      color: AppConstants.black,
                                      text: snapshot.data?.message?.groupDetails
                                              ?.groupName ??
                                          "",
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  )),
                              (snapshot.data?.message?.groupDetails
                                              ?.totalMembers ??
                                          0) >
                                      0
                                  ? const Positioned(
                                      bottom: 5,
                                      left: 65,
                                      child: commonNetworkImage(
                                        url:
                                            "https://cdn.pixabay.com/photo/2017/11/14/13/06/kitty-2948404_640.jpg",
                                        height: 22,
                                        width: 22,
                                        isTopCurved: true,
                                        radius: 100,
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                              (snapshot.data?.message?.groupDetails
                                              ?.totalMembers ??
                                          0) >
                                      1
                                  ? const Positioned(
                                      bottom: 5,
                                      left: 75,
                                      child: commonNetworkImage(
                                        url:
                                            "https://cdn.pixabay.com/photo/2016/11/29/13/00/black-1869685_640.jpg",
                                        height: 22,
                                        width: 22,
                                        isTopCurved: true,
                                        radius: 100,
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                              (snapshot.data?.message?.groupDetails
                                              ?.totalMembers ??
                                          0) >
                                      2
                                  ? const Positioned(
                                      bottom: 5,
                                      left: 85,
                                      child: commonNetworkImage(
                                        url:
                                            "https://media.istockphoto.com/id/1311467082/photo/head-shot-profile-of-a-young-puppy-beagles-dog-isolated.jpg?s=612x612&w=0&k=20&c=YBKJiNVXLBHYRQ6K33Og3hYKJi2GZYImmp6L1Q3yflc=",
                                        height: 22,
                                        width: 22,
                                        isTopCurved: true,
                                        radius: 100,
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                              (snapshot.data?.message?.groupDetails
                                              ?.totalMembers ??
                                          0) >
                                      3
                                  ? const Positioned(
                                      bottom: 5,
                                      left: 95,
                                      child: commonNetworkImage(
                                        url:
                                            "https://cdn.pixabay.com/photo/2016/11/29/13/00/black-1869685_640.jpg",
                                        height: 22,
                                        width: 22,
                                        isTopCurved: true,
                                        radius: 100,
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                              (snapshot.data?.message?.groupDetails
                                              ?.totalMembers ??
                                          0) >
                                      4
                                  ? const Positioned(
                                      bottom: 5,
                                      left: 105,
                                      child: commonNetworkImage(
                                        url:
                                            "https://images.unsplash.com/photo-1510771463146-e89e6e86560e?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8ZG9nJTIwcHJvZmlsZSUyMHBpY3R1cmV8ZW58MHx8MHx8fDA=",
                                        height: 22,
                                        width: 22,
                                        isTopCurved: true,
                                        radius: 100,
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                              (snapshot.data?.message?.groupDetails
                                              ?.totalMembers ??
                                          0) >
                                      5
                                  ? const Positioned(
                                      bottom: 5,
                                      left: 115,
                                      child: commonNetworkImage(
                                        url:
                                            "https://cdn.pixabay.com/photo/2016/11/29/13/00/black-1869685_640.jpg",
                                        height: 22,
                                        width: 22,
                                        isTopCurved: true,
                                        radius: 100,
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                              Positioned(
                                bottom: 6,
                                left: 160,
                                child: commonTextWidget(
                                  color: AppConstants.subTextGrey,
                                  text:
                                      "${context.read<CommunityHomeProvider>().formatNumber(snapshot.data?.message?.groupDetails?.totalMembers ?? 0)} members",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          const SizeBoxH(10),
                          SizedBox(
                            width: Responsive.width * 100,
                            child: commonTextWidget(
                              align: TextAlign.justify,
                              color: AppConstants.subTextGrey,
                              text: snapshot.data?.message?.groupDetails
                                      ?.groupDescription ??
                                  "",
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizeBoxH(10),
                          Consumer<CommunityProvider>(
                            builder: (context, provider, child) => SizedBox(
                              width: Responsive.width * 100,
                              height: Responsive.height * 6,
                              child: Row(
                                children: [
                                  CommunityDeatilsTabContainer(
                                    title: "Feeds",
                                    onTap: () {
                                      provider.toggleContainerTapped(0);
                                    },
                                    index: 0,
                                  ),
                                  const SizeBoxV(10),
                                  CommunityDeatilsTabContainer(
                                    title: "Chats",
                                    onTap: () async {
                                      String userId =
                                          await StringConst.getUserID();
                                      Routes.push(
                                        context: context,
                                        screen: ChatView(
                                          communityId: snapshot.data?.message
                                                  ?.groupDetails?.id ??
                                              "",
                                          communityName: snapshot.data?.message
                                                  ?.groupDetails?.groupName ??
                                              "",
                                          userId: userId,
                                        ),
                                        exit: () {
                                          provider.toggleContainerTapped(0);
                                        },
                                      );
                                      provider.toggleContainerTapped(1);
                                    },
                                    index: 1,
                                  ),
                                  const Spacer(),
                                  CommonInkwell(
                                    onTap: () {
                                      context
                                          .read<CommunityHomeProvider>()
                                          .shareFeedUrl(
                                            videoUrl: snapshot.data?.message
                                                    ?.groupDetails?.shareLink ??
                                                '',
                                            subject: snapshot.data?.message
                                                    ?.groupDetails?.groupName ??
                                                "",
                                          );
                                    },
                                    child: Container(
                                      width: 80,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        color: AppConstants.appPrimaryColor,
                                        border: Border.all(
                                          color: AppConstants.appPrimaryColor,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            AppImages.settingsRefer,
                                            color: AppConstants.white,
                                            height: 10,
                                          ),
                                          const SizeBoxV(5),
                                          const commonTextWidget(
                                            color: AppConstants.white,
                                            text: "Share",
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: 0.3,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          communityFeeds.isEmpty
                              ? EmptyScreenWidget(
                                  text: "No feeds available",
                                  image: AppImages.noCommunityImage,
                                  height: Responsive.height * 50,
                                )
                              : ListView.separated(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    var data = communityFeeds[index];
                                    return CommunityCardWidget(
                                      latestFeed: data,
                                      function: () {
                                        fetchPosts(pageNum: 1);
                                      },
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      const SizeBoxH(10),
                                  itemCount: communityFeeds.length,
                                ),
                        ],
                      ),
                    ),
                    feedDetailsStatus == 0 && isFeedDetailsListEnded == false
                        ? SizedBox(
                            height: Responsive.height * 23,
                            width: Responsive.width * 100,
                            child: const Center(
                              child: CircularProgressIndicator(
                                  color: AppConstants.appPrimaryColor),
                            ),
                          )
                        : const SizedBox.shrink()
                  ],
                ),
              );
            }),
      ),
    );
  }
}

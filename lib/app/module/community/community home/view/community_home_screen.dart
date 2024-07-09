// ignore_for_file: camel_case_types

import 'dart:async';

import 'package:clan_of_pets/app/helpers/size_box.dart';
import 'package:clan_of_pets/app/utils/app_images.dart';
import 'package:clan_of_pets/app/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/server_client_services.dart';
import '../../../../core/urls.dart';
import '../../../../helpers/common_widget.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_router.dart';
import '../../../pet profile/widget/search_widget.dart';
import '../../chat/view/community_chat_screen.dart';
import '../../community details/provider/community_details_provider.dart';
import '../../community details/view/community_details_scree.dart';
import '../../create community/view/create_community_screen.dart';
import '../../widget/community_appbar_container_widget.dart';
import '../../widget/community_card_widget.dart';
import '../model/get_community_home_model.dart';
import '../provider/community_home_provider.dart';
import 'joined_community_screen.dart';
import 'widgets/all_community_screen.dart';
import 'widgets/all_community_widget.dart';
import 'widgets/joined_community_widget.dart';
import 'widgets/trending_community_widget.dart';

class CommunityHomeScreen extends StatefulWidget {
  const CommunityHomeScreen({super.key});

  @override
  State<CommunityHomeScreen> createState() => _CommunityHomeScreenState();
}

class _CommunityHomeScreenState extends State<CommunityHomeScreen> {
  final StreamController<GetCommunityHomeModel> homeStreamController =
      StreamController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      fetchPosts();
      context
          .read<CommunityHomeProvider>()
          .allCommunitySearchFn(enteredKeyword: "", pageNum: 1);
    });
  }

  Future<void> fetchPosts() async {
    try {
      List response = await ServerClient.get(
        Urls.getCommunityHome,
      );
      if (response.first >= 200 && response.first < 300) {
        GetCommunityHomeModel getCommunityHomeModel =
            GetCommunityHomeModel.fromJson(response.last);
        homeStreamController.add(getCommunityHomeModel);
      } else {
        homeStreamController.add(GetCommunityHomeModel());
      }
    } catch (e) {
      homeStreamController.add(GetCommunityHomeModel());
    }
  }

  @override
  void dispose() {
    homeStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.white,
      appBar: AppBar(
        backgroundColor: AppConstants.white,
        automaticallyImplyLeading: false,
        title: const commonTextWidget(
          text: "Community",
          color: AppConstants.black,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        actions: [
          CommunityAppBarContainer(
            title: "Create Community",
            icon: AppImages.petsAddIcon,
            onTap: () {
              Routes.push(
                context: context,
                screen: CreateCommunityScreen(),
                exit: () {
                  fetchPosts();
                  context
                      .read<CommunityHomeProvider>()
                      .allCommunitySearchFn(enteredKeyword: "", pageNum: 1);
                },
              );
            },
            width: 120,
            fontSize: 10,
          ),
          const SizeBoxV(5),
          CommunityAppBarContainer(
            icon: AppImages.petsChatIcon,
            onTap: () {
              Routes.push(
                context: context,
                screen: const CommunityChatScreen(),
                exit: () {},
              );
            },
            width: 35,
          ),
          const SizeBoxV(10),
        ],
      ),
      body: StreamBuilder(
        stream: homeStreamController.stream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Something went wrong'),
            );
          }
          if (!snapshot.hasData) {
            return const Scaffold(
              backgroundColor: AppConstants.white,
              body: Center(
                child: CircularProgressIndicator(
                  color: AppConstants.appPrimaryColor,
                ),
              ),
            );
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const commonTextWidget(
                  color: AppConstants.black,
                  text: "Welcome Back",
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -1,
                ),
                SearchWidget(
                  readOnly: true,
                  onTap: () {
                    Routes.push(
                      context: context,
                      screen: const AllCommunityScreen(),
                      exit: () {
                        fetchPosts();
                        context
                            .read<CommunityHomeProvider>()
                            .allCommunitySearchFn(
                                enteredKeyword: "", pageNum: 1);
                      },
                    );
                  },
                  hintText: "Search Community",
                ),
                snapshot.data?.latestFeeds?.isEmpty ?? true
                    ? const SizedBox.shrink()
                    : Container(
                        margin: const EdgeInsets.only(top: 4),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const commonTextWidget(
                              color: AppConstants.black,
                              text: "New Feeds in Your Communities",
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.5,
                            ),
                            const SizeBoxH(4),
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                var data = snapshot.data?.latestFeeds?[index];
                                return CommonInkwell(
                                  onTap: () {
                                    Routes.push(
                                      context: context,
                                      screen: CommunityDetailsScreen(
                                        communityFeedId: data?.group ?? '',
                                        communityShareLink:
                                            data?.groupShareLink ?? '',
                                      ),
                                      exit: () {
                                        fetchPosts();
                                        context
                                            .read<CommunityHomeProvider>()
                                            .allCommunitySearchFn(
                                                enteredKeyword: "", pageNum: 1);
                                      },
                                    );
                                  },
                                  child: CommunityCardWidget(
                                    function: () {
                                      fetchPosts();
                                      context
                                          .read<CommunityHomeProvider>()
                                          .allCommunitySearchFn(
                                              enteredKeyword: "", pageNum: 1);
                                    },
                                    latestFeed: data,
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  const SizeBoxH(10),
                              itemCount:
                                  snapshot.data?.latestFeeds?.length ?? 0,
                            ),
                          ],
                        ),
                      ),
                snapshot.data?.trendingGroups?.isEmpty ?? true
                    ? const SizedBox.shrink()
                    : Container(
                        margin: const EdgeInsets.only(top: 15),
                        width: Responsive.width * 100,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const commonTextWidget(
                              color: AppConstants.black,
                              text: "Trending Communities",
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.5,
                            ),
                            const SizeBoxH(15),
                            GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 15,
                                childAspectRatio: 1.1,
                              ),
                              itemCount:
                                  snapshot.data?.trendingGroups?.length ?? 0,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final trendingCommunityData =
                                    snapshot.data?.trendingGroups?[index];
                                return CommonInkwell(
                                  onTap: () {
                                    context
                                        .read<CommunityDetailsProvider>()
                                        .isUnJoinedCommunity();
                                    Routes.push(
                                      context: context,
                                      screen: CommunityDetailsScreen(
                                        communityShareLink:
                                            trendingCommunityData?.shareLink ??
                                                '',
                                        communityFeedId:
                                            trendingCommunityData?.id ?? '',
                                      ),
                                      exit: () {
                                        fetchPosts();
                                      },
                                    );
                                  },
                                  child: TrendingCommunityWidget(
                                    trendingCommunityData:
                                        trendingCommunityData,
                                    function: () {
                                      fetchPosts();
                                    },
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                snapshot.data?.joinedGroups?.isEmpty ?? true
                    ? const SizedBox.shrink()
                    : Container(
                        margin: const EdgeInsets.only(top: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const commonTextWidget(
                                  color: AppConstants.black,
                                  text: "Joined Communities",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: -0.5,
                                ),
                                CommonInkwell(
                                  onTap: () {
                                    context
                                        .read<CommunityHomeProvider>()
                                        .getJoinedCommunityList(
                                            snapshot.data?.joinedGroups ?? []);
                                    Routes.push(
                                      context: context,
                                      screen: const JoinedCommunityScreen(),
                                      exit: () {
                                        fetchPosts();
                                      },
                                    );
                                  },
                                  child: const commonTextWidget(
                                    color: AppConstants.appPrimaryColor,
                                    text: "See all",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: -0.5,
                                  ),
                                ),
                              ],
                            ),
                            const SizeBoxH(15),
                            ConstrainedBox(
                              constraints: const BoxConstraints(
                                  maxHeight: 100, minHeight: 80),
                              child: ListView.separated(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                physics: const ScrollPhysics(),
                                itemBuilder: (context, index) {
                                  var data =
                                      snapshot.data?.joinedGroups?[index];
                                  return CommonInkwell(
                                      onTap: () {
                                        Routes.push(
                                          context: context,
                                          screen: CommunityDetailsScreen(
                                            communityShareLink:
                                                data?.shareLink ?? '',
                                            communityFeedId: data?.id ?? '',
                                          ),
                                          exit: () {
                                            fetchPosts();
                                            context
                                                .read<CommunityHomeProvider>()
                                                .allCommunitySearchFn(
                                                    enteredKeyword: "",
                                                    pageNum: 1);
                                          },
                                        );
                                      },
                                      child: JoinedCommunityWidget(
                                        community: data,
                                      ));
                                },
                                separatorBuilder: (context, index) =>
                                    const SizeBoxH(10),
                                itemCount:
                                    snapshot.data?.joinedGroups?.length ?? 0,
                              ),
                            ),
                          ],
                        ),
                      ),
                snapshot.data?.myCommunity?.isEmpty ?? true
                    ? const SizedBox.shrink()
                    : Container(
                        margin: const EdgeInsets.only(top: 15),
                        width: Responsive.width * 100,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const commonTextWidget(
                              color: AppConstants.black,
                              text: "My Communities",
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.5,
                            ),
                            const SizeBoxH(15),
                            GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 15,
                                childAspectRatio: 1.1,
                              ),
                              itemCount:
                                  snapshot.data?.myCommunity?.length ?? 0,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final trendingCommunityData =
                                    snapshot.data?.myCommunity?[index];
                                return CommonInkwell(
                                  onTap: () {
                                    Routes.push(
                                      context: context,
                                      screen: CommunityDetailsScreen(
                                        communityShareLink:
                                            trendingCommunityData?.shareLink ??
                                                '',
                                        communityFeedId:
                                            trendingCommunityData?.id ?? "",
                                      ),
                                      exit: () {
                                        fetchPosts();
                                        context
                                            .read<CommunityHomeProvider>()
                                            .allCommunitySearchFn(
                                                enteredKeyword: "", pageNum: 1);
                                      },
                                    );
                                  },
                                  child: TrendingCommunityWidget(
                                    isTendingCommunity: false,
                                    trendingCommunityData:
                                        trendingCommunityData,
                                    function: () {
                                      fetchPosts();
                                    },
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                const SizeBoxH(15),
                Consumer<CommunityHomeProvider>(
                  builder: (context, provider, child) => provider
                          .allCommunityFOundList.isEmpty
                      ? const SizedBox.shrink()
                      : Container(
                          margin: const EdgeInsets.only(top: 15),
                          width: Responsive.width * 100,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const commonTextWidget(
                                    color: AppConstants.black,
                                    text: "All Communities",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: -0.5,
                                  ),
                                  CommonInkwell(
                                    onTap: () {
                                      Routes.push(
                                        context: context,
                                        screen: const AllCommunityScreen(),
                                        exit: () {
                                          fetchPosts();
                                        },
                                      );
                                    },
                                    child: const commonTextWidget(
                                      color: AppConstants.appPrimaryColor,
                                      text: "See all",
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: -0.5,
                                    ),
                                  ),
                                ],
                              ),
                              const SizeBoxH(15),
                              GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 15,
                                  childAspectRatio: 1.1,
                                ),
                                physics: const ScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  final trendingCommunityData =
                                      provider.allCommunityFOundList[index];
                                  return CommonInkwell(
                                    onTap: () {},
                                    child: AllCommunityWidget(
                                      trendingCommunityData:
                                          trendingCommunityData,
                                      function: () {},
                                    ),
                                  );
                                },
                                itemCount:
                                    provider.allCommunityFOundList.length >= 6
                                        ? 6
                                        : provider.allCommunityFOundList.length,
                              ),
                            ],
                          ),
                        ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

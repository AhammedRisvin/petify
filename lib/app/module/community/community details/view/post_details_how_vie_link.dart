// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:clan_of_pets/app/env.dart';
import 'package:clan_of_pets/app/module/community/widget/community_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

import '../../../../core/server_client_services.dart';
import '../../../../core/string_const.dart';
import '../../../../helpers/common_widget.dart';
import '../../../../helpers/size_box.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/app_router.dart';
import '../../../../utils/extensions.dart';
import '../../../home/view/bottom_nav_screen.dart';
import '../../../pet profile/view/pet_profile_screen.dart';
import '../../community home/model/get_community_home_model.dart';
import '../../community home/provider/community_home_provider.dart';
import '../model/get_deeplink_community_post_details_model.dart';
import '../provider/community_details_provider.dart';

class CommunityPostDetailsScreen extends StatefulWidget {
  final String? url;
  final bool isFromLogin;
  const CommunityPostDetailsScreen({
    super.key,
    this.url,
    required this.isFromLogin,
  });

  @override
  State<CommunityPostDetailsScreen> createState() =>
      _CommunityPostDetailsScreenState();
}

class _CommunityPostDetailsScreenState
    extends State<CommunityPostDetailsScreen> {
  final StreamController<GetDeepLinkCommunityPostDetailsModel>
      homeStreamController = StreamController();
  GetDeepLinkCommunityPostDetailsModel getDeepLinkCommunityPostDetailsModel =
      GetDeepLinkCommunityPostDetailsModel();
  @override
  void initState() {
    super.initState();
    debugPrint("widget.url is ${widget.url}");
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    try {
      const FlutterSecureStorage storage = FlutterSecureStorage();
      String? url = await storage.read(key: StringConst.deepLinkUrl);
      feedDetailsStatus = 0;
      List response = await ServerClient.get(
        "${Environments.baseUrlForDeepLink}${url ?? ''}",
      );
      if (response.first >= 200 && response.first < 300) {
        GetDeepLinkCommunityPostDetailsModel getCommunityHomeModel =
            GetDeepLinkCommunityPostDetailsModel.fromJson(response.last);
        homeStreamController.add(getCommunityHomeModel);
        setState(() {
          getDeepLinkCommunityPostDetailsModel = getCommunityHomeModel;
        });
      } else {
        homeStreamController.add(GetDeepLinkCommunityPostDetailsModel());
      }
    } catch (e) {
      homeStreamController.add(GetDeepLinkCommunityPostDetailsModel());
    } finally {
      setState(() {
        feedDetailsStatus = 1;
      });
    }
  }

  @override
  void dispose() {
    homeStreamController.close();
    super.dispose();
  }

  int feedDetailsStatus = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.white,
      appBar: AppBar(
        backgroundColor: AppConstants.white,
        title: const commonTextWidget(
          text: "",
          color: AppConstants.black,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        leading: IconButton(
          onPressed: () async {
            const FlutterSecureStorage storage = FlutterSecureStorage();
            await storage.write(
                key: StringConst.deepLinkUrl, value: "deepLinkUrl");
            String role = await StringConst.getUserRole();
            if (widget.isFromLogin == true) {
              // Routes.back(context: context);
              // Routes.back(context: context);
              // Routes.back(context: context);
              if (role == "user") {
                Routes.pushRemoveUntil(
                    context: context, screen: const BottomNavBarWidget());
              } else if (role == 'temporaryParent') {
                Routes.pushRemoveUntil(
                    context: context, screen: const PetProfileScreen());
              } else {
                Routes.pushRemoveUntil(
                    context: context, screen: const BottomNavBarWidget());
              }
            } else {
              // Routes.back(context: context);
              if (role == "user") {
                Routes.pushRemoveUntil(
                    context: context, screen: const BottomNavBarWidget());
              } else if (role == 'temporaryParent') {
                Routes.pushRemoveUntil(
                    context: context, screen: const PetProfileScreen());
              } else {
                Routes.pushRemoveUntil(
                    context: context, screen: const BottomNavBarWidget());
              }
            }
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
      body: StreamBuilder(
          stream: homeStreamController.stream,
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

            return Container(
                width: Responsive.width * 100,
                color: AppConstants.white,
                // margin: const EdgeInsets.all(15),
                child: SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommunityProfileWidget(
                          onTap: () {
                            if (snapshot.data?.message?.isMember == true) {
                              context
                                  .read<CommunityDetailsProvider>()
                                  .communityLeftFun(
                                    context: context,
                                    communityId:
                                        snapshot.data?.message?.group?.id ?? "",
                                    function: () {
                                      fetchPosts();
                                    },
                                  );
                            } else {
                              context
                                  .read<CommunityDetailsProvider>()
                                  .communityJoinFun(
                                    communityId:
                                        snapshot.data?.message?.group?.id ?? '',
                                    context: context,
                                    function: () {
                                      fetchPosts();
                                    },
                                  );
                            }
                          },
                          isAdmin: false,
                          groupName: snapshot.data?.message?.group?.name ?? "",
                          groupNaprofile:
                              snapshot.data?.message?.group?.profileImage ?? "",
                          totalMembers:
                              snapshot.data?.message?.group?.membersCount,
                          isJoined: snapshot.data?.message?.isMember,
                        ),
                        const SizeBoxH(10),
                        CommunityCardWidget(
                          latestFeed: LatestFeed(
                              shareLink:
                                  snapshot.data?.message?.shareLink ?? '',
                              id: snapshot.data?.message?.id ?? '',
                              link: snapshot.data?.message?.link ?? '',
                              comments: snapshot.data?.message?.comments ?? [],
                              uploadedBy: UploadedBy(
                                  name: snapshot
                                          .data?.message?.uploadedBy?.name ??
                                      '',
                                  petShopUserDetails:
                                      UsersDatumPetShopUserDetails(
                                          profile: snapshot
                                                  .data
                                                  ?.message
                                                  ?.uploadedBy
                                                  ?.petShopUserDetails
                                                  ?.profile ??
                                              '')),
                              totalLikes:
                                  snapshot.data?.message?.totalLikes ?? 0,
                              totalShares:
                                  snapshot.data?.message?.totalShares ?? 0,
                              userLiked:
                                  snapshot.data?.message?.userLiked ?? false,
                              totalComments:
                                  snapshot.data?.message?.totalComments ?? 0,
                              caption: snapshot.data?.message?.caption ?? '',
                              post: snapshot.data?.message?.post ?? []),
                          function: () {
                            fetchPosts();
                          },
                        ),
                        const SizeBoxH(15),
                        const commonTextWidget(
                          text: "Comments",
                          color: AppConstants.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 15),
                          // height: Responsive.height * 40,
                          child: ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            separatorBuilder: (context, index) =>
                                const SizeBoxH(10),
                            itemCount:
                                snapshot.data?.message?.comments?.length ?? 0,
                            itemBuilder: (context, index) {
                              var comments = snapshot
                                      .data?.message?.comments?.reversed
                                      .toList() ??
                                  [];
                              var comment = comments[index];
                              return CommunityFeedCommentWidget(
                                comment: comment,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ));
          }),
      bottomNavigationBar: CommonInkwell(
        onTap: () {
          // showFeedCommentsBottomSheet(
          //   context,
          //   LatestFeed(
          //       id: getDeepLinkCommunityPostDetailsModel.message?.id ?? '',
          //       comments:
          //           getDeepLinkCommunityPostDetailsModel.message?.comments ??
          //               []),
          //   () {
          //     fetchPosts();
          //   },
          // );
        },
        child: Container(
          padding: const EdgeInsets.all(0),
          width: Responsive.width * 100,
          height: 70,
          decoration: const BoxDecoration(
              color: AppConstants.appPrimaryColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25))),
          child: const Center(
            child: commonTextWidget(
              color: AppConstants.white,
              text: "Add Comment",
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

class CommunityProfileWidget extends StatelessWidget {
  final void Function()? onTap;
  final String? groupName;
  final String? groupNaprofile;
  final int? totalMembers;
  final bool isAdmin;
  final bool? isJoined;

  const CommunityProfileWidget({
    super.key,
    this.onTap,
    this.isAdmin = false,
    this.groupName,
    this.groupNaprofile,
    this.totalMembers,
    this.isJoined,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // color: Colors.amber,
      width: Responsive.width * 100,
      height: Responsive.height * 7,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          commonNetworkImage(
            url: groupNaprofile ??
                "https://cdn.pixabay.com/photo/2017/11/14/13/06/kitty-2948404_640.jpg",
            height: 50,
            width: 50,
            isTopCurved: true,
            radius: 100,
          ),
          const SizeBoxV(10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              commonTextWidget(
                color: AppConstants.black,
                text: groupName ?? "Group name",
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
              commonTextWidget(
                color: AppConstants.subTextGrey,
                text:
                    "${context.read<CommunityHomeProvider>().formatNumber(totalMembers ?? 0)} members",
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
          const Spacer(),
          isAdmin == true
              ? const SizedBox.shrink()
              : CommonInkwell(
                  onTap: onTap,
                  child: Container(
                    width: 80,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: AppConstants.appPrimaryColor,
                      border: Border.all(
                        color: AppConstants.appPrimaryColor,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Image.asset(
                        //   AppImages.settingsRefer,
                        //   color: AppConstants.white,
                        //   height: 10,
                        // ),

                        commonTextWidget(
                          color: AppConstants.white,
                          text: isJoined == true ? "Joined" : "Join",
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
    );
  }
}

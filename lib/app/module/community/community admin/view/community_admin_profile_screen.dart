import 'package:clan_of_pets/app/module/community/community%20admin/model/get_community_admin_model.dart';
import 'package:clan_of_pets/app/module/community/community%20admin/provider/community_admin_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../helpers/common_widget.dart';
import '../../../../helpers/size_box.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_router.dart';
import '../../../../utils/extensions.dart';
import '../../community details/view/post_details_how_vie_link.dart';
import '../../community home/provider/community_home_provider.dart';
import 'community_admin_members_screen.dart';
import 'edit_community_screen.dart';

class CommunityAdminProfileScreen extends StatefulWidget {
  final String? communityId;
  const CommunityAdminProfileScreen({super.key, this.communityId});

  @override
  State<CommunityAdminProfileScreen> createState() =>
      _CommunityAdminProfileScreenState();
}

class _CommunityAdminProfileScreenState
    extends State<CommunityAdminProfileScreen> {
  @override
  void initState() {
    super.initState();
    context
        .read<CommunityAdminProvider>()
        .getCommunityAdminHomeFun(widget.communityId ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.white,
      body: Consumer<CommunityAdminProvider>(
        builder: (context, provider, child) => SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  commonNetworkImage(
                    url: provider.getCommunityAdminModel.message?.groupDetails
                            ?.groupCoverImage ??
                        "https://cdn.pixabay.com/photo/2017/11/14/13/06/kitty-2948404_640.jpg",
                    height: Responsive.height * 32,
                    width: Responsive.width * 100,
                    isTopCurved: false,
                  ),
                  Positioned(
                    child: AppBar(
                      backgroundColor: Colors.transparent,
                      title: commonTextWidget(
                        overFlow: TextOverflow.ellipsis,
                        text: provider.getCommunityAdminModel.message
                                ?.groupDetails?.groupName ??
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
                        PopupMenuButton(
                          position: PopupMenuPosition.under,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          onSelected: (value) {},
                          surfaceTintColor: Colors.transparent,
                          icon: Image.asset(
                            "assets/images/communityAdminSettingsicon.png",
                            height: 30,
                            width: 30,
                          ),
                          iconColor: const Color(0xFF10274A),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 0),
                          itemBuilder: (context) => [
                            "Edit community",
                            "Reomove Community"
                          ]
                              .map((e) => PopupMenuItem<String>(
                                    height: 37,
                                    value: e,
                                    onTap: () {
                                      if (e == "Edit community") {
                                        Routes.push(
                                          context: context,
                                          screen: EditCommunityScreen(
                                            communityId:
                                                widget.communityId ?? '',
                                            groupDetails: provider
                                                .getCommunityAdminModel
                                                .message
                                                ?.groupDetails,
                                          ),
                                          exit: () {
                                            context
                                                .read<CommunityAdminProvider>()
                                                .getCommunityAdminHomeFun(
                                                    widget.communityId ?? '');
                                          },
                                        );
                                      } else {
                                        context
                                            .read<CommunityAdminProvider>()
                                            .deleteCommunity(
                                                context: context,
                                                communityId:
                                                    widget.communityId ?? '');
                                      }
                                    },
                                    child: Text(
                                      e,
                                      style: TextStyle(
                                          color: e == "Reomove Community"
                                              ? Colors.red
                                              : AppConstants.black
                                                  .withOpacity(.8)),
                                    ),
                                  ))
                              .toList(),
                        ),
                        const SizeBoxV(10)
                      ],
                    ),
                  ),
                ],
              ),
              SingleChildScrollView(
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizeBoxH(14),
                    CommunityProfileWidget(
                      isAdmin: true,
                      groupName: provider.getCommunityAdminModel.message
                          ?.groupDetails?.groupName,
                      groupNaprofile: provider.getCommunityAdminModel.message
                          ?.groupDetails?.groupProfileImage,
                      totalMembers: provider.getCommunityAdminModel.message
                          ?.groupDetails?.totalMembers,
                      onTap: () => Routes.push(
                        context: context,
                        screen: const CommunityPostDetailsScreen(
                          isFromLogin: false,
                        ),
                        exit: () {},
                      ),
                    ),
                    const SizeBoxH(10),
                    commonTextWidget(
                      align: TextAlign.justify,
                      color: AppConstants.black.withOpacity(.8),
                      text: provider.getCommunityAdminModel.message
                              ?.groupDetails?.groupDescription ??
                          "",
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          commonTextWidget(
                            align: TextAlign.justify,
                            color: AppConstants.black,
                            text:
                                "${context.read<CommunityHomeProvider>().formatNumber(provider.getCommunityAdminModel.message?.groupDetails?.totalMembers ?? 0)} Members",
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          IconButton(
                              onPressed: () {
                                context
                                    .read<CommunityAdminProvider>()
                                    .getCommunityMembersList(provider
                                            .getCommunityAdminModel
                                            .message
                                            ?.groupDetails
                                            ?.users ??
                                        []);
                                Routes.push(
                                  context: context,
                                  screen: CommunityMembersScreen(
                                    communityId: provider.getCommunityAdminModel
                                            .message?.groupDetails?.id ??
                                        "",
                                    adminId: provider.getCommunityAdminModel
                                            .message?.groupDetails?.creator ??
                                        '',
                                  ),
                                  exit: () {
                                    context
                                        .read<CommunityAdminProvider>()
                                        .getCommunityAdminHomeFun(
                                            widget.communityId ?? '');
                                  },
                                );
                              },
                              icon: const Icon(
                                Icons.search,
                                size: 20,
                                color: AppConstants.appPrimaryColor,
                              ))
                        ],
                      ),
                    ),
                    MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          separatorBuilder: (context, index) =>
                              const SizeBoxH(20),
                          itemCount: provider.getCommunityAdminModel.message
                                  ?.groupDetails?.users?.length ??
                              0,
                          itemBuilder: (context, index) {
                            var data = provider.getCommunityAdminModel.message
                                ?.groupDetails?.users?[index];
                            return CommunityAdminMemberWidget(
                              communityId: widget.communityId ?? "",
                              data: data,
                              adminId: provider.getCommunityAdminModel.message
                                      ?.groupDetails?.creator ??
                                  '',
                            );
                          }),
                    ),
                    const SizeBoxH(20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CommunityAdminMemberWidget extends StatelessWidget {
  final UserElement? data;
  final String communityId;
  final String adminId;
  // final String profileImg;
  // final String userName;
  // final String userName;

  const CommunityAdminMemberWidget({
    super.key,
    this.data,
    required this.communityId,
    required this.adminId,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: Responsive.width * 100,
      child: Row(
        children: [
          commonNetworkImage(
            url: data?.user?.petShopUserDetails?.profile ?? "",
            height: 40,
            width: 40,
            isTopCurved: true,
            radius: 100,
          ),
          const SizeBoxV(15),
          commonTextWidget(
            align: TextAlign.justify,
            color: AppConstants.black,
            text: adminId == data?.user?.id
                ? "Community Admin"
                : data?.user?.name ?? "",
            fontSize: 14,
            fontWeight:
                adminId == data?.user?.id ? FontWeight.bold : FontWeight.w500,
          ),
          const Spacer(),
          adminId == data?.user?.id
              ? const SizedBox.shrink()
              : CommonInkwell(
                  onTap: () {
                    context
                        .read<CommunityAdminProvider>()
                        .removeUserFromCommunity(
                            communityId: communityId,
                            context: context,
                            memberId: data?.user?.id ?? "");
                  },
                  child: Container(
                    height: 34,
                    width: 84,
                    decoration: const BoxDecoration(
                      color: Color(0xffF3F3F5),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: const Center(
                      child: commonTextWidget(
                        color: Colors.red,
                        text: "Remove",
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}

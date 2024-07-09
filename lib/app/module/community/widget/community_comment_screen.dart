import 'dart:async';

import 'package:clan_of_pets/app/module/community/community%20home/model/get_community_home_model.dart';
import 'package:clan_of_pets/app/module/community/widget/community_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../core/server_client_services.dart';
import '../../../helpers/common_widget.dart';
import '../../../helpers/size_box.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_images.dart';
import '../../../utils/app_router.dart';
import '../../../utils/extensions.dart';
import '../../home/widget/common_grey_widget.dart';
import '../community home/model/single_post_model.dart';
import '../community home/provider/community_home_provider.dart';

class CommunityCommentScreen extends StatefulWidget {
  const CommunityCommentScreen({
    super.key,
    required this.function,
    required this.link,
    this.latestFeed,
  });

  final void Function() function;
  final String link;
  final LatestFeed? latestFeed;

  @override
  State<CommunityCommentScreen> createState() => _CommunityCommentScreenState();
}

class _CommunityCommentScreenState extends State<CommunityCommentScreen> {
  final StreamController<SinglePostModel> _streamController =
      StreamController();
  Future<void> fetchPosts() async {
    try {
      List response = await ServerClient.get(
        widget.link,
      );
      if (response.first >= 200 && response.first < 300) {
        SinglePostModel model = SinglePostModel.fromJson(response.last);
        _streamController.add(model);
      } else {
        _streamController.add(SinglePostModel());
      }
    } catch (e) {
      _streamController.add(SinglePostModel());
    }
  }

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstants.white,
        title: const commonTextWidget(
          text: "Comments",
          color: AppConstants.black,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        leading: SizedBox(
          height: 30,
          width: 30,
          child: Center(
            child: IconButton(
              onPressed: () {
                Routes.back(context: context);
              },
              style: ButtonStyle(
                fixedSize: const WidgetStatePropertyAll(Size(4, 4)),
                backgroundColor: WidgetStatePropertyAll(
                  AppConstants.white.withOpacity(.5),
                ),
              ),
              icon: const Icon(
                Icons.arrow_back_ios_new,
                size: 15,
                color: AppConstants.appPrimaryColor,
              ),
            ),
          ),
        ),
      ),
      backgroundColor: AppConstants.white,
      bottomNavigationBar: LayoutBuilder(
        builder: (context, constraints) => Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  width: 1.5,
                  color: AppConstants.black.withOpacity(.1),
                ),
              ),
            ),
            height: Responsive.height * 8,
            width: Responsive.width * 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: Responsive.height * 8,
                  width: Responsive.width * 70,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: CommonTextFormField(
                    bgColor: const Color(0xffF3F3F5),
                    hintText: " add comment",
                    keyboardType: TextInputType.text,
                    controller: context
                        .read<CommunityHomeProvider>()
                        .communityFeedCommentController,
                    radius: 10,
                    textInputAction: TextInputAction.done,
                  ),
                ),
                CommonInkwell(
                  onTap: () {
                    if (context
                        .read<CommunityHomeProvider>()
                        .communityFeedCommentController
                        .text
                        .isEmpty) {
                      toast(context,
                          title: "Please add your comment",
                          backgroundColor: Colors.red);
                    } else {
                      context
                          .read<CommunityHomeProvider>()
                          .communityFeedCommentFun(
                            context: context,
                            feedId: widget.latestFeed?.id ?? '',
                            function: () {
                              fetchPosts();
                            },
                          );
                    }
                  },
                  child: Container(
                    height: Responsive.height * 8,
                    width: 55,
                    decoration: const BoxDecoration(
                      color: Color(0xffF3F3F5),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Center(
                      child: Image.asset(
                        "assets/images/sendicon.png",
                        height: 15,
                        width: 15,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      body: StreamBuilder<SinglePostModel>(
          stream: _streamController.stream,
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
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const SizeBoxV(10),
                      commonNetworkImage(
                        url: snapshot.data?.message?.group?.profileImage ?? "",
                        height: 70,
                        width: 70,
                        radius: 100,
                      ),
                      const SizeBoxV(10),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          commonTextWidget(
                            align: TextAlign.start,
                            color: AppConstants.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            text: snapshot.data?.message?.group?.name ?? "",
                            maxLines: 2,
                            overFlow: TextOverflow.ellipsis,
                          ),
                          commonTextWidget(
                            color: AppConstants.black40,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            text:
                                "${snapshot.data?.message?.group?.membersCount} members",
                          ),
                        ],
                      ))
                    ],
                  ),
                  const SizeBoxH(15),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          widget.latestFeed?.post?.first.isEmpty ?? true
                              ? const SizedBox.shrink()
                              : commonNetworkImage(
                                  url: widget.latestFeed?.post?.first ??
                                      "https://cdn.pixabay.com/photo/2017/11/14/13/06/kitty-2948404_640.jpg",
                                  height: Responsive.height * 18.2,
                                  width: Responsive.width * 100,
                                  isBottomCurved: false,
                                  isTopCurved: false,
                                ),
                          SizeBoxH(Responsive.height * 1.5),
                          Container(
                            width: Responsive.width * 100,
                            margin: const EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                commonTextWidget(
                                  align: TextAlign.start,
                                  color: AppConstants.black,
                                  text: widget.latestFeed?.caption
                                          ?.capitalizeFirstLetter() ??
                                      "",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                                SizeBoxH(Responsive.height * 1),
                                SizedBox(
                                  height: 15,
                                  child: CommonInkwell(
                                      onTap: () => context
                                          .read<CommunityHomeProvider>()
                                          .launchURL(
                                              widget.latestFeed?.link ?? ''),
                                      child: Text(
                                        widget.latestFeed?.link ?? '',
                                        textAlign: TextAlign.start,
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.blue,
                                            overflow: TextOverflow.ellipsis,
                                            decoration:
                                                TextDecoration.underline,
                                            decorationStyle:
                                                TextDecorationStyle.solid,
                                            decorationColor: Colors.blue,
                                            height: .2),
                                      )),
                                ),
                                SizeBoxH(Responsive.height * 1),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      // color: Colors.amber,
                                      width: Responsive.width * 45,
                                      child: Row(
                                        children: [
                                          commonNetworkImage(
                                            url: widget
                                                    .latestFeed
                                                    ?.uploadedBy
                                                    ?.petShopUserDetails
                                                    ?.profile ??
                                                "https://cdn.pixabay.com/photo/2017/11/14/13/06/kitty-2948404_640.jpg",
                                            height: 30,
                                            width: 30,
                                            isTopCurved: true,
                                            radius: 100,
                                          ),
                                          const SizeBoxV(7),
                                          commonTextWidget(
                                            align: TextAlign.start,
                                            color: AppConstants.subTextGrey,
                                            overFlow: TextOverflow.ellipsis,
                                            text: widget.latestFeed?.uploadedBy
                                                    ?.name
                                                    ?.capitalizeFirstLetter() ??
                                                "iam a groomer ",
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: Responsive.width * 30,
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              CommonGreyContainer(
                                                height: 30,
                                                isLiked: widget.latestFeed
                                                        ?.userLiked ??
                                                    false,
                                                width: 30,
                                                imageHeight: 16,
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                image: AppImages
                                                    .communityBlackLove,
                                                onTap: () {},
                                              ),
                                              CommonGreyContainer(
                                                height: 30,
                                                width: 30,
                                                imageHeight: 16,
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                image: AppImages
                                                    .communityBlackChat,
                                                onTap: () {},
                                              ),
                                              CommonGreyContainer(
                                                height: 30,
                                                width: 30,
                                                imageHeight: 16,
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                image: AppImages
                                                    .communityBlackShare,
                                                onTap: () {},
                                              )
                                            ],
                                          ),
                                          const SizeBoxH(5),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0),
                                                child: commonTextWidget(
                                                  align: TextAlign.start,
                                                  color:
                                                      AppConstants.subTextGrey,
                                                  overFlow:
                                                      TextOverflow.ellipsis,
                                                  text: formatNumber(snapshot
                                                          .data
                                                          ?.message
                                                          ?.totalLikes
                                                          ?.toInt() ??
                                                      0),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              commonTextWidget(
                                                align: TextAlign.start,
                                                color: AppConstants.subTextGrey,
                                                overFlow: TextOverflow.ellipsis,
                                                text: formatNumber(snapshot.data
                                                        ?.message?.totalComments
                                                        ?.toInt() ??
                                                    0),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 3.0),
                                                child: commonTextWidget(
                                                  align: TextAlign.start,
                                                  color:
                                                      AppConstants.subTextGrey,
                                                  overFlow:
                                                      TextOverflow.ellipsis,
                                                  text: formatNumber(snapshot
                                                          .data
                                                          ?.message
                                                          ?.totalShares
                                                          ?.toInt() ??
                                                      0),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizeBoxH(8)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizeBoxH(10),
                  snapshot.data?.message?.comments?.isNotEmpty ?? false
                      ? ListView.separated(
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
                        )
                      : const Center(
                          child: Text("No comments yet"),
                        ),
                ],
              ),
            );
          }),
    );
  }

  String formatNumber(int number) {
    if (number < 1000) {
      return number.toString();
    } else if (number < 1000000) {
      double result = number / 1000;
      if (result % 1 == 0) {
        return '${result.toInt()}K';
      } else {
        return '${result.toStringAsFixed(1)}K';
      }
    } else {
      double result = number / 1000000;
      if (result % 1 == 0) {
        return '${result.toInt()}M';
      } else {
        return '${result.toStringAsFixed(1)}M';
      }
    }
  }

  String formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays == 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else {
      return DateFormat('dd/MM/yy HH:mm').format(dateTime);
    }
  }
}

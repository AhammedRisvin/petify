import 'package:clan_of_pets/app/module/community/community%20home/provider/community_home_provider.dart';
import 'package:clan_of_pets/app/utils/app_router.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../helpers/common_widget.dart';
import '../../../helpers/size_box.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_images.dart';
import '../../../utils/extensions.dart';
import '../../home/widget/common_grey_widget.dart';
import '../community home/model/get_community_home_model.dart';
import 'community_comment_screen.dart';

class CommunityCardWidget extends StatelessWidget {
  final void Function() function;
  final bool noImage;
  final LatestFeed? latestFeed;
  const CommunityCardWidget({
    super.key,
    this.noImage = false,
    this.latestFeed,
    required this.function,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
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
            noImage
                ? const SizedBox.shrink()
                : latestFeed?.post?.isEmpty ?? true
                    ? const SizedBox.shrink()
                    : latestFeed?.post?.first.isEmpty ?? true
                        ? const SizedBox.shrink()
                        : commonNetworkImage(
                            url: latestFeed?.post?.first ??
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
                    text: latestFeed?.caption?.capitalizeFirstLetter() ?? "",
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  SizeBoxH(Responsive.height * 1),
                  SizedBox(
                    height: 15,
                    child: CommonInkwell(
                        onTap: () => context
                            .read<CommunityHomeProvider>()
                            .launchURL(latestFeed?.link ?? ''),
                        child: Text(
                          latestFeed?.link ?? '',
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.blue,
                              overflow: TextOverflow.ellipsis,
                              decoration: TextDecoration.underline,
                              decorationStyle: TextDecorationStyle.solid,
                              decorationColor: Colors.blue,
                              height: .2),
                        )),
                  ),
                  SizeBoxH(Responsive.height * 1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        // color: Colors.amber,
                        width: Responsive.width * 45,
                        child: Row(
                          children: [
                            commonNetworkImage(
                              url: latestFeed?.uploadedBy?.petShopUserDetails
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
                              text: latestFeed?.uploadedBy?.name
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CommonGreyContainer(
                                  height: 30,
                                  isLiked: latestFeed?.userLiked ?? false,
                                  width: 30,
                                  imageHeight: 16,
                                  borderRadius: BorderRadius.circular(100),
                                  image: AppImages.communityBlackLove,
                                  onTap: () {
                                    context
                                        .read<CommunityHomeProvider>()
                                        .communityFeedLikeFun(
                                          context: context,
                                          communityId: latestFeed?.id ?? '',
                                          function: function,
                                        );
                                  },
                                ),
                                CommonGreyContainer(
                                  height: 30,
                                  width: 30,
                                  imageHeight: 16,
                                  borderRadius: BorderRadius.circular(100),
                                  image: AppImages.communityBlackChat,
                                  onTap: () {
                                    Routes.push(
                                      screen: CommunityCommentScreen(
                                        function: function,
                                        link: latestFeed?.shareLink ?? "",
                                        latestFeed: latestFeed,
                                      ),
                                      exit: () {
                                        function();
                                      },
                                      context: context,
                                    );
                                  },
                                ),
                                CommonGreyContainer(
                                  height: 30,
                                  width: 30,
                                  imageHeight: 16,
                                  borderRadius: BorderRadius.circular(100),
                                  image: AppImages.communityBlackShare,
                                  onTap: () {
                                    context
                                        .read<CommunityHomeProvider>()
                                        .shareFeedUrl(
                                          videoUrl: latestFeed?.shareLink ?? '',
                                          subject: latestFeed?.caption ?? "",
                                        );
                                  },
                                )
                              ],
                            ),
                            const SizeBoxH(5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: commonTextWidget(
                                    align: TextAlign.start,
                                    color: AppConstants.subTextGrey,
                                    overFlow: TextOverflow.ellipsis,
                                    text: formatNumber(
                                        latestFeed?.totalLikes?.toInt() ?? 0),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                commonTextWidget(
                                  align: TextAlign.start,
                                  color: AppConstants.subTextGrey,
                                  overFlow: TextOverflow.ellipsis,
                                  text: formatNumber(
                                      latestFeed?.totalComments?.toInt() ?? 0),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 3.0),
                                  child: commonTextWidget(
                                    align: TextAlign.start,
                                    color: AppConstants.subTextGrey,
                                    overFlow: TextOverflow.ellipsis,
                                    text: formatNumber(
                                        latestFeed?.totalShares?.toInt() ?? 0),
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
}

class CommunityFeedCommentWidget extends StatelessWidget {
  final Comment comment;
  const CommunityFeedCommentWidget({
    super.key,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: AppConstants.greyContainerBg,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        side: BorderSide(
          color: AppConstants.greyContainerBg,
          width: 1.8,
        ),
      ),
      // shadowColor: const Color(0xff000000).withOpacity(.1),
      color: const Color.fromRGBO(255, 255, 255, 1),
      elevation: .1,
      child: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Color.fromRGBO(255, 255, 255, 1),
            border: Border.fromBorderSide(
              BorderSide(
                color: AppConstants.greyContainerBg,
                width: 1,
              ),
            ),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 1),
                spreadRadius: 0,
                blurRadius: 4,
                color: AppConstants.greyContainerBg,
              )
            ]),
        padding: const EdgeInsets.all(15),
        width: Responsive.width * 100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                commonNetworkImage(
                  url: comment.user?.petShopUserDetails?.profile ?? "",
                  height: 30,
                  width: 30,
                  isTopCurved: true,
                  radius: 100,
                ),
                const SizeBoxV(7),
                commonTextWidget(
                  align: TextAlign.start,
                  color: AppConstants.black,
                  overFlow: TextOverflow.ellipsis,
                  text: comment.user?.name?.capitalizeFirstLetter() ?? "",
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
                const Spacer(),
                commonTextWidget(
                  align: TextAlign.start,
                  color: AppConstants.black.withOpacity(.4),
                  text: DateFormat('h:mm a')
                      .format(DateTime.parse(comment.date ?? '').toLocal()),
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                ),
              ],
            ),
            const SizeBoxH(10),
            commonTextWidget(
              align: TextAlign.start,
              color: AppConstants.black.withOpacity(.6),
              overFlow: TextOverflow.clip,
              text: comment.text?.capitalizeFirstLetter() ?? "",
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
      ),
    );
  }
}

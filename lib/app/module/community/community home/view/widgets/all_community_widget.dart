import 'package:clan_of_pets/app/module/community/community%20home/provider/community_home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../helpers/common_widget.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../home/view/home_screen.dart';
import '../../model/get_all_community_search_model.dart';

class AllCommunityWidget extends StatelessWidget {
  final void Function() function;
  const AllCommunityWidget({
    super.key,
    required this.trendingCommunityData,
    required this.function,
  });

  final Group? trendingCommunityData;

  @override
  Widget build(BuildContext context) {
    double leftPosition = 0;

    int length = trendingCommunityData?.users?.length ?? 0;
    if (length >= 4) {
      leftPosition = 80;
    } else if (length >= 3) {
      leftPosition = 70;
    } else if (length >= 2) {
      leftPosition = 60;
    } else if (length >= 1) {
      leftPosition = 48;
    } else {
      leftPosition = 0;
    }
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: NetworkImage(
            trendingCommunityData?.groupCoverImage ?? "",
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          commonTextWidget(
            color: AppConstants.white,
            overFlow: TextOverflow.ellipsis,
            text: trendingCommunityData?.groupName ?? "",
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          SizedBox(
            width: double.infinity,
            height: 45,
            child: Stack(
              children: [
                Positioned(
                  bottom: 15,
                  top: 15,
                  right: 15,
                  child: CommonBannerButtonWidget(
                    bgColor: AppConstants.white,
                    text: "Join",
                    borderColor: AppConstants.white,
                    textColor: AppConstants.black,
                    width: 30,
                    height: 20,
                    fontSize: 8,
                    onTap: () {
                      context.read<CommunityHomeProvider>().communityJoinFun(
                            communityId: trendingCommunityData?.id ?? '',
                            context: context,
                            function: () {
                              function();
                            },
                          );
                    },
                  ),
                ),
                if ((trendingCommunityData?.users?.length ?? 0) >= 1) ...[
                  Positioned(
                    bottom: 10,
                    left: trendingCommunityData?.users?.isNotEmpty ?? false
                        ? 15
                        : 0,
                    child: trendingCommunityData?.users?.isNotEmpty ?? false
                        ? commonNetworkImage(
                            url: trendingCommunityData?.users?[0].user
                                    ?.petShopUserDetails?.profile ??
                                "",
                            height: 25,
                            isRound: true,
                            width: 25,
                            isTopCurved: true,
                            radius: 100,
                          )
                        : const SizedBox.shrink(),
                  ),
                ],
                if ((trendingCommunityData?.users?.length ?? 0) >= 2) ...[
                  Positioned(
                    bottom: 10,
                    left: (trendingCommunityData?.users?.length ?? 0) >= 2
                        ? 28
                        : 0,
                    child: (trendingCommunityData?.users?.length ?? 0) >= 2
                        ? commonNetworkImage(
                            url: trendingCommunityData?.users?[1].user
                                    ?.petShopUserDetails?.profile ??
                                "",
                            height: 25,
                            isRound: true,
                            width: 25,
                            isTopCurved: true,
                            radius: 100,
                          )
                        : const SizedBox.shrink(),
                  ),
                ],
                if ((trendingCommunityData?.users?.length ?? 0) >= 3) ...[
                  Positioned(
                    bottom: 10,
                    left: (trendingCommunityData?.users?.length ?? 0) >= 3
                        ? 39
                        : 0,
                    child: (trendingCommunityData?.users?.length ?? 0) >= 3
                        ? commonNetworkImage(
                            url: trendingCommunityData?.users?[2].user
                                    ?.petShopUserDetails?.profile ??
                                "",
                            height: 25,
                            isRound: true,
                            width: 25,
                            isTopCurved: true,
                            radius: 100,
                          )
                        : const SizedBox.shrink(),
                  ),
                ],
                if ((trendingCommunityData?.users?.length ?? 0) >= 4) ...[
                  Positioned(
                    bottom: 10,
                    left: (trendingCommunityData?.users?.length ?? 0) >= 4
                        ? 50
                        : 0,
                    child: (trendingCommunityData?.users?.length ?? 0) >= 4
                        ? commonNetworkImage(
                            url: trendingCommunityData?.users?[3].user
                                    ?.petShopUserDetails?.profile ??
                                "",
                            height: 25,
                            isRound: true,
                            width: 25,
                            isTopCurved: true,
                            radius: 100,
                          )
                        : const SizedBox.shrink(),
                  ),
                ],
                if (trendingCommunityData?.users?.isNotEmpty ?? false) ...[
                  Positioned(
                    bottom: 15,
                    left: leftPosition,
                    child: commonTextWidget(
                      color: AppConstants.white,
                      text: context.read<CommunityHomeProvider>().formatNumber(
                          trendingCommunityData?.numberOfMembers ?? 0),
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

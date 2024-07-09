import 'package:clan_of_pets/app/module/community/community%20home/model/get_community_home_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../helpers/common_widget.dart';
import '../../../../../helpers/size_box.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../../utils/app_images.dart';
import '../../../../../utils/extensions.dart';
import '../../provider/community_home_provider.dart';

class JoinedCommunityWidget extends StatelessWidget {
  final Community? community;
  const JoinedCommunityWidget({
    super.key,
    this.community,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppConstants.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
              color: const Color(0xff000000).withOpacity(.1), width: 1)),
      elevation: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
        width: Responsive.width * 67,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: const Color(0xffFFFFFF),
          ),
        ),
        child: Row(
          children: [
            Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: commonNetworkImage(
                url: community?.groupCoverImage ??
                    "https://img.freepik.com/free-photo/lovely-pet-portrait-isolated_23-2149192357.jpg?size=626&ext=jpg",
                height: 70,
                width: 70,
                isTopCurved: true,
                radius: 10,
              ),
            ),
            const SizeBoxV(10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  commonTextWidget(
                    color: AppConstants.black,
                    text: community?.groupName ?? "",
                    fontSize: 14,
                    maxLines: 2,
                    overFlow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.bold,
                    align: TextAlign.start,
                  ),
                  const SizeBoxH(5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        AppImages.communityListProfile,
                        height: 18,
                      ),
                      const SizeBoxV(5),
                      commonTextWidget(
                        color: AppConstants.black,
                        text: context
                            .read<CommunityHomeProvider>()
                            .formatNumber(community?.numberOfMembers ?? 0),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

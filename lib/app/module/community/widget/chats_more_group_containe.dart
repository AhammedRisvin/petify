import 'package:clan_of_pets/app/module/community/chat/view%20model/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../helpers/common_widget.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/extensions.dart';
import '../chat/model/listing_chats_model.dart';

class ChatsMoreGroupContainer extends StatelessWidget {
  final GroupsWithoutMessage? chatsMoreData;
  final void Function()? onTap;
  const ChatsMoreGroupContainer({
    super.key,
    this.chatsMoreData,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CommonInkwell(
      onTap: onTap,
      child: Container(
        width: Responsive.width * 45,
        margin: const EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
            image: NetworkImage(
              chatsMoreData?.groupCoverImage ??
                  "https://media.istockphoto.com/id/1207750534/photo/404-error-internet-page-not-found-hand-with-magnifier-concept-picture.jpg?s=612x612&w=0&k=20&c=-eDOz1tb4CC8dqgcggiyA6A6ozlR_DEtaeyQI8zU_FU=",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: AppConstants.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: Responsive.height * 4,
                        width: Responsive.width * 100,
                        // color: Colors.amber,
                        margin: const EdgeInsets.only(left: 10, bottom: 10),
                        padding: const EdgeInsets.only(top: 3, left: 6),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: commonTextWidget(
                                color: AppConstants.black,
                                align: TextAlign.left,
                                text: chatsMoreData?.groupName ?? "",
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                maxLines: 1,
                                overFlow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      (chatsMoreData?.totalUserCount ?? 0) > 0
                          ? Positioned(
                              bottom: 4,
                              left: 15,
                              child: commonNetworkImage(
                                url: chatsMoreData?.usersWithProfilePics?[0]
                                        .profilePicture ??
                                    "",
                                height: 15,
                                width: 15,
                                isTopCurved: true,
                                radius: 100,
                              ),
                            )
                          : const SizedBox.shrink(),
                      (chatsMoreData?.totalUserCount ?? 0) > 1
                          ? Positioned(
                              bottom: 4,
                              left: 23,
                              child: commonNetworkImage(
                                url: chatsMoreData?.usersWithProfilePics?[1]
                                        .profilePicture ??
                                    "",
                                height: 15,
                                width: 15,
                                isTopCurved: true,
                                radius: 100,
                              ),
                            )
                          : const SizedBox.shrink(),
                      (chatsMoreData?.totalUserCount ?? 0) > 2
                          ? Positioned(
                              bottom: 4,
                              left: 32,
                              child: commonNetworkImage(
                                url: chatsMoreData?.usersWithProfilePics?[2]
                                        .profilePicture ??
                                    "",
                                height: 15,
                                width: 15,
                                isTopCurved: true,
                                radius: 100,
                              ),
                            )
                          : const SizedBox.shrink(),
                      (chatsMoreData?.totalUserCount ?? 0) > 3
                          ? Positioned(
                              bottom: 4,
                              left: 40,
                              child: commonNetworkImage(
                                url: chatsMoreData?.usersWithProfilePics?[3]
                                        .profilePicture ??
                                    "",
                                height: 15,
                                width: 15,
                                isTopCurved: true,
                                radius: 100,
                              ),
                            )
                          : const SizedBox.shrink(),
                      Positioned(
                        bottom: 4,
                        right: 50,
                        left: 30,
                        child: commonTextWidget(
                          color: AppConstants.black,
                          text: context.read<ChatProvider>().formatNumber(
                                chatsMoreData?.totalUserCount ?? 0,
                              ),
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          letterSpacing: -0.1,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

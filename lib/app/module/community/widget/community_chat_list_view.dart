// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../helpers/common_widget.dart';
import '../../../helpers/size_box.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/extensions.dart';
import '../chat/model/listing_chats_model.dart';
import '../chat/view model/chat_provider.dart';

class communityChatListViewContainerWidget extends StatelessWidget {
  final void Function()? onTap;
  final GroupsWithMessage? joinedGroupsData;
  const communityChatListViewContainerWidget({
    super.key,
    this.joinedGroupsData,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CommonInkwell(
      onTap: onTap,
      child: SizedBox(
        width: Responsive.width * 100,
        child: Row(
          children: [
            commonNetworkImage(
              url: joinedGroupsData?.groupProfileImage ?? "",
              height: Responsive.height * 7,
              width: Responsive.width * 14,
              radius: 100,
            ),
            const SizeBoxV(15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: commonTextWidget(
                          align: TextAlign.left,
                          color: AppConstants.black,
                          text: joinedGroupsData?.groupName ?? "",
                          fontSize: 14,
                        ),
                      ),
                      Row(
                        children: [
                          commonTextWidget(
                            color: AppConstants.subTextGrey,
                            text: context.read<ChatProvider>().formatDateTime(
                                  joinedGroupsData?.latestMessage?.createdAt ??
                                      DateTime.now(),
                                ),
                            fontSize: 11,
                          ),
                          const SizeBoxV(6),
                          const CircleAvatar(
                            backgroundColor: Color(0xffDC0000),
                            radius: 4,
                          )
                        ],
                      ),
                    ],
                  ),
                  commonTextWidget(
                    color: AppConstants.black,
                    text: joinedGroupsData?.latestMessage?.content ?? "",
                    fontSize: 12,
                    maxLines: 1,
                    overFlow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

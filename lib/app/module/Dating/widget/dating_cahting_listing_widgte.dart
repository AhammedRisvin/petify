import 'package:clan_of_pets/app/module/Dating/model/get_chats_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../../helpers/common_widget.dart';
import '../../../helpers/size_box.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/extensions.dart';
import '../../community/chat/view model/chat_provider.dart';

class DatingChatListingContainer extends StatelessWidget {
  final void Function()? onTap;
  final Chat? data;
  const DatingChatListingContainer({
    super.key,
    this.onTap,
    this.data,
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
              url: data?.users?[0].petShopUserDetails?.profile ?? "",
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
                      commonTextWidget(
                        align: TextAlign.left,
                        color: AppConstants.black,
                        text: data?.users?[0].name ?? "",
                        fontSize: 14,
                      ),
                      commonTextWidget(
                        color: AppConstants.subTextGrey,
                        maxLines: 1,
                        overFlow: TextOverflow.ellipsis,
                        text: context.read<ChatProvider>().formatDateTime(
                              data?.latestMessage?.createdAt ?? DateTime.now(),
                            ),
                        fontSize: 11,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      commonTextWidget(
                        color: AppConstants.subTextGrey,
                        text: data?.latestMessage?.sender?.id !=
                                data?.users?[0].id
                            ? "You :"
                            : "",
                        fontSize: 12,
                      ),
                      Expanded(
                        child: commonTextWidget(
                          align: TextAlign.start,
                          color: AppConstants.black,
                          text: data?.latestMessage?.content ?? "",
                          fontSize: 12,
                          maxLines: 1,
                          overFlow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
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

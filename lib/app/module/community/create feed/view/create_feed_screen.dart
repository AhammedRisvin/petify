import 'package:clan_of_pets/app/module/community/create%20feed/provider/create_feed_provider.dart';
import 'package:clan_of_pets/app/module/community/view%20model/Community_provider.dart';
import 'package:clan_of_pets/app/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../helpers/common_widget.dart';
import '../../../../helpers/size_box.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_router.dart';
import '../../../pet profile/view/events/create_events_screen.dart';
import '../../create community/provider/create_community_provider.dart';

class CreateFeedScreen extends StatelessWidget {
  final String? communityId;
  const CreateFeedScreen({super.key, this.communityId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: AppConstants.white,
        title: const commonTextWidget(
          text: "Create feed",
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
            size: 19,
            color: AppConstants.appPrimaryColor,
          ),
        ),
      ),
      body: Consumer<CommunityProvider>(
        builder: (context, provider, child) => Container(
          height: Responsive.height * 100,
          width: Responsive.width * 100,
          padding: const EdgeInsets.all(16),
          child: Consumer<CommunityProvider>(
            builder: (context, provider, child) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizeBoxH(20),
                const commonTextWidget(
                  color: AppConstants.black,
                  text: "Create Caption",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                const SizeBoxH(6),
                TextField(
                  onTapOutside: (event) => FocusScope.of(context).unfocus(),
                  controller: context
                      .read<CreateFeedProvider>()
                      .creteFeedCaptionController,
                  maxLines: null,
                  minLines: 6,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.done,
                  style: const TextStyle(
                    color: AppConstants.black,
                    fontSize: 12,
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide.none,
                    ),
                    fillColor: AppConstants.greyContainerBg,
                    filled: true,
                    hintText: "Write a caption ",
                    hintStyle: const TextStyle(
                      color: AppConstants.black40,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizeBoxH(22),
                const commonTextWidget(
                  color: AppConstants.black,
                  text: "Add Link",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                const SizeBoxH(6),
                CommonTextFormField(
                  bgColor: AppConstants.greyContainerBg,
                  hintText: "Add link (optional)",
                  readOnly: false,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  controller: context
                      .read<CreateFeedProvider>()
                      .communityLinkController,
                  radius: 12,
                ),
                const SizeBoxH(15),
                const commonTextWidget(
                  color: AppConstants.black,
                  text: "Add Image",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                const SizeBoxH(6),
                Consumer<CreateCommunityProvider>(
                  builder: (context, value, child) =>
                      CommonFileSelectingContainer(
                    text: value.thumbnailImage == null
                        ? "or browse from your device"
                        : value.imageTitle ?? "",
                    onTap: () {
                      context
                          .read<CreateCommunityProvider>()
                          .uploadSingleImage(context);
                    },
                  ),
                ),
                const SizeBoxH(22),
                Align(
                  alignment: Alignment.centerRight,
                  child: CommonButton(
                    onTap: () {
                      context.read<CreateFeedProvider>().createFeedFn(
                          context: context, communityId: communityId ?? '');
                    },
                    text: "Post",
                    width: Responsive.width * 50,
                    height: Responsive.height * 7,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:clan_of_pets/app/module/community/community%20admin/provider/community_admin_provider.dart';
import 'package:clan_of_pets/app/module/community/create%20community/provider/create_community_provider.dart';
import 'package:clan_of_pets/app/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../helpers/common_widget.dart';
import '../../../../helpers/size_box.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/app_router.dart';
import '../model/get_community_admin_model.dart';

class EditCommunityScreen extends StatefulWidget {
  final String communityId;
  final GroupDetails? groupDetails;
  const EditCommunityScreen(
      {super.key, required this.communityId, this.groupDetails});

  @override
  State<EditCommunityScreen> createState() => _EditCommunityScreenState();
}

class _EditCommunityScreenState extends State<EditCommunityScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CommunityAdminProvider>().communityNamerController.text =
        widget.groupDetails?.groupName ?? '';
    context.read<CommunityAdminProvider>().communityDescriptionController.text =
        widget.groupDetails?.groupDescription ?? '';
    context.read<CreateCommunityProvider>().coverImageUr =
        widget.groupDetails?.groupCoverImage ?? '';
    context.read<CreateCommunityProvider>().singleImageUr =
        widget.groupDetails?.groupProfileImage ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.white,
      appBar: AppBar(
        backgroundColor: AppConstants.white,
        title: const commonTextWidget(
          text: "Edit community ",
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
      body: Container(
        margin: const EdgeInsets.all(15),
        height: Responsive.height * 100,
        width: Responsive.width * 100,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Consumer<CreateCommunityProvider>(
                    builder: (context, value, child) => SizedBox(
                      height: 180,
                      width: Responsive.width * 100,
                      child: commonNetworkImage(
                        url: value.coverImageUr != '' ? value.coverImageUr : "",
                        height: 180,
                        width: Responsive.width * 100,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 5,
                    right: 5,
                    child: CommonInkwell(
                      onTap: () {
                        context
                            .read<CreateCommunityProvider>()
                            .uploadCoverImage(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppConstants.black.withOpacity(.1),
                            borderRadius: BorderRadius.circular(5)),
                        height: 24,
                        width: 26,
                        child: const Icon(
                          Icons.photo_camera_outlined,
                          size: 16,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.only(left: 15),
                decoration: BoxDecoration(
                    color: AppConstants.greyContainerBg,
                    borderRadius: BorderRadius.circular(10)),
                height: 56,
                width: Responsive.width * 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: Responsive.width * 60,
                      child: commonTextWidget(
                        color: AppConstants.black40,
                        overFlow: TextOverflow.ellipsis,
                        text: context
                                    .watch<CreateCommunityProvider>()
                                    .singleImageUr !=
                                ''
                            ? context
                                .watch<CreateCommunityProvider>()
                                .singleImageUr
                            : "Change Profile image",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    CommonInkwell(
                      onTap: () {
                        context
                            .read<CreateCommunityProvider>()
                            .uploadSingleImage(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppConstants.appPrimaryColor,
                            borderRadius: BorderRadius.circular(10)),
                        height: 56,
                        width: 85,
                        child: Center(
                          child: Image.asset(
                            AppImages.shareCloudIcon,
                            height: 20,
                            width: 27,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizeBoxH(15),
              const commonTextWidget(
                color: AppConstants.black,
                text: "Community Name",
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              const SizeBoxH(10),
              Container(
                height: 56,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: CommonTextFormField(
                  bgColor: AppConstants.greyContainerBg,
                  hintText: "Community name",
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  controller: context
                      .read<CommunityAdminProvider>()
                      .communityNamerController,
                  radius: 10,
                ),
              ),
              const SizeBoxH(15),
              const commonTextWidget(
                color: AppConstants.black,
                text: "Community Name",
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              const SizeBoxH(10),
              TextFormField(
                onTapOutside: (event) => FocusScope.of(context).unfocus(),
                controller: context
                    .read<CommunityAdminProvider>()
                    .communityDescriptionController,
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
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: AppConstants.greyContainerBg,
                  filled: true,
                  hintText: "Write a description",
                  hintStyle: const TextStyle(
                    color: AppConstants.black40,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizeBoxH(20),
              Align(
                alignment: Alignment.centerRight,
                child: CommonButton(
                  onTap: () {
                    context.read<CommunityAdminProvider>().updateCommunityFn(
                        context: context, communityId: widget.communityId);
                  },
                  text: "Submit",
                  width: Responsive.width * 50,
                  height: Responsive.height * 7,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

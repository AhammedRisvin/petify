import 'package:clan_of_pets/app/module/Dating/model/get_post_details.dart';
import 'package:clan_of_pets/app/module/Dating/view%20model/dating_provider.dart';
import 'package:clan_of_pets/app/utils/app_images.dart';
import 'package:clan_of_pets/app/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../helpers/common_widget.dart';
import '../../../helpers/size_box.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_router.dart';
import '../../../utils/extensions.dart';

class DatingDetailsScreen extends StatefulWidget {
  const DatingDetailsScreen({
    super.key,
    required this.link,
  });

  final String link;

  @override
  State<DatingDetailsScreen> createState() => _DatingDetailsScreenState();
}

class _DatingDetailsScreenState extends State<DatingDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<DatingProvider>().getDatePostDetailsFn(link: widget.link);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.white,
      body: Consumer<DatingProvider>(
        builder: (context, provider, child) {
          return provider.getDatePostDetailsStatus ==
                  GetDatePostDetailsStatus.loading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: AppConstants.appPrimaryColor,
                  ),
                )
              : provider.getDatePostDetailsStatus ==
                      GetDatePostDetailsStatus.loaded
                  ? SizedBox(
                      height: Responsive.height * 100,
                      width: Responsive.width * 100,
                      child: Stack(
                        children: [
                          Container(
                            height: Responsive.height * 45,
                            width: Responsive.width * 100,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              image: DecorationImage(
                                onError: (exception, stackTrace) =>
                                    const SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: Icon(
                                    Icons.image_not_supported,
                                    size: 40,
                                    color: Colors.grey,
                                  ),
                                ),
                                fit: BoxFit.cover,
                                image: NetworkImage(provider
                                        .getDatePostDetailsModel
                                        .message
                                        ?.image ??
                                    'https://assets.petco.com/petco/image/upload/c_pad,dpr_1.0,f_auto,q_auto,h_636,w_636/c_pad,h_636,w_636/1438271-center-1'),
                              ),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 40.0, left: 15),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: Center(
                                      child: IconButton(
                                        onPressed: () {
                                          Routes.back(context: context);
                                        },
                                        style: ButtonStyle(
                                          fixedSize:
                                              const WidgetStatePropertyAll(
                                                  Size(4, 4)),
                                          backgroundColor:
                                              WidgetStatePropertyAll(
                                            AppConstants.white.withOpacity(.5),
                                          ),
                                        ),
                                        icon: Icon(
                                          Icons.arrow_back_ios_new,
                                          size: 15,
                                          color: AppConstants.black
                                              .withOpacity(.9),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizeBoxV(10),
                                  const Padding(
                                    padding: EdgeInsets.only(top: 4.0),
                                    child: commonTextWidget(
                                      text: "Pet Dating",
                                      color: AppConstants.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              height: Responsive.height * 70,
                              width: Responsive.width * 100,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadiusDirectional.only(
                                  topEnd: Radius.circular(40),
                                  topStart: Radius.circular(40),
                                ),
                              ),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        commonTextWidget(
                                          color: AppConstants.black,
                                          text: provider.getDatePostDetailsModel
                                                  .message?.name ??
                                              "",
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        CommonInkwell(
                                          onTap: () {
                                            provider.shareLink(
                                              context,
                                              provider.getDatePostDetailsModel
                                                      .message?.shareLink ??
                                                  "",
                                            );
                                          },
                                          child: Container(
                                            height: 30,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              color:
                                                  AppConstants.appPrimaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  "assets/images/dateShareIcon.png",
                                                  height: 12,
                                                ),
                                                const SizeBoxV(5),
                                                const commonTextWidget(
                                                  color: AppConstants.white,
                                                  text: "Share",
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.location_on_sharp,
                                          color: AppConstants.appPrimaryColor,
                                          size: 18,
                                        ),
                                        const SizeBoxV(10),
                                        commonTextWidget(
                                          color: AppConstants.black40,
                                          text: provider.getDatePostDetailsModel
                                                  .message?.location ??
                                              "Address",
                                          fontSize: 12,
                                        ),
                                      ],
                                    ),
                                    const SizeBoxH(10),
                                    OwnerWidget(
                                      ownerData: provider
                                          .getDatePostDetailsModel
                                          .message
                                          ?.uploadedBy,
                                      provider: provider,
                                    ),
                                    const SizeBoxH(20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        DatingDetailsSmallContainerWidget(
                                          image:
                                              "assets/images/petDatingBg1.png",
                                          text: provider.getDatePostDetailsModel
                                                  .message?.species ??
                                              "Species",
                                          subText: "Species",
                                        ),
                                        DatingDetailsSmallContainerWidget(
                                          image:
                                              "assets/images/petDatingBg2.png",
                                          text: provider.getDatePostDetailsModel
                                                  .message?.breed ??
                                              "name",
                                          subText: "age",
                                        ),
                                        const DatingDetailsSmallContainerWidget(
                                          image:
                                              "assets/images/petDatingBg3.png",
                                          text: "name",
                                          subText: "Breed",
                                        ),
                                        DatingDetailsSmallContainerWidget(
                                          image:
                                              "assets/images/petDatingBg4.png",
                                          text: provider.getDatePostDetailsModel
                                                  .message?.gender ??
                                              "Female",
                                          subText: "Gender",
                                        ),
                                      ],
                                    ),
                                    const SizeBoxH(20),
                                    const commonTextWidget(
                                      color: AppConstants.black,
                                      text: "Details",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    const SizeBoxH(20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const commonTextWidget(
                                              color: AppConstants.black,
                                              text: "Birth Date",
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            commonTextWidget(
                                              color: AppConstants.subTextGrey,
                                              text: provider.formatDate2(provider
                                                      .getDatePostDetailsModel
                                                      .message
                                                      ?.birthdate ??
                                                  DateTime.now()),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const commonTextWidget(
                                              color: AppConstants.black,
                                              text: "Weight",
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            commonTextWidget(
                                              color: AppConstants.subTextGrey,
                                              text:
                                                  "${provider.getDatePostDetailsModel.message?.weight ?? "0"} kg",
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const commonTextWidget(
                                              color: AppConstants.black,
                                              text: "Height",
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            commonTextWidget(
                                              color: AppConstants.subTextGrey,
                                              text:
                                                  "${provider.getDatePostDetailsModel.message?.height ?? "subText"} cm",
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    const SizeBoxH(20),
                                    Container(
                                      width: Responsive.width * 100,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: AppConstants.black10,
                                          width: 1.5,
                                        ),
                                      ),
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: commonTextWidget(
                                          color: AppConstants.black,
                                          text:
                                              "Looking for : ${provider.getDatePostDetailsModel.message?.lookingFor ?? ""}",
                                          fontSize: 14,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  : const Center(
                      child: Text("Something went wrong"),
                    );
        },
      ),
    );
  }
}

class DatingDetailsSmallContainerWidget extends StatelessWidget {
  const DatingDetailsSmallContainerWidget({
    super.key,
    required this.image,
    required this.text,
    required this.subText,
    this.isFromAdopt = false,
  });

  final String image;
  final String text;
  final String subText;
  final bool isFromAdopt;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Responsive.height * 10,
      width: Responsive.height * 10,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: isFromAdopt ? Border.all(color: AppConstants.black10) : null,
        image: isFromAdopt
            ? null
            : DecorationImage(
                image: AssetImage(
                  image,
                ),
              ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          commonTextWidget(
            color: isFromAdopt
                ? AppConstants.black40
                : AppConstants.black.withOpacity(0.6),
            text: text,
            fontSize: isFromAdopt ? 11 : 14,
            fontWeight: FontWeight.w600,
          ),
          commonTextWidget(
            color: isFromAdopt ? AppConstants.black : AppConstants.black40,
            text: subText,
            fontSize: isFromAdopt ? 14 : 10,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }
}

class OwnerWidget extends StatelessWidget {
  const OwnerWidget({
    super.key,
    this.ownerData,
    required this.provider,
  });

  final UploadedBy? ownerData;
  final DatingProvider provider;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Responsive.width * 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color(0xffFFDEB6),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 10,
      ),
      child: Row(
        children: [
          commonNetworkImage(
            url: ownerData?.petShopUserDetails?.profile ?? "",
            height: Responsive.height * 7,
            width: Responsive.width * 14,
            radius: 100,
          ),
          const SizeBoxV(10),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    commonTextWidget(
                      color: AppConstants.black,
                      text: ownerData?.name ?? "name",
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                    const commonTextWidget(
                      color: AppConstants.black40,
                      text: "Pet Owner",
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
                CommonInkwell(
                  onTap: () {
                    provider.getAccessChatFn(
                      context: context,
                      id: ownerData?.id ?? '',
                      userName: ownerData?.name ?? '',
                    );
                  },
                  child: Container(
                    height: 30,
                    width: 80,
                    decoration: BoxDecoration(
                      color: AppConstants.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          AppImages.dateChatIcon,
                          height: 12,
                        ),
                        const SizeBoxV(5),
                        const commonTextWidget(
                          color: AppConstants.appPrimaryColor,
                          text: "Chat",
                          fontSize: 12,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

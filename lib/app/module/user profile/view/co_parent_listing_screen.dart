import 'dart:async';

import 'package:clan_of_pets/app/helpers/size_box.dart';
import 'package:clan_of_pets/app/module/user%20profile/view%20model/profile_provider.dart';
import 'package:clan_of_pets/app/module/widget/empty_screen.dart';
import 'package:clan_of_pets/app/utils/app_images.dart';
import 'package:clan_of_pets/app/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/server_client_services.dart';
import '../../../core/urls.dart';
import '../../../helpers/common_widget.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_router.dart';
import '../model/co_parent_model.dart';
import 'temeperory_access_pet_listing_screen.dart';

class CoParentListingScreen extends StatefulWidget {
  const CoParentListingScreen({super.key, required this.isFromCoParent});

  final bool isFromCoParent;

  @override
  State<CoParentListingScreen> createState() => _CoParentListingScreenState();
}

class _CoParentListingScreenState extends State<CoParentListingScreen> {
  @override
  void initState() {
    super.initState();
    getUserProfileDetailsFn();
  }

  StreamController<GetCoParentModel> streamController = StreamController();

  Future getUserProfileDetailsFn() async {
    try {
      List response = await ServerClient.get(
        widget.isFromCoParent ? Urls.getCoParentUrl : Urls.getTempAccessUrl,
      );
      if (response.first >= 200 && response.first < 300) {
        final coparentModel = GetCoParentModel.fromJson(response.last);
        streamController.add(coparentModel);
      } else {
        streamController.add(GetCoParentModel());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.white,
      appBar: AppBar(
        backgroundColor: AppConstants.white,
        title: commonTextWidget(
          text:
              widget.isFromCoParent ? "Co-Parent Listing" : "Temporary Access",
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
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: StreamBuilder<GetCoParentModel>(
            stream: streamController.stream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return snapshot.data?.coParents?.isEmpty == true
                  ? EmptyScreenWidget(
                      text: widget.isFromCoParent
                          ? "No Co-Parent Found"
                          : "No Temporary Access Found",
                      image: AppImages.noCommunityImage,
                      height: Responsive.height * 80,
                    )
                  : ListView.separated(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        final coParentData = snapshot.data?.coParents?[index];
                        return CommonInkwell(
                          onTap: () {
                            if (!widget.isFromCoParent) {
                              Routes.push(
                                context: context,
                                screen: TemporaryAccessPetListingScreen(
                                  id: snapshot.data?.coParents?[index].id ?? '',
                                ),
                                exit: () {},
                              );
                            }
                          },
                          child: Container(
                            width: Responsive.width * 100,
                            decoration: BoxDecoration(
                              color: AppConstants.transparent,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: AppConstants.greyContainerBg,
                                width: 2,
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Row(
                              children: [
                                commonNetworkImage(
                                  url: coParentData?.petShopUserDetails
                                                  ?.profile ==
                                              null ||
                                          coParentData?.petShopUserDetails
                                                  ?.profile?.isEmpty ==
                                              true
                                      ? "https://st2.depositphotos.com/1146092/8147/i/450/depositphotos_81476092-stock-photo-owner-petting-dog.jpg"
                                      : coParentData
                                              ?.petShopUserDetails?.profile ??
                                          "",
                                  height: 70,
                                  width: 70,
                                  radius: 15,
                                ),
                                const SizeBoxV(20),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      commonTextWidget(
                                        text: coParentData?.name ?? "",
                                        color: AppConstants.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      const SizeBoxH(2),
                                      commonTextWidget(
                                        text: coParentData?.phoneNumber ?? "",
                                        color: AppConstants.black40,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ],
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    context
                                        .read<EditController>()
                                        .removeCoParentFun(
                                            context: context,
                                            id: snapshot.data?.coParents?[index]
                                                    .id ??
                                                '',
                                            isFromCoParent:
                                                widget.isFromCoParent,
                                            onTap: () {
                                              getUserProfileDetailsFn();
                                            });
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                        const WidgetStatePropertyAll(
                                      AppConstants.appPrimaryColor,
                                    ),
                                    padding: const WidgetStatePropertyAll(
                                      EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 0,
                                      ),
                                    ),
                                    shape: WidgetStatePropertyAll(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                  child: const commonTextWidget(
                                    color: AppConstants.white,
                                    text: "Remove",
                                    fontSize: 14,
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const SizeBoxH(15),
                      itemCount: snapshot.data?.coParents?.length ?? 0,
                    );
            }),
      ),
    );
  }
}

import 'package:clan_of_pets/app/module/widget/empty_screen.dart';
import 'package:clan_of_pets/app/utils/app_images.dart';
import 'package:clan_of_pets/app/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../helpers/common_widget.dart';
import '../../../helpers/size_box.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_router.dart';
import '../../../utils/extensions.dart';
import '../../Dating/view/dating_details_screen.dart';
import '../view_model/adopt_provider.dart';

class AdoptPetDetailedViewScreen extends StatefulWidget {
  const AdoptPetDetailedViewScreen(
      {super.key, required this.petId, required this.image});

  final String petId;
  final String image;

  @override
  State<AdoptPetDetailedViewScreen> createState() =>
      _AdoptPetDetailedViewScreenState();
}

AdoptProvider? provider;

class _AdoptPetDetailedViewScreenState
    extends State<AdoptPetDetailedViewScreen> {
  @override
  void initState() {
    super.initState();
    provider = Provider.of<AdoptProvider>(context, listen: false);
    provider?.getAdoptPetDetailsFn(
      petId: widget.petId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AdoptProvider>(
        builder: (context, provider, child) => provider.detailsStatus ==
                GetAdoptPetDetailsStatus.loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : provider.detailsStatus == GetAdoptPetDetailsStatus.loaded
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
                              image: NetworkImage(widget.image),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 40.0, left: 15),
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
                                        fixedSize: const WidgetStatePropertyAll(
                                            Size(4, 4)),
                                        backgroundColor: WidgetStatePropertyAll(
                                          AppConstants.white.withOpacity(.5),
                                        ),
                                      ),
                                      icon: Icon(
                                        Icons.arrow_back_ios_new,
                                        size: 15,
                                        color:
                                            AppConstants.black.withOpacity(.9),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizeBoxV(10),
                                const Padding(
                                  padding: EdgeInsets.only(top: 4.0),
                                  child: commonTextWidget(
                                    text: "Adopt a Pet",
                                    color: AppConstants.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
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
                            height: Responsive.height * 60,
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
                                    children: [
                                      commonTextWidget(
                                        color: AppConstants.black,
                                        text: provider.detailsModel.feedDetails
                                                ?.petName ??
                                            "",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      commonTextWidget(
                                        color: AppConstants.black40,
                                        text:
                                            "  (${provider.detailsModel.feedDetails?.breed ?? ""})",
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      const Spacer(),
                                      Row(
                                        children: [
                                          commonTextWidget(
                                            color: AppConstants.black40,
                                            text: provider.detailsModel
                                                    .feedDetails?.location ??
                                                "",
                                            fontSize: 12,
                                          ),
                                          const SizeBoxV(10),
                                          const Icon(
                                            Icons.location_on_sharp,
                                            color: AppConstants.appPrimaryColor,
                                            size: 18,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizeBoxH(10),
                                  commonTextWidget(
                                    color: AppConstants.black,
                                    text:
                                        "${provider.detailsModel.feedDetails?.prize ?? ""} ${provider.detailsModel.currencyCode ?? ""}",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  const SizeBoxH(10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      DatingDetailsSmallContainerWidget(
                                        image: "",
                                        text: "Gender",
                                        subText: provider.detailsModel
                                                .feedDetails?.gender ??
                                            "",
                                        isFromAdopt: true,
                                      ),
                                      DatingDetailsSmallContainerWidget(
                                        image: "",
                                        text: "Age",
                                        subText: provider.getPetAge(
                                          provider.detailsModel.feedDetails
                                                  ?.birthday ??
                                              DateTime.now(),
                                        ),
                                        isFromAdopt: true,
                                      ),
                                      DatingDetailsSmallContainerWidget(
                                        image: "",
                                        text: "Weight",
                                        subText:
                                            "${provider.detailsModel.feedDetails?.weight ?? ""} Kg",
                                        isFromAdopt: true,
                                      ),
                                      DatingDetailsSmallContainerWidget(
                                        image: "",
                                        text: "Height",
                                        subText:
                                            "${provider.detailsModel.feedDetails?.height ?? ""} Cm",
                                        isFromAdopt: true,
                                      ),
                                    ],
                                  ),
                                  const SizeBoxH(20),
                                  commonTextWidget(
                                    color: AppConstants.black,
                                    text:
                                        "About ${provider.detailsModel.feedDetails?.petName ?? ""}",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  const SizeBoxH(10),
                                  commonTextWidget(
                                    align: TextAlign.start,
                                    color: AppConstants.black40,
                                    text: provider.detailsModel.feedDetails
                                            ?.description ??
                                        "",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  const SizeBoxH(20),
                                  Row(
                                    children: [
                                      Container(
                                        height: 40,
                                        width: 40,
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                        decoration: BoxDecoration(
                                          color: AppConstants.appPrimaryColor
                                              .withOpacity(0.4),
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                        child: const Icon(
                                          Icons.phone,
                                          color: AppConstants.appPrimaryColor,
                                          size: 20,
                                        ),
                                      ),
                                      commonTextWidget(
                                        align: TextAlign.start,
                                        color: AppConstants.black,
                                        text: provider.detailsModel.feedDetails
                                                ?.phone ??
                                            "",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ],
                                  ),
                                  const SizeBoxH(20),
                                  CommonButton(
                                    onTap: () {
                                      if (provider.detailsModel.intrested ==
                                          true) {
                                        toast(
                                          context,
                                          title: "Already shown interest",
                                          backgroundColor: Colors.red,
                                        );
                                      } else {
                                        provider.showInterestFn(
                                            ctx: context,
                                            petId: provider.detailsModel
                                                    .feedDetails?.id ??
                                                "");
                                      }
                                    },
                                    text:
                                        provider.detailsModel.intrested == true
                                            ? "Intrested"
                                            : "Show Intrest",
                                    size: 14,
                                    width: Responsive.width * 100,
                                    height: Responsive.height * 6,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                : EmptyScreenWidget(
                    text: "Server is Busy,please try again later",
                    image: AppImages.noBlogImage,
                    height: Responsive.height * 60,
                  ),
      ),
    );
  }
}

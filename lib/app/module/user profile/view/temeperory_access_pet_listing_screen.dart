// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:clan_of_pets/app/helpers/size_box.dart';
import 'package:clan_of_pets/app/utils/app_images.dart';
import 'package:clan_of_pets/app/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/server_client_services.dart';
import '../../../core/urls.dart';
import '../../../helpers/common_widget.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_router.dart';
import '../../home/view model/home_provider.dart';
import '../../widget/confirmation_widget.dart';
import '../model/temmp_pets_model.dart';
import '../view model/profile_provider.dart';

class TemporaryAccessPetListingScreen extends StatefulWidget {
  const TemporaryAccessPetListingScreen({
    super.key,
    required this.id,
  });
  final String id;

  @override
  State<TemporaryAccessPetListingScreen> createState() =>
      _TemporaryAccessPetListingScreenState();
}

class _TemporaryAccessPetListingScreenState
    extends State<TemporaryAccessPetListingScreen> {
  @override
  initState() {
    super.initState();
    getTempParentPetFn(
      tempParentId: widget.id,
    );
  }

  StreamController<GetTempParentPetModel> streamController = StreamController();

  Future getTempParentPetFn({required String tempParentId}) async {
    try {
      List response = await ServerClient.get(
        Urls.getTempParentPet + tempParentId,
      );
      if (response.first >= 200 && response.first < 300) {
        final getCoParentModel = GetTempParentPetModel.fromJson(response.last);
        streamController.add(getCoParentModel);
      } else {
        streamController.add(GetTempParentPetModel());
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
        title: const commonTextWidget(
          text: "Temporary Access",
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
        actions: [
          ((context.read<HomeProvider>().getPetModel.pets?.length ?? 0) > 1)
              ? ElevatedButton(
                  onPressed: () {
                    context
                        .read<EditController>()
                        .getPetsWithoutTempParentFun();
                    showDialog(
                      context: context,
                      builder: (context) {
                        return SelectPetAlertDialogWidget(
                          tempParrentId: widget.id,
                          function: () {
                            getTempParentPetFn(tempParentId: widget.id);
                          },
                        );
                      },
                    );
                  },
                  style: ButtonStyle(
                    minimumSize: WidgetStateProperty.all(
                      const Size(40, 35),
                    ),
                    backgroundColor: const WidgetStatePropertyAll(
                      Colors.white,
                    ),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                        side: const BorderSide(
                          color: AppConstants.appPrimaryColor,
                        ),
                      ),
                    ),
                  ),
                  child: const commonTextWidget(
                    color: AppConstants.appPrimaryColor,
                    text: "Add pet",
                    fontSize: 14,
                  ),
                )
              : const SizedBox.shrink(),
          const SizeBoxV(10)
        ],
      ),
      body: StreamBuilder<GetTempParentPetModel>(
          stream: streamController.stream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Container(
              padding: const EdgeInsets.all(16),
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.9,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: snapshot.data?.pets?.length,
                itemBuilder: (context, index) {
                  final pet = snapshot.data?.pets?[index];
                  return Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: Responsive.width * 2,
                      vertical: Responsive.height * 0.5,
                    ),
                    decoration: BoxDecoration(
                      color: AppConstants.transparent,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: AppConstants.greyContainerBg,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        commonNetworkImage(
                          url: pet?.image ??
                              "https://crownandpaw.com/cdn/shop/files/Floral_Pet_Portrait_500x.jpg?v=1694166173",
                          height: 130,
                          width: Responsive.width * 90,
                          radius: 15,
                        ),
                        const SizeBoxH(10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                commonTextWidget(
                                  text: pet?.name ?? "Jessica alba",
                                  color: AppConstants.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                                commonTextWidget(
                                  text: pet?.breed ?? "",
                                  color: AppConstants.black40,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: -0.5,
                                ),
                              ],
                            ),
                            CommonInkwell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return ConfirmationWidget(
                                      title: "REMOVE",
                                      message:
                                          "Are you sure you want to remove?",
                                      onTap: () {
                                        context
                                            .read<EditController>()
                                            .updateTempParentAccessForPetFn(
                                              function: () {
                                                getTempParentPetFn(
                                                    tempParentId: widget.id);
                                              },
                                              context: context,
                                              petId: pet?.id ?? '',
                                              tempParentId: widget.id,
                                            );
                                      },
                                      image: AppImages.deletePng,
                                    );
                                  },
                                );
                              },
                              child: Container(
                                height: 25,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: AppConstants.appPrimaryColor,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          }),
    );
  }
}

class SelectPetAlertDialogWidget extends StatelessWidget {
  final String tempParrentId;
  final void Function() function;
  SelectPetAlertDialogWidget({
    super.key,
    required this.tempParrentId,
    required this.function,
  });

  CarouselController carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.all(0),
      contentPadding: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      backgroundColor: Colors.white,
      content: SizedBox(
        width: Responsive.width * 80,
        height: Responsive.height * 35,
        child: Consumer<EditController>(
          builder: (context, provider, child) => Column(
            // mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: Responsive.height * 28,
                child: provider.petWithoutTempParentModel
                            .petsWithoutTemporaryParents?.isEmpty ??
                        true
                    ? const Center(child: Text("No Pets"))
                    : ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          var pet = provider.petWithoutTempParentModel
                              .petsWithoutTemporaryParents?[index];
                          return CommonInkwell(
                            onTap: () {
                              provider.selectPetForAddPetInTempParentFun(
                                  pet?.id ?? '');
                            },
                            child: Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: provider
                                            .selectPetIdForAddPetInTempUser
                                            .contains(pet?.id ?? '')
                                        ? Colors.green
                                        : Colors.transparent),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Container(
                                width: Responsive.width * 70,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                  border: provider.isSelected == true
                                      ? Border.all(
                                          color: Colors.green,
                                          width: 2,
                                        )
                                      : Border.all(
                                          color: Colors.transparent,
                                          width: 2,
                                        ),
                                ),
                                child: Column(
                                  children: [
                                    commonNetworkImage(
                                      url: pet?.image ??
                                          "https://media.gettyimages.com/id/151350785/photo/dog-and-cat.jpg?s=612x612&w=0&k=20&c=3mD8uquUJrO2E9BlmLQid-gdjE5yZFZNInZuZb3RrQs=",
                                      height: Responsive.height * 20,
                                      width: Responsive.width * 100,
                                      isBottomCurved: false,
                                      isTopCurved: true,
                                    ),
                                    const SizeBoxH(5),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          commonTextWidget(
                                            color: AppConstants.black,
                                            text: pet?.name ?? '',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                          ),
                                          commonTextWidget(
                                            color: AppConstants.subTextGrey,
                                            text: formatDateDifference(
                                                pet?.birthDate ??
                                                    DateTime.now()),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0,
                                        vertical: 4,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          commonTextWidget(
                                            color: AppConstants.subTextGrey,
                                            text: pet?.breed ?? '',
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          commonTextWidget(
                                            color: AppConstants.appPrimaryColor,
                                            text: pet?.sex ?? '',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) =>
                            const SizeBoxV(10),
                        itemCount: provider.petWithoutTempParentModel
                                .petsWithoutTemporaryParents?.length ??
                            0,
                      ),
              ),
              const Spacer(),
              CommonButton(
                onTap: () {
                  provider.addPetInTempParentFun(
                      context: context,
                      temporaryParentId: tempParrentId,
                      function: function);
                },
                text: "Select Pet",
                width: Responsive.width * 100,
                height: Responsive.height * 5,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String formatDateDifference(DateTime initialDate) {
    DateTime currentDate = DateTime.now();

    int years = currentDate.year - initialDate.year;
    int months = currentDate.month - initialDate.month;

    // Adjust the years and months if necessary
    if (months < 0) {
      years -= 1;
      months += 12;
    }

    String yearText = years == 1 ? '1 year' : '$years years';
    String monthText = months == 1 ? '1 month' : '$months months';

    return '$yearText and $monthText';
  }
}

import 'package:clan_of_pets/app/module/pet%20profile/model/get_growth_history_model.dart';
import 'package:clan_of_pets/app/module/pet%20profile/view%20model/pet_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../helpers/common_widget.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_images.dart';
import '../../../utils/app_router.dart';
import '../../../utils/extensions.dart';
import '../../widget/confirmation_widget.dart';
import '../view/growth tracker/new_growth_entry_screen.dart';

class GrowthTrackHistoryWidget extends StatelessWidget {
  const GrowthTrackHistoryWidget({
    super.key,
    this.historyData,
    required this.petId,
    required this.successCallback,
  });

  final AllGrowthDatum? historyData;
  final String petId;
  final Null Function() successCallback;

  @override
  Widget build(BuildContext context) {
    final isFromHeight = historyData?.type == "Height";
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: AppConstants.white,
        border: Border.all(
          color: AppConstants.black10,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppConstants.appPrimaryColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: const EdgeInsets.only(right: 10),
                padding: const EdgeInsets.only(
                  top: 9,
                  right: 16,
                  left: 16,
                  bottom: 9,
                ),
                child: Center(
                  child: Image.asset(
                    isFromHeight
                        ? AppImages.growthHistoryHeightIcon
                        : AppImages.growthHistoryWeightIcon,
                    height: Responsive.height * 3,
                  ),
                ),
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  commonTextWidget(
                    align: TextAlign.start,
                    text: historyData?.type ?? "",
                    color: AppConstants.black,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                  commonTextWidget(
                    text: context.read<PetProfileProvider>().formatGrowthDate(
                          historyData?.date ?? DateTime.now(),
                        ),
                    color: AppConstants.black60,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    letterSpacing: -0.2,
                  ),
                ],
              ))
            ],
          ),
          commonTextWidget(
            align: TextAlign.start,
            text: "${historyData?.value} ${historyData?.unit?.toLowerCase()}",
            color: AppConstants.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonButton(
                onTap: () {
                  Routes.push(
                    context: context,
                    screen: NewGrowthEntryScreen(
                      isEdit: true,
                      isFromHeight: isFromHeight,
                      value: historyData?.value ?? 0,
                      date: historyData?.date ?? DateTime.now(),
                      id: historyData?.id ?? '',
                      petId: petId,
                      successCallback: successCallback,
                    ),
                    exit: () {},
                  );
                },
                text: "Edit",
                width: Responsive.width * 24,
                height: Responsive.height * 3,
                size: 12,
                radius: 5,
              ),
              CommonInkwell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return ConfirmationWidget(
                        title: "DELETE",
                        image: AppImages.deletePng,
                        message: "Are you sure you want to delete?",
                        onTap: () {
                          provider.deleteGrowthFn(
                            growthId: historyData?.id ?? '',
                            type: historyData?.type ?? '',
                            petId: petId,
                            context: context,
                            successCallback: successCallback,
                          );
                        },
                      );
                    },
                  );
                },
                child: Container(
                  width: Responsive.width * 12,
                  height: Responsive.height * 3,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xffEE5158),
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Image.asset(
                      AppImages.growthHistoryDeleteIcon,
                      height: Responsive.height * 1.8,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

import 'dart:developer';

import 'package:clan_of_pets/app/module/widget/empty_screen.dart';
import 'package:clan_of_pets/app/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../helpers/common_widget.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/app_router.dart';
import '../../../../utils/enums.dart';
import '../../view model/pet_profile_provider.dart';
import '../../widget/groeth_track_history_widget.dart';

class GrowthHistoryScreen extends StatefulWidget {
  const GrowthHistoryScreen({
    super.key,
    required this.petId,
    required this.successCallback,
  });

  final String petId;
  final Null Function() successCallback;

  @override
  State<GrowthHistoryScreen> createState() => _GrowthHistoryScreenState();
}

PetProfileProvider? petProfileProvider;

class _GrowthHistoryScreenState extends State<GrowthHistoryScreen> {
  @override
  void initState() {
    super.initState();
    petProfileProvider = context.read<PetProfileProvider>();
    log("petId: ${widget.petId}");
    petProfileProvider?.getGrowthHistoryFn(petId: widget.petId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: AppConstants.white,
        title: const commonTextWidget(
          text: "Growth Tracker History",
          color: AppConstants.black,
          fontSize: 16,
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
      body: Consumer<PetProfileProvider>(
        builder: (context, provider, child) => provider
                    .getGrowthDataHistoryModel.allGrowthData?.isEmpty ==
                true
            ? EmptyScreenWidget(
                text: "No Growth History Found!",
                image: AppImages.noAppoinmentImage,
                height: Responsive.height * 80,
              )
            : provider.getGrowthHistoryStatus == GetGrowthHistoryStatus.loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : provider.getGrowthHistoryStatus ==
                        GetGrowthHistoryStatus.loaded
                    ? GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: Responsive.height * 1,
                          mainAxisSpacing: Responsive.height * 1.5,
                          childAspectRatio: Responsive.height * 0.148,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                        itemCount: provider.getGrowthDataHistoryModel
                                .allGrowthData?.length ??
                            0,
                        itemBuilder: (context, index) {
                          final historyData = provider
                              .getGrowthDataHistoryModel.allGrowthData?[index];
                          return GrowthTrackHistoryWidget(
                            historyData: historyData,
                            petId: widget.petId,
                            successCallback: widget.successCallback,
                          );
                        },
                      )
                    : EmptyScreenWidget(
                        text: "Server is Busy, Please try again later!",
                        image: AppImages.noAppoinmentImage,
                        height: Responsive.height * 80,
                      ),
      ),
    );
  }
}

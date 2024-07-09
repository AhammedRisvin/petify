import 'package:clan_of_pets/app/helpers/size_box.dart';
import 'package:clan_of_pets/app/module/pet%20profile/model/get_dewarming_model.dart';
import 'package:clan_of_pets/app/module/pet%20profile/view%20model/pet_profile_provider.dart';
import 'package:clan_of_pets/app/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../helpers/common_widget.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_router.dart';
import '../../../../utils/extensions.dart';
import '../../../widget/empty_screen.dart';
import '../../model/get_vaccination_model.dart';
import '../dewarmingtracker/dewarming_tracker_page.dart';
import 'add_new_vaccination_screen.dart';

class VaccinationHomeScreen extends StatefulWidget {
  const VaccinationHomeScreen({super.key});

  @override
  State<VaccinationHomeScreen> createState() => _VaccinationHomeScreenState();
}

class _VaccinationHomeScreenState extends State<VaccinationHomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PetProfileProvider>().getVaccinationFn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.white,
      appBar: AppBar(
        backgroundColor: AppConstants.white,
        title: const commonTextWidget(
          text: "Vaccination",
          color: AppConstants.black,
          fontSize: 16,
          fontWeight: FontWeight.w500,
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
        padding: const EdgeInsets.all(15),
        height: Responsive.height * 100,
        width: Responsive.width * 100,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Selector<PetProfileProvider, int>(
                selector: (p0, p1) => p1.getVaccinationStatus,
                builder: (context, getVaccinationStatus, child) =>
                    getVaccinationStatus == 0
                        ? const ShimmerContainerWidget()
                        : Selector<PetProfileProvider,
                            GetVaccinationTrackerModel>(
                            selector: (p0, p1) => p1.getVaccinationTrackerModel,
                            builder: (context, value, child) => value
                                        .vaccinations?.isNotEmpty ??
                                    false
                                ? ListView.separated(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      var data = value.vaccinations?[
                                          (value.vaccinations?.length ?? 0) -
                                              1 -
                                              index];
                                      var color = context
                                              .read<PetProfileProvider>()
                                              .colors[
                                          index %
                                              context
                                                  .read<PetProfileProvider>()
                                                  .colors
                                                  .length];
                                      return VaccinationCardWidget(
                                        data: data,
                                        bgColor: color,
                                      );
                                    },
                                    itemCount: value.vaccinations?.length ?? 0,
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(height: 15),
                                  )
                                : EmptyScreenWidget(
                                    text: "No Vaccination Data Found",
                                    image: AppImages.noAppoinmentImage,
                                    height: Responsive.height * 70,
                                  ),
                          ),
              ),
              SizeBoxH(Responsive.height * 4),
              CommonButton(
                  bgColor: AppConstants.transparent,
                  isFullRoundedButton: true,
                  textColor: AppConstants.appPrimaryColor,
                  onTap: () {
                    Routes.push(
                      context: context,
                      screen: const AddNewVaccinationScreen(
                        title: "Add New Vaccination",
                      ),
                      exit: () {},
                    );
                  },
                  borderColor: AppConstants.appPrimaryColor,
                  text: "+ Create New",
                  width: Responsive.width * 100,
                  size: 16,
                  height: 40)
            ],
          ),
        ),
      ),
    );
  }
}

class ShimmerContainerWidget extends StatelessWidget {
  const ShimmerContainerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[200]!,
      highlightColor: Colors.grey[300]!,
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          var color = context
              .read<PetProfileProvider>()
              .colors[index % context.read<PetProfileProvider>().colors.length];
          return VaccinationCardWidget(
            data: DewarmingData(),
            bgColor: color,
          );
        },
        itemCount: 3,
        separatorBuilder: (context, index) => const SizedBox(height: 15),
      ),
    );
  }
}

class VacinationDetailsContentWidget extends StatelessWidget {
  final String? textH1;
  final String? textH2;
  final String? valueText1;
  final String? valueText2;

  const VacinationDetailsContentWidget({
    super.key,
    this.valueText2,
    this.textH1,
    this.textH2,
    this.valueText1,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              commonTextWidget(
                align: TextAlign.start,
                color: AppConstants.black,
                text: textH1 ?? '',
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              commonTextWidget(
                align: TextAlign.start,
                color: AppConstants.black,
                text: textH2 ?? '',
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
          SizeBoxH(Responsive.height * .5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              commonTextWidget(
                align: TextAlign.start,
                color: AppConstants.black.withOpacity(.8),
                text: valueText1 ?? '',
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              commonTextWidget(
                align: TextAlign.start,
                color: AppConstants.black.withOpacity(.8),
                text: valueText2 ?? '',
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class VaccinationCategoryWidget extends StatelessWidget {
  const VaccinationCategoryWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Selector<PetProfileProvider, int>(
      selector: (p0, p1) => p1.selectedVaccinationButton,
      builder: (context, value, child) => Row(
        children: [
          CommonButton(
            onTap: () {
              context.read<PetProfileProvider>().selecteVaccinationButtonFun(1);
            },
            text: "All",
            width: 85,
            textColor: value == 1
                ? AppConstants.greyContainerBg
                : AppConstants.black40,
            size: 12,
            bgColor: value == 1
                ? AppConstants.appPrimaryColor
                : AppConstants.greyContainerBg,
            height: 30,
            isFullRoundedButton: true,
          ),
          const SizeBoxV(10),
          CommonButton(
            onTap: () {
              context.read<PetProfileProvider>().selecteVaccinationButtonFun(2);
            },
            text: "Upload",
            width: 85,
            bgColor: value == 2
                ? AppConstants.appPrimaryColor
                : AppConstants.greyContainerBg,
            height: 30,
            size: 12,
            textColor: value == 2
                ? AppConstants.greyContainerBg
                : AppConstants.black40,
            isFullRoundedButton: true,
          ),
          const SizeBoxV(10),
          CommonButton(
            onTap: () {
              context.read<PetProfileProvider>().selecteVaccinationButtonFun(3);
            },
            text: "Issued",
            size: 12,
            textColor: value == 3
                ? AppConstants.greyContainerBg
                : AppConstants.black40,
            width: 85,
            bgColor: value == 3
                ? AppConstants.appPrimaryColor
                : AppConstants.greyContainerBg,
            height: 30,
            isFullRoundedButton: true,
          ),
        ],
      ),
    );
  }
}

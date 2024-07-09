import 'package:clan_of_pets/app/module/pet%20profile/model/get_dewarming_model.dart';
import 'package:clan_of_pets/app/module/pet%20profile/view/dewarmingtracker/add_warming_track_page.dart';
import 'package:clan_of_pets/app/module/pet%20profile/view/vaccination/add_new_vaccination_screen.dart';
import 'package:clan_of_pets/app/module/widget/confirmation_widget.dart';
import 'package:clan_of_pets/app/module/widget/empty_screen.dart';
import 'package:clan_of_pets/app/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../helpers/common_widget.dart';
import '../../../../helpers/size_box.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_router.dart';
import '../../../../utils/extensions.dart';
import '../../view model/pet_profile_provider.dart';
import '../vaccination/vaccination_screen.dart';

class DewarmingTrackerScreen extends StatefulWidget {
  const DewarmingTrackerScreen({super.key});

  @override
  State<DewarmingTrackerScreen> createState() => _DewarmingTrackerScreenState();
}

class _DewarmingTrackerScreenState extends State<DewarmingTrackerScreen> {
  @override
  void initState() {
    getDewarmingTrackerScrollController.addListener(_onScroll);
    context.read<PetProfileProvider>().getDewarmingFn(pageNum: 1);

    super.initState();
  }

  @override
  void dispose() {
    getDewarmingTrackerScrollController.dispose();

    super.dispose();
  }

  final getDewarmingTrackerScrollController = ScrollController();

  void _onScroll() {
    if (getDewarmingTrackerScrollController.position.pixels >=
        getDewarmingTrackerScrollController.position.maxScrollExtent) {
      context.read<PetProfileProvider>().getDewarmingFn();
    }
  }

  final double loadMoreThreshold = 300.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.white,
      appBar: AppBar(
        backgroundColor: AppConstants.white,
        title: const commonTextWidget(
          text: "Deworming Tracker ",
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
        actions: [
          CommonInkwell(
            onTap: () {
              Routes.push(
                context: context,
                screen: const AddDwwarmingTrackerScreen(),
                exit: () {},
              );
            },
            child: Container(
              margin: const EdgeInsets.only(right: 15),
              height: 33,
              width: 33,
              decoration: BoxDecoration(
                  border: Border.all(color: AppConstants.appPrimaryColor),
                  borderRadius: BorderRadius.circular(30)),
              child: const Center(
                child: Icon(
                  Icons.add,
                  color: AppConstants.appPrimaryColor,
                  size: 18,
                ),
              ),
            ),
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        height: Responsive.height * 100,
        width: Responsive.width * 100,
        child: Consumer<PetProfileProvider>(
            builder: (context, value, child) => value
                        .getDewarmingTrackerModel.dewarmingDatas?.isNotEmpty ??
                    false
                ? ListView.separated(
                    controller: getDewarmingTrackerScrollController,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      if (index <
                          value.getDewarmingTrackerModel.dewarmingDatas!
                              .length) {
                        var data = value
                            .getDewarmingTrackerModel.dewarmingDatas?[index];
                        var color = context.read<PetProfileProvider>().colors[
                            index %
                                context
                                    .read<PetProfileProvider>()
                                    .colors
                                    .length];
                        return VaccinationCardWidget(
                          data: data,
                          isVaccination: false,
                          bgColor: color,
                        );
                      } else if (value.getDewarmingStatus == 0 &&
                          index ==
                              value.getDewarmingTrackerModel.dewarmingDatas!
                                  .length &&
                          value.isDewarmingListEnded == false) {
                        return SizedBox(
                          height: Responsive.height * 23,
                          width: Responsive.width * 100,
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: Colors.amber,
                            ),
                          ),
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                    itemCount:
                        value.getDewarmingTrackerModel.dewarmingDatas!.length +
                            (value.getDewarmingStatus == 0 ? 1 : 0),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 15),
                  )
                : EmptyScreenWidget(
                    text: "No tracking data found",
                    image: AppImages.noCommunityImage,
                    height: Responsive.height * 60,
                  )),
      ),
    );
  }
}

class VaccinationCardWidget extends StatelessWidget {
  final Color? bgColor;
  final DewarmingData? data;
  final bool isVaccination;
  const VaccinationCardWidget(
      {super.key, this.bgColor, this.data, this.isVaccination = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Responsive.height * 23,
      width: Responsive.width * 100,
      padding: const EdgeInsets.only(top: 10, bottom: 10, right: 10, left: 10),
      decoration: BoxDecoration(
          color: bgColor,
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: Responsive.width * 50,
                child: commonTextWidget(
                  overFlow: TextOverflow.ellipsis,
                  align: TextAlign.start,
                  color: AppConstants.white,
                  text: data?.vaccineName ?? "Vaccine Name",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                width: Responsive.width * 34,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonInkwell(
                      onTap: () {
                        if (isVaccination == true) {
                          Routes.push(
                            context: context,
                            screen: AddNewVaccinationScreen(
                              data: data,
                              isVaccinationUpdated: true,
                              title: "Edit Vaccination",
                            ),
                            exit: () {},
                          );
                        } else {
                          Routes.push(
                            context: context,
                            screen: AddDwwarmingTrackerScreen(
                              data: data,
                              isDewarmingUpdated: true,
                            ),
                            exit: () {},
                          );
                        }
                      },
                      child: Container(
                        height: 26,
                        width: 26,
                        decoration: BoxDecoration(
                          color: AppConstants.white.withOpacity(.12),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(100),
                          ),
                        ),
                        child: const Icon(
                          Icons.edit,
                          color: AppConstants.white,
                          size: 10,
                        ),
                      ),
                    ),
                    CommonInkwell(
                      onTap: () {
                        if (isVaccination == true) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return ConfirmationWidget(
                                title: "DELETE",
                                image: AppImages.deletePng,
                                message: "Are you sure you want to delete?",
                                onTap: () {
                                  context
                                      .read<PetProfileProvider>()
                                      .deleteVaccinationFn(
                                          context: context,
                                          vaccinId: data?.id ?? "");
                                },
                              );
                            },
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return ConfirmationWidget(
                                title: "DELETE",
                                image: AppImages.deletePng,
                                message: "Are you sure you want to delete?",
                                onTap: () {
                                  context
                                      .read<PetProfileProvider>()
                                      .deleteDewarmingTrackerFn(
                                          context: context,
                                          dewarmingId: data?.id ?? "");
                                },
                              );
                            },
                          );
                        }
                      },
                      child: Container(
                        height: 26,
                        width: 26,
                        decoration: BoxDecoration(
                          color: AppConstants.white.withOpacity(.12),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(100),
                          ),
                        ),
                        child: const Icon(
                          Icons.delete,
                          color: AppConstants.white,
                          size: 10,
                        ),
                      ),
                    ),
                    CommonInkwell(
                      onTap: () {
                        showVaccinationDetailsFn(context: context, data: data);
                      },
                      child: Container(
                        height: 26,
                        padding: const EdgeInsets.all(5),
                        width: 65,
                        decoration: BoxDecoration(
                          color: AppConstants.white.withOpacity(.12),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(100),
                          ),
                        ),
                        child: const commonTextWidget(
                          align: TextAlign.start,
                          color: AppConstants.white,
                          text: "View Detail",
                          fontSize: 9,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          SizeBoxH(Responsive.height * 1),
          commonTextWidget(
            align: TextAlign.start,
            maxLines: 2,
            overFlow: TextOverflow.ellipsis,
            color: AppConstants.white.withOpacity(.8),
            text: data?.remarks ??
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. ",
            fontSize: 12,
            fontWeight: FontWeight.w300,
          ),
          SizeBoxH(Responsive.height * 2),
          Container(
            height: 65,
            padding: const EdgeInsets.all(10),
            width: Responsive.width * 100,
            decoration: BoxDecoration(
              color: AppConstants.white.withOpacity(.10),
              borderRadius: const BorderRadius.all(
                Radius.circular(16),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    commonTextWidget(
                      align: TextAlign.start,
                      color: AppConstants.white.withOpacity(.8),
                      text: "Administration Date",
                      fontSize: 9,
                      fontWeight: FontWeight.w400,
                    ),
                    commonTextWidget(
                      align: TextAlign.start,
                      color: AppConstants.white.withOpacity(.8),
                      text: "Due date",
                      fontSize: 9,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    commonTextWidget(
                      align: TextAlign.start,
                      color: AppConstants.white,
                      text: DateFormat('EEEE, MMM d yyyy')
                          .format(data?.administrationDate ?? DateTime.now())
                          .toString(),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                    Container(
                      height: 10,
                      width: 10,
                      decoration: const BoxDecoration(
                          color: AppConstants.white,
                          borderRadius: BorderRadius.all(Radius.circular(100))),
                    ),
                    commonTextWidget(
                      align: TextAlign.start,
                      color: AppConstants.white,
                      text: DateFormat('EEEE, MMM d yyyy')
                          .format(data?.dueDate ?? DateTime.now())
                          .toString(),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

Future<dynamic> showVaccinationDetailsFn(
    {required BuildContext context, required DewarmingData? data}) {
  return showModalBottomSheet(
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40), topRight: Radius.circular(40))),
    context: context,
    builder: (context) {
      return Container(
        width: Responsive.width * 100,
        padding: const EdgeInsets.all(16),
        height: Responsive.height * 35,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                commonTextWidget(
                  overFlow: TextOverflow.ellipsis,
                  align: TextAlign.start,
                  color: AppConstants.black,
                  text: data?.vaccineName ?? "Vaccine Name",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                CommonInkwell(
                  onTap: () => Routes.back(context: context),
                  child: Container(
                    height: 26,
                    width: 26,
                    decoration: BoxDecoration(
                      color: AppConstants.appPrimaryColor.withOpacity(.70),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(100),
                      ),
                    ),
                    child: const Icon(
                      Icons.close,
                      color: AppConstants.white,
                      size: 10,
                    ),
                  ),
                ),
              ],
            ),
            SizeBoxH(Responsive.height * 2),
            const commonTextWidget(
              overFlow: TextOverflow.ellipsis,
              align: TextAlign.start,
              color: AppConstants.black,
              text: "Remarks",
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            SizeBoxH(Responsive.height * 1),
            commonTextWidget(
              align: TextAlign.start,
              color: AppConstants.black,
              text: data?.remarks ?? "",
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            SizeBoxH(Responsive.height * 1.8),
            VacinationDetailsContentWidget(
                textH1: "Administration Date",
                textH2: "Due Date",
                valueText1: DateFormat('EEEE, MMM d yyyy')
                    .format(data?.administrationDate ?? DateTime.now())
                    .toString(),
                valueText2: DateFormat('EEEE, MMM d yyyy')
                    .format(data?.dueDate ?? DateTime.now())
                    .toString()),
            SizeBoxH(Responsive.height * 2),
            VacinationDetailsContentWidget(
              textH1: "Serial Number",
              textH2: "Clinic Name",
              valueText1: data?.serialNumber.toString() ?? "",
              valueText2: data?.clinicName ?? "",
            ),
          ],
        ),
      );
    },
  );
}

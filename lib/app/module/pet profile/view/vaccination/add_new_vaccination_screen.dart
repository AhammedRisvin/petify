import 'package:clan_of_pets/app/module/pet%20profile/view%20model/pet_profile_provider.dart';
import 'package:clan_of_pets/app/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../helpers/common_widget.dart';
import '../../../../helpers/size_box.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_router.dart';
import '../../../../utils/extensions.dart';
import '../../model/get_dewarming_model.dart';
import '../events/create_events_screen.dart';

class AddNewVaccinationScreen extends StatefulWidget {
  final DewarmingData? data;
  final bool isVaccinationUpdated;
  final String title;
  const AddNewVaccinationScreen(
      {super.key,
      this.data,
      this.isVaccinationUpdated = false,
      required this.title});

  @override
  State<AddNewVaccinationScreen> createState() =>
      _AddNewVaccinationScreenState();
}

class _AddNewVaccinationScreenState extends State<AddNewVaccinationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    if (widget.isVaccinationUpdated == true) {
      context
          .read<PetProfileProvider>()
          .vaccinationTrackervaccinenameCtrl
          .text = widget.data?.vaccineName ?? '';
      context.read<PetProfileProvider>().vaccinationSelectedDateString =
          DateFormat('yyyy-MM-dd')
              .format(widget.data?.administrationDate ?? DateTime.now())
              .toString();
      context.read<PetProfileProvider>().vaccinationDueSelectedDateString =
          DateFormat('yyyy-MM-dd')
              .format(widget.data?.administrationDate ?? DateTime.now())
              .toString();
      context
          .read<PetProfileProvider>()
          .vaccinationTrackerserialNumberCtrl
          .text = widget.data?.serialNumber ?? '';
      context.read<PetProfileProvider>().vaccinationTrackerclinicNameCtrl.text =
          widget.data?.clinicName ?? '';
      context.read<PetProfileProvider>().vaccinationTrackerremarksCtrl.text =
          widget.data?.remarks ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.white,
      appBar: AppBar(
        backgroundColor: AppConstants.white,
        title: commonTextWidget(
          text: widget.title,
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
      body: Container(
        padding: const EdgeInsets.all(15),
        height: Responsive.height * 100,
        width: Responsive.width * 100,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const commonTextWidget(
                  text: "Please put the following information Below",
                  color: AppConstants.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                SizeBoxH(Responsive.height * 2),
                Padding(
                  padding: const EdgeInsets.only(left: 1.0, right: 1),
                  child: CommonFileSelectingContainer(
                    imgIcon: AppImages.qrScannerIcon,
                    text: 'Scan serial number',
                    onTap: () {
                      context
                          .read<PetProfileProvider>()
                          .getSerialNumberUsingQrScannFn();
                    },
                  ),
                ),
                SizeBoxH(Responsive.height * 1),
                const commonTextWidget(
                  color: AppConstants.black,
                  text: "Vaccine name",
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                SizeBoxH(Responsive.height * 1),
                SizedBox(
                  child: CommonTextFormField(
                    bgColor: AppConstants.greyContainerBg,
                    hintText: "Vaccine name",
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a vaccine name';
                      } else {
                        return null;
                      }
                    },
                    controller: context
                        .read<PetProfileProvider>()
                        .vaccinationTrackervaccinenameCtrl,
                  ),
                ),
                SizeBoxH(Responsive.height * 2),
                const commonTextWidget(
                  color: AppConstants.black,
                  text: "Administration Date",
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                SizeBoxH(Responsive.height * 1),
                CommonInkwell(
                  onTap: () {
                    context
                        .read<PetProfileProvider>()
                        .addNewVaccinationSelectDate(
                          context: context,
                          isDueDate: false,
                        );
                  },
                  child: Selector<PetProfileProvider, String>(
                    selector: (p0, p1) => p1.vaccinationSelectedDateString,
                    builder: (context, value, child) => Container(
                      padding: const EdgeInsets.all(12),
                      height: 46,
                      width: Responsive.width * 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: AppConstants.greyContainerBg,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: Responsive.width * 35,
                            padding: EdgeInsets.symmetric(
                                horizontal: Responsive.width * 2),
                            child: commonTextWidget(
                              align: TextAlign.start,
                              color: value == ""
                                  ? AppConstants.subTextGrey
                                  : AppConstants.black,
                              text: value == "" ? "Administration Date" : value,
                              fontSize: 12,
                            ),
                          ),
                          Icon(
                            Icons.calendar_month_sharp,
                            size: 22,
                            color: AppConstants.black.withOpacity(.4),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizeBoxH(Responsive.height * 2),
                const commonTextWidget(
                  color: AppConstants.black,
                  text: "Due Date",
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                SizeBoxH(Responsive.height * 1),
                CommonInkwell(
                  onTap: () {
                    context
                        .read<PetProfileProvider>()
                        .addNewVaccinationSelectDate(
                          context: context,
                          isDueDate: true,
                        );
                  },
                  child: Selector<PetProfileProvider, String>(
                    selector: (p0, p1) => p1.vaccinationDueSelectedDateString,
                    builder: (context, value, child) => Container(
                      padding: const EdgeInsets.all(12),
                      height: 46,
                      width: Responsive.width * 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: AppConstants.greyContainerBg,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: Responsive.width * 35,
                            padding: EdgeInsets.symmetric(
                                horizontal: Responsive.width * 2),
                            child: commonTextWidget(
                              align: TextAlign.start,
                              color: value == ""
                                  ? AppConstants.subTextGrey
                                  : AppConstants.black,
                              text: value == "" ? "Due Date" : value,
                              fontSize: 12,
                            ),
                          ),
                          Icon(
                            Icons.calendar_month_sharp,
                            size: 22,
                            color: AppConstants.black.withOpacity(.4),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizeBoxH(Responsive.height * 2),
                const commonTextWidget(
                  color: AppConstants.black,
                  text: "Serial Number ( optional )",
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                SizeBoxH(Responsive.height * 1),
                SizedBox(
                  height: 46,
                  child: Selector<PetProfileProvider, String>(
                    selector: (p0, p1) => p1.barcodeScanRes,
                    builder: (context, barcodeScanRes, child) =>
                        CommonTextFormField(
                      bgColor: AppConstants.greyContainerBg,
                      hintText: "Serial Number ( Scan or type )",
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      controller: context
                          .read<PetProfileProvider>()
                          .vaccinationTrackerserialNumberCtrl,
                    ),
                  ),
                ),
                SizeBoxH(Responsive.height * 2),
                const commonTextWidget(
                  color: AppConstants.black,
                  text: "Clinic Name ( optional )",
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                SizeBoxH(Responsive.height * 1),
                SizedBox(
                  height: 46,
                  child: CommonTextFormField(
                    bgColor: AppConstants.greyContainerBg,
                    hintText: "Clinic Name ( optional )",
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    controller: context
                        .read<PetProfileProvider>()
                        .vaccinationTrackerclinicNameCtrl,
                  ),
                ),
                SizeBoxH(Responsive.height * 2),
                const commonTextWidget(
                  color: AppConstants.black,
                  text: "Remarks",
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                SizeBoxH(Responsive.height * 1),
                SizedBox(
                  child: CommonTextFormField(
                    bgColor: AppConstants.greyContainerBg,
                    hintText: "Remarks",
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a remarks';
                      } else {
                        return null;
                      }
                    },
                    controller: context
                        .read<PetProfileProvider>()
                        .vaccinationTrackerremarksCtrl,
                  ),
                ),
                SizeBoxH(Responsive.height * 3),
                CommonButton(
                    isFullRoundedButton: true,
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        if (widget.isVaccinationUpdated == false) {
                          context
                              .read<PetProfileProvider>()
                              .createVaccinationTrackerFn(context: context);
                        } else {
                          context
                              .read<PetProfileProvider>()
                              .updateVaccinationTrackerFn(
                                  context: context,
                                  vaccinId: widget.data?.id ?? '');
                        }
                      }
                    },
                    text: "Add & Continue",
                    width: Responsive.width * 100,
                    size: 16,
                    height: 40)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

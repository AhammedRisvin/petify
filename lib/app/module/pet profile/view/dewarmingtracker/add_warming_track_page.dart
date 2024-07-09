import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../helpers/common_widget.dart';
import '../../../../helpers/size_box.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_router.dart';
import '../../../../utils/extensions.dart';
import '../../model/get_dewarming_model.dart';
import '../../view model/pet_profile_provider.dart';
import '../events/create_events_screen.dart';

class AddDwwarmingTrackerScreen extends StatefulWidget {
  final DewarmingData? data;
  final bool isDewarmingUpdated;
  const AddDwwarmingTrackerScreen(
      {super.key, this.data, this.isDewarmingUpdated = false});

  @override
  State<AddDwwarmingTrackerScreen> createState() =>
      _AddDwwarmingTrackerScreenState();
}

class _AddDwwarmingTrackerScreenState extends State<AddDwwarmingTrackerScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    if (widget.isDewarmingUpdated == true) {
      context.read<PetProfileProvider>().singleImageUr =
          widget.data?.image ?? '';
      context.read<PetProfileProvider>().imageTitlee = widget.data?.image ?? '';
      context.read<PetProfileProvider>().dewarmingTrackervaccinenameCtrl.text =
          widget.data?.vaccineName ?? '';
      context.read<PetProfileProvider>().vaccinationSelectedDateString =
          DateFormat('yyyy-MM-dd')
              .format(widget.data?.administrationDate ?? DateTime.now())
              .toString();
      context.read<PetProfileProvider>().vaccinationDueSelectedDateString =
          DateFormat('yyyy-MM-dd')
              .format(widget.data?.administrationDate ?? DateTime.now())
              .toString();
      context.read<PetProfileProvider>().dewarmingTrackerserialNumberCtrl.text =
          widget.data?.serialNumber ?? '';
      context.read<PetProfileProvider>().dewarmingTrackerclinicNameCtrl.text =
          widget.data?.clinicName ?? '';
      context.read<PetProfileProvider>().dewarmingTrackerremarksCtrl.text =
          widget.data?.remarks ?? '';
    } else {
      context.read<PetProfileProvider>().imageTitlee = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.white,
      appBar: AppBar(
        backgroundColor: AppConstants.white,
        title: const commonTextWidget(
          text: "Add Deworming Tracker ",
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
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const commonTextWidget(
                  text: "Please put the following information Below",
                  color: AppConstants.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                SizeBoxH(Responsive.height * 2),
                Padding(
                  padding: const EdgeInsets.only(left: 1.0, right: 1),
                  child:
                      Consumer<PetProfileProvider>(builder: (context, obj, _) {
                    return CommonFileSelectingContainer(
                      subText: '',
                      isDrawble: true,
                      text: obj.imageTitlee == ''
                          ? 'Add image \n(It should capture the serial no details)'
                          : obj.imageTitlee,
                      onTap: () {
                        context.read<PetProfileProvider>().uploadSingleImage();
                      },
                    );
                  }),
                ),
                SizeBoxH(Responsive.height * 1),
                const commonTextWidget(
                  color: AppConstants.black,
                  text: "Deworming name",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                SizeBoxH(Responsive.height * 1),
                SizedBox(
                  height: 46,
                  child: CommonTextFormField(
                    bgColor: AppConstants.greyContainerBg,
                    hintText: "Deworming name",
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a Deworming name';
                      } else {
                        return null;
                      }
                    },
                    controller: context
                        .read<PetProfileProvider>()
                        .dewarmingTrackervaccinenameCtrl,
                  ),
                ),
                SizeBoxH(Responsive.height * 2),
                const commonTextWidget(
                  color: AppConstants.black,
                  text: "Administration Date",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                SizeBoxH(Responsive.height * 1),
                CommonInkwell(
                  onTap: () {
                    context
                        .read<PetProfileProvider>()
                        .addNewVaccinationSelectDate(
                            context: context, isDueDate: false);
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
                  fontWeight: FontWeight.w500,
                ),
                SizeBoxH(Responsive.height * 1),
                CommonInkwell(
                  onTap: () {
                    context
                        .read<PetProfileProvider>()
                        .addNewVaccinationSelectDate(
                            context: context, isDueDate: true);
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
                  fontWeight: FontWeight.w500,
                ),
                SizeBoxH(Responsive.height * 1),
                SizedBox(
                  height: 46,
                  child: CommonTextFormField(
                    bgColor: AppConstants.greyContainerBg,
                    hintText: "Serial Number ( optional )",
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    controller: context
                        .read<PetProfileProvider>()
                        .dewarmingTrackerserialNumberCtrl,
                  ),
                ),
                SizeBoxH(Responsive.height * 2),
                const commonTextWidget(
                  color: AppConstants.black,
                  text: "Clinic Name ( optional )",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
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
                        .dewarmingTrackerclinicNameCtrl,
                  ),
                ),
                SizeBoxH(Responsive.height * 2),
                const commonTextWidget(
                  color: AppConstants.black,
                  text: "Remarks",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                SizeBoxH(Responsive.height * 1),
                CommonTextFormField(
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
                      .dewarmingTrackerremarksCtrl,
                ),
                SizeBoxH(Responsive.height * 3),
                CommonButton(
                  isFullRoundedButton: true,
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      if (widget.isDewarmingUpdated == false) {
                        if (context
                                .read<PetProfileProvider>()
                                .vaccinationDueSelectedDateString ==
                            '') {
                          toast(context,
                              title: 'Please add vaccination due date',
                              backgroundColor: Colors.red);
                        } else if (context
                                .read<PetProfileProvider>()
                                .vaccinationSelectedDateString ==
                            '') {
                          toast(context,
                              title: 'Please add Administration date',
                              backgroundColor: Colors.red);
                        } else if (context
                                .read<PetProfileProvider>()
                                .singleImageUr ==
                            '') {
                          toast(context,
                              title: 'Please add image',
                              backgroundColor: Colors.red);
                        } else {
                          context
                              .read<PetProfileProvider>()
                              .createDewarmingTrackerFn(context: context);
                        }
                      } else {
                        if (context
                                .read<PetProfileProvider>()
                                .vaccinationDueSelectedDateString ==
                            '') {
                          toast(context,
                              title: 'Please add vaccination due date',
                              backgroundColor: Colors.red);
                        } else if (context
                                .read<PetProfileProvider>()
                                .vaccinationSelectedDateString ==
                            '') {
                          toast(context,
                              title: 'Please add Administration date',
                              backgroundColor: Colors.red);
                        } else if (context
                                .read<PetProfileProvider>()
                                .singleImageUr ==
                            '') {
                          toast(context,
                              title: 'Please add image',
                              backgroundColor: Colors.red);
                        } else {
                          context
                              .read<PetProfileProvider>()
                              .updateDewarmingTrackerFn(
                                  context: context,
                                  dewarmingId: widget.data?.id ?? '');
                        }
                      }
                    }
                  },
                  text: "Add & Continue",
                  width: Responsive.width * 100,
                  size: 16,
                  height: 50,
                ),
                SizeBoxH(Responsive.height * 2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

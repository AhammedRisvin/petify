import 'package:clan_of_pets/app/helpers/size_box.dart';
import 'package:clan_of_pets/app/module/pet%20profile/view%20model/pet_profile_provider.dart';
import 'package:clan_of_pets/app/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../helpers/common_widget.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_router.dart';
import '../../widget/dotted_border_painter.dart';

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({super.key});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: AppConstants.white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: AppConstants.white,
        title: const commonTextWidget(
          text: "Create Events",
          color: AppConstants.black,
          fontSize: 17,
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
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Consumer<PetProfileProvider>(
            builder: (context, provider, child) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonFileSelectingContainer(
                  text:
                      context.read<PetProfileProvider>().thumbnailImage == null
                          ? "Add Event Image"
                          : provider.imageTitle ?? "",
                  onTap: () {
                    provider.uploadSingleImage();
                  },
                ),
                const commonTextWidget(
                  color: AppConstants.black,
                  text: 'Event name',
                  fontSize: 14,
                ),
                SizeBoxH(Responsive.height * 2),
                CommonTextFormField(
                  bgColor: AppConstants.greyContainerBg,
                  hintText: "Event Name",
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.next,
                  controller: provider.eventNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter event name';
                    }
                    return null;
                  },
                ),
                SizeBoxH(Responsive.height * 2),
                const commonTextWidget(
                  color: AppConstants.black,
                  text: 'Event Description',
                  fontSize: 14,
                ),
                SizeBoxH(Responsive.height * 2),
                CommonTextFormField(
                  bgColor: AppConstants.greyContainerBg,
                  hintText: "Event Description",
                  keyboardType: TextInputType.multiline,
                  maxLength: null,
                  contentPadding: const EdgeInsets.all(30),
                  textInputAction: TextInputAction.next,
                  controller: provider.eventDescriptionController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Description';
                    }
                    return null;
                  },
                ),
                SizeBoxH(Responsive.height * 2),
                const commonTextWidget(
                  color: AppConstants.black,
                  text: 'Event Date&Time',
                  fontSize: 14,
                ),
                SizeBoxH(Responsive.height * 2),
                SizedBox(
                  width: Responsive.width * 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CommonInkwell(
                        onTap: () {
                          provider.growthSelectDate(
                              context, true, false, DateTime.now());
                        },
                        child: Container(
                          height: Responsive.height * 6,
                          width: Responsive.width * 44,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: AppConstants.greyContainerBg,
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: Responsive.width * 35,
                                padding: EdgeInsets.symmetric(
                                    horizontal: Responsive.width * 2),
                                child: commonTextWidget(
                                  align: TextAlign.start,
                                  color: provider.selectedDateString == ""
                                      ? AppConstants.subTextGrey
                                      : AppConstants.black,
                                  text: provider.selectedDateString == ""
                                      ? "Event Date"
                                      : provider.selectedDateString,
                                  fontSize: 12,
                                ),
                              ),
                              const Icon(
                                Icons.calendar_month_outlined,
                                size: 22,
                                color: AppConstants.subTextGrey,
                              ),
                            ],
                          ),
                        ),
                      ),
                      CommonInkwell(
                        onTap: () {
                          provider.eventSelectTime(context);
                        },
                        child: Container(
                          height: Responsive.height * 6,
                          width: Responsive.width * 44,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: AppConstants.greyContainerBg,
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: Responsive.width * 35,
                                padding: EdgeInsets.symmetric(
                                    horizontal: Responsive.width * 2),
                                child: commonTextWidget(
                                  align: TextAlign.start,
                                  color: provider.eventSelectedTimeString == ""
                                      ? AppConstants.subTextGrey
                                      : AppConstants.black,
                                  text: provider.eventSelectedTimeString == ""
                                      ? "Event Time"
                                      : provider.eventSelectedTimeString,
                                  fontSize: 12,
                                ),
                              ),
                              const Icon(
                                Icons.timer_outlined,
                                size: 25,
                                color: AppConstants.subTextGrey,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizeBoxH(Responsive.height * 2),
                const commonTextWidget(
                  color: AppConstants.black,
                  text: 'Event Location',
                  fontSize: 14,
                ),
                SizeBoxH(Responsive.height * 2),
                CommonTextFormField(
                  bgColor: AppConstants.greyContainerBg,
                  hintText: "Event Location",
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.done,
                  controller: provider.eventLocationController,
                  suffixIcon: const Icon(
                    Icons.location_on,
                    size: 25,
                    color: AppConstants.subTextGrey,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Location';
                    }
                    return null;
                  },
                ),
                SizeBoxH(Responsive.height * 4),
                CommonButton(
                  onTap: () {
                    if (provider.thumbnailImage == null ||
                        provider.eventSelectedTimeString == "" ||
                        provider.selectedDateString == "") {
                      toast(
                        context,
                        title: "Provide Required Fields To Continue",
                        backgroundColor: Colors.red,
                      );
                    } else {
                      provider.createEventFn(context: context);
                    }
                  },
                  text: "Add & Continue",
                  width: Responsive.width * 100,
                  height: Responsive.height * 6,
                  isFullRoundedButton: true,
                ),
                SizeBoxH(Responsive.height * 4),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CommonFileSelectingContainer extends StatelessWidget {
  final void Function()? onTap;
  final String? text;
  final bool? isDrawble;
  final String? subText;
  final String imgIcon;
  const CommonFileSelectingContainer(
      {this.subText,
      this.isDrawble,
      super.key,
      this.onTap,
      this.text,
      this.imgIcon = 'assets/images/eventFileUploadIcon.png'});

  @override
  Widget build(BuildContext context) {
    return CommonInkwell(
      onTap: onTap,
      child: Container(
        height: Responsive.height * 18,
        width: Responsive.width * 100,
        margin: const EdgeInsets.symmetric(vertical: 15),
        padding: const EdgeInsets.symmetric(horizontal: 1),
        child: CustomPaint(
          painter: DottedBorderPainter(
            color: AppConstants.appPrimaryColor,
            gap: 5,
            strokeWidth: 3,
          ),
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: AppConstants.greyContainerBg,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    imgIcon,
                    height: 30,
                  ),
                  const SizedBox(height: 15),
                  commonTextWidget(
                    color: AppConstants.black.withOpacity(.4),
                    text: text ?? '',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  isDrawble == true
                      ? commonTextWidget(
                          color: AppConstants.black.withOpacity(.4),
                          text: subText ??
                              '(It should capturethe serial no destails)',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        )
                      : const SizedBox.shrink()
                ],
              )),
        ),
      ),
    );
  }
}

class GalleryOrCameraWidget extends StatelessWidget {
  final String icon;
  final String title;
  final void Function() onTap;
  const GalleryOrCameraWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CommonInkwell(
      onTap: onTap,
      child: Column(
        children: [
          Image.asset(
            icon,
            height: 50,
          ),
          const SizeBoxH(10),
          commonTextWidget(
            color: AppConstants.black,
            text: title,
            fontSize: 12,
          ),
        ],
      ),
    );
  }
}

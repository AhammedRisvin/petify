// ignore_for_file: use_full_hex_values_for_flutter_colors

import 'package:clan_of_pets/app/helpers/size_box.dart';
import 'package:clan_of_pets/app/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../helpers/common_widget.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_images.dart';
import '../../../utils/app_router.dart';
import '../view_model/lostgem_provider.dart';
import '../widgets/dottedContainer.dart';

class PetInformationScreen extends StatefulWidget {
  const PetInformationScreen({super.key});

  @override
  State<PetInformationScreen> createState() => _PetInformationScreenState();
}

class _PetInformationScreenState extends State<PetInformationScreen> {
  final controller = TextEditingController;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.white,
      appBar: AppBar(
        backgroundColor: AppConstants.white,
        title: const commonTextWidget(
          text: "Pet Information",
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Consumer<LostGemProvider>(
            builder: (context, provider, child) => Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizeBoxH(Responsive.height * 2),
                  Container(
                    width: Responsive.width * 100,
                    decoration: BoxDecoration(
                        color: const Color(0xffF3F3F5),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(
                                0x26000000), // Alpha value 26 in hexadecimal
                            offset: Offset(0, 1),
                            blurRadius: 4,
                            spreadRadius: 0,
                          )
                        ]),
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 14, left: 10, right: 17),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            commonNetworkImage(
                                isBorder: true,
                                borderRadius: BorderRadius.circular(16),
                                url: provider.singlePetData?.missingDetails
                                        ?.identification ??
                                    'https://example.com/image.jpg',
                                height: Responsive.height * 15,
                                width: Responsive.width * 45),
                            SizeBoxV(Responsive.width * 2),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                commonTextWidget(
                                  text: provider.singlePetData?.name ?? "",
                                  color: AppConstants.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                                SizeBoxH(Responsive.height * 1.4),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      AppImages.locationImage,
                                    ),
                                    SizeBoxV(Responsive.width * 1),
                                    commonTextWidget(
                                      color: Colors.grey,
                                      text: provider.singlePetData
                                              ?.missingDetails?.location ??
                                          "",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13,
                                    ),
                                  ],
                                ),
                                SizeBoxH(Responsive.height * 1.4),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Icon(
                                      Icons.phone,
                                      size: 15,
                                    ),
                                    SizeBoxV(Responsive.width * 1),
                                    commonTextWidget(
                                      color: Colors.grey,
                                      text: provider.singlePetData
                                              ?.missingDetails?.ownerContact ??
                                          "",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13,
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                        SizeBoxH(Responsive.height * 1.4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  AppImages.callenderImage,
                                ),
                                SizeBoxV(Responsive.width * 2),
                                commonTextWidget(
                                  color: Colors.grey,
                                  text: provider.formatDateTimeToString(
                                    provider.singlePetData?.missingDetails
                                            ?.date ??
                                        DateTime.now(),
                                  ),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  AppImages.minusImage,
                                ),
                                SizeBoxV(Responsive.width * 02),
                                const commonTextWidget(
                                  color: Colors.grey,
                                  text: 'Report',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13,
                                ),
                              ],
                            ),
                            Container(
                              width: Responsive.width * 20,
                              height: Responsive.height * 3,
                              decoration: const BoxDecoration(
                                color: Color(0xfffee5158),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30),
                                ),
                              ),
                              alignment: Alignment.center,
                              child: commonTextWidget(
                                color: Colors.white,
                                text: provider.singlePetData?.status ?? "",
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  SizeBoxH(Responsive.height * 2),
                  const commonTextWidget(
                    color: Colors.black,
                    text: 'Pet Information',
                    fontWeight: FontWeight.w500,
                    fontSize: 19,
                  ),
                  SizeBoxH(Responsive.height * 2),
                  const commonTextWidget(
                    color: Colors.black,
                    text: 'Location',
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                  ),
                  SizeBoxH(Responsive.height * 1),
                  CommonTextFormField(
                    controller: provider.petInformLocationCntrlr,
                    textInputAction: TextInputAction.none,
                    keyboardType: TextInputType.name,
                    bgColor: const Color(0xffF3F3F5),
                    hintText: 'Location',
                    suffixIcon: const Icon(
                      Icons.location_on,
                      color: AppConstants.black40,
                    ),
                    validator: (value) {
                      if (value?.isEmpty == true) {
                        return 'Please enter the location';
                      }
                      return null;
                    },
                  ),
                  SizeBoxH(Responsive.height * 2),
                  const commonTextWidget(
                    color: Colors.black,
                    text: 'Date seen',
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                  ),
                  SizeBoxH(Responsive.height * 1),
                  CommonInkwell(
                    onTap: () {
                      provider.eventSelectDate(context, false);
                    },
                    child: Container(
                      height: Responsive.height * 6,
                      width: Responsive.width * 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: AppConstants.greyContainerBg,
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(right: Responsive.width * 3),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: Responsive.width * 35,
                              padding: EdgeInsets.symmetric(
                                  horizontal: Responsive.width * 2),
                              child: commonTextWidget(
                                align: TextAlign.start,
                                color: provider.lostPetSelectedDateString == ""
                                    ? AppConstants.subTextGrey
                                    : AppConstants.black,
                                text: provider.lostPetSelectedDateString == ""
                                    ? "Event Date"
                                    : provider.lostPetSelectedDateString,
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
                  ),
                  SizeBoxH(Responsive.height * 2),
                  const commonTextWidget(
                    color: Colors.black,
                    text: 'Time seen',
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                  ),
                  SizeBoxH(Responsive.height * 1),
                  CommonInkwell(
                    onTap: () {
                      provider.eventSelectTime(context);
                    },
                    child: Container(
                      height: Responsive.height * 6,
                      width: Responsive.width * 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: AppConstants.greyContainerBg,
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(right: Responsive.width * 3),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: Responsive.width * 35,
                              padding: EdgeInsets.symmetric(
                                  horizontal: Responsive.width * 2),
                              child: commonTextWidget(
                                align: TextAlign.start,
                                color: provider.lostPetSelectedTimeString == ""
                                    ? AppConstants.subTextGrey
                                    : AppConstants.black,
                                text: provider.lostPetSelectedTimeString == ""
                                    ? "Event Time"
                                    : provider.lostPetSelectedTimeString,
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
                  ),
                  SizeBoxH(Responsive.height * 2),
                  const commonTextWidget(
                    color: Colors.black,
                    text: 'Contact Details',
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                  ),
                  SizeBoxH(Responsive.height * 1),
                  CommonTextFormField(
                    controller: provider.petInformContactCntrlr,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    bgColor: const Color(0xffF3F3F5),
                    hintText: 'Contact details',
                    validator: (value) {
                      if (value?.isEmpty == true) {
                        return 'Please enter Contact details';
                      }
                      return null;
                    },
                    maxLength: 10,
                  ),
                  SizeBoxH(Responsive.height * 2),
                  const commonTextWidget(
                    color: Colors.black,
                    text: 'Remarks',
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                  ),
                  SizeBoxH(Responsive.height * 1),
                  CommonTextFormField(
                    controller: provider.petInformRemarksCntrlr,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.name,
                    bgColor: const Color(0xffF3F3F5),
                    hintText: 'Remarks',
                  ),
                  SizeBoxH(Responsive.height * 2),
                  const commonTextWidget(
                    color: Colors.black,
                    text: 'Identification with attach',
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                  ),
                  SizeBoxH(Responsive.height * 2),
                  DottedContainer(
                    onTap: () {
                      provider.uploadImage();
                    },
                  ),
                  SizeBoxH(Responsive.height * 3),
                  CommonButton(
                    isFullRoundedButton: true,
                    height: Responsive.height * 6,
                    text: 'Done',
                    width: Responsive.width * 100,
                    bgColor: const Color(0XFFF6884F),
                    onTap: () {
                      if (formKey.currentState!.validate() &&
                          provider.lostPetSelectedTimeString != "" &&
                          provider.lostPetSelectedDateString != "") {
                        // Form is valid, perform actions

                        provider.foundPetFn(
                          context: context,
                          petId: provider.singlePetData?.id ?? '',
                        );
                      } else if (provider.lostPetSelectedTimeString == "" ||
                          provider.lostPetSelectedDateString == "") {
                        toast(
                          context,
                          title: "provide date and time",
                          backgroundColor: Colors.red,
                        );
                      }
                    },
                  ),
                  SizeBoxH(Responsive.height * 3),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

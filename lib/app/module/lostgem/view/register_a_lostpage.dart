import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../helpers/common_widget.dart';
import '../../../helpers/size_box.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_router.dart';
import '../../../utils/extensions.dart';
import '../../pet profile/view/events/create_events_screen.dart';
import '../view_model/lostgem_provider.dart';

class RegisterALostPetScreen extends StatelessWidget {
  RegisterALostPetScreen({super.key});
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.white,
      appBar: AppBar(
        backgroundColor: AppConstants.white,
        title: const commonTextWidget(
          text: "Register a Lost Pet",
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
                  const commonTextWidget(
                    color: Colors.black,
                    text: 'Please put the following information below',
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                  ),
                  SizeBoxH(Responsive.height * 3),
                  const commonTextWidget(
                    color: Colors.black,
                    text: 'Pet Name',
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                  ),
                  const SizeBoxH(10),
                  CommonTextFormField(
                    controller: context
                        .read<LostGemProvider>()
                        .registerLostPetNameCntrlr,
                    textInputAction: TextInputAction.none,
                    keyboardType: TextInputType.name,
                    bgColor: const Color(0xffF3F3F5),
                    hintText: 'Pet names',
                    validator: (value) {
                      if (value?.isEmpty == true) {
                        return 'Please enter Pet names';
                      }
                      return null;
                    },
                  ),
                  SizeBoxH(Responsive.height * 2),
                  const commonTextWidget(
                    color: Colors.black,
                    text: 'Status Update',
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                  ),
                  const SizeBoxH(10),
                  Container(
                    height: Responsive.height * 6,
                    width: Responsive.width * 100,
                    padding: EdgeInsets.symmetric(
                        horizontal: Responsive.width * 2,
                        vertical: Responsive.height * 1),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: const Color(0xffF3F3F5),
                    ),
                    child: const Row(
                      children: [
                        commonTextWidget(
                          color: AppConstants.black,
                          text: "Missing",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.5,
                        )
                      ],
                    ),
                  ),
                  SizeBoxH(Responsive.height * 2),
                  const commonTextWidget(
                    color: Colors.black,
                    text: 'Location',
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                  ),
                  const SizeBoxH(10),
                  CommonTextFormField(
                    controller: context
                        .read<LostGemProvider>()
                        .registerLostPetLocationCntrlr,
                    textInputAction: TextInputAction.none,
                    keyboardType: TextInputType.name,
                    bgColor: const Color(0xffF3F3F5),
                    hintText: 'Location',
                    validator: (value) {
                      if (value?.isEmpty == true) {
                        return 'Please enter Location';
                      }
                      return null;
                    },
                    prefixIcon: const Icon(
                      Icons.location_on,
                      color: Color(0xffB6B6B8),
                    ),
                  ),
                  SizeBoxH(Responsive.height * 2),
                  const commonTextWidget(
                    color: Colors.black,
                    text: 'Missing Date',
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                  ),
                  const SizeBoxH(10),
                  CommonInkwell(
                    onTap: () {
                      provider.eventSelectDate(context, true);
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
                                color:
                                    provider.registerLostPetSelectedDateString ==
                                            ""
                                        ? AppConstants.subTextGrey
                                        : AppConstants.black,
                                text:
                                    provider.registerLostPetSelectedDateString ==
                                            ""
                                        ? "Missing Date"
                                        : provider
                                            .registerLostPetSelectedDateString,
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
                    text: 'Contact Number',
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                  ),
                  const SizeBoxH(10),
                  CommonTextFormField(
                    controller: context
                        .read<LostGemProvider>()
                        .registerLostPetNumberCntrlr,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.number,
                    bgColor: const Color(0xffF3F3F5),
                    hintText: 'Contact Number',
                    maxLength: 10,
                    prefixIcon: const Icon(
                      Icons.phone,
                      color: Color(0xffB6B6B8),
                    ),
                    validator: (value) {
                      if (value?.isEmpty == true) {
                        return 'Please enter Contact Number';
                      }
                      return null;
                    },
                  ),
                  const SizeBoxH(10),
                  SizeBoxH(Responsive.height * 2),
                  const commonTextWidget(
                    color: Colors.black,
                    text: 'Identification with attach',
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                  ),
                  SizeBoxH(Responsive.height * 2),
                  CommonFileSelectingContainer(
                    text: provider.imageTitle ?? 'Add Image',
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
                          provider.registerLostPetSelectedDateString != '') {
                        // Form is valid, perform actions
                        provider.registerLostPetFn(context: context);
                      } else if (provider.registerLostPetSelectedDateString ==
                          '') {
                        toast(context,
                            title: "Provide date", backgroundColor: Colors.red);
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

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../helpers/common_widget.dart';
import '../../../../helpers/size_box.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/app_router.dart';
import '../../../../utils/extensions.dart';
import '../../../home/view/notification_scree.dart';
import '../../view model/pet_profile_provider.dart';
import '../events/create_events_screen.dart';

class CreateAchievementScreen extends StatelessWidget {
  CreateAchievementScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.white,
      appBar: AppBar(
        backgroundColor: AppConstants.white,
        title: const commonTextWidget(
          text: "Create New Achievements",
          color: AppConstants.black,
          fontSize: 14,
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
          SizedBox(
            height: 35,
            child: IconButton(
                style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: AppConstants.greyContainerBg,
                    padding: const EdgeInsets.all(8)),
                onPressed: () {
                  Routes.push(
                    context: context,
                    screen: const NotificationScreen(),
                    exit: () {},
                  );
                },
                icon: Image.asset(
                  AppImages.bellIcon,
                  height: 14,
                  width: 12,
                )),
          ),
          SizeBoxV(Responsive.width * 3),
        ],
      ),
      body: Container(
        height: Responsive.height * 100,
        width: Responsive.width * 100,
        margin: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const commonTextWidget(
                  text: "Please put the following information",
                  color: AppConstants.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                SizeBoxH(Responsive.height * 4),
                const commonTextWidget(
                  color: AppConstants.black,
                  text: "Achievement name",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                SizeBoxH(Responsive.height * 1),
                SizedBox(
                  child: CommonTextFormField(
                    bgColor: AppConstants.greyContainerBg,
                    hintText: "Achievement name",
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter achievement name';
                      } else {
                        return null;
                      }
                    },
                    textInputAction: TextInputAction.next,
                    controller: context
                        .read<PetProfileProvider>()
                        .createNewAchievementNameCtrl,
                  ),
                ),
                SizeBoxH(Responsive.height * 2),
                const commonTextWidget(
                  color: AppConstants.black,
                  text: "venue ",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                SizeBoxH(Responsive.height * 1),
                SizedBox(
                  child: CommonTextFormField(
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Image.asset(
                        AppImages.locationIcon,
                        height: 16,
                        width: 10,
                      ),
                    ),
                    bgColor: AppConstants.greyContainerBg,
                    hintText: "venue ",
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter venue';
                      } else {
                        return null;
                      }
                    },
                    textInputAction: TextInputAction.done,
                    controller: context
                        .read<PetProfileProvider>()
                        .createNewAchievementVenueCtrl,
                  ),
                ),
                SizeBoxH(Responsive.height * 2),
                const commonTextWidget(
                  color: AppConstants.black,
                  text: "Venue date ",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                SizeBoxH(Responsive.height * 1),
                SizedBox(
                  height: 46,
                  child: Selector<PetProfileProvider, String>(
                    selector: (p0, p1) => p1.selectedAchivementDate,
                    builder: (context, value, child) => CommonTextFormField(
                      readOnly: true,
                      onTap: () => context
                          .read<PetProfileProvider>()
                          .achivementSelectDate(context),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Image.asset(
                          AppImages.calenderIcon,
                          height: 16,
                          width: 16,
                        ),
                      ),
                      bgColor: AppConstants.greyContainerBg,
                      hintText: "Venue date",
                      hintTextColor: AppConstants.subTextGrey,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      controller: TextEditingController(
                        text: value == "" ? "Venue date" : value,
                      ),
                    ),
                  ),
                ),
                SizeBoxH(Responsive.height * 2),
                const commonTextWidget(
                  color: AppConstants.black,
                  text: "Issuing organisation",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                SizeBoxH(Responsive.height * 1),
                SizedBox(
                  child: CommonTextFormField(
                    bgColor: AppConstants.greyContainerBg,
                    hintText: "Issuing organisation",
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter organisation name';
                      } else {
                        return null;
                      }
                    },
                    textInputAction: TextInputAction.done,
                    controller: context
                        .read<PetProfileProvider>()
                        .createNewAchievementOrganisationCtrl,
                  ),
                ),
                SizeBoxH(Responsive.height * 2),
                const commonTextWidget(
                  color: AppConstants.black,
                  text: "Add Image (Optional) ",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                SizeBoxH(Responsive.height * 1),
                Selector<PetProfileProvider, String>(
                  selector: (p0, p1) => p1.imageTitlee,
                  builder: (context, value, child) =>
                      CommonFileSelectingContainer(
                    text: value.isEmpty ? 'Add Image (Optional)' : value,
                    onTap: () {
                      context.read<PetProfileProvider>().uploadSingleImage();
                    },
                  ),
                ),
                SizeBoxH(Responsive.height * 2),
                CommonButton(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        context
                            .read<PetProfileProvider>()
                            .createNewAchievementFn(context: context);
                      }
                    },
                    text: 'Save & Continue',
                    width: Responsive.width * 100,
                    size: 14,
                    isFullRoundedButton: true,
                    height: 50)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

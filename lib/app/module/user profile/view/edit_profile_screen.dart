import 'package:clan_of_pets/app/helpers/size_box.dart';
import 'package:clan_of_pets/app/module/user%20profile/model/user_profile_model.dart';
import 'package:clan_of_pets/app/module/user%20profile/view%20model/profile_provider.dart';
import 'package:clan_of_pets/app/utils/app_images.dart';
import 'package:clan_of_pets/app/utils/extensions.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
// import 'package:language_picker/language_picker.dart';
import 'package:language_picker/language_picker_dropdown.dart';
import 'package:language_picker/languages.dart';
import 'package:provider/provider.dart';

import '../../../helpers/common_widget.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_router.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key, this.data, required this.isEdit});
  final UserDetails? data;
  final bool isEdit;
  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController userFirstNameCntrlr = TextEditingController();
  TextEditingController userLastNameCntrlr = TextEditingController();

  EditController provider = EditController();
  @override
  void initState() {
    super.initState();
    provider = context.read<EditController>();
    if (widget.isEdit) {
      userFirstNameCntrlr.text = widget.data?.firstName ?? "";
      userLastNameCntrlr.text = widget.data?.lastName ?? "";
      provider.profileImagePath = widget.data?.profile ?? "";
      provider.coverImagePath = widget.data?.coverImage?.split('/').last ?? "";
      provider.selectedCountry =
          widget.data?.nationality?.split('/').last ?? "";
      provider.selectedCity = widget.data?.city ?? "";
      provider.selectedState = widget.data?.country ?? "";
      provider.imageUrlForUploadCover = widget.data?.coverImage ?? "";
      provider.imageUrlForUploadProfile = widget.data?.profile ?? "";
      provider.selectedLanguage = Language.fromIsoCode(
        widget.data?.language ?? "en",
      );
    } else {
      userFirstNameCntrlr.text = "";
      userLastNameCntrlr.text = "";
    }
  }

  @override
  void dispose() {
    userFirstNameCntrlr.dispose();
    userLastNameCntrlr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.white,
      appBar: AppBar(
        backgroundColor: AppConstants.white,
        title: commonTextWidget(
          text: widget.isEdit ? "Edit Profile" : "Add Profile",
          color: AppConstants.black,
          fontSize: 16,
          fontWeight: FontWeight.w700,
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
        padding: const EdgeInsets.all(15),
        child: Consumer<EditController>(
          builder: (context, provider, child) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const commonTextWidget(
                color: AppConstants.black,
                text: "Please put the following information Below",
                fontSize: 16,
                letterSpacing: 0.5,
                fontWeight: FontWeight.w700,
              ),
              const SizeBoxH(16),
              const commonTextWidget(
                color: AppConstants.black,
                text: "Upload Profile Picture",
                fontSize: 14,
                letterSpacing: 0.5,
                fontWeight: FontWeight.w600,
              ),
              const SizeBoxH(10),
              SizedBox(
                height: Responsive.height * 5.2,
                child: CommonTextFormField(
                  bgColor: AppConstants.greyContainerBg,
                  hintText: provider.profileImagePath ??
                      "Select your profile picture",
                  keyboardType: TextInputType.none,
                  textInputAction: TextInputAction.none,
                  controller: TextEditingController(),
                  readOnly: true,
                  contentPadding: const EdgeInsets.only(
                    left: 20,
                    top: 0,
                    bottom: 0,
                  ),
                  suffixIcon: Container(
                    width: Responsive.width * 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: AppConstants.appPrimaryColor,
                    ),
                    child: IconButton(
                      onPressed: () {
                        provider.uploadImage(
                          isFromProfilePic: true,
                          context: context,
                        );
                      },
                      icon: Image.asset(
                        AppImages.shareCloudIcon,
                        height: 18,
                      ),
                    ),
                  ),
                ),
              ),
              const SizeBoxH(16),
              const commonTextWidget(
                color: AppConstants.black,
                text: "Upload Cover  Image",
                fontSize: 14,
                letterSpacing: 0.5,
                fontWeight: FontWeight.w600,
              ),
              const SizeBoxH(10),
              SizedBox(
                height: Responsive.height * 5.2,
                child: CommonTextFormField(
                  bgColor: AppConstants.greyContainerBg,
                  hintText:
                      provider.coverImagePath ?? "Select your Cover Image",
                  keyboardType: TextInputType.none,
                  textInputAction: TextInputAction.none,
                  controller: TextEditingController(),
                  readOnly: true,
                  contentPadding: const EdgeInsets.only(
                    left: 20,
                  ),
                  suffixIcon: Container(
                    width: Responsive.width * 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: AppConstants.appPrimaryColor,
                    ),
                    child: IconButton(
                      onPressed: () {
                        provider.uploadImage(
                            isFromProfilePic: false, context: context);
                      },
                      icon: Image.asset(
                        AppImages.shareCloudIcon,
                        height: 18,
                      ),
                    ),
                  ),
                ),
              ),
              const SizeBoxH(16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const commonTextWidget(
                        color: AppConstants.black,
                        text: "First Name",
                        fontSize: 14,
                        letterSpacing: 0.5,
                        fontWeight: FontWeight.w600,
                      ),
                      const SizeBoxH(10),
                      SizedBox(
                        height: Responsive.height * 5.2,
                        width: Responsive.width * 45,
                        child: CommonTextFormField(
                          bgColor: AppConstants.greyContainerBg,
                          hintText: "Enter first name",
                          keyboardType: TextInputType.multiline,
                          textInputAction: TextInputAction.next,
                          controller: userFirstNameCntrlr,
                          readOnly: false,
                          contentPadding: const EdgeInsets.only(
                            left: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const commonTextWidget(
                        color: AppConstants.black,
                        text: "Last Name",
                        fontSize: 14,
                        letterSpacing: 0.5,
                        fontWeight: FontWeight.w600,
                      ),
                      const SizeBoxH(10),
                      SizedBox(
                        height: Responsive.height * 5.2,
                        width: Responsive.width * 45,
                        child: CommonTextFormField(
                          bgColor: AppConstants.greyContainerBg,
                          hintText: "Enter last name",
                          keyboardType: TextInputType.multiline,
                          textInputAction: TextInputAction.next,
                          controller: userLastNameCntrlr,
                          readOnly: false,
                          contentPadding: const EdgeInsets.only(
                            left: 20,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizeBoxH(16),
              const commonTextWidget(
                color: AppConstants.black,
                text: "Nationality",
                fontSize: 14,
                letterSpacing: 0.5,
                fontWeight: FontWeight.w600,
              ),
              const SizeBoxH(10),
              CSCPicker(
                layout: Layout.vertical,
                flagState: CountryFlag.ENABLE,
                disabledDropdownDecoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                  color: AppConstants.greyContainerBg,
                  border: Border.all(
                    color: AppConstants.greyContainerBg,
                    width: 1,
                  ),
                ),
                dropdownDecoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                  color: AppConstants.greyContainerBg,
                  border: Border.all(
                    color: AppConstants.greyContainerBg,
                    width: 1,
                  ),
                ),
                dropdownHeadingStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                currentCity: provider.selectedCity,
                currentCountry: provider.selectedCountry,
                currentState: provider.selectedState,
                showCities: true,
                showStates: true,
                searchBarRadius: 50,
                defaultCountry: CscCountry.India,
                countryDropdownLabel: "Country",
                onCountryChanged: (value) {
                  provider.setCountry(value);
                },
                onStateChanged: (value) {
                  provider.setState(value);
                },
                onCityChanged: (value) {
                  provider.setCity(value);
                },
              ),
              const SizeBoxH(16),
              const commonTextWidget(
                color: AppConstants.black,
                text: "Language",
                fontSize: 14,
                letterSpacing: 0.5,
                fontWeight: FontWeight.w600,
              ),
              const SizeBoxH(10),
              Container(
                height: Responsive.height * 5.2,
                width: Responsive.width * 100,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: AppConstants.greyContainerBg,
                ),
                child: LanguagePickerDropdown(
                  initialValue: Language.fromIsoCode(widget.isEdit
                      ? provider.getUserProfileModel.details?.language ?? "en"
                      : "en"),
                  onValuePicked: (language) {
                    provider.setLanguage(language);
                  },
                ),
              ),
              SizeBoxH(Responsive.height * 4),
              CommonButton(
                onTap: () {
                  if (!widget.isEdit) {
                    provider.addUserProfileFn(
                      context: context,
                      firstName: userFirstNameCntrlr.text,
                      lastName: userLastNameCntrlr.text,
                      clear: () {
                        userFirstNameCntrlr.clear();
                        userLastNameCntrlr.clear();
                      },
                    );
                  } else {
                    provider.editUserProfileFn(
                      context: context,
                      firstName: userFirstNameCntrlr.text,
                      lastName: userLastNameCntrlr.text,
                      clear: () {
                        userFirstNameCntrlr.clear();

                        userLastNameCntrlr.clear();
                      },
                    );
                  }
                },
                text: "Save Profile",
                width: Responsive.width * 100,
                height: Responsive.height * 6,
                isFullRoundedButton: true,
              )
            ],
          ),
        ),
      ),
    );
  }
}

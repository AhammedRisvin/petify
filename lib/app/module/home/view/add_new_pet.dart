import 'package:clan_of_pets/app/helpers/size_box.dart';
import 'package:clan_of_pets/app/module/home/model/get_pet_model.dart';
import 'package:clan_of_pets/app/module/home/view%20model/home_provider.dart';
import 'package:clan_of_pets/app/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../helpers/common_widget.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_images.dart';
import '../../../utils/app_router.dart';

class AddNewPetScreen extends StatefulWidget {
  const AddNewPetScreen({super.key, required this.isEdit, this.data});

  final bool isEdit;
  final PetData? data;

  @override
  State<AddNewPetScreen> createState() => _AddNewPetScreenState();
}

class _AddNewPetScreenState extends State<AddNewPetScreen> {
  // ProfileProvider provider = ProfileProvider();
  HomeProvider homeProvider = HomeProvider();
  @override
  void initState() {
    super.initState();

    if (widget.isEdit) {
      petFirstNameCntrlr.text =
          widget.data?.name?.capitalizeFirstLetter() ?? '';
      petNickNameCntrlr.text =
          widget.data?.nickName?.capitalizeFirstLetter() ?? '';
      petWeightCntrlr.text = widget.data?.weight.toString() ?? '';
      petHeightCntrlr.text = widget.data?.height.toString() ?? '';
      petCopId.text = widget.data?.copId ?? '';
      petMicroChipId.text = widget.data?.chipId ?? '';
    } else {
      petFirstNameCntrlr.clear();
      petNickNameCntrlr.clear();
      petWeightCntrlr.clear();
      petHeightCntrlr.clear();
      petCopId.clear();
      petMicroChipId.clear();
      homeProvider.imageUrlForUploadCover = "";
      homeProvider.imageUrlForUploadProfile = '';
      homeProvider.profileImagePath = '';
      homeProvider.coverImagePath = '';
      homeProvider.eventSelectedDate = null;
      homeProvider.selectedDateString = '';
    }
  }

  TextEditingController petFirstNameCntrlr = TextEditingController();
  TextEditingController petNickNameCntrlr = TextEditingController();
  TextEditingController petWeightCntrlr = TextEditingController();
  TextEditingController petHeightCntrlr = TextEditingController();
  TextEditingController petCopId = TextEditingController();
  TextEditingController petMicroChipId = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.white,
      appBar: AppBar(
        backgroundColor: AppConstants.white,
        title: commonTextWidget(
          text: widget.isEdit ? "Edit Pet" : "Add New Pet",
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
        child: Consumer<HomeProvider>(
          builder: (context, provider, child) {
            if (widget.isEdit) {
              provider.profileImagePath =
                  widget.data?.image?.split('/').last ?? '';
              provider.coverImagePath =
                  widget.data?.coverImage?.split('/').last ?? '';
              provider.imageUrlForUploadCover = widget.data?.coverImage ?? '';
              provider.imageUrlForUploadProfile = widget.data?.image ?? '';
              provider.selectedSpecies = widget.data?.species ?? '';
              provider.selectedBreed = widget.data?.breed ?? '';
              provider.selectedSex = widget.data?.sex ?? '';
              provider.eventSelectedDate =
                  widget.data?.birthDate ?? DateTime.now();
              String date = homeProvider
                  .updateSelectedDate(widget.data?.birthDate ?? DateTime.now());
              provider.selectedDateString = date;
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonInkwell(
                  onTap: () {
                    provider.uploadImage(
                        isFromProfilePic: true, context: context);
                  },
                  child: Container(
                    width: Responsive.width * 100,
                    height: Responsive.height * 23,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppConstants.greyContainerBg,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/addNewPetpickImage.png",
                          height: Responsive.height * 8,
                        ),
                        const SizeBoxH(10),
                        commonTextWidget(
                          color: AppConstants.black,
                          text: provider.profileImagePath == null ||
                                  provider.profileImagePath?.isEmpty == true
                              ? "Upload Profile image"
                              : provider.profileImagePath ?? "",
                          letterSpacing: -0.5,
                        )
                      ],
                    ),
                  ),
                ),
                const SizeBoxH(22),
                SizedBox(
                  height: Responsive.height * 6,
                  child: Container(
                    padding: const EdgeInsets.only(left: 20, right: 0),
                    decoration: BoxDecoration(
                      color: AppConstants.greyContainerBg,
                      borderRadius:
                          BorderRadius.circular(100), // Adjust as needed
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            provider.coverImagePath == null ||
                                    provider.coverImagePath!.isEmpty
                                ? "Upload Cover image"
                                : provider.coverImagePath!,
                            style: const TextStyle(
                              color: Colors.black26,
                              fontSize: 12,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          width: Responsive.width * 20,
                          height: Responsive.height * 6,
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
                      ],
                    ),
                  ),
                ),
                const SizeBoxH(22),
                SizedBox(
                  width: Responsive.width * 100,
                  child: const commonTextWidget(
                    color: AppConstants.black,
                    text: "Please put the following information about your pet",
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    letterSpacing: -0.1,
                    align: TextAlign.start,
                  ),
                ),
                const SizeBoxH(15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const commonTextWidget(
                          color: AppConstants.black,
                          text: "Name",
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
                            controller: petFirstNameCntrlr,
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
                          text: "Nick Name",
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
                            hintText: "Enter Nick name",
                            keyboardType: TextInputType.multiline,
                            textInputAction: TextInputAction.next,
                            controller: petNickNameCntrlr,
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
                const SizeBoxH(10),
                const commonTextWidget(
                  color: AppConstants.black,
                  text: "Species",
                  fontSize: 14,
                  letterSpacing: 0.5,
                  fontWeight: FontWeight.w600,
                ),
                const SizeBoxH(10),
                widget.isEdit
                    ? Container(
                        height: Responsive.height * 6,
                        width: Responsive.width * 100,
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 10,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: AppConstants.greyContainerBg,
                        ),
                        child: Text(widget.data?.species ?? ""),
                      )
                    : Container(
                        height: Responsive.height * 6,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: AppConstants.greyContainerBg,
                        ),
                        child: DropdownButtonFormField<String>(
                          dropdownColor: AppConstants.greyContainerBg,
                          borderRadius: BorderRadius.circular(10),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                          value: provider.selectedSpecies,
                          hint: const Text("Species"),
                          items: provider.petSpecies
                              .map<DropdownMenuItem<String>>((String species) {
                            return DropdownMenuItem<String>(
                              value: species,
                              child: Text(species),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            provider.setSelectedSpecies(newValue ?? '');
                          },
                        ),
                      ),
                const SizeBoxH(10),
                const commonTextWidget(
                  color: AppConstants.black,
                  text: "Breed",
                  fontSize: 14,
                  letterSpacing: 0.5,
                  fontWeight: FontWeight.w600,
                ),
                const SizeBoxH(10),
                widget.isEdit
                    ? Container(
                        height: Responsive.height * 6,
                        width: Responsive.width * 100,
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 10,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: AppConstants.greyContainerBg,
                        ),
                        child: Text(widget.data?.breed ?? ""),
                      )
                    : Container(
                        height: Responsive.height * 6,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: AppConstants.greyContainerBg,
                        ),
                        child: DropdownButtonFormField<String>(
                          dropdownColor: AppConstants.greyContainerBg,
                          borderRadius: BorderRadius.circular(10),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                          value: provider.selectedBreed,
                          hint: const Text("Breed"),
                          items: provider.petBreeds
                              .map<DropdownMenuItem<String>>((String breed) {
                            return DropdownMenuItem<String>(
                              value: breed,
                              child: Text(breed),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            provider.setSelectedBreed(newValue ?? '');
                          },
                        ),
                      ),
                const SizeBoxH(10),
                const commonTextWidget(
                  color: AppConstants.black,
                  text: "Sex",
                  fontSize: 14,
                  letterSpacing: 0.5,
                  fontWeight: FontWeight.w600,
                ),
                const SizeBoxH(10),
                widget.isEdit
                    ? Container(
                        height: Responsive.height * 6,
                        width: Responsive.width * 100,
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 10,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: AppConstants.greyContainerBg,
                        ),
                        child: Text(widget.data?.sex ?? ""),
                      )
                    : Container(
                        height: Responsive.height * 6,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: AppConstants.greyContainerBg,
                        ),
                        child: DropdownButtonFormField<String>(
                          dropdownColor: AppConstants.greyContainerBg,
                          borderRadius: BorderRadius.circular(10),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                          value: provider.selectedSex,
                          hint: const Text("Sex"),
                          items: provider.petGender
                              .map<DropdownMenuItem<String>>((String sex) {
                            return DropdownMenuItem<String>(
                              value: sex,
                              child: Text(sex),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            provider.setSelectedSex(newValue ?? '');
                          },
                        ),
                      ),
                const SizeBoxH(10),
                const commonTextWidget(
                  color: AppConstants.black,
                  text: "Birth Date",
                  fontSize: 14,
                  letterSpacing: 0.5,
                  fontWeight: FontWeight.w600,
                ),
                const SizeBoxH(10),
                widget.isEdit
                    ? Container(
                        height: Responsive.height * 6,
                        width: Responsive.width * 100,
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 10,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: AppConstants.greyContainerBg,
                        ),
                        child: Text(provider.selectedDateString),
                      )
                    : CommonInkwell(
                        onTap: () {
                          if (widget.isEdit) {
                            toast(
                              context,
                              title:
                                  "You can't change the birth date of your pet",
                              backgroundColor: Colors.red,
                            );
                          } else {
                            provider.eventSelectDate(context);
                          }
                        },
                        child: Container(
                          height: Responsive.height * 6,
                          width: Responsive.width * 100,
                          padding: const EdgeInsets.only(right: 10, left: 5),
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
                                  color: provider.selectedDateString == ""
                                      ? AppConstants.subTextGrey
                                      : AppConstants.black,
                                  text: provider.selectedDateString == ""
                                      ? "Birth Date"
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
                const SizeBoxH(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: const TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Weight ',
                                style: TextStyle(
                                  color: AppConstants.black,
                                  fontSize: 14,
                                  letterSpacing: 0.5,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextSpan(
                                text: '(Kg)',
                                style: TextStyle(
                                  color: Colors
                                      .grey, // replace with your desired color
                                  fontSize:
                                      10, // replace with your desired size
                                  letterSpacing: 0.5,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizeBoxH(10),
                        SizedBox(
                          height: Responsive.height * 5.2,
                          width: Responsive.width * 45,
                          child: CommonTextFormField(
                            bgColor: AppConstants.greyContainerBg,
                            hintText: "Enter Weight",
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            controller: petWeightCntrlr,
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
                        RichText(
                          text: const TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Height ',
                                style: TextStyle(
                                  color: AppConstants.black,
                                  fontSize: 14,
                                  letterSpacing: 0.5,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextSpan(
                                text: '(cm)',
                                style: TextStyle(
                                  color: Colors
                                      .grey, // replace with your desired color
                                  fontSize:
                                      10, // replace with your desired size
                                  letterSpacing: 0.5,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizeBoxH(10),
                        SizedBox(
                          height: Responsive.height * 5.2,
                          width: Responsive.width * 45,
                          child: CommonTextFormField(
                            bgColor: AppConstants.greyContainerBg,
                            hintText: "Enter Height",
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            controller: petHeightCntrlr,
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
                const SizeBoxH(10),
                const commonTextWidget(
                  color: AppConstants.black,
                  text: "COP id",
                  fontSize: 14,
                  letterSpacing: 0.5,
                  fontWeight: FontWeight.w600,
                ),
                const SizeBoxH(10),
                CommonTextFormField(
                  bgColor: AppConstants.greyContainerBg,
                  hintText: "Enter pet COP id",
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  controller: petCopId,
                  readOnly: widget.isEdit ? true : false,
                  contentPadding: const EdgeInsets.only(
                    left: 20,
                  ),
                ),
                const SizeBoxH(10),
                const commonTextWidget(
                  color: AppConstants.black,
                  text: "Micro Chip id",
                  fontSize: 14,
                  letterSpacing: 0.5,
                  fontWeight: FontWeight.w600,
                ),
                const SizeBoxH(10),
                CommonTextFormField(
                  bgColor: AppConstants.greyContainerBg,
                  hintText: "Enter pet micro chip id",
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  controller: petMicroChipId,
                  readOnly: widget.isEdit ? true : false,
                  contentPadding: const EdgeInsets.only(
                    left: 20,
                  ),
                ),
                const SizeBoxH(30),
                CommonButton(
                  onTap: () {
                    if (widget.isEdit) {
                      provider.editPetFn(
                        context: context,
                        name: petFirstNameCntrlr.text,
                        nickName: petNickNameCntrlr.text,
                        height: petHeightCntrlr.text,
                        weight: petWeightCntrlr.text,
                        clear: () {
                          petNickNameCntrlr.clear();
                          petFirstNameCntrlr.clear();
                          petHeightCntrlr.clear();
                          petWeightCntrlr.clear();
                          petCopId.clear();
                          petMicroChipId.clear();
                        },
                      );
                    } else {
                      provider.addPetFn(
                        context: context,
                        name: petFirstNameCntrlr.text,
                        nickName: petNickNameCntrlr.text,
                        height: petHeightCntrlr.text,
                        weight: petWeightCntrlr.text,
                        copId: petCopId.text,
                        microChipId: petMicroChipId.text,
                        clear: () {
                          petNickNameCntrlr.clear();
                          petFirstNameCntrlr.clear();
                          petHeightCntrlr.clear();
                          petWeightCntrlr.clear();
                          petCopId.clear();
                          petMicroChipId.clear();
                        },
                      );
                    }
                  },
                  text: "Submit",
                  width: Responsive.width * 100,
                  height: Responsive.height * 6,
                  isFullRoundedButton: true,
                ),
                const SizeBoxH(20),
              ],
            );
          },
        ),
      ),
    );
  }
}

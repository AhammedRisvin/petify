import 'package:clan_of_pets/app/helpers/size_box.dart';
import 'package:clan_of_pets/app/module/Dating/model/get_all_post.dart';
import 'package:clan_of_pets/app/module/Dating/view%20model/dating_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../helpers/common_widget.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_router.dart';
import '../../../utils/extensions.dart';
import '../../pet profile/view/events/create_events_screen.dart';
import '../widget/small_map_container.dart';

class DatingCreatePostScreen extends StatefulWidget {
  const DatingCreatePostScreen({
    super.key,
    this.petData,
    required this.isEdit,
    required this.id,
  });

  final bool isEdit;
  final Post? petData;
  final String id;

  @override
  State<DatingCreatePostScreen> createState() => _DatingCreatePostScreenState();
}

class _DatingCreatePostScreenState extends State<DatingCreatePostScreen> {
  TextEditingController petNameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController breedController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController lookingForController = TextEditingController();

  double? editLatitude;
  double? editLongitude;

  @override
  void initState() {
    super.initState();

    if (widget.isEdit) {
      petNameController.text = widget.petData?.name ?? "";
      ageController.text = widget.petData?.age ?? "";
      breedController.text = widget.petData?.breed ?? "";
      genderController.text = widget.petData?.gender ?? "";
      weightController.text = widget.petData?.weight ?? "";
      heightController.text = widget.petData?.height ?? "";
      lookingForController.text = widget.petData?.lookingFor ?? "";
      context.read<DatingProvider>().placeName = widget.petData?.location ?? "";
      context.read<DatingProvider>().selectedSpecies =
          widget.petData?.species ?? "";
      context.read<DatingProvider>().imageTitle = widget.petData?.image ?? "";
      context.read<DatingProvider>().singleImageUr =
          widget.petData?.image ?? "";

      editLatitude = double.tryParse(widget.petData?.latitude ?? "");
      editLongitude = double.tryParse(widget.petData?.longitude ?? "");
      context.read<DatingProvider>().formatDate(
            widget.petData?.birthdate ?? DateTime.now(),
          );
    } else {
      petNameController.clear();
      ageController.clear();
      breedController.clear();
      genderController.clear();
      weightController.clear();
      heightController.clear();
      lookingForController.clear();
      context.read<DatingProvider>().selectedDateString = "";
      context.read<DatingProvider>().imageTitle = "";
    }
  }

  @override
  void dispose() {
    petNameController.dispose();
    ageController.dispose();
    breedController.dispose();
    genderController.dispose();
    weightController.dispose();
    heightController.dispose();
    lookingForController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.white,
      appBar: AppBar(
        backgroundColor: AppConstants.white,
        title: commonTextWidget(
          text: widget.isEdit ? "Edit post" : "Create Post",
          color: AppConstants.black,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        leading: SizedBox(
          height: 30,
          width: 30,
          child: Center(
            child: IconButton(
              onPressed: () {
                Routes.back(context: context);
              },
              style: ButtonStyle(
                fixedSize: const WidgetStatePropertyAll(Size(4, 4)),
                backgroundColor: WidgetStatePropertyAll(
                  AppConstants.white.withOpacity(.5),
                ),
              ),
              icon: const Icon(
                Icons.arrow_back_ios_new,
                size: 15,
                color: AppConstants.appPrimaryColor,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        physics: const ScrollPhysics(),
        child: Consumer<DatingProvider>(
          builder: (context, provider, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const commonTextWidget(
                  color: AppConstants.black,
                  text: "Please put the following information below",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                const SizeBoxH(20),
                const commonTextWidget(
                  color: AppConstants.black,
                  text: "Pet Name",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                const SizeBoxH(10),
                CommonTextFormField(
                  bgColor: AppConstants.greyContainerBg,
                  hintText: "name",
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  controller: petNameController,
                ),
                const SizeBoxH(20),
                const commonTextWidget(
                  color: AppConstants.black,
                  text: "Species",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                const SizeBoxH(10),
                Container(
                  height: Responsive.height * 6,
                  width: Responsive.width * 100,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: AppConstants.greyContainerBg,
                  ),
                  child: widget.isEdit
                      ? Center(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: commonTextWidget(
                              color: AppConstants.black,
                              text: widget.petData?.species ?? "",
                              fontSize: 16,
                            ),
                          ),
                        )
                      : DropdownButtonFormField<String>(
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
                const SizeBoxH(20),
                const commonTextWidget(
                  color: AppConstants.black,
                  text: "Age",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                const SizeBoxH(10),
                CommonTextFormField(
                  bgColor: AppConstants.greyContainerBg,
                  hintText: "Age",
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  readOnly: widget.isEdit,
                  controller: ageController,
                  onTap: () {
                    if (widget.isEdit) {
                      toast(
                        context,
                        title: "You cant edit age",
                        backgroundColor: Colors.red,
                      );
                    }
                  },
                ),
                const SizeBoxH(20),
                const commonTextWidget(
                  color: AppConstants.black,
                  text: "Breed",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                const SizeBoxH(10),
                CommonTextFormField(
                  bgColor: AppConstants.greyContainerBg,
                  hintText: "Breed",
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  controller: breedController,
                ),
                const SizeBoxH(20),
                const commonTextWidget(
                  color: AppConstants.black,
                  text: "Gender",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                const SizeBoxH(10),
                CommonTextFormField(
                  bgColor: AppConstants.greyContainerBg,
                  hintText: "GenderS",
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  controller: genderController,
                ),
                const SizeBoxH(20),
                const commonTextWidget(
                  color: AppConstants.black,
                  text: "Date of Birth",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                const SizeBoxH(10),
                CommonInkwell(
                  onTap: () {
                    if (widget.isEdit) {
                      toast(
                        context,
                        title: "You cant edit the DOB",
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
                          color: AppConstants.appPrimaryColor,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizeBoxH(20),
                const commonTextWidget(
                  color: AppConstants.black,
                  text: "Weight",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                const SizeBoxH(10),
                CommonTextFormField(
                  bgColor: AppConstants.greyContainerBg,
                  hintText: "Weight",
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  controller: weightController,
                ),
                const SizeBoxH(20),
                const commonTextWidget(
                  color: AppConstants.black,
                  text: "Height",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                const SizeBoxH(10),
                CommonTextFormField(
                  bgColor: AppConstants.greyContainerBg,
                  hintText: "Height",
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  controller: heightController,
                ),
                const SizeBoxH(20),
                const commonTextWidget(
                  color: AppConstants.black,
                  text: "Location",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                const SizeBoxH(10),
                Container(
                  width: Responsive.width * 100,
                  height: Responsive.height * 6,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: AppConstants.greyContainerBg,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: commonTextWidget(
                      color: AppConstants.black,
                      text: provider.placeName ??
                          "change location by clicking th map below",
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizeBoxH(10),
                const commonTextWidget(
                  color: AppConstants.subTextGrey,
                  text: "click here to change location",
                  fontSize: 12,
                ),
                const SizeBoxH(10),
                MapPreview(
                  editLatitude: editLatitude,
                  editLongitude: editLongitude,
                  isEdit: widget.isEdit,
                ),
                const SizeBoxH(20),
                const commonTextWidget(
                  color: AppConstants.black,
                  text: "Looking For",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                const SizeBoxH(10),
                CommonTextFormField(
                  bgColor: AppConstants.greyContainerBg,
                  hintText: "Looking For",
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  controller: lookingForController,
                ),
                const SizeBoxH(20),
                CommonFileSelectingContainer(
                  text: context.read<DatingProvider>().singleImageUr == ''
                      ? "Add pet Image"
                      : provider.imageTitle ?? "",
                  onTap: () {
                    provider.uploadSingleImage(
                      context: context,
                    );
                  },
                ),
                const SizeBoxH(30),
                CommonButton(
                  onTap: () {
                    if (!widget.isEdit) {
                      provider.createDatePost(
                        name: petNameController.text,
                        age: ageController.text,
                        breed: breedController.text,
                        context: context,
                        gender: genderController.text,
                        height: heightController.text,
                        weight: weightController.text,
                        lookingFor: lookingForController.text,
                        clear: () {
                          petNameController.clear();
                          ageController.clear();
                          breedController.clear();
                          genderController.clear();
                          heightController.clear();
                          weightController.clear();
                          lookingForController.clear();
                        },
                      );
                    } else {
                      provider.editDatePostFn(
                        name: petNameController.text,
                        age: ageController.text,
                        breed: breedController.text,
                        context: context,
                        gender: genderController.text,
                        height: heightController.text,
                        weight: weightController.text,
                        lookingFor: lookingForController.text,
                        id: widget.id,
                        clear: () {
                          petNameController.clear();
                          ageController.clear();
                          breedController.clear();
                          genderController.clear();
                          heightController.clear();
                          weightController.clear();
                          lookingForController.clear();
                        },
                      );
                    }
                  },
                  text: "Publish",
                  width: Responsive.width * 100,
                  height: Responsive.height * 6,
                  isFullRoundedButton: true,
                ),
                const SizeBoxH(20)
              ],
            );
          },
        ),
      ),
    );
  }
}

// ignore_for_file: unused_element

import 'package:clan_of_pets/app/helpers/size_box.dart';
import 'package:clan_of_pets/app/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../helpers/common_widget.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_router.dart';
import '../../view model/pet_profile_provider.dart';

class NewGrowthEntryScreen extends StatefulWidget {
  const NewGrowthEntryScreen({
    super.key,
    required this.isEdit,
    this.isFromHeight = false,
    this.value = 0,
    required this.date,
    required this.id,
    required this.petId,
    required this.successCallback,
  });

  final bool isEdit;
  final bool isFromHeight;
  final int value;
  final DateTime date;
  final String id;
  final String petId;
  final Null Function() successCallback;

  @override
  State<NewGrowthEntryScreen> createState() => _NewGrowthEntryScreenState();
}

PetProfileProvider provider = PetProfileProvider();

class _NewGrowthEntryScreenState extends State<NewGrowthEntryScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    provider = Provider.of<PetProfileProvider>(context);
    if (widget.isEdit) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(widget.date);
      provider.selectedDateString = formattedDate;
      if (widget.isFromHeight) {
        provider.selectedType = "Height";
        provider.heightController.text = widget.value.toString();
      } else {
        provider.selectedType = "Weight";
        provider.weightController.text = widget.value.toString();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: AppConstants.white,
        title: commonTextWidget(
          text: widget.isEdit ? "Edit Growth Entry" : "New Growth Entry",
          color: AppConstants.black,
          fontSize: 18,
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
        child: Consumer<PetProfileProvider>(
          builder: (context, value, child) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const commonTextWidget(
                color: AppConstants.black,
                text: "Please put the following information Below",
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
              SizeBoxH(Responsive.height * 4),
              const commonTextWidget(
                color: AppConstants.black,
                text: "Date of Measurements",
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              SizeBoxH(Responsive.height * 2),
              CommonInkwell(
                onTap: () {
                  if (widget.isEdit) {
                    provider.growthSelectDate(
                      context,
                      false,
                      true,
                      widget.date,
                    );
                  } else {
                    provider.growthSelectDate(
                      context,
                      false,
                      false,
                      DateTime.now(),
                    );
                  }
                },
                child: Container(
                  height: Responsive.height * 6,
                  width: Responsive.width * 100,
                  padding:
                      EdgeInsets.symmetric(horizontal: Responsive.width * 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: AppConstants.greyContainerBg,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: Responsive.width * 60,
                        padding: EdgeInsets.symmetric(
                            horizontal: Responsive.width * 2),
                        child: commonTextWidget(
                          align: TextAlign.start,
                          color: provider.selectedDateString == ""
                              ? AppConstants.subTextGrey
                              : AppConstants.black,
                          text: provider.selectedDateString == ""
                              ? "Date of Measurements"
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
              SizeBoxH(Responsive.height * 2),
              const commonTextWidget(
                color: AppConstants.black,
                text: "Type",
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              SizeBoxH(Responsive.height * 2),
              widget.isEdit
                  ? Container(
                      height: 50,
                      width: Responsive.width * 100,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: AppConstants.greyContainerBg,
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: commonTextWidget(
                          color: AppConstants.black,
                          text: provider.selectedType ?? "",
                          fontSize: 14,
                        ),
                      ),
                    )
                  : Container(
                      height: 50,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: AppConstants.greyContainerBg,
                      ),
                      child: DropdownButtonFormField<String>(
                        dropdownColor: AppConstants.greyContainerBg,
                        borderRadius: BorderRadius.circular(20),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        value: provider.selectedType,
                        hint: const Text("Type"),
                        items: <String>['Height', 'Weight'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          provider.setType(newValue);
                        },
                      ),
                    ),
              SizeBoxH(Responsive.height * 2),
              commonTextWidget(
                color: AppConstants.black,
                text: provider.selectedType == 'Height' ? "Height" : "Weight",
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              SizeBoxH(Responsive.height * 2),
              Row(
                children: [
                  SizedBox(
                    width: Responsive.width * 70,
                    child: CommonTextFormField(
                      bgColor: AppConstants.greyContainerBg,
                      hintText: provider.selectedType == 'Height'
                          ? "Height"
                          : "Weight",
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      controller: provider.selectedType == 'Height'
                          ? provider.heightController
                          : provider.weightController,
                    ),
                  ),
                  const SizeBoxV(10),
                  Container(
                    width: Responsive.width * 20,
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                        color: AppConstants.red,
                      ),
                    ),
                    child: Center(
                      child: commonTextWidget(
                        color: AppConstants.red,
                        text: provider.selectedType == 'Height' ? "Cm" : "Kg",
                        fontSize: 12,
                      ),
                    ),
                  )
                ],
              ),
              SizeBoxH(Responsive.height * 6),
              CommonButton(
                onTap: () {
                  if (widget.isEdit) {
                    if (provider.selectedType == "Height") {
                      provider.createNewHeightGrowthFn(
                        context: context,
                        isEdit: widget.isEdit,
                        growthId: widget.id,
                        successCallback: widget.successCallback,
                      );
                    } else if (provider.selectedType == "Weight") {
                      provider.createNewWeightGrowthFn(
                        context: context,
                        isEdit: widget.isEdit,
                        growthId: widget.id,
                        successCallback: widget.successCallback,
                      );
                    }
                  } else {
                    if (provider.selectedType == "Height") {
                      provider.createNewHeightGrowthFn(
                          context: context,
                          isEdit: widget.isEdit,
                          successCallback: () {},
                          growthId: '');
                    } else if (provider.selectedType == "Weight") {
                      provider.createNewWeightGrowthFn(
                          context: context,
                          isEdit: widget.isEdit,
                          successCallback: () {},
                          growthId: '');
                    }
                  }
                },
                isFullRoundedButton: true,
                size: 16,
                text: "Add & Continue",
                width: Responsive.width * 100,
                height: Responsive.height * 6,
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:clan_of_pets/app/utils/app_images.dart';
import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../../helpers/common_widget.dart';
import '../../../../helpers/size_box.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_router.dart';
import '../../../../utils/extensions.dart';
import '../../../pet profile/view model/pet_profile_provider.dart';
import '../../model/temmp_pets_model.dart';
import '../../view model/profile_provider.dart';

class AddCoParentOrAddTempAccessScreen extends StatefulWidget {
  final bool isAddCoParent;
  const AddCoParentOrAddTempAccessScreen(
      {super.key, this.isAddCoParent = true});

  @override
  State<AddCoParentOrAddTempAccessScreen> createState() =>
      _AddCoParentOrAddTempAccessScreenState();
}

class _AddCoParentOrAddTempAccessScreenState
    extends State<AddCoParentOrAddTempAccessScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (!widget.isAddCoParent) {
      context.read<EditController>().getPetsWithoutTempParentFun();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        context.read<PetProfileProvider>().singleImageUr = '';
        context.read<EditController>().selectedPetList.clear();
        context.read<EditController>().selectPetIdForAddPetInTempUser.clear();
        context.read<EditController>().selectedPetListForTempAccess.clear();
        context.read<EditController>().selectedPetList.clear();
        context.read<EditController>().selectedPetId = null;
        context.read<EditController>().selectedPet = null;
      },
      child: Scaffold(
        backgroundColor: AppConstants.white,
        appBar: AppBar(
          backgroundColor: AppConstants.white,
          title: commonTextWidget(
            text:
                widget.isAddCoParent ? "Add co-parent" : "Add Temporary access",
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
                    align: TextAlign.start,
                    color: AppConstants.black,
                    text: "Please put the following information Below",
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  SizeBoxH(Responsive.height * 4),
                  const commonTextWidget(
                    color: AppConstants.black,
                    text: "Upload Profile Picture",
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  SizeBoxH(Responsive.height * 1),
                  Container(
                    padding: const EdgeInsets.only(left: 15),
                    decoration: BoxDecoration(
                        color: AppConstants.greyContainerBg,
                        borderRadius: BorderRadius.circular(30)),
                    height: 46,
                    width: Responsive.width * 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Consumer<PetProfileProvider>(
                          builder: (context, provider, child) => Expanded(
                            child: commonTextWidget(
                              align: TextAlign.start,
                              maxLines: 2,
                              overFlow: TextOverflow.ellipsis,
                              color: AppConstants.black40,
                              text: provider.imageTitle?.isEmpty ??
                                      true && widget.isAddCoParent
                                  ? "Select co-parent profile picture"
                                  : provider.imageTitle?.isEmpty ??
                                          true && !widget.isAddCoParent
                                      ? 'Select Temporary access profile picture'
                                      : provider.imageTitle ?? '',
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        CommonInkwell(
                          onTap: () {
                            context
                                .read<PetProfileProvider>()
                                .uploadSingleImage();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: AppConstants.appPrimaryColor,
                                borderRadius: BorderRadius.circular(30)),
                            height: 46,
                            width: 85,
                            child: Center(
                              child: Image.asset(
                                AppImages.shareCloudIcon,
                                height: 20,
                                width: 27,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizeBoxH(Responsive.height * 3),
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
                            fontWeight: FontWeight.w500,
                          ),
                          SizeBoxH(Responsive.height * 1),
                          SizedBox(
                            width: Responsive.width * 45,
                            child: CommonTextFormField(
                              bgColor: AppConstants.greyContainerBg,
                              hintText: "Enter first name",
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter first name';
                                } else {
                                  return null;
                                }
                              },
                              controller: context
                                  .read<EditController>()
                                  .addCoParentFirstNameController,
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
                            fontWeight: FontWeight.w500,
                          ),
                          SizeBoxH(Responsive.height * 1),
                          SizedBox(
                            width: Responsive.width * 45,
                            child: CommonTextFormField(
                              bgColor: AppConstants.greyContainerBg,
                              hintText: "Enter last name",
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter last name';
                                } else {
                                  return null;
                                }
                              },
                              controller: context
                                  .read<EditController>()
                                  .addCoParentLastNameController,
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
                  SizeBoxH(Responsive.height * 3),
                  commonTextWidget(
                    color: AppConstants.black,
                    text: widget.isAddCoParent
                        ? "Co-Parent Mobile Number"
                        : "Mobile Number",
                    fontSize: 14,
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.w500,
                  ),
                  SizeBoxH(Responsive.height * 1),
                  Consumer<EditController>(
                    builder: (context, provider, child) => Row(
                      children: [
                        CountryListPick(
                          theme: CountryTheme(
                            isShowFlag: false,
                            isShowTitle: false,
                            isShowCode: true,
                            isDownIcon: true,
                            showEnglishName: true,
                            // alphabetSelectedBackgroundColor:
                            //     AppColors.limeColor,
                          ),
                          initialSelection: '+971',
                          onChanged: (CountryCode? code) {
                            provider.updateCountryCode(
                              code?.dialCode ?? 'AE',
                            );
                          },
                          appBar: AppBar(
                            systemOverlayStyle: const SystemUiOverlayStyle(
                              statusBarColor: AppConstants.appPrimaryColor,
                              statusBarIconBrightness: Brightness.light,
                            ),
                            backgroundColor: AppConstants.appPrimaryColor,
                            title: const Text(
                              'Choose Country',
                              style: TextStyle(
                                color: AppConstants.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          pickerBuilder: (context, CountryCode? code) {
                            return Row(
                              children: [
                                commonTextWidget(
                                  text: code?.dialCode ?? "+971",
                                  color: AppConstants.black60,
                                ),
                                SizedBox(width: Responsive.width * 2),
                                const Icon(
                                  Icons.arrow_drop_down,
                                  color: AppConstants.appPrimaryColor,
                                ),
                              ],
                            );
                          },
                        ),
                        Expanded(
                          child: Container(
                            height: Responsive.height * 6,
                            margin: EdgeInsets.only(
                              left: Responsive.width * 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppConstants.white,
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                color: AppConstants.greyContainerBg,
                              ),
                            ),
                            child: CommonTextFormField(
                              bgColor: AppConstants.white,
                              hintTextColor: AppConstants.black40,
                              hintText: "Mobile Number",
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.done,
                              controller: provider.addCoParentMobileController,
                              maxLength: provider.maxLength,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter mobile number';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (!widget.isAddCoParent) ...[
                    Container(
                      margin: EdgeInsets.only(
                        top: Responsive.height * 3,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const commonTextWidget(
                            color: AppConstants.black,
                            text: "Select Pet",
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          SizeBoxH(Responsive.height * 1),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.only(left: 8, right: 8),
                                margin: const EdgeInsets.only(
                                  right: 10,
                                ),
                                decoration: const BoxDecoration(
                                    color: AppConstants.greyContainerBg,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(100))),
                                child: Consumer<EditController>(
                                  builder: (context, petModelList, child) =>
                                      SizedBox(
                                    width: petModelList
                                                .petWithoutTempParentModelStatus ==
                                            0
                                        ? 20
                                        : Responsive.width * 65,
                                    child: petModelList
                                                .petWithoutTempParentModelStatus ==
                                            0
                                        ? const Center(
                                            child: CircularProgressIndicator())
                                        : petModelList
                                                .petWithoutTempParentModelList
                                                .isEmpty
                                            ? const Padding(
                                                padding: EdgeInsets.symmetric(
                                                  vertical: 12.0,
                                                ),
                                                child: Text("No Pets"),
                                              )
                                            : DropdownButtonFormField<TempPet>(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                icon: const Icon(
                                                    Icons.arrow_drop_down),
                                                dropdownColor:
                                                    AppConstants.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                decoration:
                                                    const InputDecoration(
                                                  border: InputBorder.none,
                                                ),
                                                value: petModelList
                                                            .selectedPet ==
                                                        null
                                                    ? null
                                                    : petModelList
                                                        .petWithoutTempParentModelList
                                                        .firstWhere((element) =>
                                                            element.name ==
                                                            petModelList
                                                                .selectedPet),
                                                hint: const Text(
                                                  "Select pet",
                                                  style: TextStyle(
                                                    color: AppConstants.black40,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                items: petModelList
                                                    .petWithoutTempParentModelList
                                                    .map(
                                                      (label) =>
                                                          DropdownMenuItem(
                                                        value: label,
                                                        child: commonTextWidget(
                                                            text: label.name ??
                                                                "",
                                                            color: AppConstants
                                                                .black,
                                                            fontSize: Responsive
                                                                    .text *
                                                                1.6),
                                                      ),
                                                    )
                                                    .toList(),
                                                onChanged: (value) {
                                                  context
                                                      .read<EditController>()
                                                      .selectPetFun(value);
                                                },
                                                onSaved: (newValue) {
                                                  context
                                                      .read<EditController>()
                                                      .selectPetFun(newValue);
                                                },
                                              ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: CommonInkwell(
                                  onTap: () {
                                    if (context
                                        .read<EditController>()
                                        .petWithoutTempParentModelList
                                        .isEmpty) {
                                      toast(context,
                                          title: "No pets available",
                                          backgroundColor: Colors.red);
                                    } else {
                                      context
                                          .read<EditController>()
                                          .addPetForTempAccessFun(true);
                                    }
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: AppConstants.appPrimaryColor,
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    height: 40,
                                    width: 80,
                                    child: const Center(
                                      child: commonTextWidget(
                                        color: AppConstants.white,
                                        text: "Add Pet",
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Consumer<EditController>(
                      builder: (context, value, child) => ListView.builder(
                        itemCount: value.selectedPetListForTempAccess.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final data =
                              value.selectedPetListForTempAccess[index];
                          return ListTile(
                            title: Text(data.name ?? ""),
                            trailing: IconButton(
                              onPressed: () {
                                value.selectPetFun(data);
                                value.addPetForTempAccessFun(false);
                              },
                              icon: const Icon(Icons.delete),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                  SizeBoxH(Responsive.height * 4),
                  CommonButton(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          if (widget.isAddCoParent) {
                            context
                                .read<EditController>()
                                .addCoParentFun(context: context);
                          } else {
                            if (context
                                .read<EditController>()
                                .selectedPetList
                                .isEmpty) {
                              toast(context,
                                  title: "Please add pet.",
                                  backgroundColor: Colors.red);
                            } else {
                              context
                                  .read<EditController>()
                                  .addTemporaryAccessFun(context: context);
                            }
                          }
                        }
                      },
                      isFullRoundedButton: true,
                      text: "Save Profile",
                      size: 15,
                      width: Responsive.width * 100,
                      height: 50)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

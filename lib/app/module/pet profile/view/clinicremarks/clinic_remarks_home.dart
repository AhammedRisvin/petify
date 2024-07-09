import 'package:clan_of_pets/app/helpers/size_box.dart';
import 'package:clan_of_pets/app/utils/app_images.dart';
import 'package:clan_of_pets/app/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../helpers/common_widget.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_router.dart';
import '../../view model/pet_profile_provider.dart';
import 'grooming_history_details_screen.dart';
import 'medical_history_details_screen.dart';
import 'widget/clinic_remarks_common_gridview_widget.dart';
import 'widget/service_history-selecting_widget.dart';

class GroomingHistoryScreen extends StatelessWidget {
  const GroomingHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.white,
      appBar: AppBar(
        backgroundColor: AppConstants.white,
        title: const commonTextWidget(
          text: "Clinic Remarks",
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
      body: Consumer<PetProfileProvider>(
        builder: (context, obj, child) => Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                width: Responsive.width * 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage(
                      AppImages.gromingBankroundImage,
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    top: Responsive.height * 4,
                    left: 20,
                    bottom: 15,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const commonTextWidget(
                        color: Colors.white,
                        text: 'CLINIC REMARKS',
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                      SizeBoxH(
                        Responsive.height * 1,
                      ),
                      SizedBox(
                        width: Responsive.width * 60,
                        child: commonTextWidget(
                          color: Colors.white.withOpacity(0.6),
                          text:
                              'Lorem Ipsum is simply dummy text of the printing Lorem Ipsum the printing and typesetting industry',
                          fontWeight: FontWeight.w400,
                          fontSize: 8,
                          align: TextAlign.start,
                        ),
                      ),
                      SizeBoxH(
                        Responsive.height * 1,
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          top: 5,
                        ),
                        height: Responsive.height * 3,
                        padding: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                        ),
                        decoration: BoxDecoration(
                            color: const Color(0xffFABA9E),
                            borderRadius: BorderRadius.circular(40)),
                        child: DropdownButton<String>(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          dropdownColor: const Color(0xffFABA9E),
                          icon: const Icon(
                            Icons.keyboard_arrow_down_sharp,
                            color: Colors.white,
                            size: 18,
                          ),
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: GoogleFonts.roboto().fontFamily,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                          value: obj.dropDownValue,
                          onChanged: (value) {
                            obj.dropDownFnc(value: value);
                          },
                          items: obj.dropDownlist
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              if (obj.dropDownValue == 'Medical History') ...[
                Column(
                  children: [
                    SizeBoxH(Responsive.height * 2.5),
                    Row(
                      children: [
                        Expanded(
                          child: TabContainerWidget(
                            title: 'Medical Profile',
                            provider: obj,
                          ),
                        ),
                        const SizeBoxV(15),
                        Expanded(
                          child: TabContainerWidget(
                            title: 'Medical History',
                            provider: obj,
                          ),
                        ),
                      ],
                    ),
                    SizeBoxH(Responsive.height * 2.5),
                    if (obj.selectedMedicalService == 'Medical History') ...[
                      GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 4,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: Responsive.height * 0.14,
                            crossAxisSpacing: 28,
                            mainAxisSpacing: 18,
                            crossAxisCount: 2),
                        itemBuilder: (context, index) {
                          return CommonInkwell(
                              onTap: () {
                                Routes.push(
                                  context: context,
                                  screen: const MedicalHistoryDetailsScreen(),
                                  exit: () {},
                                );
                              },
                              child: const ClinicRemarksCommonGridviewWidget());
                        },
                      ),
                    ],
                    if (obj.selectedMedicalService == 'Medical Profile') ...[
                      const Row(
                        children: [
                          Expanded(
                            child: MedicalProfileWidget(
                              image: 'assets/images/vaccineSyringe.png',
                              text: 'Vaccination status',
                              value: 'Vaccinated',
                            ),
                          ),
                          SizeBoxV(10),
                          Expanded(
                            child: MedicalProfileWidget(
                              image: 'assets/images/allergyIcon.png',
                              text: 'Allergies',
                              value: 'No',
                            ),
                          ),
                          SizeBoxV(10),
                          Expanded(
                            child: MedicalProfileWidget(
                              image: 'assets/images/sprayedIcon.png',
                              text: 'Spayed / Neutered',
                              value: 'Yes',
                            ),
                          ),
                        ],
                      )
                    ]
                  ],
                ),
              ],
              if (obj.dropDownValue == 'Grooming History') ...[
                Column(
                  children: [
                    SizeBoxH(Responsive.height * 2.5),
                    GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 4,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: Responsive.height * 0.14,
                          crossAxisSpacing: 28,
                          mainAxisSpacing: 18,
                          crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        return CommonInkwell(
                            onTap: () {
                              Routes.push(
                                  screen: const GroomingHistoryDetailsScreen(),
                                  exit: () {},
                                  context: context);
                            },
                            child: const ClinicRemarksCommonGridviewWidget());
                      },
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class MedicalProfileWidget extends StatelessWidget {
  const MedicalProfileWidget({
    super.key,
    required this.text,
    required this.value,
    required this.image,
  });
  final String text;
  final String value;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Responsive.height * 6,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppConstants.black10,
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 5,
      ),
      child: Row(
        children: [
          Image.asset(
            image,
            height: 15,
          ),
          const SizeBoxV(10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizeBoxH(7),
              commonTextWidget(
                color: AppConstants.black,
                text: text,
                fontWeight: FontWeight.w400,
                fontSize: 8,
                letterSpacing: 0.1,
              ),
              commonTextWidget(
                align: TextAlign.start,
                color: AppConstants.black,
                text: value,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ],
          )
        ],
      ),
    );
  }
}

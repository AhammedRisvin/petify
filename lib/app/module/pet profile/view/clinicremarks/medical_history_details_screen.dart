import 'package:clan_of_pets/app/module/pet%20profile/view%20model/pet_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../helpers/common_widget.dart';
import '../../../../helpers/size_box.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_router.dart';
import '../../../../utils/extensions.dart';
import 'widget/diagnosis_content_widget.dart';
import 'widget/info_content_widget.dart';
import 'widget/prescription_content_widget.dart';

class MedicalHistoryDetailsScreen extends StatelessWidget {
  const MedicalHistoryDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.white,
      body: Consumer<PetProfileProvider>(
        builder: (context, value, child) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: Responsive.height * 41,
                  width: Responsive.width * 100,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        "https://img.freepik.com/free-photo/veterinarian-check-ing-puppy-s-health_23-2148728396.jpg?w=826&t=st=1713440289~exp=1713440889~hmac=70c75254f6d4291150a644cd51482cd06a8ec3e81a86934be0b2f308bacc7d2c",
                      ),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                ),
                Container(
                  height: Responsive.height * 41,
                  width: Responsive.width * 100,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.white.withOpacity(0.7),
                      ],
                      stops: const [
                        0.7,
                        1.0
                      ], // Adjust these values to control the fade effect
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CommonContainerWidget(
                        title: "Info",
                        provider: value,
                      ),
                      const SizeBoxV(5),
                      CommonContainerWidget(
                        title: "Diagnosis",
                        provider: value,
                      ),
                      const SizeBoxV(5),
                      CommonContainerWidget(
                        title: "Prescription",
                        provider: value,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: Responsive.height * 3,
                  left: Responsive.width * 5,
                  child: Row(
                    children: [
                      IconButton(
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
                      SizeBoxV(Responsive.width * 2),
                      commonTextWidget(
                        text: value.selectedServiceDetailedOption,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppConstants.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizeBoxH(20),
            Expanded(
              child: SingleChildScrollView(
                physics: const ScrollPhysics(),
                child: _buildSelectedContent(value),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectedContent(PetProfileProvider provider) {
    switch (provider.selectedServiceDetailedOption) {
      case 'Info':
        return _buildInfoContent(provider);
      case 'Diagnosis':
        return _buildDiagnosisContent(provider);
      case 'Prescription':
        return _buildPrescriptionContent(provider);
      default:
        return _buildInfoContent(provider);
    }
  }

  Widget _buildInfoContent(PetProfileProvider value) {
    return BuildInfoContentWidget(
      value: value,
    );
  }

  Widget _buildDiagnosisContent(PetProfileProvider value) {
    return DiagnosisContentWidget(
      value: value,
    );
  }

  Widget _buildPrescriptionContent(PetProfileProvider value) {
    return PrescriptionContentWidget(
      value: value,
    );
  }
}

class CommonContainerWidget extends StatelessWidget {
  const CommonContainerWidget({
    super.key,
    required this.title,
    required this.provider,
  });

  final String title;
  final PetProfileProvider provider;

  @override
  Widget build(BuildContext context) {
    final selected = provider.selectedServiceDetailedOption == title;
    return CommonInkwell(
      onTap: () {
        provider.updateServiceDetailedOption(title);
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: Responsive.height * 1,
          horizontal: Responsive.width * 6,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: selected
              ? AppConstants.appPrimaryColor
              : AppConstants.appPrimaryColor.withOpacity(0.3),
        ),
        child: Center(
          child: commonTextWidget(
            color: selected
                ? AppConstants.white
                : AppConstants.white.withOpacity(0.3),
            text: title,
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}

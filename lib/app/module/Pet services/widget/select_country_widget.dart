import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';

import '../../../helpers/common_widget.dart';
import '../../../helpers/size_box.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/extensions.dart';
import '../view_model/services_provider.dart';

class SelectCountryWidget extends StatelessWidget {
  const SelectCountryWidget({
    super.key,
    required this.provider,
  });

  final ServiceProvider provider;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const commonTextWidget(
          text: "Destination Country",
          color: AppConstants.black,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        const SizeBoxH(10),
        Transform.scale(
          scale: 1.15,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Responsive.width * 6),
            child: CSCPicker(
              showCities: false,
              showStates: false,
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
              searchBarRadius: 50,
              defaultCountry: CscCountry.India,
              countryDropdownLabel: "Destination country",
              onCountryChanged: (value) {
                provider.setCountry(value);
              },
            ),
          ),
        ),
        const SizeBoxH(10),
      ],
    );
  }
}

import 'package:flutter/material.dart';

import '../../../helpers/common_widget.dart';
import '../../../helpers/size_box.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_images.dart';
import '../../../utils/extensions.dart';
import '../view_model/services_provider.dart';

class PetSizeSelectingDropDownWidget extends StatelessWidget {
  const PetSizeSelectingDropDownWidget({
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
          color: AppConstants.black,
          text: "Approximate Pet Size",
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        const SizeBoxH(10),
        Container(
          height: Responsive.height * 6,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: AppConstants.greyContainerBg,
          ),
          child: DropdownButtonFormField<String>(
            dropdownColor: AppConstants.greyContainerBg,
            borderRadius: BorderRadius.circular(10),
            decoration: const InputDecoration(border: InputBorder.none),
            value: provider.selectedSize,
            icon: const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: AppConstants.black40,
            ),
            hint: Row(
              children: [
                Image.asset(AppImages.petPawIcon,
                    height: Responsive.height * 2),
                const SizeBoxV(10),
                const commonTextWidget(
                  color: AppConstants.black,
                  text: 'Select Size',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
            items:
                provider.petSizes.map<DropdownMenuItem<String>>((String name) {
              return DropdownMenuItem<String>(
                value: name,
                child: commonTextWidget(
                  color: AppConstants.black,
                  text: name,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              provider.setSelectedSize(newValue);
            },
          ),
        ),
      ],
    );
  }
}

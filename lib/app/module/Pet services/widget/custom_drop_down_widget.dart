import 'package:clan_of_pets/app/module/Pet%20services/model/pet_slot_model.dart';
import 'package:flutter/material.dart';

import '../../../helpers/common_widget.dart';
import '../../../helpers/size_box.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_images.dart';
import '../../../utils/extensions.dart';
import '../view_model/services_provider.dart';

class CustomDropDownWidget extends StatelessWidget {
  final ServiceProvider provider;
  final FormDatum formData;
  final int dropDownIndex;
  final String? Function(String?)? validator;

  const CustomDropDownWidget({
    super.key,
    required this.provider,
    required this.formData,
    required this.dropDownIndex,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizeBoxH(10),
        commonTextWidget(
          color: AppConstants.black,
          text: formData.label ?? '',
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        const SizeBoxH(10),
        Container(
          height: Responsive.height * 6,
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: AppConstants.greyContainerBg,
          ),
          child: DropdownButtonFormField<String>(
            validator: validator,
            dropdownColor: AppConstants.greyContainerBg,
            borderRadius: BorderRadius.circular(10),
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
            value: provider.dropdownValues[formData.label ?? ""],
            hint: Row(
              children: [
                Image.asset(
                  AppImages.petPawIcon,
                  height: Responsive.height * 2,
                ),
                const SizeBoxV(10),
                Text(
                  formData.instruction ?? '',
                  style: const TextStyle(
                    color: AppConstants.black40,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            items:
                formData.choices?.map<DropdownMenuItem<String>>((String name) {
              return DropdownMenuItem<String>(
                value: name,
                child: Text(name),
              );
            }).toList(),
            onChanged: (String? newValue) {
              provider.setSelectedDropdownValue(
                formData.label ?? "",
                newValue ?? '',
              );
            },
          ),
        ),
        const SizeBoxH(10),
      ],
    );
  }
}

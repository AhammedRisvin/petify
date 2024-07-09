import 'package:clan_of_pets/app/module/Pet%20services/model/pet_slot_model.dart';
import 'package:flutter/material.dart';

import '../../../helpers/common_widget.dart';
import '../../../helpers/size_box.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_images.dart';
import '../../../utils/extensions.dart';
import '../view_model/services_provider.dart';

class SelectPetWidget extends StatelessWidget {
  const SelectPetWidget({
    super.key,
    required this.provider,
    this.petList,
    this.validator,
  });

  final ServiceProvider provider;
  final List<Pet>? petList;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizeBoxH(10),
        const commonTextWidget(
          color: AppConstants.black,
          text: "Select pet here",
          fontSize: 14,
          fontWeight: FontWeight.w600,
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
            icon: const Icon(
              Icons.keyboard_arrow_down_rounded,
            ),
            hint: Row(
              children: [
                Image.asset(
                  AppImages.petPawIcon,
                  height: Responsive.height * 2,
                ),
                const SizeBoxV(10),
                const Text(
                  "Select Pet here",
                  style: TextStyle(
                    color: AppConstants.black40,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            items: petList?.map<DropdownMenuItem<String>>((Pet pet) {
              return DropdownMenuItem<String>(
                value: pet.id,
                child: Text(pet.name ?? ''),
              );
            }).toList(),
            value: provider.selectedPet == null ||
                    petList?.any((pet) => pet.id == provider.selectedPet) !=
                        true
                ? null
                : provider.selectedPet,
            onChanged: (String? newValue) {
              provider.setSelectedPet(newValue ?? '');
            },
          ),
        ),
        const SizeBoxH(10),
      ],
    );
  }
}

import 'package:flutter/material.dart';

import '../../../../../helpers/common_widget.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../../utils/extensions.dart';
import '../../../view model/pet_profile_provider.dart';

class TabContainerWidget extends StatelessWidget {
  const TabContainerWidget({
    super.key,
    required this.title,
    required this.provider,
  });
  final String title;
  final PetProfileProvider provider;

  @override
  Widget build(BuildContext context) {
    final selected = provider.selectedMedicalService == title;
    return CommonInkwell(
      onTap: () {
        provider.updateMedicalHistoryService(title);
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: Responsive.height * 1.2,
          horizontal: Responsive.width * 2,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color:
              selected ? AppConstants.appPrimaryColor : const Color(0xffF3F3F5),
        ),
        child: Center(
          child: commonTextWidget(
            color: selected ? Colors.white : AppConstants.black,
            text: title,
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../../../helpers/common_widget.dart';
import '../../../helpers/size_box.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/extensions.dart';
import '../model/pet_slot_model.dart';
import '../view_model/services_provider.dart';

class CustomCheckboxWidget extends StatelessWidget {
  const CustomCheckboxWidget({
    super.key,
    required this.index,
    required this.valueText,
    this.onTap,
    required this.section,
    required this.selectedValues,
    required this.provider,
  });
  final void Function()? onTap;
  final int index;
  final List<String> selectedValues;
  final ServiceProvider provider;
  final String valueText;
  final String section;

  @override
  Widget build(BuildContext context) {
    return CommonInkwell(
      onTap: () {
        provider.toggleValueCheckboxFn(section, valueText);
      },
      child: Row(
        children: [
          Container(
            width: Responsive.height * 3,
            height: Responsive.height * 3,
            decoration: BoxDecoration(
              color: selectedValues.contains(valueText)
                  ? AppConstants.appPrimaryColor
                  : AppConstants.transparent,
              border: Border.all(color: AppConstants.appPrimaryColor),
              borderRadius:
                  BorderRadius.circular(4), // Rectangular with rounded corners
            ),
            child: selectedValues.contains(valueText)
                ? Icon(
                    Icons.check,
                    color: Colors.white,
                    size: Responsive.height * 2.3,
                  )
                : null,
          ),
          const SizeBoxV(10),
          commonTextWidget(
            color: AppConstants.black,
            text: valueText,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }
}

class CheckboxListWidget extends StatelessWidget {
  final ServiceProvider provider;
  final FormDatum formData;

  const CheckboxListWidget({
    super.key,
    required this.provider,
    required this.formData,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
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
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final choices = formData.choices?[index];
            return CustomCheckboxWidget(
              section: formData.label ?? '',
              provider: provider,
              index: index,
              valueText: choices ?? '',
              selectedValues: provider.getSelectedValues(formData.label ?? ''),
            );
          },
          separatorBuilder: (context, index) => const SizeBoxH(10),
          itemCount: formData.choices?.length ?? 0,
        ),
        const SizeBoxH(10),
      ],
    );
  }
}

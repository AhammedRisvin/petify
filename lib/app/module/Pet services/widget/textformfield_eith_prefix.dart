import 'package:flutter/material.dart';

import '../../../helpers/common_widget.dart';
import '../../../helpers/size_box.dart';
import '../../../utils/app_constants.dart';

class TextFormFieldWithPrefix extends StatelessWidget {
  const TextFormFieldWithPrefix(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.title,
      required this.keyboardType,
      required this.textInputAction,
      this.prefixIcon,
      this.validator,
      this.suffixIcon,
      this.isFromLocation = false
      // this.maxLength = 10,
      });

  final TextEditingController controller;
  final String hintText;
  final String title;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final bool isFromLocation;
  // final int maxLength;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        isFromLocation
            ? Row(
                children: [
                  commonTextWidget(
                    color: AppConstants.black,
                    text: title,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  const commonTextWidget(
                    color: AppConstants.black40,
                    text: " (optional)",
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              )
            : commonTextWidget(
                color: AppConstants.black,
                text: title,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
        const SizeBoxH(10),
        CommonTextFormField(
          bgColor: AppConstants.greyContainerBg,
          hintText: hintText,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          controller: controller,
          prefixIcon: prefixIcon,
          validator: validator,
          suffixIcon: suffixIcon,
          // maxLength: maxLength,
        ),
        const SizeBoxH(10),
      ],
    );
  }
}

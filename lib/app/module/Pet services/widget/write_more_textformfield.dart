import 'package:clan_of_pets/app/module/Pet%20services/view_model/services_provider.dart';
import 'package:flutter/material.dart';

import '../../../helpers/common_widget.dart';
import '../../../helpers/size_box.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/extensions.dart';

class WriteMoreTextFormFieldWidget extends StatelessWidget {
  const WriteMoreTextFormFieldWidget({
    super.key,
    required this.provider,
    required this.controller,
    this.validator,
  });

  final TextEditingController controller;
  final ServiceProvider provider;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizeBoxH(10),
        const commonTextWidget(
          color: AppConstants.black,
          text: 'Anything else the provider needs to know ?',
          fontSize: 16,
          fontWeight: FontWeight.w500,
          letterSpacing: -0.1,
        ),
        SizeBoxH(Responsive.height * 2),
        TextFormField(
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
          controller: controller,
          maxLines: null,
          minLines: 5,
          keyboardType: TextInputType.multiline,
          textInputAction: TextInputAction.done,
          style: const TextStyle(
            color: AppConstants.black,
            fontSize: 12,
          ),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide.none,
            ),
            fillColor: AppConstants.greyContainerBg,
            filled: true,
            hintText: 'Anything else the provider needs to know ?',
            hintStyle: const TextStyle(
              color: AppConstants.subTextGrey,
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          ),
          validator: validator,
        ),
        const SizeBoxH(10),
      ],
    );
  }
}

// ignore_for_file: deprecated_member_use

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../helpers/size_box.dart';
import '../../../utils/app_constants.dart';
import '../view_model/services_provider.dart';

class TermsAndConditionSelectWidget extends StatelessWidget {
  const TermsAndConditionSelectWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizeBoxH(25),
        Row(
          children: [
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                    text: 'I have agreed to the',
                    style: TextStyle(
                      color: AppConstants.black,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                  TextSpan(
                    recognizer: TapGestureRecognizer()..onTap = () {},
                    text: ' Terms & Condition',
                    style: const TextStyle(
                      color: AppConstants.appPrimaryColor,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ],
              ),
            ),
            const SizeBoxV(10),
            Selector<ServiceProvider, bool>(
              selector: (p0, p1) => p1.isAgree,
              builder: (context, value, child) => SizedBox(
                width: 20,
                height: 20,
                child: Checkbox(
                  side: MaterialStateBorderSide.resolveWith(
                    (states) => const BorderSide(
                      width: 1.0,
                      color: AppConstants.appPrimaryColor,
                    ),
                  ),
                  checkColor:
                      value ? AppConstants.white : const Color(0xffC1AE97),
                  activeColor: AppConstants.appPrimaryColor,
                  focusColor: AppConstants.appPrimaryColor,
                  fillColor: MaterialStateProperty.all(value
                      ? AppConstants.appPrimaryColor
                      : AppConstants.white),
                  value: value,
                  shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Color(0xFFC4C4C4)),
                      borderRadius: BorderRadius.circular(3)),
                  onChanged: (bool? value) {
                    context
                        .read<ServiceProvider>()
                        .agreeTermsNCondition(value!);
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

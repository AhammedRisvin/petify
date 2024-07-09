import 'package:flutter/material.dart';

import '../../helpers/common_widget.dart';
import '../../utils/app_constants.dart';
import '../../utils/app_router.dart';
import '../../utils/extensions.dart';

class ConfirmationWidget extends StatelessWidget {
  final String title;
  final String message;
  final String image;
  final void Function() onTap;
  const ConfirmationWidget({
    super.key,
    required this.title,
    required this.message,
    required this.onTap,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: Container(
        height: Responsive.height * 40,
        width: Responsive.width * 90,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppConstants.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              image,
              height: Responsive.height * 20,
              width: Responsive.width * 40,
            ),
            commonTextWidget(
              text: title,
              color: AppConstants.black,
              fontSize: 20,
              fontWeight: FontWeight.w700,
              // letterSpacing: 1.5,
            ),
            commonTextWidget(
              text: message,
              color: AppConstants.black,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              align: TextAlign.center,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AlertDialogButtonWidget(
                  onTap: onTap,
                  text: "Yes",
                  buttonBgColor: AppConstants.appPrimaryColor,
                  buttonBorderColor: AppConstants.white,
                  textColor: AppConstants.white,
                ),
                AlertDialogButtonWidget(
                  onTap: () {
                    Routes.back(context: context);
                  },
                  text: "No",
                  buttonBgColor: AppConstants.white,
                  buttonBorderColor: AppConstants.white,
                  textColor: AppConstants.appPrimaryColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AlertDialogButtonWidget extends StatelessWidget {
  final void Function() onTap;
  final Color buttonBgColor;
  final Color buttonBorderColor;
  final Color textColor;
  final String text;
  const AlertDialogButtonWidget({
    super.key,
    required this.onTap,
    required this.buttonBgColor,
    required this.buttonBorderColor,
    required this.textColor,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Container(
        height: Responsive.height * 5,
        width: Responsive.width * 30,
        decoration: BoxDecoration(
          color: buttonBgColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: AppConstants.appPrimaryColor,
            width: 1,
          ),
        ),
        child: Center(
          child: commonTextWidget(
            color: textColor,
            text: text,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

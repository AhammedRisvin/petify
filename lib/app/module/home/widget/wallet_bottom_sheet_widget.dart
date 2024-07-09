import 'package:flutter/material.dart';

import '../../../helpers/common_widget.dart';
import '../../../helpers/size_box.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/extensions.dart';

class WalletBottomSheetWidget extends StatelessWidget {
  const WalletBottomSheetWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Container(
          decoration: const BoxDecoration(
            color: AppConstants.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          padding: EdgeInsets.only(
            left: Responsive.width * 5,
            right: Responsive.width * 5,
            top: Responsive.height * 2,
            bottom: Responsive.height * 2,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const commonTextWidget(
                text: "Withdraw",
                color: AppConstants.black,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              SizeBoxH(Responsive.height * 2),
              WalletCommonTextFieldWithHeading(
                title: "Enter Amount",
                hintText: "Enter Amount",
                keyboardType: TextInputType.number,
                controller: TextEditingController(),
                textInputAction: TextInputAction.next,
              ),
              SizeBoxH(Responsive.height * 1.5),
              WalletCommonTextFieldWithHeading(
                title: "Bank Account Number",
                hintText: "Bank Account Number",
                keyboardType: TextInputType.number,
                controller: TextEditingController(),
                textInputAction: TextInputAction.next,
              ),
              SizeBoxH(Responsive.height * 1.5),
              WalletCommonTextFieldWithHeading(
                title: "Re - enter Bank Account Number",
                hintText: "Re - enter Bank Account Number",
                keyboardType: TextInputType.number,
                controller: TextEditingController(),
                textInputAction: TextInputAction.next,
              ),
              SizeBoxH(Responsive.height * 1.5),
              WalletCommonTextFieldWithHeading(
                title: "Bank Name",
                hintText: "Bank Name",
                keyboardType: TextInputType.number,
                controller: TextEditingController(),
                textInputAction: TextInputAction.next,
              ),
              SizeBoxH(Responsive.height * 1.5),
              WalletCommonTextFieldWithHeading(
                title: "iban",
                hintText: "iban",
                keyboardType: TextInputType.number,
                controller: TextEditingController(),
                textInputAction: TextInputAction.next,
              ),
              SizeBoxH(Responsive.height * 2),
              CommonButton(
                onTap: () {},
                text: "Withdraw",
                width: Responsive.width * 100,
                height: Responsive.height * 6,
                size: 15,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class WalletCommonTextFieldWithHeading extends StatelessWidget {
  const WalletCommonTextFieldWithHeading({
    super.key,
    required this.title,
    required this.hintText,
    required this.keyboardType,
    required this.controller,
    required this.textInputAction,
  });
  final String title;
  final String hintText;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final TextInputAction textInputAction;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        commonTextWidget(
          text: title,
          color: AppConstants.black,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        SizeBoxH(Responsive.height * 1),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppConstants.appPrimaryColor),
          ),
          child: CommonTextFormField(
            bgColor: AppConstants.transparent,
            hintText: hintText,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            controller: controller,
            isFromChat: true,
          ),
        ),
      ],
    );
  }
}

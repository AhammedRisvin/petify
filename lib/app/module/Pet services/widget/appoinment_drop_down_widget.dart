// ignore_for_file: deprecated_member_use

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../helpers/common_widget.dart';
import '../../../helpers/size_box.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/extensions.dart';
import '../view_model/services_provider.dart';

class AppoinmentDropDownWidget extends StatelessWidget {
  const AppoinmentDropDownWidget({
    super.key,
    required this.provider,
    this.isFromGrooming = false,
  });

  final ServiceProvider provider;
  final bool isFromGrooming;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizeBoxH(25),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            isFromGrooming
                ? const commonTextWidget(
                    color: AppConstants.black,
                    text: "Preferred Time For Appoinment",
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    letterSpacing: -0.1,
                  )
                : Row(
                    children: [
                      FromToSelectingContainer(
                        provider: provider,
                        title: "From",
                        value: true,
                      ),
                      SizeBoxV(Responsive.width * 2),
                      FromToSelectingContainer(
                        provider: provider,
                        title: "To",
                        value: false,
                      ),
                    ],
                  ),
            Container(
              height: Responsive.height * 5,
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: const Color(0xffEE5158),
              ),
              child: CustomDropdownButtonWidget(
                hintText: 'Select month',
                items: provider.month,
                value: provider.selectedMonth,
                onChanged: (String? value) {
                  provider.setSelectedMonth(value ?? '');
                },
                iconColor: AppConstants.white,
                iconWidth: Responsive.width * 4,
                iconHeight: Responsive.height * 2,
                buttonWidth: Responsive.width * 25,
                buttonHeight: Responsive.height * 2,
                dropdWidth: Responsive.width * 35,
                dropdHeight: Responsive.height * 20,
                isbuttonRadiusChange: false,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class FromToSelectingContainer extends StatelessWidget {
  const FromToSelectingContainer({
    super.key,
    required this.provider,
    required this.title,
    required this.value,
  });

  final ServiceProvider provider;
  final String title;
  final bool value;

  @override
  Widget build(BuildContext context) {
    return Consumer<ServiceProvider>(
      builder: (context, provider, child) => CommonInkwell(
        onTap: () {
          provider.setSelectedContainer(title);
        },
        child: Container(
          width: Responsive.width * 25,
          height: Responsive.height * 5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: provider.selectedContainer == title
                ? AppConstants.appPrimaryColor
                : AppConstants.greyContainerBg,
          ),
          child: Center(
            child: commonTextWidget(
              color: AppConstants.white,
              text: title,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}

class CustomDropdownButtonWidget extends StatelessWidget {
  final String? hintText;
  final List<String> items;
  final String value;
  final void Function(String?)? onChanged;
  final Color iconColor;
  final double? iconWidth;
  final double? iconHeight;
  final double? buttonWidth;
  final double? buttonHeight;
  final double? dropdWidth;
  final double? dropdHeight;
  final bool? isbuttonRadiusChange;
  final Color? color;
  final void Function()? onItemTap;
  const CustomDropdownButtonWidget({
    super.key,
    this.hintText,
    required this.items,
    required this.value,
    this.onChanged,
    required this.iconColor,
    this.iconWidth,
    this.iconHeight,
    this.buttonWidth,
    this.buttonHeight,
    this.dropdWidth,
    this.dropdHeight,
    this.isbuttonRadiusChange,
    this.onItemTap,
    this.color = const Color(0xffEE5158),
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        hint: commonTextWidget(
          color: AppConstants.white,
          text: hintText ?? '',
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
        items: items
            .map((String item) => DropdownMenuItem<String>(
                  onTap: onItemTap,
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ))
            .toList(),
        value: value,
        onChanged: onChanged,
        buttonStyleData: ButtonStyleData(
          height: buttonHeight,
          width: buttonWidth,
          padding: const EdgeInsets.only(left: 4, right: 4),
          decoration: BoxDecoration(
            borderRadius: isbuttonRadiusChange == false
                ? BorderRadius.circular(20)
                : const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
            color: color,
          ),
          elevation: 0,
        ),
        iconStyleData: const IconStyleData(
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: AppConstants.white,
          ),
        ),
        dropdownStyleData: DropdownStyleData(
          elevation: 0,
          padding: const EdgeInsets.only(bottom: 10, top: 5),
          maxHeight: dropdHeight,
          width: dropdWidth,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)),
            color: color,
          ),
          offset: const Offset(-0, 0),
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(0),
            thickness: MaterialStateProperty.all(0),
            thumbVisibility: MaterialStateProperty.all(true),
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 25,
          padding: EdgeInsets.only(
            left: 8,
            right: 8,
          ),
        ),
        style: TextStyle(
          letterSpacing: 0.5,
          fontWeight: FontWeight.w300,
          fontSize: 10,
          color: AppConstants.white,
          fontFamily: GoogleFonts.roboto().fontFamily,
        ),
      ),
    );
  }
}

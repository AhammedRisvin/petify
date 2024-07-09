import 'package:flutter/material.dart';

import '../../helpers/common_widget.dart';
import '../../utils/app_constants.dart';
import '../../utils/extensions.dart';

class EmptyScreenWidget extends StatelessWidget {
  final String text;
  final String image;
  final double? height;
  const EmptyScreenWidget(
      {super.key,
      required this.text,
      required this.image,
      required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: Responsive.width * 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            height: Responsive.height * 25,
            width: Responsive.width * 25,
          ),
          // const SizeBoxH(10),
          commonTextWidget(
            color: AppConstants.subTextGrey,
            text: text,
            align: TextAlign.center,
            fontSize: 12,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5,
            wordSpacing: 0.5,
          )
        ],
      ),
    );
  }
}

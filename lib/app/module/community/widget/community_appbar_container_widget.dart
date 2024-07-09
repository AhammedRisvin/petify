import 'package:flutter/material.dart';

import '../../../helpers/common_widget.dart';
import '../../../helpers/size_box.dart';
import '../../../utils/app_constants.dart';

class CommunityAppBarContainer extends StatelessWidget {
  final String? title;
  final String? icon;
  final double? width;
  final double? fontSize;
  final void Function() onTap;
  const CommunityAppBarContainer({
    super.key,
    this.width = 80,
    this.title,
    this.icon,
    this.fontSize = 12,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CommonInkwell(
      onTap: onTap,
      child: Container(
        height: 30,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color: AppConstants.appPrimaryColor,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              icon ?? '',
              height: 12,
            ),
            const SizeBoxV(3),
            commonTextWidget(
              color: AppConstants.appPrimaryColor,
              text: title ?? "",
              fontSize: fontSize ?? 12,
            )
          ],
        ),
      ),
    );
  }
}

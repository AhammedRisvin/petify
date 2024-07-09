import 'package:flutter/material.dart';

import '../../../../../helpers/common_widget.dart';
import '../../../../../helpers/size_box.dart';
import '../../../../../utils/app_constants.dart';

class CommunityDeatilsTabContainer extends StatelessWidget {
  const CommunityDeatilsTabContainer(
      {super.key,
      required this.title,
      required this.onTap,
      required this.index});
  final String title;
  final void Function() onTap;
  final int index;

  @override
  Widget build(BuildContext context) {
    return CommonInkwell(
      onTap: onTap,
      child: Container(
        width: 80,
        height: 32,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: AppConstants.appPrimaryColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            commonTextWidget(
              color: AppConstants.white,
              text: title,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            const SizeBoxV(5),
            const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizeBoxH(1),
                CircleAvatar(
                  backgroundColor: AppConstants.white,
                  radius: 3,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../helpers/common_widget.dart';
import '../../../helpers/size_box.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_images.dart';
import '../../../utils/extensions.dart';
import '../../home/view/home_screen.dart';

class PetProfileEmptyScreen extends StatelessWidget {
  final Function() onTap;
  const PetProfileEmptyScreen({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Responsive.height * 100,
      width: Responsive.width * 100,
      color: AppConstants.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizeBoxH(50),
          Image.asset(
            AppImages.petProfileEmptyGif,
            height: Responsive.height * 25,
          ),
          const SizeBoxH(10),
          const commonTextWidget(
            color: AppConstants.black,
            text: "No Pets",
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          const SizeBoxH(15),
          const commonTextWidget(
            color: AppConstants.black40,
            text: "Add your pet to get started",
            fontSize: 12,
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
          ),
          const SizeBoxH(30),
          CommonBannerButtonWidget(
            bgColor: AppConstants.appPrimaryColor,
            text: "Add New Pet",
            width: 120,
            borderColor: AppConstants.appPrimaryColor,
            textColor: AppConstants.white,
            onTap: onTap,
            radius: 8,
          ),
        ],
      ),
    );
  }
}

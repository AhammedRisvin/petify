import 'package:clan_of_pets/app/helpers/common_widget.dart';
import 'package:flutter/material.dart';

import '../../../utils/app_constants.dart';

class CommonGreyContainer extends StatelessWidget {
  final double height;
  final double imageHeight;
  final double width;
  final Color bgColor;
  final String image;
  final bool isLiked;
  final void Function()? onTap;
  final BorderRadiusGeometry? borderRadius;
  const CommonGreyContainer(
      {super.key,
      required this.height,
      required this.width,
      required this.imageHeight,
      this.bgColor = AppConstants.greyContainerBg,
      required this.image,
      this.borderRadius,
      this.onTap,
      this.isLiked = false});

  @override
  Widget build(BuildContext context) {
    return CommonInkwell(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          color: bgColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            isLiked == true
                ? const Icon(
                    Icons.favorite,
                    color: Colors.red,
                    size: 18,
                  )
                : Center(
                    child: Image.asset(
                      image,
                      height: imageHeight,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

import 'package:clan_of_pets/app/helpers/common_widget.dart';
import 'package:flutter/material.dart';

import '../../../utils/app_images.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String subtitle;
  final Color bgColor;
  final void Function() onTap;
  final bool isFromDrawer;
  final String image;
  final Color? color;

  const CustomAppBar({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.bgColor,
    this.isFromDrawer = false,
    required this.image,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CommonInkwell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              AppImages.signUpLogo,
              height: 40,
              width: 60,
              fit: BoxFit.cover,
              color: color,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

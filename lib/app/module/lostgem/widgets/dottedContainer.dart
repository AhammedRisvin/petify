// ignore_for_file: file_names

import 'package:clan_of_pets/app/helpers/common_widget.dart';
import 'package:clan_of_pets/app/module/lostgem/view_model/lostgem_provider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../helpers/size_box.dart';
import '../../../utils/app_images.dart';
import '../../../utils/extensions.dart';

class DottedContainer extends StatelessWidget {
  final void Function()? onTap;
  const DottedContainer({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    LostGemProvider provider = context.read<LostGemProvider>();
    return CommonInkwell(
      onTap: onTap,
      child: DottedBorder(
        dashPattern: const [6, 6, 6, 6],
        color: const Color(0xffF6884F),
        borderType: BorderType.RRect,
        strokeCap: StrokeCap.butt,
        radius: const Radius.circular(
          20,
        ),
        child: Container(
          width: Responsive.width * 100,
          height: Responsive.height * 20,
          decoration: const BoxDecoration(
            color: Color(0xffF3F3F5),
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AppImages.cloudIcon,
              ),
              SizeBoxH(
                Responsive.height * 2,
              ),
              commonTextWidget(
                color: Colors.black,
                text: provider.imageTitle ?? 'Identification with attach',
                fontWeight: FontWeight.w400,
                fontSize: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../../../helpers/common_widget.dart';
import '../../../../../helpers/size_box.dart';
import '../../../../../utils/app_images.dart';
import '../../../../../utils/extensions.dart';

class ClinicRemarksCommonGridviewWidget extends StatelessWidget {
  const ClinicRemarksCommonGridviewWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Color(0xffF3F3F5),
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          child: Column(
            children: [
              commonNetworkImage(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
                isBorder: true,
                url:
                    'https://t4.ftcdn.net/jpg/04/95/28/65/240_F_495286577_rpsT2Shmr6g81hOhGXALhxWOfx1vOQBa.jpg',
                height: Responsive.height * 11.5,
                width: Responsive.width * 100,
              ),
              SizeBoxH(Responsive.height * 0.3),
              Row(
                children: [
                  const SizeBoxV(10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const commonTextWidget(
                        color: Colors.black,
                        text: 'Paws & Tails',
                        fontWeight: FontWeight.w600,
                        fontSize: 11,
                      ),
                      SizeBoxH(Responsive.height * 0.6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            AppImages.locationImage,
                            height: 15,
                          ),
                          SizeBoxV(Responsive.width * 1),
                          const commonTextWidget(
                            color: Colors.grey,
                            text: 'Location',
                            fontWeight: FontWeight.w400,
                            fontSize: 10,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        const Positioned(
          right: 0,
          bottom: 0,
          child: CircleAvatar(
            radius: 18,
            backgroundColor: Color(0xffF5895A),
            child: Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
              size: 12,
            ),
          ),
        )
      ],
    );
  }
}

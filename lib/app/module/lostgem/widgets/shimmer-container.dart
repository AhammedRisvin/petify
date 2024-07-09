// ignore_for_file: file_names, use_full_hex_values_for_flutter_colors

import 'package:clan_of_pets/app/utils/app_router.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../helpers/common_widget.dart';
import '../../../helpers/size_box.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_images.dart';
import '../../../utils/extensions.dart';
import '../view/lost_pet_share_widget.dart';
import 'container_painter.dart';

class LostPetContainerShimmer extends StatelessWidget {
  final bool isFound;

  const LostPetContainerShimmer({
    this.isFound = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: Responsive.width * 100,
        decoration: BoxDecoration(
          color: const Color(0xffF3F3F5),
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Color(0x26000000),
              offset: Offset(0, 1),
              blurRadius: 4,
              spreadRadius: 0,
            )
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              right: 0,
              top: 0,
              child: CustomPaint(
                painter: isFound ? RPSCustomPainterWhite() : RPSCustomPainter(),
                size: Size(
                  Responsive.width * 55,
                  Responsive.height * 6,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 16,
                left: 10,
                right: 17,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizeBoxH(10),
                  Row(
                    children: [
                      commonNetworkImage(
                        isBorder: true,
                        borderRadius: BorderRadius.circular(16),
                        url: 'https://example.com/image.jpg',
                        height: Responsive.height * 15,
                        width: Responsive.width * 45,
                      ),
                      SizeBoxV(Responsive.width * 2),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizeBoxH(
                            Responsive.height * 3,
                          ),
                          const commonTextWidget(
                            text: "",
                            color: AppConstants.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          SizeBoxH(
                            Responsive.height * 1.4,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(
                                AppImages.locationImage,
                              ),
                              SizeBoxV(
                                Responsive.width * 1,
                              ),
                              const commonTextWidget(
                                color: Colors.grey,
                                text: '',
                                fontWeight: FontWeight.w400,
                                fontSize: 13,
                              ),
                            ],
                          ),
                          SizeBoxH(Responsive.height * 1.4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.phone,
                                size: 15,
                              ),
                              SizeBoxV(Responsive.width * 1),
                              const commonTextWidget(
                                color: Colors.grey,
                                text: '9928929723',
                                fontWeight: FontWeight.w400,
                                fontSize: 13,
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                  SizeBoxH(Responsive.height * 1.4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            AppImages.callenderImage,
                          ),
                          SizeBoxV(Responsive.width * 2),
                          const commonTextWidget(
                            color: Colors.grey,
                            text: '',
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                        ],
                      ),
                      isFound
                          ? CommonInkwell(
                              onTap: () {
                                Routes.push(
                                  context: context,
                                  screen: const LostPetShareWidget(
                                    pet: "",
                                  ),
                                  exit: () {},
                                );
                              },
                              child: Row(
                                children: [
                                  Image.asset(
                                    AppImages.dawnloadIcon,
                                  ),
                                  SizeBoxV(Responsive.width * 02),
                                  const commonTextWidget(
                                    color: Colors.grey,
                                    text: 'Download',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13,
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox.shrink(),
                      Row(
                        children: [
                          Image.asset(
                            AppImages.minusImage,
                          ),
                          SizeBoxV(Responsive.width * 02),
                          const commonTextWidget(
                            color: Colors.grey,
                            text: 'Report',
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                          ),
                        ],
                      ),
                      Container(
                        width: Responsive.width * 20,
                        height: Responsive.height * 3,
                        decoration: BoxDecoration(
                          color: isFound
                              ? const Color(0xff7D7A43)
                              : const Color(0xfffee5158),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: const commonTextWidget(
                          color: Colors.white,
                          text: "",
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

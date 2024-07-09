// ignore_for_file: use_full_hex_values_for_flutter_colors

import 'package:clan_of_pets/app/module/lostgem/view_model/lostgem_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../helpers/common_widget.dart';
import '../../../helpers/size_box.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_images.dart';
import '../../../utils/app_router.dart';
import '../../../utils/extensions.dart';
import '../model/get_lost-pet_model.dart';
import '../view/pet_information.dart';
import 'container_painter.dart';

class LostPetContainer extends StatelessWidget {
  final bool isFound;
  final Pet? lostPetData;
  const LostPetContainer({
    this.isFound = false,
    super.key,
    this.lostPetData,
  });

  @override
  Widget build(BuildContext context) {
    LostGemProvider provider = context.read<LostGemProvider>();
    return Container(
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
          ]),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            top: 0,
            child: CustomPaint(
              painter: lostPetData?.status == "Found"
                  ? RPSCustomPainterWhite()
                  : RPSCustomPainter(),
              size: Size(
                Responsive.width * 55,
                Responsive.height * 6,
              ),
            ),
          ),
          Positioned(
            right: Responsive.width * 10,
            top: Responsive.height * 0.7,
            child: Row(
              children: [
                Image.asset(AppImages.spekerimg),
                const commonTextWidget(
                  text: "Inform About Pet",
                  color: AppConstants.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ],
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
                        url: lostPetData?.missingDetails?.identification ??
                            'https://example.com/image.jpg',
                        height: Responsive.height * 15,
                        width: Responsive.width * 45),
                    SizeBoxV(Responsive.width * 2),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizeBoxH(
                          Responsive.height * 3,
                        ),
                        commonTextWidget(
                          text: lostPetData?.name ?? "",
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
                            commonTextWidget(
                              color: Colors.grey,
                              text: lostPetData?.missingDetails?.location ?? '',
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
                            commonTextWidget(
                              color: Colors.grey,
                              text: lostPetData?.missingDetails?.ownerContact ??
                                  '',
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
                        commonTextWidget(
                          color: Colors.grey,
                          text: provider.formatDateTimeToString(
                            lostPetData?.missingDetails?.date ?? DateTime.now(),
                          ),
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                      ],
                    ),
                    lostPetData?.status == "Found"
                        ? const SizedBox.shrink()
                        : CommonInkwell(
                            onTap: () {
                              provider.captureScreenShot(
                                  context: context,
                                  missingDetails: lostPetData?.missingDetails,
                                  pet: lostPetData?.name ?? "");
                            },
                            child: Row(
                              children: [
                                Image.asset(
                                  AppImages.dawnloadIcon,
                                ),
                                SizeBoxV(Responsive.width * 02),
                                const commonTextWidget(
                                  color: Color(0xff000000),
                                  text: 'Download',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13,
                                ),
                              ],
                            ),
                          ),
                    lostPetData?.status == "Found"
                        ? const SizedBox.shrink()
                        : CommonInkwell(
                            onTap: () {
                              if (lostPetData?.status == "Missing") {
                                provider.getSinglePet(lostPetData);
                                Routes.push(
                                  context: context,
                                  screen: const PetInformationScreen(),
                                  exit: () {},
                                );
                              }
                            },
                            child: Row(
                              children: [
                                Image.asset(
                                  AppImages.minusImage,
                                ),
                                SizeBoxV(Responsive.width * 02),
                                const commonTextWidget(
                                  color: Color(0xff000000),
                                  text: 'Report',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13,
                                ),
                              ],
                            ),
                          ),
                    Container(
                      width: Responsive.width * 20,
                      height: Responsive.height * 3,
                      decoration: BoxDecoration(
                        color: lostPetData?.status == "Found"
                            ? const Color(0xff7D7A43)
                            : const Color(0xfffee5158),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: commonTextWidget(
                        color: Colors.white,
                        text: lostPetData?.status ?? "",
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
    );
  }
}

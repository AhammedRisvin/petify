import 'package:clan_of_pets/app/helpers/common_widget.dart';
import 'package:clan_of_pets/app/helpers/size_box.dart';
import 'package:clan_of_pets/app/module/lostgem/model/get_lost-pet_model.dart';
import 'package:clan_of_pets/app/utils/app_constants.dart';
import 'package:clan_of_pets/app/utils/app_images.dart';
import 'package:clan_of_pets/app/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LostPetShareWidget extends StatefulWidget {
  const LostPetShareWidget({
    super.key,
    this.missingDetails,
    required this.pet,
  });
  final MissingDetails? missingDetails;
  final String pet;

  @override
  State<LostPetShareWidget> createState() => _LostPetShareWidgetState();
}

class _LostPetShareWidgetState extends State<LostPetShareWidget> {
  @override
  void initState() {
    super.initState();
    loadImage();
  }

  void loadImage() async {
    await precacheImage(
        AssetImage(
          AppImages.helpMeGetHomePoster,
        ),
        onError: (exception, stackTrace) {},
        context);
  }

  String formatDateTimeToString(DateTime dateTime) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(dateTime);
    return formatted;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: Responsive.height * 50,
        width: Responsive.width * 90,
        decoration: BoxDecoration(
          color: AppConstants.white,
          image: DecorationImage(
            image: AssetImage(
              AppImages.helpMeGetHomePoster,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            SizeBoxH(Responsive.height * 8),
            commonNetworkImage(
              url: widget.missingDetails?.identification ?? "",
              height: Responsive.height * 22,
              width: Responsive.width * 50,
              radius: 0,
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Container(
                        height: 30,
                        width: 120,
                        decoration: BoxDecoration(
                          color: AppConstants.appPrimaryColor,
                          borderRadius: BorderRadius.circular(0),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.phone,
                              size: 18,
                              color: AppConstants.white,
                            ),
                            SizeBoxV(5),
                            commonTextWidget(
                              color: AppConstants.black,
                              text: "Contact",
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ],
                        ),
                      ),
                      const SizeBoxH(6),
                      commonTextWidget(
                        color: AppConstants.black,
                        text: widget.missingDetails?.ownerContact ?? "",
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      commonTextWidget(
                        color: AppConstants.appPrimaryColor,
                        text: widget.pet,
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                      Row(
                        children: [
                          commonTextWidget(
                            color: AppConstants.black,
                            text: widget.missingDetails?.location ?? "",
                            fontSize: 12,
                            letterSpacing: -0.5,
                          ),
                          const SizeBoxV(6),
                          Container(
                            height: 15,
                            width: 15,
                            decoration: BoxDecoration(
                              color: AppConstants.white.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: const Icon(
                              Icons.location_on,
                              size: 10,
                              color: AppConstants.black,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          commonTextWidget(
                            color: AppConstants.black,
                            text: formatDateTimeToString(
                              widget.missingDetails?.date ?? DateTime.now(),
                            ),
                            fontSize: 12,
                            letterSpacing: -0.5,
                          ),
                          const SizeBoxV(6),
                          Container(
                            height: 15,
                            width: 15,
                            decoration: BoxDecoration(
                              color: AppConstants.white.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: const Icon(
                              Icons.calendar_month_outlined,
                              size: 10,
                              color: AppConstants.black,
                            ),
                          ),
                        ],
                      ),
                      const SizeBoxH(10)
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:clan_of_pets/app/module/home/model/get_pet_model.dart';
import 'package:clan_of_pets/app/utils/extensions.dart';
import 'package:flutter/material.dart';

import '../../../helpers/common_widget.dart';
import '../../../helpers/size_box.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_images.dart';
import '../view/pet_profile_screen.dart';

class DownloadingWidgetWithPetDetails extends StatefulWidget {
  const DownloadingWidgetWithPetDetails({super.key, required this.data});

  final PetData data;

  @override
  State<DownloadingWidgetWithPetDetails> createState() =>
      _DownloadingWidgetWithPetDetailsState();
}

class _DownloadingWidgetWithPetDetailsState
    extends State<DownloadingWidgetWithPetDetails> {
  String formatDate(DateTime dateTime) {
    final String day = dateTime.day.toString().padLeft(2, '0');
    final String month = _getMonthName(dateTime.month);
    final String year = dateTime.year.toString();
    return '$day $month $year';
  }

  String formatDate2(DateTime dateTime) {
    final String day = dateTime.day.toString().padLeft(2, '0');
    final String month = dateTime.month.toString().padLeft(2, '0');
    final String year = dateTime.year.toString();
    return '$day / $month / $year';
  }

  String _getMonthName(int month) {
    switch (month) {
      case 1:
        return 'Jan';
      case 2:
        return 'Feb';
      case 3:
        return 'Mar';
      case 4:
        return 'Apr';
      case 5:
        return 'May';
      case 6:
        return 'Jun';
      case 7:
        return 'Jul';
      case 8:
        return 'Aug';
      case 9:
        return 'Sep';
      case 10:
        return 'Oct';
      case 11:
        return 'Nov';
      case 12:
        return 'Dec';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        width: Responsive.width * 100,
        height: Responsive.height * 75,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppConstants.white,
        ),
        child: SizedBox(
          width: Responsive.width * 100,
          child: Column(
            children: [
              commonNetworkImage(
                url: widget.data.coverImage == null ||
                        widget.data.coverImage?.isEmpty == true
                    ? "https://cdn.pixabay.com/photo/2017/11/14/13/06/kitty-2948404_640.jpg"
                    : widget.data.coverImage ?? "",
                height: Responsive.height * 28,
                width: Responsive.width * 100,
                radius: 15,
              ),
              const SizeBoxH(15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const SizeBoxV(10),
                      commonNetworkImage(
                        url: widget.data.image == null ||
                                widget.data.image?.isEmpty == true
                            ? "https://cdn.pixabay.com/photo/2017/11/14/13/06/kitty-2948404_640.jpg"
                            : widget.data.image ?? "",
                        height: 72,
                        width: 72,
                        radius: 100,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 11,
                        ),
                        child: commonTextWidget(
                          color: AppConstants.black,
                          text: widget.data.name ?? 'Name',
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      right: 10,
                    ),
                    width: 110,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      // color: AppConstants.greyContainerBg,
                    ),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizeBoxH(Responsive.height * 0.5),
                          const commonTextWidget(
                            color: AppConstants.appPrimaryColor,
                            text: "Joined",
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                          ),
                          commonTextWidget(
                            color: AppConstants.black,
                            text: formatDate(
                              widget.data.birthDate ?? DateTime.now(),
                            ),
                            // text: "12/12/2021",
                            fontSize: 13,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizeBoxH(Responsive.height * 2),
              Container(
                width: Responsive.width * 90,
                padding: const EdgeInsets.only(
                  left: 5,
                  top: 10,
                  bottom: 5,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppConstants.greyContainerBg,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ProfileCommonRowWidget(
                          image: AppImages.copId,
                          text: "COP id",
                          subText: widget.data.copId ?? '',
                        ),
                        ProfileCommonRowWidget(
                          image: AppImages.copId,
                          text: "Micro chip id ",
                          subText: widget.data.chipId ?? '',
                        ),
                      ],
                    ),
                    const SizeBoxH(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ProfileCommonRowWidget(
                          image: AppImages.speciesIcon,
                          text: "Species",
                          subText: widget.data.species ?? '',
                        ),
                        ProfileCommonRowWidget(
                          image: AppImages.breedIcon,
                          text: "Breed",
                          subText: widget.data.breed ?? '',
                        ),
                      ],
                    ),
                    const SizeBoxH(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ProfileCommonRowWidget(
                          image: AppImages.sexIcon,
                          text: "Sex",
                          subText: widget.data.sex ?? '',
                        ),
                        ProfileCommonRowWidget(
                          image: AppImages.birthDateIcon,
                          text: "Birth Date",
                          subText: formatDate2(
                            widget.data.birthDate ?? DateTime.now(),
                          ),
                          // subText: '',
                        ),
                      ],
                    ),
                    const SizeBoxH(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ProfileCommonRowWidget(
                          image: AppImages.wweightIcon,
                          text: "Weight",
                          subText: widget.data.weight.toString(),
                        ),
                        ProfileCommonRowWidget(
                          image: AppImages.heightIcon,
                          text: "Height",
                          subText: widget.data.height.toString(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

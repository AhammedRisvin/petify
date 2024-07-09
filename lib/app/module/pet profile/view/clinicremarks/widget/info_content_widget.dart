import 'package:flutter/material.dart';

import '../../../../../helpers/common_widget.dart';
import '../../../../../helpers/size_box.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../../utils/app_images.dart';
import '../../../../../utils/extensions.dart';
import '../../../view model/pet_profile_provider.dart';

class BuildInfoContentWidget extends StatelessWidget {
  const BuildInfoContentWidget({
    super.key,
    required this.value,
  });
  final PetProfileProvider value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              commonTextWidget(
                color: AppConstants.black,
                text: 'Al pets',
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.calendar_month_outlined,
                    color: Colors.grey,
                    size: 14,
                  ),
                  SizeBoxV(10),
                  commonTextWidget(
                    color: Colors.grey,
                    text: 'Mar,27,2024',
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ],
              )
            ],
          ),
          const SizeBoxH(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(AppImages.locationImage),
              SizeBoxV(Responsive.width * 2),
              const commonTextWidget(
                color: Colors.grey,
                text: 'Location',
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
            ],
          ),
          const SizeBoxH(10),
          const commonTextWidget(
            color: AppConstants.black,
            text: 'Available services',
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
          const SizeBoxH(10),
          Wrap(
            alignment: WrapAlignment.start,
            direction: Axis.horizontal,
            spacing: Responsive.width * 2,
            runSpacing: Responsive.width * 2,
            children: List.generate(
              value.servicelist.length,
              (index) => CommonInkwell(
                onTap: () {
                  value.currentIndexFnc(index: index);
                },
                child: Container(
                  height: Responsive.height * 3.5,
                  decoration: BoxDecoration(
                      color: value.currentIndex == index
                          ? const Color(0xffFABA9E)
                          : const Color(0xffF3F3F5),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      bottom: 5,
                      left: 25,
                      right: 25,
                      top: 7,
                    ),
                    child: commonTextWidget(
                      align: TextAlign.center,
                      color: Colors.black,
                      text: value.servicelist[index],
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizeBoxH(10),
          const commonTextWidget(
            color: AppConstants.black,
            text: 'Consultant Doctor',
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
          const SizeBoxH(10),
          Row(
            children: [
              const CircleAvatar(
                radius: 30,
                backgroundColor: Colors.white,
                child: commonNetworkImage(url: '', height: 50, width: 50),
              ),
              SizeBoxV(Responsive.width * 2),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  commonTextWidget(
                    color: Color(0xff000000),
                    text: 'John joy',
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                  commonTextWidget(
                    color: Colors.grey,
                    text: 'Vetinary surgeon',
                    fontWeight: FontWeight.w500,
                    fontSize: 10,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

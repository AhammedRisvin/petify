import 'package:flutter/material.dart';

import '../../../../../helpers/common_widget.dart';
import '../../../../../helpers/size_box.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../../utils/extensions.dart';
import '../../../view model/pet_profile_provider.dart';

class PrescriptionContentWidget extends StatelessWidget {
  const PrescriptionContentWidget({
    super.key,
    required this.value,
  });

  final PetProfileProvider value;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
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
        const SizeBoxH(15),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              commonTextWidget(
                color: AppConstants.black,
                text: 'Treatment',
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
              Row(
                children: [
                  commonTextWidget(
                    color: AppConstants.appPrimaryColor,
                    text: 'Prescription',
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                  SizeBoxV(5),
                  Icon(
                    Icons.download_outlined,
                    color: AppConstants.appPrimaryColor,
                    size: 16,
                  )
                ],
              ),
            ],
          ),
        ),
        const SizeBoxH(10),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: commonTextWidget(
            align: TextAlign.start,
            color: AppConstants.black40,
            text:
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrs standard dummy text ever since the 1500s, when an unknownprinter took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software likeAldus PageMaker including versions of Lorem Ipsum. ',
            fontWeight: FontWeight.w500,
            height: 2.5,
            fontSize: 10,
          ),
        )
      ],
    );
  }
}

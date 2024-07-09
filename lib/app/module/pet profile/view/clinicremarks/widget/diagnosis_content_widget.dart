import 'package:flutter/material.dart';

import '../../../../../helpers/common_widget.dart';
import '../../../../../helpers/size_box.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../../utils/extensions.dart';
import '../../../view model/pet_profile_provider.dart';

class DiagnosisContentWidget extends StatelessWidget {
  const DiagnosisContentWidget({
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
          const SizeBoxH(20),
          const commonTextWidget(
            color: AppConstants.black,
            text: 'Rabies (hydrophobia)',
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
          const SizeBoxH(10),
          const commonTextWidget(
            align: TextAlign.start,
            color: AppConstants.black40,
            text:
                'Rabies (hydrophobia) is a fatal viral disease that can affect any mammal, although the close relationship of dogs with humans makes canine rabies a zoonotic concern. Vaccination of dogs for rabies is commonly required by law. Please see the article dog health for information on this disease in dogs',
            fontWeight: FontWeight.w500,
            fontSize: 10,
          ),
          const SizeBoxH(15),
          const commonTextWidget(
            color: AppConstants.black,
            text: 'Treatment',
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return const Row(
                children: [
                  CircleAvatar(
                    radius: 6,
                    backgroundColor: AppConstants.appPrimaryColor,
                  ),
                  SizeBoxV(10),
                  commonTextWidget(
                    align: TextAlign.start,
                    color: AppConstants.black,
                    maxLines: 2,
                    overFlow: TextOverflow.ellipsis,
                    text:
                        'Rabies (hydrophobia) is a fatal viral disease that can affect any mammal',
                    fontWeight: FontWeight.w500,
                    fontSize: 10,
                  ),
                ],
              );
            },
            separatorBuilder: (context, index) => const SizeBoxH(12),
            itemCount: 10,
          ),
          const SizeBoxH(30)
        ],
      ),
    );
  }
}

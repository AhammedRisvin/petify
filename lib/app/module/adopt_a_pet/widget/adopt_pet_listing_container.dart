import 'package:clan_of_pets/app/module/adopt_a_pet/model/get_all_adoption_pet_model.dart';
import 'package:clan_of_pets/app/utils/extensions.dart';
import 'package:flutter/material.dart';

import '../../../helpers/common_widget.dart';
import '../../../helpers/size_box.dart';
import '../../../utils/app_constants.dart';

class AdoptPetListingContainer extends StatelessWidget {
  const AdoptPetListingContainer({
    super.key,
    this.petFeedData,
  });

  final Feed? petFeedData;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: AppConstants.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: AppConstants.black.withOpacity(0.1),
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          commonNetworkImage(
            url: petFeedData?.image ??
                "https://jankrepl.github.io/assets/images/symbolic_regression/main_files/cute-dog-transparent-background.png",
            height: Responsive.height * 13.5,
            width: Responsive.width * 80,
            isTopCurved: true,
            isBottomCurved: false,
          ),
          const SizeBoxH(10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                commonTextWidget(
                  color: AppConstants.black,
                  text: petFeedData?.petName ?? "Catagories",
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  maxLines: 2,
                  overFlow: TextOverflow.ellipsis,
                ),
                const SizeBoxH(10),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppConstants.appPrimaryColor.withOpacity(
                          0.3,
                        ),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: AppConstants.black10,
                        ),
                      ),
                      margin: const EdgeInsets.only(right: 5),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      child: Center(
                        child: commonTextWidget(
                          color: AppConstants.appPrimaryColor,
                          text: petFeedData?.gender ?? "Female",
                          maxLines: 2,
                          overFlow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: AppConstants.appPrimaryColor.withOpacity(
                          0.3,
                        ),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: AppConstants.black10,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      child: Center(
                        child: commonTextWidget(
                          color: AppConstants.appPrimaryColor,
                          text: "${petFeedData?.age} Year",
                          maxLines: 2,
                          overFlow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w500,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizeBoxH(10),
        ],
      ),
    );
  }
}

import 'package:clan_of_pets/app/module/home/view/add_new_pet.dart';
import 'package:clan_of_pets/app/utils/app_router.dart';
import 'package:flutter/material.dart';

import '../../../helpers/common_widget.dart';
import '../../../helpers/size_box.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_images.dart';
import '../../../utils/extensions.dart';

class AddNewPetCarousalWidget extends StatelessWidget {
  const AddNewPetCarousalWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
            image: AssetImage(
              AppImages.homeScreenCarousalBg,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: 15,
                top: Responsive.height * 2,
              ),
              child: SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const commonTextWidget(
                      color: AppConstants.white,
                      text: "Add New Pet",
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                    ),
                    SizeBoxH(Responsive.height * 1),
                    commonTextWidget(
                      color: AppConstants.white.withOpacity(0.6),
                      align: TextAlign.start,
                      text:
                          "Add New Pet to your\nprofile and get started\nwith the app",
                      maxLines: 3,
                      overFlow: TextOverflow.ellipsis,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                    SizeBoxH(Responsive.height * 1),
                    CommonInkwell(
                      onTap: () {
                        Routes.push(
                          context: context,
                          screen: const AddNewPetScreen(
                            isEdit: false,
                          ),
                          exit: () {},
                        );
                      },
                      child: Container(
                        height: 35,
                        width: 90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: AppConstants.transparent,
                          border: Border.all(
                            color: AppConstants.white,
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add,
                              color: AppConstants.white,
                              size: 20,
                            ),
                            commonTextWidget(
                              color: AppConstants.white,
                              text: "Add New",
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.3,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: commonNetworkImage(
                url:
                    "https://jankrepl.github.io/assets/images/symbolic_regression/main_files/cute-dog-transparent-background.png",
                height: 150,
                width: Responsive.width * 100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

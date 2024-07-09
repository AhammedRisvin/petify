import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/string_const.dart';
import '../../../helpers/common_widget.dart';
import '../../../helpers/size_box.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_images.dart';
import '../../../utils/extensions.dart';
import '../model/get_pet_model.dart';
import '../view model/home_provider.dart';
import '../view/home_screen.dart';

class HomeCarousalWidget extends StatelessWidget {
  final PetData? petData;
  final int? index;
  const HomeCarousalWidget({
    super.key,
    this.petData,
    this.index,
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
                      text: "Name",
                      fontSize: 10,
                    ),
                    commonTextWidget(
                      color: AppConstants.white,
                      text: petData?.name?.capitalizeFirstLetter() ?? "",
                      fontSize: 40,
                      fontWeight: FontWeight.w900,
                    ),
                    commonTextWidget(
                      color: AppConstants.white,
                      text:
                          "Breed : ${petData?.breed?.capitalizeFirstLetter() ?? ""}",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.5,
                    ),
                    SizeBoxH(Responsive.height * 1.8),
                    CommonBannerButtonWidget(
                      bgColor: AppConstants.white,
                      borderColor: AppConstants.white,
                      textColor: AppConstants.black,
                      text: "View Profile",
                      fontSize: 9,
                      width: 70,
                      height: 28,
                      onTap: () {
                        StringConst.setPetIndex(index: index.toString());
                        StringConst.setPetId(pet: petData?.id ?? "");
                        context.read<HomeProvider>().onItemTapped(index: 4);
                      },
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: commonNetworkImage(
                  url: petData?.image ??
                      "https://jankrepl.github.io/assets/images/symbolic_regression/main_files/cute-dog-transparent-background.png",
                  height: 150,
                  width: Responsive.width * 80,
                  radius: 25,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:clan_of_pets/app/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../helpers/common_widget.dart';
import '../../../../helpers/size_box.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/app_router.dart';
import '../../view model/pet_profile_provider.dart';

class GroomingHistoryDetailsScreen extends StatelessWidget {
  const GroomingHistoryDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Consumer<PetProfileProvider>(
          builder: (context, value, child) => SizedBox(
            height: Responsive.height * 100,
            width: Responsive.width * 100,
            child: Stack(
              children: [
                commonNetworkImage(
                  url:
                      "https://img.freepik.com/free-photo/veterinarian-check-ing-puppy-s-health_23-2148728396.jpg?w=826&t=st=1713440289~exp=1713440889~hmac=70c75254f6d4291150a644cd51482cd06a8ec3e81a86934be0b2f308bacc7d2c",
                  height: Responsive.height * 42,
                  width: Responsive.width * 100,
                ),
                Positioned(
                  top: Responsive.height * 38,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: SingleChildScrollView(
                    physics: const ScrollPhysics(),
                    child: Container(
                      width: Responsive.width * 100,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const commonTextWidget(
                                color: AppConstants.black,
                                text: 'Al pets',
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const commonTextWidget(
                                    color: Colors.grey,
                                    text: 'Location',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                  ),
                                  SizeBoxV(Responsive.width * 2),
                                  Image.asset(AppImages.locationImage),
                                ],
                              ),
                            ],
                          ),
                          SizeBoxH(Responsive.height * 1.5),
                          const commonTextWidget(
                            color: AppConstants.black,
                            text: 'Service Availed',
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                          SizeBoxH(Responsive.height * 1),
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
                                          ? AppConstants.appPrimaryColor
                                          : const Color(0xffF3F3F5),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 5,
                                      left: 25,
                                      right: 25,
                                      top: 7,
                                    ),
                                    child: commonTextWidget(
                                      align: TextAlign.center,
                                      color: value.currentIndex == index
                                          ? Colors.white
                                          : AppConstants.black,
                                      text: value.servicelist[index],
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizeBoxH(Responsive.height * 1.5),
                          const commonTextWidget(
                            color: AppConstants.black,
                            text: 'Groomer Name',
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                          SizeBoxH(Responsive.height * 1.5),
                          Row(
                            children: [
                              const CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.white,
                                child: commonNetworkImage(
                                    url: '', height: 50, width: 50),
                              ),
                              SizeBoxV(Responsive.width * 2),
                              const commonTextWidget(
                                color: Color(0xff000000),
                                text: 'John joy',
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ],
                          ),
                          SizeBoxH(Responsive.height * 1.5),
                          Container(
                            width: Responsive.width * 100,
                            height: Responsive.height * 4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppConstants.greyContainerBg,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const commonTextWidget(
                                  color: Colors.black,
                                  text: 'Instruction given (signed Document)',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 10,
                                ),
                                CommonInkwell(
                                  onTap: () {},
                                  child: Container(
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                      color: AppConstants.appPrimaryColor
                                          .withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: const Icon(
                                      Icons.remove_red_eye,
                                      color: Colors.white,
                                      size: 10,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizeBoxH(Responsive.height * 2.5),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const commonTextWidget(
                                      color: Colors.black,
                                      text: 'Before',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                    ),
                                    SizeBoxH(Responsive.height * 0.8),
                                    commonNetworkImage(
                                      url:
                                          'https://img.freepik.com/free-photo/veterinarian-check-ing-puppy-s-health_23-2148728396.jpg?w=826&t=st=1713440289~exp=1713440889~hmac=70c75254f6d4291150a644cd51482cd06a8ec3e81a86934be0b2f308bacc7d2c',
                                      height: Responsive.height * 19,
                                      width: Responsive.width * 45,
                                    )
                                  ],
                                ),
                              ),
                              const SizeBoxV(20),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const commonTextWidget(
                                      color: Colors.black,
                                      text: 'After',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                    ),
                                    SizeBoxH(Responsive.height * 0.8),
                                    commonNetworkImage(
                                      url:
                                          'https://img.freepik.com/free-photo/veterinarian-check-ing-puppy-s-health_23-2148728396.jpg?w=826&t=st=1713440289~exp=1713440889~hmac=70c75254f6d4291150a644cd51482cd06a8ec3e81a86934be0b2f308bacc7d2c',
                                      height: Responsive.height * 19,
                                      width: Responsive.width * 45,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: Responsive.height * 3,
                  left: Responsive.width * 5,
                  child: Row(
                    children: [
                      Transform.scale(
                        scale: 0.7,
                        child: IconButton(
                          onPressed: () {
                            Routes.back(context: context);
                          },
                          style: const ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(
                              AppConstants.greyContainerBg,
                            ),
                          ),
                          icon: const Icon(
                            Icons.arrow_back_ios_new,
                            size: 19,
                            color: AppConstants.appPrimaryColor,
                          ),
                        ),
                      ),
                      SizeBoxV(Responsive.width * 2),
                      const commonTextWidget(
                        text: 'Grooming History Details',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppConstants.black,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

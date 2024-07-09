import 'package:cached_network_image/cached_network_image.dart';
import 'package:clan_of_pets/app/helpers/size_box.dart';
import 'package:clan_of_pets/app/module/Pet%20services/model/service_appoinments_model.dart';
import 'package:clan_of_pets/app/module/Pet%20services/view_model/services_provider.dart';
import 'package:clan_of_pets/app/utils/app_router.dart';
import 'package:clan_of_pets/app/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../helpers/common_widget.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_images.dart';

class AppointMentDetailsScreen extends StatelessWidget {
  const AppointMentDetailsScreen({
    super.key,
    this.data,
  });

  final Appointment? data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.white,
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: SizedBox(
          height: Responsive.height * 100,
          width: Responsive.width * 100,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: CachedNetworkImage(
                  imageUrl: data?.clinicImage ??
                      'https://img.freepik.com/free-photo/veterinarian-check-ing-puppy-s-health_23-2148728396.jpg?w=826&t=st=1713440289~exp=1713440889~hmac=70c75254f6d4291150a644cd51482cd06a8ec3e81a86934be0b2f308bacc7d2c',
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      height: Responsive.height * 45,
                      width: Responsive.width * 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                  placeholder: (context, url) => SizedBox(
                    height: Responsive.height * 45,
                    width: Responsive.width * 100,
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: AppConstants.appPrimaryColor,
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => SizedBox(
                      height: Responsive.height * 45,
                      width: Responsive.width * 100,
                      child: const Icon(
                        Icons.image_not_supported,
                        size: 40,
                        color: Colors.grey,
                      )),
                ),
              ),
              Positioned(
                top: Responsive.height * 40,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  width: Responsive.width * 100,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      color: Colors.white),
                  child: SingleChildScrollView(
                    physics: const ScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizeBoxH(Responsive.height * 1),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.red,
                                child: commonNetworkImage(
                                  url: data?.petImage ?? "",
                                  height: 50,
                                  width: 50,
                                  radius: 25,
                                ),
                              ),
                              SizeBoxV(Responsive.width * 5),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  commonTextWidget(
                                    text: data?.petName ?? '',
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xff000000),
                                  ),
                                  commonTextWidget(
                                    text: (data?.bookingId ?? '878377287382863')
                                                .length >
                                            10
                                        ? (data?.bookingId ?? '878377287382863')
                                            .substring((data?.bookingId ??
                                                        '878377287382863')
                                                    .length -
                                                10)
                                        : (data?.bookingId ??
                                            '878377287382863'),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xff000000),
                                  ),
                                ],
                              ),
                              SizeBoxV(Responsive.width * 5),
                              Container(
                                width: Responsive.width * 30,
                                height: Responsive.height * 5,
                                decoration: BoxDecoration(
                                  color:
                                      data?.status?.toLowerCase() == "pending"
                                          ? const Color(0xffEE5158)
                                          : data?.status?.toLowerCase() ==
                                                  "approved"
                                              ? const Color(0xff4CAF50)
                                              : const Color(0xffEE5158),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(40)),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    data?.status?.toLowerCase() == "processing"
                                        ? Image.asset(
                                            AppImages.lodingImage,
                                            width: 18,
                                            height: 18,
                                          )
                                        : const SizedBox.shrink(),
                                    SizeBoxV(Responsive.width * 1),
                                    commonTextWidget(
                                      text: data?.status ?? '',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xffFFFFFF),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizeBoxH(Responsive.height * 2),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: Responsive.width * 27,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const commonTextWidget(
                                        text: 'Service Provider',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: AppConstants.black40,
                                      ),
                                      SizeBoxH(Responsive.height * 0.5),
                                      commonTextWidget(
                                        text: data?.clinicName ?? "",
                                        fontSize: 16,
                                        maxLines: 2,
                                        overFlow: TextOverflow.ellipsis,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xff000000),
                                      ),
                                    ],
                                  ),
                                ),
                                SizeBoxV(Responsive.width * 15),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const commonTextWidget(
                                      text: 'Service',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: AppConstants.black40,
                                    ),
                                    SizeBoxH(Responsive.height * 0.5),
                                    commonTextWidget(
                                      text: data?.service ?? '',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xff000000),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizeBoxH(10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const commonTextWidget(
                                text: 'Grooming Services',
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppConstants.black40,
                              ),
                              SizeBoxH(Responsive.height * 0.5),
                              const commonTextWidget(
                                text: 'Dog full grooming small',
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Color(0xff000000),
                              ),
                              SizeBoxH(Responsive.height * 3),
                            ],
                          ),
                          Consumer<ServiceProvider>(
                            builder: (context, provider, child) => Row(
                              children: [
                                SizedBox(
                                  width: Responsive.width * 27,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const commonTextWidget(
                                        text: 'Service Requested',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: AppConstants.black40,
                                        letterSpacing: -0.5,
                                      ),
                                      SizeBoxH(Responsive.height * 0.5),
                                      commonTextWidget(
                                        text: provider.serviceDate(
                                            data?.requestedDate ??
                                                DateTime.now()),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xff000000),
                                      ),
                                    ],
                                  ),
                                ),
                                SizeBoxV(Responsive.width * 15),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const commonTextWidget(
                                      text: 'Service on',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: AppConstants.black40,
                                    ),
                                    SizeBoxH(Responsive.height * 0.5),
                                    commonTextWidget(
                                      text: provider.serviceDate(
                                          data?.serviceDate ?? DateTime.now()),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xff000000),
                                    ),
                                  ],
                                ),
                                SizeBoxV(Responsive.width * 5),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const commonTextWidget(
                                      text: '',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: AppConstants.black40,
                                    ),
                                    SizeBoxH(Responsive.height * 0.5),
                                    SizedBox(
                                      width: Responsive.width * 15,
                                      child: commonTextWidget(
                                        text: provider.serviceTime(
                                            data?.requestedDate ??
                                                DateTime.now()),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xff000000),
                                        overFlow: TextOverflow.ellipsis,
                                      ),
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
                ),
              ),
              Positioned(
                top: Responsive.height * 1,
                left: Responsive.width * 5,
                bottom: Responsive.height * 90,
                child: Row(
                  children: [
                    CommonInkwell(
                      onTap: () => Routes.back(
                        context: context,
                      ),
                      child: Container(
                        width: Responsive.width * 10,
                        height: Responsive.height * 10,
                        decoration: BoxDecoration(
                            color: const Color(0xfff3f5cc).withOpacity(0.8),
                            shape: BoxShape.circle),
                        alignment: Alignment.center,
                        child: const Padding(
                          padding: EdgeInsets.all(12),
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.amber,
                            size: 25,
                          ),
                        ),
                      ),
                    ),
                    SizeBoxV(Responsive.width * 2),
                    const commonTextWidget(
                      text: 'My Appoinment Details',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff000000),
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

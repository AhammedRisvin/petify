import 'package:clan_of_pets/app/module/blog/view_model/blog_provioder.dart';
import 'package:clan_of_pets/app/utils/app_images.dart';
import 'package:clan_of_pets/app/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../helpers/common_widget.dart';
import '../../../helpers/size_box.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_router.dart';

class BlogDetailsScreen extends StatelessWidget {
  const BlogDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.white,
      body: Consumer<BlogProvider>(
        builder: (context, provider, child) => SizedBox(
          height: Responsive.height * 100,
          width: Responsive.width * 100,
          child: Stack(
            children: [
              Container(
                height: Responsive.height * 45,
                width: Responsive.width * 100,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  image: DecorationImage(
                    onError: (exception, stackTrace) => const SizedBox(
                        height: 50,
                        width: 50,
                        child: Icon(
                          Icons.image_not_supported,
                          size: 40,
                          color: Colors.grey,
                        )),
                    fit: BoxFit.cover,
                    image: NetworkImage(provider.singleBlogData?.blogImage ??
                        'https://t4.ftcdn.net/jpg/04/95/28/65/240_F_495286577_rpsT2Shmr6g81hOhGXALhxWOfx1vOQBa.jpg'),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 60.0, left: 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30,
                        width: 30,
                        child: Center(
                          child: IconButton(
                            onPressed: () {
                              Routes.back(context: context);
                            },
                            style: ButtonStyle(
                              fixedSize:
                                  const WidgetStatePropertyAll(Size(4, 4)),
                              backgroundColor: WidgetStatePropertyAll(
                                AppConstants.white.withOpacity(.5),
                              ),
                            ),
                            icon: Icon(
                              Icons.arrow_back_ios_new,
                              size: 15,
                              color: AppConstants.black.withOpacity(.9),
                            ),
                          ),
                        ),
                      ),
                      const SizeBoxV(10),
                      const Padding(
                        padding: EdgeInsets.only(top: 4.0),
                        child: commonTextWidget(
                          text: "Blog",
                          color: AppConstants.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  height: Responsive.height * 60,
                  width: Responsive.width * 100,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadiusDirectional.only(
                      topEnd: Radius.circular(40),
                      topStart: Radius.circular(40),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        commonTextWidget(
                          text: provider.singleBlogData?.title ?? '',
                          color: AppConstants.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        SizeBoxH(Responsive.height * 2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              child: Row(
                                children: [
                                  commonNetworkImage(
                                      radius: 30,
                                      url: provider.singleBlogData?.userImage ==
                                                  null ||
                                              provider.singleBlogData?.userImage
                                                      ?.isEmpty ==
                                                  true
                                          ? ''
                                          : provider
                                                  .singleBlogData?.userImage ??
                                              '',
                                      height: 35,
                                      width: 35),
                                  SizeBoxV(Responsive.width * 2),
                                  commonTextWidget(
                                    align: TextAlign.start,
                                    color: AppConstants.black,
                                    text:
                                        provider.singleBlogData?.userName ?? '',
                                    fontSize: 12,
                                    overFlow: TextOverflow.ellipsis,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              child: Row(
                                children: [
                                  commonTextWidget(
                                    align: TextAlign.start,
                                    color: AppConstants.black.withOpacity(.4),
                                    text: DateFormat('MMM dd, yyyy').format(
                                      provider.singleBlogData?.createdAt ??
                                          DateTime.now(),
                                    ),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  SizeBoxV(Responsive.width * 2),
                                  Image.asset(
                                    AppImages.calenderIcon,
                                    height: 16,
                                    width: 14,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizeBoxH(Responsive.height * 2),
                        commonTextWidget(
                          align: TextAlign.start,
                          overFlow: TextOverflow.clip,
                          color: AppConstants.black.withOpacity(.4),
                          text: provider.singleBlogData?.blog ??
                              "In Mumbai, there are many professional pet grooming services availableto cater to your pet’s In Mumbai, there are many professional pet grooming services availableto cater to your pet’s needs. Whether you have a dog or a cat at home, both of them need extra care and attention especially when you cannot be with them physically for a long time. You can get the best service from a pet grooming company in Mumbai. These companies have a complete teamof pet experts who can do all the pet grooming services you need like earcleaning, haircutting, shampooing, nail clipping, and many more. A full-ser needs. Whether you have a dog or a cat at home, both of them need extra care and attention especially when you cannot be with them physically for a long time. You can get the best service from a pet grooming company in Mumbai. These companies have a complete teamof pet experts who can do all the pet grooming services you need like earcleaning, haircutting, shampooing, nail clipping, and many more. A full-ser  In Mumbai, there are many professional pet grooming services availableto cater to your pet’s needs. Whether you have a dog or a cat at home, both of them need extra care and attention especially when you cannot be with them physically for a long time. You can get the best service from a pet grooming company in Mumbai. These companies have a complete teamof pet experts who can do all the pet grooming services you need like earcleaning, haircutting, shampooing, nail clipping, and many more. A full-ser",
                          fontSize: 12,
                          height: 22,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

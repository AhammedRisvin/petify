import 'package:clan_of_pets/app/module/Dating/model/get_all_post.dart';
import 'package:clan_of_pets/app/module/Dating/view%20model/dating_provider.dart';
import 'package:clan_of_pets/app/module/Dating/view/post_list_screen.dart';
import 'package:clan_of_pets/app/module/pet%20profile/widget/search_widget.dart';
import 'package:clan_of_pets/app/module/widget/confirmation_widget.dart';
import 'package:clan_of_pets/app/module/widget/empty_screen.dart';
import 'package:clan_of_pets/app/utils/app_images.dart';
import 'package:clan_of_pets/app/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../helpers/common_widget.dart';
import '../../../helpers/size_box.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_router.dart';
import '../../../utils/extensions.dart';
import '../../Pet services/widget/appoinment_drop_down_widget.dart';
import '../view model/location_provider.dart';
import 'create_post_screen.dart';
import 'dating_details_screen.dart';

class DatingHomeScreen extends StatefulWidget {
  const DatingHomeScreen({super.key});

  @override
  State<DatingHomeScreen> createState() => _DatingHomeScreenState();
}

class _DatingHomeScreenState extends State<DatingHomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<LocationProvider>().checkLocationPermission(context: context);
    context.read<DatingProvider>().getAllDatePostFn(
          isFromCatagory: false,
          isFromSearch: false,
          isFromFilter: false,
          value: '',
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.white,
      appBar: AppBar(
        backgroundColor: AppConstants.white,
        title: const commonTextWidget(
          text: "Pet Dating",
          color: AppConstants.black,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        leading: SizedBox(
          height: 30,
          width: 30,
          child: Center(
            child: IconButton(
              onPressed: () {
                Routes.back(context: context);
              },
              style: ButtonStyle(
                fixedSize: const WidgetStatePropertyAll(Size(4, 4)),
                backgroundColor: WidgetStatePropertyAll(
                  AppConstants.white.withOpacity(.5),
                ),
              ),
              icon: const Icon(
                Icons.arrow_back_ios_new,
                size: 15,
                color: AppConstants.appPrimaryColor,
              ),
            ),
          ),
        ),
        actions: [
          SizedBox(
            height: 35,
            width: 113,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  side: const BorderSide(color: AppConstants.appPrimaryColor),
                  // backgroundColor: AppConstants.greyContainerBg,
                  padding: const EdgeInsets.all(8)),
              onPressed: () {
                Routes.push(
                  context: context,
                  screen: const DatingCreatePostScreen(
                    isEdit: false,
                    id: '',
                  ),
                  exit: () {},
                );
              },
              icon: const Icon(
                Icons.add,
                color: AppConstants.appPrimaryColor,
                size: 18,
              ),
              label: const commonTextWidget(
                align: TextAlign.start,
                color: AppConstants.appPrimaryColor,
                text: "Create Post",
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizeBoxV(Responsive.width * 2),
          CommonInkwell(
            onTap: () {
              Routes.push(
                context: context,
                screen: const DatingPostListScreen(),
                exit: () {},
              );
            },
            child: Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                color: AppConstants.white,
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: AppConstants.appPrimaryColor),
              ),
              child: Image.asset(
                AppImages.datePawIcon,
                height: 20,
                width: 20,
              ),
            ),
          ),
          SizeBoxV(Responsive.width * 2),
        ],
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Consumer<DatingProvider>(
          builder: (context, provider, child) => Column(
            children: [
              SearchWidget(
                hintText: "Search using breed name",
                onChanged: (p0) {
                  provider.getAllDatePostFn(
                    isFromCatagory: false,
                    isFromSearch: true,
                    isFromFilter: false,
                    value: p0,
                  );
                },
              ),
              const SizeBoxH(20),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 30,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final catagoryData = provider
                              .getDateAllPostModel.speciesList?[(provider
                                      .getDateAllPostModel
                                      .speciesList
                                      ?.length ??
                                  0) -
                              1 -
                              index];

                          bool isSelect = provider.selectedIndex == index;
                          return CommonInkwell(
                            onTap: () {
                              provider.setSelectedIndex(index);
                              provider.getAllDatePostFn(
                                isFromCatagory: true,
                                isFromSearch: false,
                                isFromFilter: false,
                                value: catagoryData?.species ?? "",
                              );
                            },
                            child: Container(
                              width: 60,
                              decoration: BoxDecoration(
                                color: isSelect
                                    ? AppConstants.appPrimaryColor
                                    : AppConstants.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: AppConstants.appPrimaryColor,
                                  width: 1,
                                ),
                              ),
                              child: Center(
                                child: commonTextWidget(
                                  color: isSelect
                                      ? AppConstants.white
                                      : AppConstants.black,
                                  text: catagoryData?.species ?? "",
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizeBoxV(Responsive.height * 2);
                        },
                        itemCount:
                            provider.getDateAllPostModel.speciesList?.length ??
                                0,
                      ),
                    ),
                  ),
                  Container(
                    height: Responsive.height * 5,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: AppConstants.appPrimaryColor,
                    ),
                    child: CustomDropdownButtonWidget(
                      hintText: 'Filter',
                      items: provider.dateFilter,
                      value: provider.selectedFilter ?? provider.dateFilter[0],
                      onChanged: (String? value) {
                        provider.setSelectedFilter(value);
                        if (value == "All") {
                          provider.getAllDatePostFn(
                            isFromCatagory: false,
                            isFromSearch: false,
                            isFromFilter: false,
                            value: "",
                          );
                        } else {
                          provider.getAllDatePostFn(
                            isFromCatagory: false,
                            isFromSearch: false,
                            isFromFilter: true,
                            value: "",
                          );
                        }
                      },
                      iconColor: AppConstants.white,
                      iconWidth: Responsive.width * 4,
                      iconHeight: Responsive.height * 1,
                      buttonWidth: Responsive.width * 18,
                      buttonHeight: Responsive.height * 2,
                      dropdWidth: Responsive.width * 26,
                      dropdHeight: Responsive.height * 10,
                      isbuttonRadiusChange: false,
                      color: AppConstants.appPrimaryColor,
                    ),
                  ),
                ],
              ),
              const SizeBoxH(15),
              provider.getDateAllPostModel.posts?.isEmpty == true
                  ? EmptyScreenWidget(
                      text: "No posts available",
                      image: AppImages.noCommunityImage,
                      height: Responsive.height * 80,
                    )
                  : provider.getDateAllPostStatus ==
                          GetDateAllPostStatus.loading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: AppConstants.appPrimaryColor,
                          ),
                        )
                      : provider.getDateAllPostStatus ==
                              GetDateAllPostStatus.loaded
                          ? ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final petData = provider
                                    .getDateAllPostModel.posts?[(provider
                                            .getDateAllPostModel
                                            .posts
                                            ?.length ??
                                        0) -
                                    1 -
                                    index];
                                return DatingPetListingContainerWidget(
                                  petData: petData,
                                  provider: provider,
                                );
                              },
                              separatorBuilder: (context, index) {
                                return SizeBoxH(Responsive.height * 2);
                              },
                              itemCount:
                                  provider.getDateAllPostModel.posts?.length ??
                                      0,
                            )
                          : const Text("Something went wrong")
            ],
          ),
        ),
      ),
    );
  }
}

class DatingPetListingContainerWidget extends StatelessWidget {
  const DatingPetListingContainerWidget({
    super.key,
    this.isFromPostList = false,
    this.petData,
    required this.provider,
  });
  final bool isFromPostList;
  final Post? petData;
  final DatingProvider provider;

  @override
  Widget build(BuildContext context) {
    return CommonInkwell(
      onTap: () {
        isFromPostList
            ? null
            : Routes.push(
                context: context,
                screen: DatingDetailsScreen(
                  link: petData?.shareLink ?? "link",
                ),
                exit: () {},
              );
      },
      child: Container(
        width: Responsive.width * 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: AppConstants.black10,
            width: 2,
          ),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 6,
          horizontal: 10,
        ),
        child: Row(
          children: [
            commonNetworkImage(
              url: petData?.image ?? "url",
              height: Responsive.height * 12,
              width: Responsive.width * 24,
              radius: 15,
            ),
            const SizeBoxV(10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  commonTextWidget(
                    color: AppConstants.black,
                    text: petData?.name ?? "name",
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  const SizeBoxH(5),
                  Container(
                    width: 130,
                    padding: const EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xffFFDEB6),
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: commonTextWidget(
                        align: TextAlign.start,
                        color: AppConstants.black,
                        text: provider
                            .getPetAge(petData?.birthdate ?? DateTime.now()),
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizeBoxH(5),
                  commonTextWidget(
                    color: AppConstants.black60,
                    text: "Breed : ${petData?.breed ?? ""}",
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  isFromPostList
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CommonInkwell(
                              onTap: () {
                                Routes.push(
                                  context: context,
                                  screen: DatingCreatePostScreen(
                                    petData: petData,
                                    isEdit: true,
                                    id: petData?.id ?? "",
                                  ),
                                  exit: () {},
                                );
                              },
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: const Color(0xffEE5158),
                                  ),
                                ),
                                child: Image.asset(
                                  AppImages.dateEditIcon,
                                  height: 10,
                                  width: 10,
                                ),
                              ),
                            ),
                            const SizeBoxV(5),
                            CommonInkwell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return ConfirmationWidget(
                                      title: "DELETE",
                                      message: "Are you sure?",
                                      onTap: () {
                                        provider.deleteDatePostFn(
                                          context: context,
                                          id: petData?.id ?? "",
                                        );
                                      },
                                      image: AppImages.deletePng,
                                    );
                                  },
                                );
                              },
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0xffEE5158),
                                  border: Border.all(
                                    color: const Color(0xffEE5158),
                                  ),
                                ),
                                child: Image.asset(
                                  AppImages.dateDeleteIcon,
                                  height: 10,
                                  width: 10,
                                ),
                              ),
                            ),
                          ],
                        )
                      : const SizedBox.shrink()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

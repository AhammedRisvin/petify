import 'package:clan_of_pets/app/helpers/size_box.dart';
import 'package:clan_of_pets/app/module/adopt_a_pet/view_model/adopt_provider.dart';
import 'package:clan_of_pets/app/module/widget/empty_screen.dart';
import 'package:clan_of_pets/app/utils/app_images.dart';
import 'package:clan_of_pets/app/utils/enums.dart';
import 'package:clan_of_pets/app/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../helpers/common_widget.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_router.dart';
import '../../pet profile/widget/search_widget.dart';
import '../widget/adopt_pet_listing_container.dart';
import 'adopt_pet_detailed_view_screen.dart';
import 'intrested_pet_listing_screen.dart';

class AdoptAPetHomeScreen extends StatefulWidget {
  const AdoptAPetHomeScreen({super.key});

  @override
  State<AdoptAPetHomeScreen> createState() => _AdoptAPetHomeScreenState();
}

AdoptProvider? provider;

class _AdoptAPetHomeScreenState extends State<AdoptAPetHomeScreen> {
  @override
  void initState() {
    super.initState();
    provider = Provider.of<AdoptProvider>(context, listen: false);
    provider?.getAllAdoptionPetsFn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: AppConstants.white,
        title: const commonTextWidget(
          text: "Adopt a Pet",
          color: AppConstants.black,
          fontSize: 14,
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
          CommonInkwell(
            onTap: () {
              Routes.push(
                context: context,
                screen: const IntrestedPetListingScreen(),
                exit: () {},
              );
            },
            child: Image.asset(
              AppImages.intrestedPetIcon,
              height: 30,
            ),
          ),
          const SizeBoxV(10)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          bottom: 16.0,
          right: 16.0,
          left: 16.0,
        ),
        child: Consumer<AdoptProvider>(
          builder: (context, provider, child) => provider.status ==
                  GetAllAdoptionPetStatus.loading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : provider.status == GetAllAdoptionPetStatus.loaded
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SearchWidget(
                          onChanged: (value) {
                            provider.getAllAdoptionPetsFn(search: value);
                          },
                          hintText: "Search for pets",
                        ),
                        provider.allPetModel.feeds?.isEmpty == true
                            ? const SizedBox.shrink()
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const commonTextWidget(
                                    color: AppConstants.black,
                                    text: "Catagories",
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                  const SizeBoxH(10),
                                  SizedBox(
                                    height: Responsive.height * 5,
                                    child: ListView.separated(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final isSelected =
                                            provider.selectedIndex == index;
                                        final species =
                                            provider.speciesList[index];
                                        return CommonInkwell(
                                          onTap: () {
                                            provider.updateIndex(index);
                                            if (index == 0) {
                                              provider.getAllAdoptionPetsFn(
                                                  petType: '');
                                            } else {
                                              provider.getAllAdoptionPetsFn(
                                                petType: species,
                                              );
                                            }
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: isSelected
                                                  ? AppConstants.appPrimaryColor
                                                  : AppConstants.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                color: AppConstants.black10,
                                              ),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 20,
                                              vertical: 5,
                                            ),
                                            margin: const EdgeInsets.only(
                                                right: 10),
                                            child: Center(
                                              child: commonTextWidget(
                                                color: isSelected
                                                    ? AppConstants.white
                                                    : AppConstants.black,
                                                text: species,
                                                fontWeight: isSelected
                                                    ? FontWeight.w600
                                                    : FontWeight.w400,
                                                fontSize: isSelected ? 14 : 12,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: provider.speciesList.length,
                                      separatorBuilder: (context, index) =>
                                          const SizeBoxH(10),
                                    ),
                                  ),
                                ],
                              ),
                        const SizeBoxH(10),
                        provider.allPetModel.feeds?.isEmpty == true
                            ? EmptyScreenWidget(
                                text: 'No Pets Found',
                                image: AppImages.noAppoinmentImage,
                                height: Responsive.height * 50,
                              )
                            : Expanded(
                                child: GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: Responsive.height * 0.11,
                                  ),
                                  itemCount:
                                      provider.allPetModel.feeds?.length ?? 0,
                                  itemBuilder: (context, index) {
                                    final petFeedData =
                                        provider.allPetModel.feeds?[index];
                                    return CommonInkwell(
                                      onTap: () {
                                        Routes.push(
                                          context: context,
                                          screen: AdoptPetDetailedViewScreen(
                                            petId: petFeedData?.id ?? '',
                                            image: petFeedData?.image ?? '',
                                          ),
                                          exit: () {},
                                        );
                                      },
                                      child: AdoptPetListingContainer(
                                        petFeedData: petFeedData,
                                      ),
                                    );
                                  },
                                ),
                              )
                      ],
                    )
                  : EmptyScreenWidget(
                      text: "Server is Busy, Please try again later!",
                      image: AppImages.noAppoinmentImage,
                      height: Responsive.height * 80,
                    ),
        ),
      ),
    );
  }
}

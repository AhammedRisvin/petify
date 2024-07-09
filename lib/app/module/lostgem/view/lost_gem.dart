import 'package:clan_of_pets/app/module/lostgem/view/register_a_lostpage.dart';
import 'package:clan_of_pets/app/module/lostgem/view_model/lostgem_provider.dart';
import 'package:clan_of_pets/app/module/lostgem/widgets/lost_pet_container.dart';
import 'package:clan_of_pets/app/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../helpers/common_widget.dart';
import '../../../helpers/size_box.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_images.dart';
import '../../../utils/app_router.dart';
import '../../../utils/extensions.dart';
import '../../home/view/home_screen.dart';
import '../../pet profile/widget/search_widget.dart';
import '../../widget/empty_screen.dart';
import '../widgets/shimmer-container.dart';

class LostGemScreen extends StatefulWidget {
  const LostGemScreen({super.key});

  @override
  State<LostGemScreen> createState() => _LostGemScreenState();
}

class _LostGemScreenState extends State<LostGemScreen> {
  @override
  void initState() {
    super.initState();
    context.read<LostGemProvider>().getLostPetFn(status: "", keyword: "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.white,
      appBar: AppBar(
        backgroundColor: AppConstants.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const commonTextWidget(
              text: "Lost & Found Pets",
              color: AppConstants.black,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            CommonInkwell(
              onTap: () {
                Routes.push(
                  context: context,
                  screen: RegisterALostPetScreen(),
                  exit: () {},
                );
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: const BoxDecoration(
                  color: Color(0xffF5F5F7),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                alignment: Alignment.center,
                child: const commonTextWidget(
                  text: "Register a lost pet",
                  color: Color(0xffF5895A),
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            )
          ],
        ),
        leading: IconButton(
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Consumer<LostGemProvider>(
          builder: (context, provider, child) => Column(
            children: [
              SearchWidget(
                hintText: "Search lost pet",
                onChanged: (value) {
                  context
                      .read<LostGemProvider>()
                      .getLostPetFn(status: "", keyword: value);
                },
              ),
              const SizeBoxH(10),
              SizedBox(
                width: Responsive.width * 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonBannerButtonWidget(
                      text: "All",
                      borderColor: Colors.transparent,
                      bgColor: provider.selectedContainer ==
                              LostPetSelectedContainer.lostPetAll
                          ? AppConstants.appPrimaryColor
                          : AppConstants.greyContainerBg,
                      textColor: provider.selectedContainer ==
                              LostPetSelectedContainer.lostPetAll
                          ? AppConstants.white
                          : AppConstants.subTextGrey,
                      fontSize: 12,
                      width: Responsive.width * 18,
                      onTap: () {
                        provider.getLostPetFn(status: "", keyword: "");
                        provider.updateSelectedContainer(
                            LostPetSelectedContainer.lostPetAll);
                      },
                    ),
                    const SizeBoxV(15),
                    CommonBannerButtonWidget(
                      text: "Missing",
                      borderColor: Colors.transparent,
                      bgColor: provider.selectedContainer ==
                              LostPetSelectedContainer.lostPetMissing
                          ? AppConstants.appPrimaryColor
                          : AppConstants.greyContainerBg,
                      textColor: provider.selectedContainer ==
                              LostPetSelectedContainer.lostPetMissing
                          ? AppConstants.white
                          : AppConstants.subTextGrey,
                      fontSize: 12,
                      width: Responsive.width * 18,
                      onTap: () {
                        provider.getLostPetFn(status: "Missing", keyword: "");
                        provider.updateSelectedContainer(
                            LostPetSelectedContainer.lostPetMissing);
                      },
                    ),
                    const SizeBoxV(15),
                    CommonBannerButtonWidget(
                      text: "Found",
                      borderColor: Colors.transparent,
                      bgColor: provider.selectedContainer ==
                              LostPetSelectedContainer.lostPetFound
                          ? AppConstants.appPrimaryColor
                          : AppConstants.greyContainerBg,
                      textColor: provider.selectedContainer ==
                              LostPetSelectedContainer.lostPetFound
                          ? AppConstants.white
                          : AppConstants.subTextGrey,
                      fontSize: 12,
                      width: Responsive.width * 18,
                      onTap: () {
                        provider.getLostPetFn(status: "Found", keyword: "");
                        provider.updateSelectedContainer(
                            LostPetSelectedContainer.lostPetFound);
                      },
                    ),
                    const SizeBoxV(15),
                    CommonBannerButtonWidget(
                      text: "My Lost Pet",
                      borderColor: Colors.transparent,
                      bgColor: provider.selectedContainer ==
                              LostPetSelectedContainer.myLostPet
                          ? AppConstants.appPrimaryColor
                          : AppConstants.greyContainerBg,
                      textColor: provider.selectedContainer ==
                              LostPetSelectedContainer.myLostPet
                          ? AppConstants.white
                          : AppConstants.subTextGrey,
                      fontSize: 12,
                      width: Responsive.width * 18,
                      onTap: () {
                        provider.getLostPetFn(status: "myPets", keyword: "");
                        provider.updateSelectedContainer(
                            LostPetSelectedContainer.myLostPet);
                      },
                    ),
                  ],
                ),
              ),
              SizeBoxH(Responsive.height * 2),
              provider.getLostPetModel.pets?.isEmpty == true
                  ? EmptyScreenWidget(
                      height: Responsive.height * 50,
                      image: AppImages.noBlogImage,
                      text:
                          " No lost pet found. \n\n Please register a lost pet.",
                    )
                  : ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: provider.getLostPetModel.pets?.length ?? 0,
                      separatorBuilder: (context, index) =>
                          SizeBoxH(Responsive.height * 2),
                      itemBuilder: (context, index) {
                        final lostPetData = provider.getLostPetModel.pets?[
                            (provider.getLostPetModel.pets?.length ?? 0) -
                                1 -
                                index];
                        return provider.getLostPetStatus ==
                                GetLostPetStatus.loading
                            ? const LostPetContainerShimmer(
                                isFound: true,
                              )
                            : provider.getLostPetStatus ==
                                    GetLostPetStatus.loaded
                                ? LostPetContainer(
                                    lostPetData: lostPetData,
                                  )
                                : Container();
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

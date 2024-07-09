import 'package:clan_of_pets/app/helpers/size_box.dart';
import 'package:clan_of_pets/app/module/widget/empty_screen.dart';
import 'package:clan_of_pets/app/utils/app_images.dart';
import 'package:clan_of_pets/app/utils/enums.dart';
import 'package:clan_of_pets/app/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../helpers/common_widget.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_router.dart';
import '../view_model/adopt_provider.dart';

class IntrestedPetListingScreen extends StatefulWidget {
  const IntrestedPetListingScreen({super.key});

  @override
  State<IntrestedPetListingScreen> createState() =>
      _IntrestedPetListingScreenState();
}

AdoptProvider? adoptProvider;

class _IntrestedPetListingScreenState extends State<IntrestedPetListingScreen> {
  @override
  void initState() {
    super.initState();
    adoptProvider = context.read<AdoptProvider>();
    adoptProvider?.getIntrestedPetFn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.white,
      appBar: AppBar(
        backgroundColor: AppConstants.white,
        title: const commonTextWidget(
          text: "Intrested Pets",
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
                  AppConstants.white.withOpacity(0.1),
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
      ),
      body: Consumer<AdoptProvider>(
        builder: (context, provider, child) =>
            provider.shownIntrestModel.feeds?.isEmpty == true
                ? EmptyScreenWidget(
                    text: "You haven't shown intrest to any pet",
                    image: AppImages.noAppoinmentImage,
                    height: Responsive.height * 80,
                  )
                : provider.shownIntrestStatus == GetShowIntrestStatus.loading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : provider.shownIntrestStatus == GetShowIntrestStatus.loaded
                        ? ListView.separated(
                            padding: const EdgeInsets.all(16),
                            itemBuilder: (context, index) {
                              final intrestData =
                                  provider.shownIntrestModel.feeds?[index];
                              return Card(
                                elevation: 1,
                                child: Container(
                                  width: Responsive.width * 100,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: AppConstants.white,
                                    border: Border.all(
                                      color: AppConstants.black10,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    children: [
                                      commonNetworkImage(
                                        url: intrestData?.image ?? '',
                                        height: 80,
                                        width: 80,
                                      ),
                                      const SizeBoxV(10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          commonTextWidget(
                                            color: AppConstants.black,
                                            text: intrestData?.petName ?? '',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                            maxLines: 2,
                                            overFlow: TextOverflow.ellipsis,
                                          ),
                                          const SizeBoxH(10),
                                          Row(
                                            children: [
                                              CommonContainer(
                                                text: intrestData?.gender ?? '',
                                              ),
                                              CommonContainer(
                                                text: provider.getPetAge(
                                                  intrestData?.birthday ??
                                                      DateTime.now(),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      CommonInkwell(
                                        onTap: () {
                                          adoptProvider?.showUnIntrest(
                                            ctx: context,
                                            petId: intrestData?.id ?? '',
                                          );
                                        },
                                        child: const CommonContainer(
                                          text: "Un intrested",
                                          isBgOrange: true,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const SizeBoxH(10),
                            itemCount:
                                provider.shownIntrestModel.feeds?.length ?? 0,
                          )
                        : EmptyScreenWidget(
                            text: "Server is busy, try again later",
                            image: AppImages.noCommunityImage,
                            height: Responsive.height * 80,
                          ),
      ),
    );
  }
}

class CommonContainer extends StatelessWidget {
  const CommonContainer({
    super.key,
    required this.text,
    this.isBgOrange = false,
  });

  final String text;
  final bool isBgOrange;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: isBgOrange ? AppConstants.appPrimaryColor : AppConstants.white,
        border: Border.all(
          color: AppConstants.appPrimaryColor,
        ),
      ),
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      child: Center(
        child: commonTextWidget(
          color: isBgOrange ? AppConstants.white : AppConstants.appPrimaryColor,
          text: text,
          maxLines: 2,
          overFlow: TextOverflow.ellipsis,
          fontWeight: FontWeight.w500,
          fontSize: 10,
        ),
      ),
    );
  }
}

import 'package:clan_of_pets/app/module/community/community%20home/provider/community_home_provider.dart';
import 'package:clan_of_pets/app/module/community/community%20home/view/widgets/trending_community_widget.dart';
import 'package:clan_of_pets/app/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../helpers/common_widget.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_router.dart';
import '../../../../utils/extensions.dart';
import '../../community details/view/community_details_scree.dart';

class JoinedCommunityScreen extends StatelessWidget {
  const JoinedCommunityScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.white,
      appBar: AppBar(
        backgroundColor: AppConstants.white,
        title: const commonTextWidget(
          text: "Joined Community",
          color: AppConstants.black,
          fontSize: 18,
          fontWeight: FontWeight.w600,
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
        actions: const [],
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: Container(
              padding: const EdgeInsets.only(left: 10, right: 10),
              height: 46,
              width: Responsive.width * 100,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(30)),
              child: CommonTextFormField(
                bgColor: const Color(0xffF3F3F5),
                hintText: "Search joined communities",
                keyboardType: TextInputType.text,
                controller: context
                    .read<CommunityHomeProvider>()
                    .joinedCommunitySearchCOntroller,
                radius: 30,
                textInputAction: TextInputAction.done,
                onChanged: (value) {
                  context
                      .read<CommunityHomeProvider>()
                      .joinedCommunitySearchFn(enteredKeyword: value);
                },
                suffixIcon: Icon(
                  Icons.search,
                  size: 20,
                  color: AppConstants.black.withOpacity(.5),
                ),
              ),
            )),
      ),
      body: Container(
        margin: const EdgeInsets.all(15),
        child: Consumer<CommunityHomeProvider>(
          builder: (context, provider, child) => provider
                  .joinedCommunityFOundList.isEmpty
              ? Center(
                  child: Image.asset(
                  AppImages.noCommunityImage,
                  height: Responsive.height * 30,
                  width: Responsive.width * 40,
                ))
              : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    childAspectRatio: 1.1,
                  ),
                  itemCount: provider.joinedCommunityFOundList.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final trendingCommunityData =
                        provider.joinedCommunityFOundList[index];
                    return CommonInkwell(
                      onTap: () {
                        Routes.push(
                          context: context,
                          screen: CommunityDetailsScreen(
                            communityShareLink:
                                trendingCommunityData.shareLink ?? '',
                            communityFeedId: trendingCommunityData.id ?? '',
                          ),
                          exit: () {},
                        );
                      },
                      child: TrendingCommunityWidget(
                        isTendingCommunity: false,
                        trendingCommunityData: trendingCommunityData,
                        function: () {},
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}

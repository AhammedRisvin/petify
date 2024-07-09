import 'package:clan_of_pets/app/module/community/community%20home/provider/community_home_provider.dart';
import 'package:clan_of_pets/app/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../helpers/common_widget.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../../utils/app_router.dart';
import '../../../../../utils/extensions.dart';
import 'all_community_widget.dart';

class AllCommunityScreen extends StatefulWidget {
  const AllCommunityScreen({
    super.key,
  });

  @override
  State<AllCommunityScreen> createState() => _AllCommunityScreenState();
}

class _AllCommunityScreenState extends State<AllCommunityScreen> {
  @override
  void initState() {
    getAllCommunityScrollController.addListener(_onScroll);
    context
        .read<CommunityHomeProvider>()
        .allCommunitySearchFn(enteredKeyword: "", pageNum: 1);

    super.initState();
  }

  @override
  void dispose() {
    getAllCommunityScrollController.dispose();

    super.dispose();
  }

  final getAllCommunityScrollController = ScrollController();

  void _onScroll() {
    if (getAllCommunityScrollController.position.pixels >=
        getAllCommunityScrollController.position.maxScrollExtent) {
      context.read<CommunityHomeProvider>().allCommunitySearchFn(
            enteredKeyword: "",
          );
    }
  }

  final double loadMoreThreshold = 300.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const commonTextWidget(
          text: "All Community",
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
                hintText: "Search all communities",
                keyboardType: TextInputType.text,
                controller: context
                    .read<CommunityHomeProvider>()
                    .allCommunitySearchCOntroller,
                radius: 30,
                textInputAction: TextInputAction.done,
                onChanged: (value) {
                  context
                      .read<CommunityHomeProvider>()
                      .allCommunitySearchFn(enteredKeyword: value);
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
                  .allCommunityFOundList.isEmpty
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
                  physics: const ScrollPhysics(),
                  controller: getAllCommunityScrollController,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    if (index < provider.allCommunityFOundList.length) {
                      final trendingCommunityData =
                          provider.allCommunityFOundList[index];
                      return CommonInkwell(
                        onTap: () {},
                        child: AllCommunityWidget(
                          trendingCommunityData: trendingCommunityData,
                          function: () {},
                        ),
                      );
                    } else if (provider.allCommunitySearchFnStatus == 0 &&
                        index == provider.allCommunityFOundList.length &&
                        provider.allCommunityListEnded == false) {
                      return SizedBox(
                        height: Responsive.height * 23,
                        width: Responsive.width * 100,
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: Colors.amber,
                          ),
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                  itemCount: provider.allCommunityFOundList.length +
                      (provider.allCommunitySearchFnStatus == 0 ? 1 : 0),
                ),
        ),
      ),
    );
  }
}

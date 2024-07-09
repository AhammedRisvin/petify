import 'package:clan_of_pets/app/module/Dating/view%20model/dating_provider.dart';
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
import 'chat_listing_screen.dart';
import 'dating_homescreen.dart';

class DatingPostListScreen extends StatefulWidget {
  const DatingPostListScreen({super.key});

  @override
  State<DatingPostListScreen> createState() => _DatingPostListScreenState();
}

class _DatingPostListScreenState extends State<DatingPostListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<DatingProvider>().getUserDatePostFn();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.white,
      appBar: AppBar(
        backgroundColor: AppConstants.white,
        title: const commonTextWidget(
          text: "Post List",
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
          CommonInkwell(
            onTap: () {
              Routes.push(
                context: context,
                screen: const ChatListingScreen(),
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
                AppImages.dateChatIcon,
                height: 20,
                width: 20,
              ),
            ),
          ),
          SizeBoxV(Responsive.width * 2),
        ],
      ),
      body: Consumer<DatingProvider>(
        builder: (context, provider, child) {
          return provider.getUserPostModel.posts?.isEmpty == true
              ? EmptyScreenWidget(
                  text: "You haven't created any post!",
                  image: AppImages.noBlogImage,
                  height: Responsive.height * 80,
                )
              : provider.getUserDatePostStatus == GetUserDatePostStatus.loading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: AppConstants.appPrimaryColor,
                      ),
                    )
                  : provider.getUserDatePostStatus ==
                          GetUserDatePostStatus.loaded
                      ? ListView.separated(
                          padding: const EdgeInsets.all(16),
                          itemBuilder: (context, index) {
                            final petData =
                                provider.getUserPostModel.posts?[index];
                            return DatingPetListingContainerWidget(
                              isFromPostList: true,
                              petData: petData,
                              provider: provider,
                            );
                          },
                          separatorBuilder: (context, index) =>
                              const SizeBoxH(10),
                          itemCount:
                              provider.getUserPostModel.posts?.length ?? 0,
                        )
                      : const Center(
                          child:
                              Text("Something went wrong! Please try again."),
                        );
        },
      ),
    );
  }
}

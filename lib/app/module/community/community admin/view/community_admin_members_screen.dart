import 'package:clan_of_pets/app/module/community/community%20admin/provider/community_admin_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../helpers/common_widget.dart';
import '../../../../helpers/size_box.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/app_router.dart';
import '../../../../utils/extensions.dart';
import 'community_admin_profile_screen.dart';

class CommunityMembersScreen extends StatelessWidget {
  final String communityId;
  final String adminId;
  const CommunityMembersScreen({
    super.key,
    required this.communityId,
    required this.adminId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.white,
      appBar: AppBar(
        backgroundColor: AppConstants.white,
        title: const commonTextWidget(
          text: "",
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
              padding: const EdgeInsets.only(left: 15, right: 10),
              height: 46,
              width: Responsive.width * 100,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(30)),
              child: CommonTextFormField(
                bgColor: const Color(0xffF3F3F5),
                hintText: "Search here",
                keyboardType: TextInputType.text,
                controller: context
                    .read<CommunityAdminProvider>()
                    .communityMembersSearchCOntroller,
                onChanged: (value) {
                  context
                      .read<CommunityAdminProvider>()
                      .getCommunityMembersListSearchFn(
                          communityId: communityId, enteredKeyword: value);
                },
                radius: 30,
                textInputAction: TextInputAction.done,
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
        child: Consumer<CommunityAdminProvider>(
          builder: (context, provider, child) => provider
                  .communityMembersFoundList.isEmpty
              ? Center(
                  child: Image.asset(
                  AppImages.noCommunityImage,
                  height: Responsive.height * 30,
                  width: Responsive.width * 40,
                ))
              : MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) => const SizeBoxH(20),
                      itemCount: provider.communityMembersFoundList.length,
                      itemBuilder: (context, index) {
                        var data = provider.communityMembersFoundList[index];
                        return CommunityAdminMemberWidget(
                          communityId: communityId,
                          data: data,
                          adminId: adminId,
                        );
                      }),
                ),
        ),
      ),
    );
  }
}

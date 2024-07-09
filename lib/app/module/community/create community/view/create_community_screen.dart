import 'package:clan_of_pets/app/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../helpers/common_widget.dart';
import '../../../../helpers/size_box.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_router.dart';
import '../../../pet profile/view/events/create_events_screen.dart';
import '../provider/create_community_provider.dart';

class CreateCommunityScreen extends StatelessWidget {
  CreateCommunityScreen({
    super.key,
  });
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: AppConstants.white,
        title: const commonTextWidget(
          text: "Create a community ",
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
      ),
      body: Container(
        height: Responsive.height * 100,
        width: Responsive.width * 100,
        padding: const EdgeInsets.all(16),
        child: Consumer<CreateCommunityProvider>(
          builder: (context, provider, child) => Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const commonTextWidget(
                    color: AppConstants.black,
                    text: "Community Name",
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  const SizeBoxH(6),
                  Container(
                    height: Responsive.height * 6.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: CommonTextFormField(
                      bgColor: AppConstants.greyContainerBg,
                      hintText: "Community name",
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter community name';
                        } else {
                          return null;
                        }
                      },
                      controller: provider.communityNamerController,
                      radius: 12,
                    ),
                  ),
                  const SizeBoxH(20),
                  const commonTextWidget(
                    color: AppConstants.black,
                    text: "Description",
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  const SizeBoxH(6),
                  TextFormField(
                    onTapOutside: (event) => FocusScope.of(context).unfocus(),
                    controller: provider.communityDescriptionController,
                    maxLines: null,
                    minLines: 6,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.done,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please enter description';
                      } else {
                        return null;
                      }
                    },
                    style: const TextStyle(
                      color: AppConstants.black,
                      fontSize: 12,
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide.none,
                      ),
                      fillColor: AppConstants.greyContainerBg,
                      filled: true,
                      hintText: "Write a description",
                      hintStyle: const TextStyle(
                        color: AppConstants.black40,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizeBoxH(22),
                  const commonTextWidget(
                    color: AppConstants.black,
                    text: "Add Profile Image",
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  const SizeBoxH(6),
                  CommonFileSelectingContainer(
                    text: provider.imageTitlee == null
                        ? " browse from your device "
                        : provider.imageTitlee ?? " ",
                    onTap: () {
                      provider.uploadSingleImage(context);
                    },
                  ),
                  const SizeBoxH(22),
                  const commonTextWidget(
                    color: AppConstants.black,
                    text: "Add Cover Image",
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  const SizeBoxH(6),
                  CommonFileSelectingContainer(
                    text: provider.coverImageTitle == null
                        ? "browse from your device "
                        : provider.coverImageTitle ?? " ",
                    onTap: () {
                      provider.uploadCoverImage(context);
                    },
                  ),
                  const SizeBoxH(22),
                  Align(
                    alignment: Alignment.centerRight,
                    child: CommonButton(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          if (provider.singleImageUr.isEmpty) {
                            toast(context,
                                title: "Select a profile image",
                                backgroundColor: Colors.red);
                          } else if (provider.coverImageUr.isEmpty) {
                            toast(context,
                                title: "Select a Cover image",
                                backgroundColor: Colors.red);
                          } else {
                            if (provider.singleImageUr.isNotEmpty &&
                                provider.coverImageUr.isNotEmpty) {
                              provider.createCommunityFn(context: context);
                            } else {
                              toast(context,
                                  title: "Select a profile image",
                                  backgroundColor: Colors.red);
                            }
                          }
                        }
                      },
                      text: "Post",
                      width: Responsive.width * 50,
                      height: Responsive.height * 7,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

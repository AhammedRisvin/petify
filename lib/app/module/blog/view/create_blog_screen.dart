import 'package:clan_of_pets/app/utils/app_images.dart';
import 'package:clan_of_pets/app/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../helpers/common_widget.dart';
import '../../../helpers/size_box.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_router.dart';
import '../../pet profile/view/events/create_events_screen.dart';
import '../view_model/blog_provioder.dart';

class CreateBlogScreen extends StatelessWidget {
  const CreateBlogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.white,
      appBar: AppBar(
        backgroundColor: AppConstants.white,
        title: const commonTextWidget(
          text: "Create blog",
          color: AppConstants.black,
          fontSize: 16,
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
        margin: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Consumer<BlogProvider>(
            builder: (context, provider, child) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const commonTextWidget(
                  align: TextAlign.start,
                  color: AppConstants.black,
                  text: "Upload your documents",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                Selector<BlogProvider, String?>(
                  selector: (p0, p1) => p1.imageTitle,
                  builder: (context, value, _) => CommonFileSelectingContainer(
                    text: value ?? 'Add Image',
                    onTap: () => context.read<BlogProvider>().uploadImage(),
                  ),
                ),
                SizeBoxH(Responsive.height * 1),
                const commonTextWidget(
                  color: AppConstants.black,
                  text: "Title",
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                SizeBoxH(Responsive.height * 1),
                SizedBox(
                  height: 46,
                  child: CommonTextFormField(
                    bgColor: AppConstants.greyContainerBg,
                    hintText: "Title",
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    controller: provider.blogTitleTextEditingController,
                  ),
                ),
                SizeBoxH(Responsive.height * 2),
                const commonTextWidget(
                  color: AppConstants.black,
                  text: "Date",
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                SizeBoxH(Responsive.height * 1),
                CommonInkwell(
                  onTap: () {
                    provider.blogSelectDate(context);
                  },
                  child: Selector<BlogProvider, String>(
                    selector: (p0, p1) => p1.blogSelectedDateString,
                    builder: (context, value, child) => Container(
                      height: Responsive.height * 6,
                      width: Responsive.width * 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: AppConstants.greyContainerBg,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: Responsive.width * 35,
                            padding: EdgeInsets.symmetric(
                                horizontal: Responsive.width * 2),
                            child: commonTextWidget(
                              align: TextAlign.start,
                              color: value == ""
                                  ? AppConstants.subTextGrey
                                  : AppConstants.black,
                              text: value == "" ? " Date" : value,
                              fontSize: 12,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              right: 15.0,
                            ),
                            child: Image.asset(
                              AppImages.calenderIcon,
                              height: 16,
                              width: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizeBoxH(Responsive.height * 2),
                const commonTextWidget(
                  color: AppConstants.black,
                  text: "Blog",
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                SizeBoxH(Responsive.height * 1),
                SizedBox(
                  height: 90,
                  child: CommonTextFormField(
                    maxLength: null,
                    radius: 10,
                    bgColor: AppConstants.greyContainerBg,
                    hintText: "Write a Blog",
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    controller: provider.blogTextEditingController,
                  ),
                ),
                SizeBoxH(Responsive.height * 1),
                CommonButton(
                  size: 16,
                  onTap: () {
                    provider.createBlogFn(context: context);
                  },
                  text: 'Create Blog',
                  width: Responsive.width * 100,
                  height: 50,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

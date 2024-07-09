import 'package:clan_of_pets/app/module/blog/view_model/blog_provioder.dart';
import 'package:clan_of_pets/app/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../helpers/common_widget.dart';
import '../../../helpers/size_box.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_images.dart';
import '../../../utils/app_router.dart';
import '../../../utils/extensions.dart';
import '../../widget/empty_screen.dart';
import '../model/get_blogs_model.dart';
import '../widget/blog_home_shimmer.dart';
import 'blog_details_screen.dart';

class BlogHomeScreen extends StatefulWidget {
  const BlogHomeScreen({super.key});

  @override
  State<BlogHomeScreen> createState() => _BlogHomeScreenState();
}

class _BlogHomeScreenState extends State<BlogHomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<BlogProvider>().getBlogFn(filter: "all");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppConstants.white,
        title: const commonTextWidget(
          text: "Blog",
          color: AppConstants.black,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        // actions: [
        //   SizedBox(
        //     height: 35,
        //     width: 113,
        //     child: ElevatedButton.icon(
        //       style: ElevatedButton.styleFrom(
        //           elevation: 0,
        //           side: const BorderSide(color: AppConstants.appPrimaryColor),
        //           // backgroundColor: AppConstants.greyContainerBg,
        //           padding: const EdgeInsets.all(8)),
        //       onPressed: () {
        //         Routes.push(
        //           context: context,
        //           screen: const CreateBlogScreen(),
        //           exit: () {},
        //         );
        //       },
        //       icon: const Icon(
        //         Icons.add,
        //         color: AppConstants.appPrimaryColor,
        //         size: 18,
        //       ),
        //       label: const commonTextWidget(
        //         align: TextAlign.start,
        //         color: AppConstants.appPrimaryColor,
        //         text: "Create blog",
        //         fontSize: 12,
        //         fontWeight: FontWeight.w400,
        //       ),
        //     ),
        //   ),
        //   SizeBoxV(Responsive.width * 4),
        // ],
      ),
      body: Container(
        margin: const EdgeInsets.all(16),
        height: Responsive.height * 100,
        width: Responsive.width * 100,
        child: SingleChildScrollView(
          child: Consumer<BlogProvider>(
            builder: (context, provider, child) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                provider.blogModel.mostlyLikedBlogs?.isEmpty == true
                    ? const SizedBox.shrink()
                    : const commonTextWidget(
                        height: 23.44,
                        align: TextAlign.start,
                        text: "Your Daily",
                        color: AppConstants.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                      ),
                provider.blogModel.mostlyLikedBlogs?.isEmpty == true
                    ? const SizedBox.shrink()
                    : const commonTextWidget(
                        align: TextAlign.start,
                        color: AppConstants.black,
                        text: "Recommentation",
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      ),
                provider.blogModel.mostlyLikedBlogs?.isEmpty == true
                    ? const SizedBox.shrink()
                    : Container(
                        height: Responsive.height * 26,
                        margin: const EdgeInsets.only(top: 15, bottom: 15),
                        child: ListView.separated(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: 2,
                            separatorBuilder: (context, index) {
                              return const SizeBoxV(20);
                            },
                            itemBuilder: (context, index) {
                              // var mostlyLikedBlogsData =
                              //     provider.blogModel.mostlyLikedBlogs?[index];
                              return BlogRecomendationWidget(
                                onTap: () {
                                  Routes.push(
                                    context: context,
                                    screen: const BlogDetailsScreen(),
                                    exit: () {},
                                  );
                                },
                              );
                            }),
                      ),
                Selector<BlogProvider, String>(
                  selector: (p0, p1) => p1.selectedTabBlog,
                  builder: (context, value, child) => Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Row(
                      children: [
                        BlogTabWidget(
                          onTap: () {
                            context
                                .read<BlogProvider>()
                                .getBlogFn(filter: "all");
                            context
                                .read<BlogProvider>()
                                .selectedTabBlogFn('All');
                          },
                          text: 'All',
                          width: 25,
                          color: value == 'All'
                              ? AppConstants.appPrimaryColor
                              : AppConstants.black.withOpacity(.4),
                        ),
                        SizeBoxV(Responsive.width * 10),
                        BlogTabWidget(
                          onTap: () {
                            context
                                .read<BlogProvider>()
                                .getBlogFn(filter: "top");
                            context
                                .read<BlogProvider>()
                                .selectedTabBlogFn('Top');
                          },
                          text: 'Top',
                          width: 30,
                          color: value == 'Top'
                              ? AppConstants.appPrimaryColor
                              : AppConstants.black.withOpacity(.4),
                        ),
                        SizeBoxV(Responsive.width * 10),
                        BlogTabWidget(
                          onTap: () {
                            context
                                .read<BlogProvider>()
                                .getBlogFn(filter: "trending");
                            context
                                .read<BlogProvider>()
                                .selectedTabBlogFn('Trending');
                          },
                          text: 'Trending',
                          width: 70,
                          color: value == 'Trending'
                              ? AppConstants.appPrimaryColor
                              : AppConstants.black.withOpacity(.4),
                        ),
                      ],
                    ),
                  ),
                ),
                provider.blogModel.blogDatas?.isEmpty == true
                    ? EmptyScreenWidget(
                        image: AppImages.noBlogImage,
                        height: Responsive.height * 50,
                        text:
                            "No blogs, Feeling creative? Write a post about something that inspires you.",
                      )
                    : ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: provider.blogModel.blogDatas?.length ?? 0,
                        separatorBuilder: (context, index) =>
                            const SizeBoxH(10),
                        itemBuilder: (context, index) {
                          var blogData = provider.blogModel.blogDatas?[index];
                          return provider.getBlogStatus == GetBlogStatus.loading
                              ? const BlogWidgetShimmer()
                              : provider.getBlogStatus == GetBlogStatus.loaded
                                  ? CommonInkwell(
                                      onTap: () {
                                        provider.updateSingleBlogData(blogData);

                                        Routes.push(
                                          context: context,
                                          screen: const BlogDetailsScreen(),
                                          exit: () {},
                                        );
                                      },
                                      child: BlogWidget(
                                        blogData: blogData,
                                      ),
                                    )
                                  : const Text("Something Went Wrong");
                        },
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BlogWidget extends StatelessWidget {
  final BlogData? blogData;
  const BlogWidget({
    super.key,
    this.blogData,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: commonNetworkImage(
                radius: 16,
                url: blogData?.blogImage ?? '',
                height: 85,
                width: Responsive.width * 28,
              ),
            ),
            Expanded(
              child: SizedBox(
                height: 85,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    commonTextWidget(
                      overFlow: TextOverflow.ellipsis,
                      height: 14.44,
                      align: TextAlign.start,
                      text: blogData?.title ?? "",
                      color: AppConstants.black,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                    commonTextWidget(
                      overFlow: TextOverflow.ellipsis,
                      height: 14.44,
                      align: TextAlign.start,
                      text: blogData?.blog ?? "",
                      color: AppConstants.black.withOpacity(.4),
                      fontSize: 11,
                      maxLines: 1,
                      fontWeight: FontWeight.w300,
                    ),
                    Row(
                      children: [
                        commonNetworkImage(
                            radius: 30,
                            url: blogData?.userImage ??
                                '', //blogData?.blogImage ?? ''
                            height: 35,
                            width: 35),
                        SizeBoxV(Responsive.width * 2),
                        commonTextWidget(
                          align: TextAlign.start,
                          color: AppConstants.black,
                          text: blogData?.userName ?? "",
                          fontSize: 12,
                          overFlow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w500,
                        ),
                        SizeBoxV(Responsive.width * 2),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: commonTextWidget(
                              align: TextAlign.start,
                              color: AppConstants.black.withOpacity(.4),
                              text: context.read<BlogProvider>().formatDate(
                                    blogData?.createdAt ?? DateTime.now(),
                                  ),
                              fontSize: 9,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BlogTabWidget extends StatelessWidget {
  final String text;
  final double width;
  final Color? color;
  final void Function()? onTap;

  const BlogTabWidget({
    super.key,
    required this.text,
    required this.width,
    this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CommonInkwell(
      onTap: onTap,
      child: Selector<BlogProvider, String>(
        selector: (p0, p1) => p1.selectedTabBlog,
        builder: (context, value, child) => SizedBox(
          height: 30,
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text,
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: color,
                  fontSize: 14,
                  fontFamily: GoogleFonts.roboto().fontFamily,
                  fontWeight: FontWeight.w500,
                ),
              ),
              value == text
                  ? Expanded(
                      child: Divider(
                        thickness: 3,
                        color: color,
                      ),
                    )
                  : const SizedBox.shrink()
            ],
          ),
        ),
      ),
    );
  }
}

class BlogRecomendationWidget extends StatelessWidget {
  final void Function()? onTap;
  const BlogRecomendationWidget({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CommonInkwell(
      onTap: onTap,
      child: Container(
        width: Responsive.width * 43,
        height: Responsive.height * 26,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: AppConstants.black.withOpacity(.4),
                offset: const Offset(0, 4),
                blurRadius: 14)
          ],
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          // color: AppConstants.appCommonRed,
          image: const DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
                'https://i.pinimg.com/originals/bf/e3/89/bfe389e3abeb648129371b57a2262d8d.jpg'),
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.all(10),
                height: Responsive.height * 7,
                width: Responsive.width * 43,
                decoration: BoxDecoration(
                    color: AppConstants.black.withOpacity(.7),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: Row(
                  children: [
                    const commonNetworkImage(
                        radius: 30,
                        url:
                            'https://i.pinimg.com/originals/bf/e3/89/bfe389e3abeb648129371b57a2262d8d.jpg',
                        height: 25,
                        width: 25),
                    SizeBoxV(Responsive.width * 2),
                    const commonTextWidget(
                      align: TextAlign.start,
                      color: AppConstants.white,
                      text: "Juliya Rodrigo",
                      fontSize: 9,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: Responsive.height * 5.2,
              left: 10,
              child: const commonTextWidget(
                align: TextAlign.start,
                color: AppConstants.white,
                text: "Benefits of Pet Grooming\nServices",
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

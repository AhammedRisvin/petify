// ignore_for_file: deprecated_member_use

import 'package:clan_of_pets/app/helpers/common_widget.dart';
import 'package:flutter/material.dart';

import '../../../../helpers/size_box.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/extensions.dart';

class ImageScreen extends StatefulWidget {
  final String? imageUrl;
  final String? content;
  final String? profilePicUrl;
  const ImageScreen({
    super.key,
    this.imageUrl,
    this.content,
    this.profilePicUrl,
  });

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.transparent,
      appBar: AppBar(
        backgroundColor: AppConstants.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: const ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizeBoxH(Responsive.height * 20),
          SizedBox(
            height: Responsive.height * 40,
            width: Responsive.width * 90,
            child: commonNetworkImage(
              url: widget.imageUrl ?? '',
              height: Responsive.height * 40,
              width: Responsive.width * 90,
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                commonNetworkImage(
                  url: widget.profilePicUrl == null ||
                          widget.profilePicUrl?.isEmpty == true
                      ? "https://media.istockphoto.com/id/526947869/vector/man-silhouette-profile-picture.jpg?s=612x612&w=0&k=20&c=5I7Vgx_U6UPJe9U2sA2_8JFF4grkP7bNmDnsLXTYlSc="
                      : widget.profilePicUrl ?? '',
                  height: 40,
                  width: 40,
                  radius: 100,
                ),
                const SizeBoxV(10),
                Expanded(
                  child: commonTextWidget(
                    color: AppConstants.white,
                    text: widget.content ?? '',
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          const SizeBoxH(10),
        ],
      ),
    );
  }
}

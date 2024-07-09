// ignore_for_file: deprecated_member_use

import 'package:clan_of_pets/app/helpers/size_box.dart';
import 'package:clan_of_pets/app/module/community/chat/view%20model/chat_provider.dart';
import 'package:clan_of_pets/app/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../helpers/common_widget.dart';
import '../../../../utils/app_constants.dart';

class SelectedMediaViewScreen extends StatefulWidget {
  const SelectedMediaViewScreen({
    super.key,
    required this.onTap,
  });
  final Function(String? caption) onTap;
  @override
  State<SelectedMediaViewScreen> createState() =>
      _SelectedMediaViewScreenState();
}

class _SelectedMediaViewScreenState extends State<SelectedMediaViewScreen> {
  TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: AppConstants.transparent,
        title: const commonTextWidget(
          text: "Media",
          color: AppConstants.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
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
      backgroundColor: AppConstants.transparent,
      body: Consumer<ChatProvider>(
        builder: (context, value, child) => SizedBox(
          height: Responsive.height * 100,
          width: Responsive.width * 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizeBoxH(Responsive.height * 20),
              SizedBox(
                height: Responsive.height * 40,
                width: Responsive.width * 90,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image(
                    image: Image.file(value.petDocumentFiles.first).image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Spacer(),
              Container(
                margin: const EdgeInsets.only(
                    bottom: 20, right: 10, left: 10, top: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(
                    color: AppConstants.black40,
                  ),
                ),
                child: CommonTextFormField(
                  bgColor: AppConstants.transparent,
                  hintText: "Type a message...",
                  color: AppConstants.white,
                  hintTextColor: AppConstants.white,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.done,
                  controller: controller,
                  suffixIcon: IconButton(
                    onPressed: () {
                      widget.onTap(controller.text);
                    },
                    icon: const Icon(
                      Icons.send,
                      color: AppConstants.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

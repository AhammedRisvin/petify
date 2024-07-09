import 'package:clan_of_pets/app/helpers/size_box.dart';
import 'package:flutter/material.dart';

import '../../../helpers/common_widget.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_router.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.white,
      appBar: AppBar(
        backgroundColor: AppConstants.white,
        title: const commonTextWidget(
          text: "Notification",
          color: AppConstants.black,
          fontSize: 17,
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        physics: const ScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    children: [
                      const commonNetworkImage(
                        url:
                            "https://plus.unsplash.com/premium_photo-1664303072846-5dfab1ba8304?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8ZG9nJTIwcHJvZmlsZSUyMHBpY3R1cmV8ZW58MHx8MHx8fDA=",
                        height: 50,
                        width: 50,
                        radius: 100,
                      ),
                      const SizeBoxV(10),
                      Expanded(
                        child: SizedBox(
                          child: RichText(
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                            text: const TextSpan(
                              style: TextStyle(
                                color: Colors.black, // Change color as needed
                              ),
                              children: [
                                TextSpan(
                                  text: 'Danie David ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      'posted a feed in pet grooming community  Group aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    wordSpacing: 1.4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const commonTextWidget(
                        color: AppConstants.subTextGrey,
                        text: "9:30 Am",
                        fontSize: 10,
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizeBoxH(10),
              itemCount: 30,
            )
          ],
        ),
      ),
    );
  }
}

import 'package:clan_of_pets/app/helpers/size_box.dart';
import 'package:clan_of_pets/app/utils/extensions.dart';
import 'package:flutter/material.dart';

import '../../../helpers/common_widget.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_router.dart';

class SwitchAccountScreen extends StatelessWidget {
  const SwitchAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.white,
      appBar: AppBar(
        backgroundColor: AppConstants.white,
        title: const commonTextWidget(
          text: "Choose Account",
          color: AppConstants.black,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        leading: Transform.scale(
          scale: 0.6,
          child: IconButton(
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
      ),
      body: Column(
        children: [
          SizeBoxH(Responsive.height * 1.2),
          ListView.separated(
            shrinkWrap: true,
            padding: const EdgeInsets.all(16),
            itemBuilder: (context, index) {
              return Container(
                width: Responsive.width * 100,
                decoration: BoxDecoration(
                  color: AppConstants.white,
                  border: Border.all(
                    color: AppConstants.black10,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 18,
                  horizontal: 15,
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: commonTextWidget(
                        align: TextAlign.start,
                        color: AppConstants.black,
                        text: "Continue as petRole of ownerName",
                        maxLines: 3,
                        overFlow: TextOverflow.ellipsis,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 14,
                      color: AppConstants.appPrimaryColor,
                    )
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => SizeBoxH(
              Responsive.height * 1.7,
            ),
            itemCount: 5,
          ),
        ],
      ),
    );
  }
}

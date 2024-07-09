import 'package:clan_of_pets/app/helpers/size_box.dart';
import 'package:clan_of_pets/app/module/Pet%20services/view_model/services_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../helpers/common_widget.dart';
import '../../../utils/app_constants.dart';

class HealthOptionWidget extends StatelessWidget {
  final String title;
  const HealthOptionWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    String status =
        Provider.of<ServiceProvider>(context).getSelectionStatus(title);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        commonTextWidget(
          text: title,
          color: AppConstants.black,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        const SizeBoxH(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => Provider.of<ServiceProvider>(context, listen: false)
                  .setSelectionStatus(title, status == 'No' ? '' : 'No'),
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: CircleAvatar(
                  radius: 12,
                  backgroundColor: AppConstants.appPrimaryColor,
                  child: CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 9,
                      backgroundColor: status == 'No'
                          ? AppConstants.appPrimaryColor
                          : Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizeBoxV(5),
            const commonTextWidget(
              text: "No",
              color: AppConstants.black,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
        const SizeBoxH(10),
        Row(
          children: [
            GestureDetector(
              onTap: () => Provider.of<ServiceProvider>(context, listen: false)
                  .setSelectionStatus(title, status == 'Yes' ? '' : 'Yes'),
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: CircleAvatar(
                  radius: 12,
                  backgroundColor: AppConstants.appPrimaryColor,
                  child: CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 9,
                      backgroundColor: status == 'Yes'
                          ? AppConstants.appPrimaryColor
                          : Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizeBoxV(5),
            const commonTextWidget(
              text: "Yes",
              color: AppConstants.black,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
      ],
    );
  }
}

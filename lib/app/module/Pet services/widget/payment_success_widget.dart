import 'package:clan_of_pets/app/helpers/size_box.dart';
import 'package:clan_of_pets/app/utils/app_constants.dart';
import 'package:clan_of_pets/app/utils/extensions.dart';
import 'package:flutter/material.dart';

import '../../../helpers/common_widget.dart';

class PaymentSuccessWidget extends StatelessWidget {
  const PaymentSuccessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.white,
      body: SizedBox(
        height: Responsive.height * 100,
        width: Responsive.width * 100,
        child: Column(
          children: [
            SizeBoxH(Responsive.height * 4.5),
            Image.asset(
              "assets/images/pet-booking-gif.gif",
              height: Responsive.height * 55,
            ),
            const commonTextWidget(
              text: "Appoinment",
              color: AppConstants.black,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.4,
            ),
            const SizeBoxH(5),
            const commonTextWidget(
              text: "Successfully Booked",
              color: AppConstants.black,
              fontSize: 30,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.6,
            ),
            SizeBoxH(Responsive.height * 7.5),
            CommonButton(
              onTap: () {},
              text: "View Appoinments",
              width: Responsive.width * 80,
              height: Responsive.height * 6,
              size: 14,
            ),
            TextButton(
              onPressed: () {},
              child: const commonTextWidget(
                text: "Go Home",
                color: AppConstants.black,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.4,
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:clan_of_pets/app/helpers/size_box.dart';
import 'package:clan_of_pets/app/utils/extensions.dart';
import 'package:flutter/material.dart';

import '../../../helpers/common_widget.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_router.dart';
import '../widget/wallet_bottom_sheet_widget.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.white,
      appBar: AppBar(
        backgroundColor: AppConstants.white,
        title: const commonTextWidget(
          text: "Wallet",
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: Responsive.width * 100,
              height: Responsive.height * 14,
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage(
                    "assets/images/walletWithdrawContainerBg.png",
                  ),
                  fit: BoxFit.cover,
                ),
                color: AppConstants.white,
                boxShadow: const [
                  BoxShadow(
                    color: AppConstants.black10,
                    blurRadius: 30,
                    offset: Offset(0, 4),
                  ),
                ],
                borderRadius: BorderRadius.circular(15),
              ),
              padding: EdgeInsets.only(
                left: Responsive.width * 5,
                right: Responsive.width * 5,
              ),
              child: Row(
                children: [
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      commonTextWidget(
                        text: "Wallet Amount",
                        color: AppConstants.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                      commonTextWidget(
                        text: "\$ 700.00",
                        color: AppConstants.black,
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                  const Spacer(),
                  Transform.scale(
                    scale: 0.8,
                    child: ElevatedButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) {
                            return const WalletBottomSheetWidget();
                          },
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all<Color>(
                          AppConstants.appPrimaryColor,
                        ),
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      child: const commonTextWidget(
                        text: "Withdraw",
                        color: AppConstants.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizeBoxH(Responsive.height * 3),
            const commonTextWidget(
              text: "History",
              color: AppConstants.black,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
            SizeBoxH(Responsive.height * 2),
            ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Container(
                  width: Responsive.width * 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: AppConstants.greyContainerBg,
                      width: 1,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: Responsive.width * 3,
                    vertical: Responsive.height * 1,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          commonTextWidget(
                            text: "Refund for pet grooming booking",
                            color: AppConstants.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                          commonTextWidget(
                            text: "200.00 AED",
                            color: Colors.green,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      ),
                      SizeBoxH(
                        Responsive.height * 1.5,
                      ),
                      const commonTextWidget(
                        text: "06/06/2024",
                        color: Colors.lightBlue,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) =>
                  SizeBoxH(Responsive.height * 1.6),
              itemCount: 10,
            )
          ],
        ),
      ),
    );
  }
}

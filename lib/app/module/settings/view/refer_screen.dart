import 'package:clan_of_pets/app/helpers/size_box.dart';
import 'package:clan_of_pets/app/utils/extensions.dart';
import 'package:flutter/material.dart';

import '../../../helpers/common_widget.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_images.dart';
import '../../../utils/app_router.dart';
import '../../pet profile/widget/dotted_border_painter.dart';

class ReferScreen extends StatefulWidget {
  const ReferScreen({super.key});

  @override
  State<ReferScreen> createState() => _ReferScreenState();
}

class _ReferScreenState extends State<ReferScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.white,
      body: Container(
        height: Responsive.height * 100,
        width: Responsive.width * 100,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/referScreeBg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            AppBar(
              backgroundColor: Colors.transparent,
              title: const commonTextWidget(
                text: "Refer a Friend",
                color: AppConstants.white,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              leading: IconButton(
                onPressed: () {
                  Routes.back(context: context);
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                    Colors.white.withOpacity(0.5),
                  ),
                ),
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  size: 19,
                  color: AppConstants.appPrimaryColor,
                ),
              ),
            ),
            SizeBoxH(Responsive.height * 5.5),
            SizedBox(
              width: Responsive.width * 80,
              child: const commonTextWidget(
                color: AppConstants.white,
                align: TextAlign.center,
                text: "Refer a friend today and make a offer their purchase",
                fontSize: 16,
                wordSpacing: 1,
                letterSpacing: 1,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizeBoxH(Responsive.height * 2),
            Container(
              padding: const EdgeInsets.all(10),
              width: Responsive.width * 80,
              height: Responsive.height * 43,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppImages.referGif),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizeBoxH(Responsive.height * 6),
            SizedBox(
              width: Responsive.width * 90,
              child: commonTextWidget(
                color: Colors.white.withOpacity(0.7),
                align: TextAlign.center,
                text:
                    "Lorem Ipsum has been the industry's standard dummy text ver since the 1500s, when an unknown printer",
                fontSize: 13,
              ),
            ),
            SizeBoxH(Responsive.height * 3.5),
            Container(
              height: Responsive.height * 6.2,
              width: Responsive.width * 65,
              margin: const EdgeInsets.symmetric(vertical: 15),
              child: CustomPaint(
                painter: DottedBorderPainter(
                  color: Colors.white.withOpacity(0.7),
                  gap: 6,
                  strokeWidth: 1.5,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    commonTextWidget(
                      text: "ABSDJBDJC234",
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    SizeBoxV(Responsive.width * 5),
                    SizedBox(
                      height: 25,
                      child: VerticalDivider(
                        color: Colors.white.withOpacity(0.7),
                        thickness: 2,
                      ),
                    ),
                    SizeBoxV(Responsive.width * 5),
                    Image.asset(
                      AppImages.referCopyIcon,
                      height: 24,
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            Container(
              width: Responsive.width * 100,
              height: Responsive.height * 7,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
                color: Color(0xffFBB394),
              ),
              child: const Center(
                child: commonTextWidget(
                  text: "Refer  a friend",
                  color: AppConstants.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

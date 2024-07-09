import 'package:clan_of_pets/app/module/Pet%20services/view_model/services_provider.dart';
import 'package:clan_of_pets/app/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../helpers/common_widget.dart';
import '../../../helpers/size_box.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_router.dart';
import '../../../utils/extensions.dart';
import 'clinic_selecting_screen.dart';

class PetServicesHomeScreen extends StatefulWidget {
  const PetServicesHomeScreen({super.key});

  @override
  State<PetServicesHomeScreen> createState() => _PetServicesHomeScreenState();
}

class _PetServicesHomeScreenState extends State<PetServicesHomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppConstants.white,
        title: const commonTextWidget(
          text: "Pet services",
          color: AppConstants.black,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: Consumer<ServiceProvider>(
        builder: (context, provider, child) {
          return Container(
            padding: const EdgeInsets.all(16),
            height: Responsive.height * 100,
            width: Responsive.width * 100,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: Responsive.width * 100,
                    height: Responsive.height * 22,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        image: AssetImage(
                          AppImages.serviceBanner,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizeBoxH(Responsive.height * 2),
                  const commonTextWidget(
                    color: AppConstants.black,
                    text: "Services",
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  SizeBoxH(Responsive.height * 2),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: Responsive.height * 0.095,
                    ),
                    itemCount: provider.serviceHomeImages.length,
                    itemBuilder: (context, index) {
                      final image = provider.serviceHomeImages[index];
                      final name = provider.serviceHomeNames[index];
                      return CommonInkwell(
                        onTap: () {
                          Routes.push(
                            context: context,
                            screen: ClinicSelectingScreen(
                              title: name,
                            ),
                            exit: () {},
                          );
                        },
                        child: Column(
                          children: [
                            Container(
                              height: Responsive.height * 10,
                              width: Responsive.width * 22,
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.only(bottom: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xffF3F3F5),
                              ),
                              child: Image.asset(
                                image,
                              ),
                            ),
                            commonTextWidget(
                              color: AppConstants.black,
                              text: name,
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  SizeBoxH(Responsive.height * 3),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:clan_of_pets/app/helpers/size_box.dart';
import 'package:clan_of_pets/app/module/Pet%20services/view_model/services_provider.dart';
import 'package:clan_of_pets/app/module/home/view%20model/home_provider.dart';
import 'package:clan_of_pets/app/module/pet%20profile/widget/search_widget.dart';
import 'package:clan_of_pets/app/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../helpers/common_widget.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_images.dart';
import '../../../utils/app_router.dart';
import '../../../utils/extensions.dart';
import '../../widget/empty_screen.dart';
import '../widget/filter_bottom_sheet_widget.dart';
import 'service_provider_dertails_screen.dart';

class ClinicSelectingScreen extends StatefulWidget {
  final String? id;
  final String? serviceName;
  final String title;
  const ClinicSelectingScreen({
    super.key,
    this.id,
    this.serviceName,
    required this.title,
  });

  @override
  State<ClinicSelectingScreen> createState() => _ClinicSelectingScreenState();
}

class _ClinicSelectingScreenState extends State<ClinicSelectingScreen> {
  @override
  void initState() {
    super.initState();

    context.read<ServiceProvider>().getPetClinicFn(
          clinicId: widget.id ?? '',
          isFromFilter: false,
          search: '',
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.white,
      appBar: AppBar(
        backgroundColor: AppConstants.white,
        title: commonTextWidget(
          text: widget.title,
          color: AppConstants.black,
          fontSize: 16,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.8,
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
        padding: const EdgeInsets.all(16),
        child: Consumer<ServiceProvider>(
          builder: (context, provider, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SearchWidget(
                  hintText: "Search service provider",
                  onChanged: (value) {
                    provider.getPetClinicFn(
                      isFromFilter: false,
                      clinicId: widget.id ?? '',
                      search: value,
                    );
                  },
                ),
                const SizeBoxH(0),
                provider.petClinicsModel.clinics?.isEmpty == true
                    ? EmptyScreenWidget(
                        text: "No service Providers",
                        image: AppImages.noAppoinmentImage,
                        height: Responsive.height * 80,
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CommonInkwell(
                            onTap: () {
                              Routes.push(
                                context: context,
                                screen: ServiceProviderDetailsScreen(
                                  // clinicData: clinicData,
                                  serviceId: widget.id,
                                  serviceName: widget.serviceName,
                                  title: widget.title,
                                ),
                                exit: () {},
                              );
                            },
                            child: const commonTextWidget(
                              color: AppConstants.black,
                              text: "Choose a service provider",
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          CommonInkwell(
                            onTap: () {
                              showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                builder: (context) {
                                  return const FilterBottomSheetWidget();
                                },
                              );
                            },
                            child: Container(
                              height: Responsive.height * 4,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: AppConstants.appPrimaryColor,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const commonTextWidget(
                                    color: AppConstants.white,
                                    text: "Filter",
                                    fontSize: 12,
                                  ),
                                  const SizeBoxV(10),
                                  Image.asset(
                                    "assets/images/serviceFilterIcon.png",
                                    height: Responsive.height * 2,
                                    width: Responsive.width * 4,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                const SizeBoxH(20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizeBoxH(10),
                    provider.getPetClinicsStatus == GetPetClinicsStatus.loading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : provider.getPetClinicsStatus ==
                                GetPetClinicsStatus.loaded
                            ? GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount:
                                    provider.petClinicsModel.clinics?.length ??
                                        0,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisSpacing: 12,
                                  mainAxisSpacing: 12,
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.9,
                                ),
                                itemBuilder: (context, index) {
                                  final clinicData =
                                      provider.petClinicsModel.clinics?[index];
                                  return CommonInkwell(
                                    onTap: () {
                                      List petList = context
                                              .read<HomeProvider>()
                                              .getPetModel
                                              .pets ??
                                          [];

                                      if (petList.length > 1) {
                                        Routes.push(
                                          context: context,
                                          screen: ServiceProviderDetailsScreen(
                                            clinicData: clinicData,
                                            serviceId: widget.id,
                                            serviceName: widget.serviceName,
                                            title: widget.title,
                                          ),
                                          exit: () {},
                                        );
                                      } else {
                                        toast(
                                          context,
                                          title: "Add pet to continue",
                                          backgroundColor: Colors.red,
                                        );
                                      }
                                    },
                                    child: Container(
                                        width: Responsive.width * 40,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: AppConstants.black40,
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              clinicData?.clinicImage ?? "",
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Stack(
                                              children: [
                                                Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    vertical: 10,
                                                    horizontal: 10,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    color: AppConstants
                                                        .greyContainerBg,
                                                  ),
                                                  width: Responsive.width * 100,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      commonTextWidget(
                                                        color:
                                                            AppConstants.black,
                                                        text: clinicData
                                                                ?.clinicName ??
                                                            "",
                                                        fontSize: 12,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            child:
                                                                commonTextWidget(
                                                              align: TextAlign
                                                                  .start,
                                                              color: AppConstants
                                                                  .subTextGrey,
                                                              text: clinicData
                                                                      ?.description ??
                                                                  "",
                                                              fontSize: 12,
                                                              maxLines: 2,
                                                              overFlow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),
                                                          SizeBoxV(
                                                              Responsive.width *
                                                                  4)
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Positioned(
                                                  bottom: 0,
                                                  right: 0,
                                                  child: CircleAvatar(
                                                    radius: 15,
                                                    backgroundColor:
                                                        AppConstants
                                                            .appPrimaryColor,
                                                    child: IconButton(
                                                      padding: EdgeInsets.zero,
                                                      onPressed: () {},
                                                      icon: const Icon(
                                                        Icons
                                                            .arrow_forward_ios_rounded,
                                                        color:
                                                            AppConstants.white,
                                                        size: 14,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        )),
                                  );
                                },
                              )
                            : EmptyScreenWidget(
                                text: "Server Busy,please try again later",
                                image: AppImages.noAppoinmentImage,
                                height: Responsive.height * 50,
                              ),
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

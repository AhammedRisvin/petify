import 'package:clan_of_pets/app/module/Pet%20services/model/pet_clinics_model.dart';
import 'package:clan_of_pets/app/module/Pet%20services/view_model/services_provider.dart';
import 'package:clan_of_pets/app/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../helpers/common_widget.dart';
import '../../../helpers/size_box.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_router.dart';
import '../../../utils/extensions.dart';
import 'service_providers_screen.dart';

class ServiceProviderDetailsScreen extends StatefulWidget {
  const ServiceProviderDetailsScreen({
    super.key,
    this.clinicData,
    this.serviceId,
    this.serviceName,
    required this.title,
  });

  final Clinic? clinicData;
  final String? serviceId;
  final String? serviceName;
  final String title;

  @override
  State<ServiceProviderDetailsScreen> createState() =>
      _ServiceProviderDetailsScreenState();
}

class _ServiceProviderDetailsScreenState
    extends State<ServiceProviderDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ServiceProvider>().setToday();
    context.read<ServiceProvider>().getPetSlotFn(
          context: context,
          clinicId: widget.clinicData?.clinicId ?? "",
          serviceId: widget.serviceId ?? "",
          date: context.read<ServiceProvider>().today ?? "",
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.white,
      body: SizedBox(
        height: Responsive.height * 100,
        width: Responsive.width * 100,
        child: SingleChildScrollView(
          child: Consumer<ServiceProvider>(
            builder: (context, provider, child) => Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: Responsive.height * 43.5,
                      width: Responsive.width * 100,
                      decoration: BoxDecoration(
                        color: AppConstants.white,
                        image: DecorationImage(
                          image: NetworkImage(
                              widget.clinicData?.clinicImage ?? ""),
                          fit: BoxFit.cover,
                        ),
                        border: Border(
                          bottom: BorderSide(
                              color: Colors.grey.withOpacity(.4), width: 2),
                        ),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 40.0, left: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 30,
                              width: 30,
                              child: Center(
                                child: IconButton(
                                  onPressed: () {
                                    Routes.back(context: context);
                                  },
                                  style: ButtonStyle(
                                    fixedSize: const WidgetStatePropertyAll(
                                        Size(4, 4)),
                                    backgroundColor: WidgetStatePropertyAll(
                                      AppConstants.white.withOpacity(.5),
                                    ),
                                  ),
                                  icon: const Icon(
                                    Icons.arrow_back_ios_new,
                                    size: 15,
                                    color: AppConstants.appPrimaryColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ServiceProviderDetailsInfoWidget(
                      clinicData: widget.clinicData,
                      provider: provider,
                    ),
                    ServiceProviderDetailsServicesWidget(
                      provider: provider,
                      servicesList: widget.clinicData?.services ?? [],
                    ),
                    ServiceProviderDetailsLocationWidget(
                      provider: provider,
                      clinicData: widget.clinicData,
                    ),
                    SizeBoxH(Responsive.height * 2),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: CommonButton(
                        isFullRoundedButton: true,
                        onTap: () {
                          Routes.push(
                            context: context,
                            screen: ServiceProvidersScreen(
                              clinicId: widget.clinicData?.clinicId ?? "",
                              serviceId: widget.serviceId ?? "",
                              serviceName: widget.serviceName ?? "",
                            ),
                            exit: () {},
                          );
                        },
                        borderColor: AppConstants.appPrimaryColor,
                        text: "Book Now",
                        width: Responsive.width * 100,
                        size: 16,
                        height: 50,
                      ),
                    ),
                    SizeBoxH(Responsive.height * 1),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ServiceProviderDetailsLocationWidget extends StatelessWidget {
  final ServiceProvider provider;
  final Clinic? clinicData;
  const ServiceProviderDetailsLocationWidget({
    super.key,
    required this.provider,
    this.clinicData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const commonTextWidget(
            text: "Locate in Map",
            color: AppConstants.appCommonRed,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          SizeBoxH(Responsive.height * 2),
          Consumer<ServiceProvider>(
            builder: (context, value, child) {
              double longitude =
                  double.tryParse(clinicData?.location?.lng ?? "0.00") ?? 0;
              double latitude =
                  double.tryParse(clinicData?.location?.lat ?? "0.00") ?? 0;

              return Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                height: Responsive.height * 20,
                width: Responsive.width * 100,
                child: GoogleMap(
                  onMapCreated: (controller) {
                    value.onMapCreated(controller, latitude, longitude);
                  },
                  markers: value.markers,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      latitude,
                      longitude,
                    ),
                    zoom: 15,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class ServiceProviderDetailsServicesWidget extends StatelessWidget {
  final ServiceProvider provider;
  final List<String> servicesList;
  const ServiceProviderDetailsServicesWidget({
    super.key,
    required this.provider,
    required this.servicesList,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const commonTextWidget(
            color: AppConstants.black,
            text: "Services",
            fontSize: 16,
          ),
          SizeBoxH(Responsive.height * 1),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: servicesList.map((servicesData) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 3.0),
                    child: CircleAvatar(
                      radius: 5,
                      backgroundColor: AppConstants.appPrimaryColor,
                    ),
                  ),
                  const SizeBoxV(5),
                  commonTextWidget(
                    color: AppConstants.black,
                    text: servicesData,
                    fontSize: 14,
                    maxLines: 1,
                    overFlow: TextOverflow.ellipsis,
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class ServiceProviderDetailsInfoWidget extends StatelessWidget {
  const ServiceProviderDetailsInfoWidget({
    super.key,
    this.clinicData,
    required this.provider,
  });

  final Clinic? clinicData;
  final ServiceProvider provider;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            SizeBoxH(Responsive.height * 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                commonTextWidget(
                  align: TextAlign.start,
                  overFlow: TextOverflow.ellipsis,
                  text: clinicData?.clinicName ?? "",
                  color: AppConstants.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
                Row(
                  children: [
                    Image.asset(
                      AppImages.locationFlagIcon,
                      height: 15,
                      width: 15,
                    ),
                    const SizeBoxV(5),
                    commonTextWidget(
                      overFlow: TextOverflow.ellipsis,
                      text: clinicData?.country ?? "",
                      color: AppConstants.appPrimaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
              ],
            ),
            const SizeBoxH(10),
            Row(
              children: [
                Image.asset(
                  AppImages.locationIcon,
                  height: 15,
                  width: 15,
                ),
                const SizeBoxV(5),
                FutureBuilder<String>(
                    future: provider.getAddressFromLatLng(
                        clinicData?.location?.lat ?? "0.00",
                        clinicData?.location?.lng ?? "0.00"),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasData) {
                        return SizedBox(
                          width: Responsive.width * 75,
                          child: commonTextWidget(
                            align: TextAlign.start,
                            overFlow: TextOverflow.ellipsis,
                            text: snapshot.data ?? "",
                            color: AppConstants.black.withOpacity(.6),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        );
                      } else {
                        return const Text('Address not found');
                      }
                    }),
              ],
            ),
            const SizeBoxH(20),
            SizedBox(
              width: Responsive.width * 100,
              child: commonTextWidget(
                align: TextAlign.justify,
                overFlow: TextOverflow.clip,
                text: clinicData?.description ?? "",
                color: AppConstants.black.withOpacity(.6),
                fontSize: 12,
                fontWeight: FontWeight.w300,
              ),
            ),
            SizeBoxH(Responsive.height * 4),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      AppConstants.appPrimaryColor.withOpacity(.2),
                    ),
                  ),
                  icon: const Icon(
                    Icons.phone,
                    size: 19,
                    color: AppConstants.appPrimaryColor,
                  ),
                ),
                const SizeBoxV(10),
                commonTextWidget(
                  align: TextAlign.start,
                  overFlow: TextOverflow.ellipsis,
                  text: clinicData?.phone ?? "",
                  color: AppConstants.black.withOpacity(.6),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
          ],
        ));
  }
}

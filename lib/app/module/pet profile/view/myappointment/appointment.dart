import 'package:clan_of_pets/app/module/Pet%20services/model/service_appoinments_model.dart';
import 'package:clan_of_pets/app/module/Pet%20services/view_model/services_provider.dart';
import 'package:clan_of_pets/app/utils/app_images.dart';
import 'package:clan_of_pets/app/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../helpers/common_widget.dart';
import '../../../../helpers/size_box.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_router.dart';
import '../../../../utils/extensions.dart';
import '../../../home/view/home_screen.dart';
import '../../view model/pet_profile_provider.dart';

class MyAppointmentScreen extends StatefulWidget {
  const MyAppointmentScreen({super.key});

  @override
  State<MyAppointmentScreen> createState() => _MyAppointmentScreenState();
}

class _MyAppointmentScreenState extends State<MyAppointmentScreen> {
  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<PetProfileProvider>(context, listen: false)
          .updateSelectedContainer(SelectedContainer.all);
      Provider.of<ServiceProvider>(context, listen: false)
          .getServiceAppoinments(page: 1, search: '');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.white,
      appBar: AppBar(
        backgroundColor: AppConstants.white,
        title: const commonTextWidget(
          text: "My Appoinments",
          color: AppConstants.black,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        leading: IconButton(
          onPressed: () {
            Routes.back(context: context);
          },
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(
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
        child: Consumer<ServiceProvider>(
          builder: (context, provider, child) {
            return Column(
              children: [
                // Selector<PetProfileProvider, SelectedContainer>(
                //   selector: (context, provider) => provider.selectedContainer,
                //   builder: (context, selectedContainer, child) => SearchWidget(
                //     onChanged: (value) {
                //       selectedContainer == SelectedContainer.all
                //           ? provider.getServiceAppoinments(
                //               page: 1, search: value)
                //           : selectedContainer == SelectedContainer.ended
                //               ? provider.getEndedAppoinments(
                //                   page: 1, search: value)
                //               : provider.getUpcomingAppoinmentsFn(
                //                   page: 1, search: value);
                //     },
                //     hintText: "Search Appoinments",
                //   ),
                // ),
                const SizeBoxH(10),
                Selector<PetProfileProvider, SelectedContainer>(
                  selector: (context, provider) => provider.selectedContainer,
                  builder: (context, selectedContainer, child) => SizedBox(
                    width: Responsive.width * 100,
                    child: Row(
                      children: [
                        Expanded(
                          child: CommonBannerButtonWidget(
                            text: "All",
                            borderColor: Colors.transparent,
                            bgColor: selectedContainer == SelectedContainer.all
                                ? AppConstants.appPrimaryColor
                                : AppConstants.greyContainerBg,
                            textColor:
                                selectedContainer == SelectedContainer.all
                                    ? AppConstants.white
                                    : AppConstants.subTextGrey,
                            fontSize: 11,
                            height: 30,
                            width: Responsive.width * 20,
                            onTap: () {
                              provider.getServiceAppoinments(
                                  page: 1, search: '');
                              Provider.of<PetProfileProvider>(context,
                                      listen: false)
                                  .updateSelectedContainer(
                                      SelectedContainer.all);
                            },
                          ),
                        ),
                        const SizeBoxV(10),
                        Expanded(
                          child: CommonBannerButtonWidget(
                            text: "Completed",
                            borderColor: Colors.transparent,
                            bgColor:
                                selectedContainer == SelectedContainer.ended
                                    ? AppConstants.appPrimaryColor
                                    : AppConstants.greyContainerBg,
                            textColor:
                                selectedContainer == SelectedContainer.ended
                                    ? AppConstants.white
                                    : AppConstants.subTextGrey,
                            fontSize: 11,
                            height: 30,
                            width: Responsive.width * 20,
                            onTap: () {
                              provider.getEndedAppoinments(page: 1, search: '');
                              Provider.of<PetProfileProvider>(context,
                                      listen: false)
                                  .updateSelectedContainer(
                                      SelectedContainer.ended);
                            },
                          ),
                        ),
                        const SizeBoxV(10),
                        Expanded(
                          child: CommonBannerButtonWidget(
                            text: "Upcoming",
                            borderColor: Colors.transparent,
                            bgColor:
                                selectedContainer == SelectedContainer.upcoming
                                    ? AppConstants.appPrimaryColor
                                    : AppConstants.greyContainerBg,
                            textColor:
                                selectedContainer == SelectedContainer.upcoming
                                    ? AppConstants.white
                                    : AppConstants.subTextGrey,
                            fontSize: 11,
                            height: 30,
                            width: Responsive.width * 20,
                            onTap: () {
                              provider.getUpcomingAppoinmentsFn(
                                  page: 1, search: '');
                              Provider.of<PetProfileProvider>(context,
                                      listen: false)
                                  .updateSelectedContainer(
                                      SelectedContainer.upcoming);
                            },
                          ),
                        ),
                        const SizeBoxV(10),
                        Expanded(
                          child: CommonBannerButtonWidget(
                            text: "Cancelled",
                            borderColor: Colors.transparent,
                            bgColor:
                                selectedContainer == SelectedContainer.cancelled
                                    ? AppConstants.appPrimaryColor
                                    : AppConstants.greyContainerBg,
                            textColor:
                                selectedContainer == SelectedContainer.cancelled
                                    ? AppConstants.white
                                    : AppConstants.subTextGrey,
                            fontSize: 11,
                            height: 30,
                            width: Responsive.width * 20,
                            onTap: () {
                              provider.getUpcomingAppoinmentsFn(
                                  page: 1, search: '');
                              Provider.of<PetProfileProvider>(context,
                                      listen: false)
                                  .updateSelectedContainer(
                                      SelectedContainer.cancelled);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizeBoxH(Responsive.height * 3.5),
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount:
                      provider.appoinmentsModel.appointments?.length ?? 0,
                  separatorBuilder: (context, index) {
                    return SizeBoxH(Responsive.height * 1.5);
                  },
                  itemBuilder: (context, index) {
                    final appoinmentData = provider
                            .appoinmentsModel.appointments?[
                        (provider.appoinmentsModel.appointments?.length ?? 0) -
                            1 -
                            index];
                    return provider.getAppoinmentsStatus ==
                            GetAppoinmentsStatus.loaded
                        ? BoxContainer(
                            data: appoinmentData,
                          )
                        : const Text("Something went wrong");
                  },
                ),
                const SizeBoxH(30)
              ],
            );
          },
        ),
      ),
    );
  }
}

class BoxContainer extends StatelessWidget {
  const BoxContainer({super.key, this.data});

  final Appointment? data;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppConstants.transparent,
        border: Border.all(
          color: AppConstants.black10,
          width: 1,
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Consumer<ServiceProvider>(
        builder: (context, provider, child) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                commonTextWidget(
                  text: data?.petName ?? 'Shadow',
                  fontSize: 18,
                  maxLines: 2,
                  overFlow: TextOverflow.ellipsis,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xff000000),
                ),
                Container(
                  width: Responsive.width * 15,
                  height: Responsive.height * 2.5,
                  decoration: BoxDecoration(
                    color: data?.status?.toLowerCase() == "pending"
                        ? const Color(0xffEE5158)
                        : data?.status?.toLowerCase() == "approved"
                            ? const Color(0xff4CAF50)
                            : const Color(0xffEE5158),
                    borderRadius: const BorderRadius.all(Radius.circular(40)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      data?.status?.toLowerCase() == "pending"
                          ? Image.asset(
                              AppImages.lodingImage,
                              width: 18,
                              height: 18,
                            )
                          : const SizedBox.shrink(),
                      const SizeBoxV(5),
                      commonTextWidget(
                        text: data?.status?.capitalizeFirstLetter() ?? '',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xffFFFFFF),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            commonTextWidget(
              text: (data?.bookingId ?? '').length > 10
                  ? (data?.bookingId ?? '')
                      .substring((data?.bookingId ?? '').length - 10)
                  : (data?.bookingId ?? ''),
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: AppConstants.black40,
            ),
            SizeBoxH(Responsive.height * 0.5),
            const commonTextWidget(
              align: TextAlign.start,
              text: 'Service',
              fontSize: 11,
              fontWeight: FontWeight.w400,
              color: AppConstants.black40,
            ),
            commonTextWidget(
              align: TextAlign.start,
              text: data?.service ?? 'Pet Grooming',
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: const Color(0xff000000),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:clan_of_pets/app/helpers/size_box.dart';
import 'package:clan_of_pets/app/module/home/view/home_screen.dart';
import 'package:clan_of_pets/app/module/pet%20profile/view%20model/pet_profile_provider.dart';
import 'package:clan_of_pets/app/utils/enums.dart';
import 'package:clan_of_pets/app/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../helpers/common_widget.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/app_router.dart';
import '../../../widget/empty_screen.dart';
import '../../widget/event_details_container.dart';
import '../../widget/event_details_shimmer.dart';
import '../../widget/search_widget.dart';
import 'create_events_screen.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PetProfileProvider>().getEventFn(
          filter: "",
          pageNo: "",
          searchKeyword: "",
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.white,
      appBar: AppBar(
          backgroundColor: AppConstants.white,
          title: const commonTextWidget(
            text: "Events",
            color: AppConstants.black,
            fontSize: 18,
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
          )),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SearchWidget(
              onChanged: (value) {
                context.read<PetProfileProvider>().getEventFn(
                      filter: "",
                      pageNo: "",
                      searchKeyword: value,
                    );
              },
            ),
            const SizeBoxH(10),
            Selector<PetProfileProvider, SelectedContainer>(
              selector: (context, provider) => provider.selectedContainer,
              builder: (context, selectedContainer, child) => SizedBox(
                width: Responsive.width * 100,
                child: Row(
                  children: [
                    CommonBannerButtonWidget(
                      text: "All",
                      borderColor: Colors.transparent,
                      bgColor: selectedContainer == SelectedContainer.all
                          ? AppConstants.appPrimaryColor
                          : AppConstants.greyContainerBg,
                      textColor: selectedContainer == SelectedContainer.all
                          ? AppConstants.white
                          : AppConstants.subTextGrey,
                      fontSize: 12,
                      width: 90,
                      onTap: () {
                        context.read<PetProfileProvider>().getEventFn(
                              filter: "",
                              pageNo: "",
                              searchKeyword: "",
                            );
                        Provider.of<PetProfileProvider>(context, listen: false)
                            .updateSelectedContainer(SelectedContainer.all);
                      },
                    ),
                    const SizeBoxV(15),
                    CommonBannerButtonWidget(
                      text: "Ended",
                      borderColor: Colors.transparent,
                      bgColor: selectedContainer == SelectedContainer.ended
                          ? AppConstants.appPrimaryColor
                          : AppConstants.greyContainerBg,
                      textColor: selectedContainer == SelectedContainer.ended
                          ? AppConstants.white
                          : AppConstants.subTextGrey,
                      fontSize: 12,
                      width: 90,
                      onTap: () {
                        context.read<PetProfileProvider>().getEventFn(
                              filter: "ended",
                              pageNo: "",
                              searchKeyword: "",
                            );
                        Provider.of<PetProfileProvider>(context, listen: false)
                            .updateSelectedContainer(SelectedContainer.ended);
                      },
                    ),
                    const SizeBoxV(15),
                    CommonBannerButtonWidget(
                      text: "Upcoming",
                      borderColor: Colors.transparent,
                      bgColor: selectedContainer == SelectedContainer.upcoming
                          ? AppConstants.appPrimaryColor
                          : AppConstants.greyContainerBg,
                      textColor: selectedContainer == SelectedContainer.upcoming
                          ? AppConstants.white
                          : AppConstants.subTextGrey,
                      fontSize: 12,
                      width: 90,
                      onTap: () {
                        context.read<PetProfileProvider>().getEventFn(
                              filter: "upcoming",
                              pageNo: "",
                              searchKeyword: "",
                            );
                        Provider.of<PetProfileProvider>(context, listen: false)
                            .updateSelectedContainer(
                                SelectedContainer.upcoming);
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizeBoxH(Responsive.height * 2),
            Consumer<PetProfileProvider>(
              builder: (context, provider, child) {
                return provider.petEventModel.eventData?.isEmpty == true
                    ? EmptyScreenWidget(
                        image: AppImages.noBlogImage,
                        text: "No Events Found",
                        height: Responsive.height * 50,
                      )
                    : ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final eventData =
                              provider.petEventModel.eventData?[index];
                          return provider.getEventStatus ==
                                  GetEventStatus.loading
                              ? const EventDetailsShimmer()
                              : provider.getEventStatus == GetEventStatus.loaded
                                  ? EventDetailsContainer(
                                      eventData: eventData,
                                    )
                                  : const Text("Something went wrong");
                        },
                        separatorBuilder: (context, index) =>
                            SizeBoxH(Responsive.height * 2),
                        itemCount:
                            provider.petEventModel.eventData?.length ?? 0,
                      );
              },
            ),
            SizeBoxH(Responsive.height * 2),
            CommonButton(
              onTap: () {
                Routes.push(
                  context: context,
                  screen: const CreateEventScreen(),
                  exit: () {},
                );
              },
              isIconShow: true,
              isFullRoundedButton: true,
              text: "Create New",
              size: 12,
              bgColor: AppConstants.white,
              textColor: AppConstants.appPrimaryColor,
              borderColor: AppConstants.appPrimaryColor,
              width: Responsive.width * 100,
              height: 50,
            ),
            SizeBoxH(Responsive.height * 2),
          ],
        ),
      ),
    );
  }
}

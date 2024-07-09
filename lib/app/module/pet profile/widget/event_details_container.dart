import 'package:clan_of_pets/app/module/pet%20profile/view%20model/pet_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../../helpers/common_widget.dart';
import '../../../helpers/size_box.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/extensions.dart';
import '../model/pet_event_model.dart';

class EventDetailsContainer extends StatelessWidget {
  final EventDatum? eventData;
  const EventDetailsContainer({super.key, this.eventData});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Responsive.width * 100,
      padding: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppConstants.greyContainerBg,
      ),
      child: Column(
        children: [
          commonNetworkImage(
            url: eventData?.image == null || eventData?.image?.isEmpty == true
                ? "https://cdn.dribbble.com/userupload/11926943/file/original-f0aeaf93e5bcacfe266c1df05322b95c.jpg?crop=1051x0-5347x3222&resize=400x300&vertical=center"
                : eventData?.image ?? "",
            height: Responsive.height * 15,
            width: Responsive.width * 100,
          ),
          SizeBoxH(Responsive.height * 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                commonTextWidget(
                  color: AppConstants.black,
                  text: eventData?.name ?? "Event name",
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
                commonTextWidget(
                  color: eventData?.isExpired == true
                      ? const Color(0XFFEE5158)
                      : const Color(0xff7D7A43),
                  text: eventData?.isExpired == true ? "Ended" : "Upcoming",
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ],
            ),
          ),
          SizeBoxH(Responsive.height * 0.5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: commonTextWidget(
                    color: AppConstants.black60,
                    align: TextAlign.start,
                    maxLines: null,
                    text: eventData?.description ?? "",
                    // overFlow: TextOverflow.ellipsis,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  children: [
                    commonTextWidget(
                      color: eventData?.isExpired == true
                          ? const Color(0XFFEE5158)
                          : const Color(0xff7D7A43),
                      text: context.read<PetProfileProvider>().formatTime(
                            eventData?.time?.toLocal() ?? DateTime.now(),
                          ),
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                    const SizeBoxV(5),
                    Image.asset(
                      "assets/images/eventClockIcon.png",
                      height: 12,
                      color: eventData?.isExpired == true
                          ? const Color(0XFFEE5158)
                          : const Color(0xff7D7A43),
                    )
                  ],
                ),
              ],
            ),
          ),
          SizeBoxH(Responsive.height * 0.5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      "assets/images/eventLocationIcon.png",
                      height: 12,
                    ),
                    const SizeBoxV(5),
                    commonTextWidget(
                      color: AppConstants.black60,
                      align: TextAlign.start,
                      text: eventData?.location ?? "",
                      overFlow: TextOverflow.ellipsis,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
                Row(
                  children: [
                    commonTextWidget(
                      color: eventData?.isExpired == true
                          ? const Color(0XFFEE5158)
                          : const Color(0xff7D7A43),
                      text: context.read<PetProfileProvider>().formatDate(
                            eventData?.date?.toLocal() ?? DateTime.now(),
                          ),
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                    const SizeBoxV(5),
                    Image.asset(
                      "assets/images/eventCalenderIcon.png",
                      color: eventData?.isExpired == true
                          ? const Color(0XFFEE5158)
                          : const Color(0xff7D7A43),
                      height: 14,
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

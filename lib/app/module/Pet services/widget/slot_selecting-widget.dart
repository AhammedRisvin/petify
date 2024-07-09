// ignore_for_file: file_names

import 'package:clan_of_pets/app/helpers/common_widget.dart';
import 'package:clan_of_pets/app/module/Pet%20services/model/pet_slot_model.dart';
import 'package:clan_of_pets/app/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../helpers/size_box.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/extensions.dart';
import '../view_model/services_provider.dart';

class SlotSelectingWidget extends StatelessWidget {
  const SlotSelectingWidget({
    super.key,
    required this.morningList,
    required this.afternoonList,
  });

  final List<SlotForBooking> morningList;
  final List<SlotForBooking> afternoonList;

  @override
  Widget build(BuildContext context) {
    return Consumer<ServiceProvider>(
      builder: (context, provider, child) => Column(
        children: [
          const SizeBoxH(10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 15),
                width: 10,
                child: Column(
                  children: [
                    const SizeBoxH(5),
                    Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                          color: AppConstants.appPrimaryColor,
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    SizedBox(
                      height: Responsive.height * 10.2,
                      child: VerticalDivider(
                        thickness: 2,
                        color: AppConstants.black.withOpacity(.2),
                      ),
                    ),
                    Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                          color: AppConstants.appPrimaryColor,
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    SizedBox(
                      height: (afternoonList.length >= 4)
                          ? Responsive.height * 12.5
                          : (afternoonList.length >= 8)
                              ? Responsive.height * 18.5
                              : Responsive.height * 6.5,
                      child: VerticalDivider(
                        thickness: 2,
                        color: AppConstants.black.withOpacity(.2),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const commonTextWidget(
                      color: AppConstants.black,
                      text: "Morning",
                      height: 1.5,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    provider.getPetStatusStatus == GetPetStatusStatus.loading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: AppConstants.appPrimaryColor,
                            ),
                          )
                        : provider.getPetStatusStatus ==
                                GetPetStatusStatus.loaded
                            ? Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: SizedBox(
                                  height: Responsive.height * 8,
                                  child: morningList.isEmpty
                                      ? const Center(
                                          child: Text("No slots available"),
                                        )
                                      : ListView.separated(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          padding:
                                              const EdgeInsets.only(bottom: 28),
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            final morningSlot =
                                                morningList[index];
                                            final isSelected = index ==
                                                provider.selectedMorningIndex;
                                            return Center(
                                              child: PetServicesTimeWidget(
                                                title:
                                                    provider.getHourAndMinute(
                                                  morningSlot.startTime ??
                                                      DateTime.now(),
                                                ),
                                                isSelected: isSelected,
                                                onTap: () {
                                                  provider.setMorningIndex(
                                                      index,
                                                      morningSlot.slotId ?? '',
                                                      true,
                                                      morningSlot.subSlotId ??
                                                          '');
                                                },
                                              ),
                                            );
                                          },
                                          itemCount: morningList.length,
                                          separatorBuilder: (context, index) =>
                                              const SizeBoxV(8),
                                        ),
                                ),
                              )
                            : const Text("Something went wrong"),
                    const commonTextWidget(
                      color: AppConstants.black,
                      text: "Afternoon",
                      height: 0.5,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(
                      height: Responsive.height * 12,
                      child: afternoonList.isEmpty
                          ? const Center(
                              child: Text("No slots available"),
                            )
                          : GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.only(top: 10),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisSpacing: 8,
                                      childAspectRatio: 18 / 10,
                                      crossAxisCount: 4),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                final afterNoonSlot = afternoonList[index];

                                final isSelected =
                                    index == provider.selectedAfternoonIndex;

                                return Center(
                                  child: PetServicesTimeWidget(
                                    title: provider.getHourAndMinute(
                                      afterNoonSlot.startTime ?? DateTime.now(),
                                    ),
                                    isSelected: isSelected,
                                    onTap: () {
                                      provider.setMorningIndex(
                                          index,
                                          afterNoonSlot.slotId ?? '',
                                          false,
                                          afterNoonSlot.subSlotId ?? '');
                                    },
                                  ),
                                );
                              },
                              itemCount: afternoonList.length,
                            ),
                    ),
                  ],
                ),
              )
            ],
          ),
          (afternoonList.length >= 4)
              ? const SizeBoxH(25)
              : (afternoonList.length >= 8)
                  ? const SizeBoxH(25)
                  : const SizeBoxH(0),
        ],
      ),
    );
  }
}

class PetServicesTimeWidget extends StatelessWidget {
  final String title;
  final Function() onTap;
  final bool isSelected;
  const PetServicesTimeWidget({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CommonInkwell(
      onTap: onTap,
      child: Container(
        height: 30,
        decoration: BoxDecoration(
            color: isSelected
                ? AppConstants.appPrimaryColor
                : const Color(0xFFF3F3F5),
            boxShadow: [
              BoxShadow(
                  spreadRadius: 0,
                  blurRadius: 0,
                  color: AppConstants.black.withOpacity(.08),
                  offset: const Offset(0, 2)),
              BoxShadow(
                  spreadRadius: 0,
                  blurRadius: 0,
                  color: AppConstants.black.withOpacity(.08),
                  offset: const Offset(1, .1)),
              BoxShadow(
                  spreadRadius: 0,
                  blurRadius: 0,
                  color: AppConstants.black.withOpacity(.08),
                  offset: const Offset(0, .1)),
              BoxShadow(
                  spreadRadius: 0,
                  blurRadius: 0,
                  color: AppConstants.black.withOpacity(.08),
                  offset: const Offset(.1, 0)),
            ],
            borderRadius: BorderRadius.circular(40)),
        width: 85,
        child: Center(
          child: commonTextWidget(
            color: isSelected ? AppConstants.white : AppConstants.black,
            text: title,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

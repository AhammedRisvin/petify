// ignore_for_file: deprecated_member_use

import 'package:clan_of_pets/app/module/Pet%20services/view_model/services_provider.dart';
import 'package:clan_of_pets/app/utils/extensions.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../helpers/common_widget.dart';
import '../../../helpers/size_box.dart';
import '../../../utils/app_constants.dart';

class CalenderWidget extends StatelessWidget {
  const CalenderWidget({
    super.key,
    required this.provider,
    required this.clinicId,
    required this.serviceId,
    required this.title,
  });

  final ServiceProvider provider;
  final String clinicId;
  final String serviceId;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizeBoxH(10),
        Stack(
          children: [
            Positioned(
              right: 10,
              top: Responsive.height * 1,
              child: Container(
                width: 80,
                height: Responsive.height * 4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xffEE5158),
                ),
              ),
            ),
            EasyDateTimeLine(
              initialDate: DateTime.now(),
              onDateChange: (selectedDate) {
                String date = provider.formatDate(selectedDate);
                provider.getPetSlotFn(
                  context: context,
                  clinicId: clinicId,
                  serviceId: serviceId,
                  date: date,
                );
              },
              dayProps: const EasyDayProps(
                activeBorderRadius: 10,
                height: 81,
                width: 60,
              ),
              headerProps: const EasyHeaderProps(
                showMonthPicker: true,
                monthStyle: TextStyle(
                  color: AppConstants.white,
                ),
                showSelectedDate: false,
              ),
              itemBuilder: (BuildContext context, DateTime date,
                  bool isSelected, void Function() onTap) {
                final now = DateTime.now();
                DateTime today = DateTime(now.year, now.month, now.day);
                String dayNumber = date.day.toString();
                String dayName =
                    DateFormat('EEE').format(date); // 'Mon', 'Tue', etc.

                bool isPastDate = date.isBefore(today);

                return InkWell(
                  onTap: isPastDate ? null : onTap,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 1),
                    height: 81,
                    width: 60,
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: BoxDecoration(
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                  spreadRadius: 0,
                                  blurRadius: 0,
                                  color: AppConstants.black.withOpacity(.09),
                                  offset: const Offset(0, 2)),
                              BoxShadow(
                                  spreadRadius: 0,
                                  blurRadius: 0,
                                  color: AppConstants.black.withOpacity(.08),
                                  offset: const Offset(1, .1)),
                              BoxShadow(
                                  spreadRadius: 0,
                                  blurRadius: 1,
                                  color: AppConstants.black.withOpacity(.08),
                                  offset: const Offset(-1, .1)),
                              BoxShadow(
                                  spreadRadius: 0,
                                  blurRadius: 0,
                                  color: AppConstants.black.withOpacity(.08),
                                  offset: const Offset(.1, 0)),
                            ]
                          : [],
                      color: isPastDate
                          ? Colors.grey.withOpacity(0.5)
                          : isSelected
                              ? const Color(0xFFF3F3F5)
                              : Colors.white.withOpacity(.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        commonTextWidget(
                          color: isPastDate
                              ? Colors.grey.withOpacity(0.5)
                              : AppConstants.black,
                          text: dayNumber,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        const SizedBox(
                          width: 8.0,
                        ),
                        FittedBox(
                          child: commonTextWidget(
                            color: AppConstants.black.withOpacity(.5),
                            text: dayNumber == now.day.toString()
                                ? "Today"
                                : dayName,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            if (title == "Pet Boarding" ||
                title == "Pet Taxi" ||
                title == "Pet Training") ...[
              Consumer<ServiceProvider>(
                builder: (context, provider, child) => Positioned(
                  top: Responsive.height * 1.6,
                  child: Row(
                    children: [
                      CommonContainer(
                        title: "From",
                        provider: provider,
                      ),
                      CommonContainer(
                        title: "To",
                        provider: provider,
                      ),
                    ],
                  ),
                ),
              ),
            ],
            if (title == "Day Care" ||
                title == "Veterinary" ||
                title == "Pet Grooming") ...[
              Positioned(
                top: Responsive.height * 1.6,
                child: const commonTextWidget(
                  color: AppConstants.black,
                  text: "Preferred  Time For Appoinment",
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ],
        ),
        const SizeBoxH(10),
      ],
    );
  }
}

class CommonContainer extends StatelessWidget {
  const CommonContainer({
    super.key,
    required this.title,
    required this.provider,
  });

  final String title;
  final ServiceProvider provider;

  @override
  Widget build(BuildContext context) {
    final isSelected = provider.fromContainer == title;
    return CommonInkwell(
      onTap: () {
        provider.updateContainerBg(title);
      },
      child: Container(
        width: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: !isSelected
              ? const Color(0xFFF3F3F5)
              : AppConstants.appPrimaryColor,
        ),
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(
          horizontal: 5,
          vertical: 5,
        ),
        child: commonTextWidget(
          color: isSelected ? AppConstants.white : AppConstants.black60,
          text: title,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}

import 'dart:async';
import 'dart:math';

import 'package:clan_of_pets/app/helpers/common_widget.dart';
import 'package:clan_of_pets/app/helpers/size_box.dart';
import 'package:clan_of_pets/app/module/home/model/get_pet_model.dart';
import 'package:clan_of_pets/app/module/home/view/home_screen.dart';
import 'package:clan_of_pets/app/module/pet%20profile/view%20model/pet_profile_provider.dart';
import 'package:clan_of_pets/app/utils/app_images.dart';
import 'package:clan_of_pets/app/utils/app_router.dart';
import 'package:clan_of_pets/app/utils/extensions.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/server_client_services.dart';
import '../../../../core/string_const.dart';
import '../../../../core/urls.dart';
import '../../../../utils/app_constants.dart';
import '../../model/get_growth_model.dart';
import 'growth_history_screen.dart';
import 'new_growth_entry_screen.dart';

class GrowthTrackerScreen extends StatefulWidget {
  const GrowthTrackerScreen({super.key, required this.data});

  final PetData data;

  @override
  State<GrowthTrackerScreen> createState() => _GrowthTrackerScreenState();
}

String? petId;

class _GrowthTrackerScreenState extends State<GrowthTrackerScreen> {
  @override
  void initState() {
    super.initState();

    getPetId();
    getPetGrowthFn(hFilter: "Weekly", wFilter: "Weekly");
  }

  void getPetId() async {
    petId = await StringConst.getPetID();
  }

  GetPetGrowthModel getGrowthModel = GetPetGrowthModel();

  final StreamController<GetPetGrowthModel> streamController =
      StreamController.broadcast();

  Future getPetGrowthFn({String? wFilter, String? hFilter}) async {
    try {
      String petId = await StringConst.getPetID();

      List response = await ServerClient.get(
        "${Urls.getPetGrowthUrl}$petId&wfilter=$wFilter&hfilter=$hFilter",
      );
      debugPrint(' response.first    :: ${response.first}');
      debugPrint(' response.last    :: ${response.last}');
      if (response.first >= 200 && response.first < 300) {
        final getGrowthModel = GetPetGrowthModel.fromJson(response.last);
        streamController.add(getGrowthModel);
      } else {
        streamController.add(GetPetGrowthModel());
      }
    } catch (e) {
      streamController.add(GetPetGrowthModel());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.white,
      appBar: AppBar(
          backgroundColor: AppConstants.white,
          title: const commonTextWidget(
            text: "Growth Tracker",
            color: AppConstants.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
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
          actions: [
            CommonInkwell(
              onTap: () {
                Routes.push(
                  context: context,
                  screen: GrowthHistoryScreen(
                    petId: petId ?? '',
                    successCallback: () {
                      getPetGrowthFn(hFilter: "Weekly", wFilter: "Weekly");
                    },
                  ),
                  exit: () {},
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Image.asset(
                  AppImages.growthHistoryIcon,
                  height: 22,
                ),
              ),
            ),
          ]),
      body: StreamBuilder<GetPetGrowthModel>(
        stream: streamController.stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return SingleChildScrollView(
            physics: const ScrollPhysics(),
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Card(
                  elevation: 5,
                  shadowColor: AppConstants.greyContainerBg,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(
                      color: AppConstants.greyContainerBg,
                      width: 1,
                    ),
                  ),
                  child: Container(
                    width: Responsive.width * 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppConstants.white,
                    ),
                    padding: const EdgeInsets.all(6),
                    child: Column(
                      children: [
                        commonNetworkImage(
                          url: widget.data.coverImage ??
                              "https://cdn.pixabay.com/photo/2017/11/14/13/06/kitty-2948404_640.jpg",
                          height: Responsive.height * 16,
                          width: Responsive.width * 100,
                          radius: 15,
                        ),
                        SizeBoxH(Responsive.height * .5),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  commonTextWidget(
                                    color: AppConstants.appPrimaryColor,
                                    text: widget.data.name ?? "",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  SizeBoxH(Responsive.height * .3),
                                  commonTextWidget(
                                    color: AppConstants.subTextGrey,
                                    text: context
                                        .read<PetProfileProvider>()
                                        .calculatePetAge(
                                          widget.data.birthDate ??
                                              DateTime.now(),
                                        ),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ],
                              ),
                              CommonBannerButtonWidget(
                                bgColor: AppConstants.greyContainerBg,
                                text: widget.data.sex ?? "",
                                borderColor: Colors.transparent,
                                textColor: AppConstants.appPrimaryColor,
                                width: 80,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizeBoxH(Responsive.height * 4),
                Material(
                  color: AppConstants.white,
                  elevation: 5,
                  shadowColor: AppConstants.greyContainerBg,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(
                      color: AppConstants.white,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 8, right: 8, top: 8),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      AppImages.weightIcon,
                                      height: 20,
                                    ),
                                    const SizeBoxV(10),
                                    const commonTextWidget(
                                      color: AppConstants.black,
                                      text: "Weight Tracker",
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    snapshot.data?.heightsData?.isEmpty == true
                                        ? const SizedBox.shrink()
                                        : PopupMenuButton<String>(
                                            color: AppConstants.white,
                                            shadowColor: AppConstants.white,
                                            surfaceTintColor:
                                                AppConstants.white,
                                            itemBuilder:
                                                (BuildContext context) =>
                                                    <PopupMenuEntry<String>>[
                                              const PopupMenuItem<String>(
                                                value: 'Weekly',
                                                child: Text(
                                                  'Weekly',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                              const PopupMenuItem<String>(
                                                value: 'Monthly',
                                                child: Text(
                                                  'Monthly',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                              const PopupMenuItem<String>(
                                                value: 'Yearly',
                                                child: Text(
                                                  'Yearly',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                            ],
                                            onSelected: (String value) {
                                              getPetGrowthFn(
                                                hFilter: "Weekly",
                                                wFilter: value,
                                              );
                                              context
                                                  .read<PetProfileProvider>()
                                                  .changeGrowthShowingDateType(
                                                    value,
                                                    false,
                                                  );
                                            },
                                            child: Container(
                                              width: 80,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                color: AppConstants
                                                    .greyContainerBg,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  commonTextWidget(
                                                    color: AppConstants.black40,
                                                    text: context
                                                        .read<
                                                            PetProfileProvider>()
                                                        .selectedGrowthShowingDateTypeForWeight
                                                        .toString(),
                                                    fontSize: 12,
                                                  ),
                                                  const Icon(
                                                    Icons
                                                        .keyboard_arrow_down_rounded,
                                                    color: AppConstants.black40,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      snapshot.data?.isNotWeight == true ||
                              snapshot.data?.weightsData?.isEmpty == true
                          ? SizedBox(
                              height: Responsive.height * 25,
                              child: const Center(
                                child: commonTextWidget(
                                  color: AppConstants.black40,
                                  text: "No data available",
                                  fontSize: 12,
                                ),
                              ),
                            )
                          : Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child:
                                  LineWidget(data: snapshot.data?.weightsData),
                            ),
                    ],
                  ),
                ),
                SizeBoxH(Responsive.height * 4),
                Material(
                  color: AppConstants.white,
                  elevation: 5,
                  shadowColor: AppConstants.greyContainerBg,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(
                      color: AppConstants.white,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 8, right: 8, top: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  AppImages.petHeightIcon,
                                  height: 18,
                                ),
                                const SizeBoxV(10),
                                const commonTextWidget(
                                  color: AppConstants.black,
                                  text: "Height Tracker",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                )
                              ],
                            ),
                            Row(
                              children: [
                                snapshot.data?.weightsData?.isEmpty == true
                                    ? const SizedBox.shrink()
                                    : PopupMenuButton<String>(
                                        color: AppConstants.white,
                                        shadowColor: AppConstants.white,
                                        surfaceTintColor: AppConstants.white,
                                        itemBuilder: (BuildContext context) =>
                                            <PopupMenuEntry<String>>[
                                          const PopupMenuItem<String>(
                                            value: 'Weekly',
                                            child: Text(
                                              'Weekly',
                                              style: TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                          const PopupMenuItem<String>(
                                            value: 'Monthly',
                                            child: Text(
                                              'Monthly',
                                              style: TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                          const PopupMenuItem<String>(
                                            value: 'Yearly',
                                            child: Text(
                                              'Yearly',
                                              style: TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ],
                                        onSelected: (String value) {
                                          getPetGrowthFn(
                                              hFilter: value,
                                              wFilter: "Weekly");
                                          context
                                              .read<PetProfileProvider>()
                                              .changeGrowthShowingDateType(
                                                value,
                                                true,
                                              );
                                        },
                                        child: Container(
                                          width: 80,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            color: AppConstants.greyContainerBg,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              commonTextWidget(
                                                color: AppConstants.black40,
                                                text: context
                                                    .read<PetProfileProvider>()
                                                    .selectedGrowthShowingDateTypeForHeight
                                                    .toString(),
                                                fontSize: 12,
                                              ),
                                              const Icon(
                                                Icons
                                                    .keyboard_arrow_down_rounded,
                                                color: AppConstants.black40,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      snapshot.data?.isNotHeight == true ||
                              snapshot.data?.heightsData?.isEmpty == true
                          ? SizedBox(
                              height: Responsive.height * 25,
                              child: const Center(
                                child: commonTextWidget(
                                  color: AppConstants.black40,
                                  text: "No data available",
                                  fontSize: 12,
                                ),
                              ),
                            )
                          : Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: LineWidget(
                                data: snapshot.data?.heightsData,
                              ),
                            ),
                    ],
                  ),
                ),
                SizeBoxH(Responsive.height * 4),
                CommonButton(
                  onTap: () {
                    Routes.push(
                      context: context,
                      screen: NewGrowthEntryScreen(
                        isEdit: false,
                        date: DateTime.now(),
                        id: '',
                        petId: '',
                        successCallback: () {},
                      ),
                      exit: () {
                        getPetGrowthFn(hFilter: "Weekly", wFilter: "Weekly");
                      },
                    );
                  },
                  isIconShow: true,
                  text: "Add New",
                  isFullRoundedButton: true,
                  size: 12,
                  bgColor: AppConstants.white,
                  textColor: AppConstants.appPrimaryColor,
                  borderColor: AppConstants.appPrimaryColor,
                  width: Responsive.width * 100,
                  height: 50,
                ),
                SizeBoxH(Responsive.height * 4),
              ],
            ),
          );
        },
      ),
    );
  }
}

class LineWidget extends StatelessWidget {
  const LineWidget({super.key, this.data});
  final List<EightsDatum>? data;
  @override
  Widget build(BuildContext context) {
    final maxY = data != null && data!.isNotEmpty
        ? data!.map((e) => e.value?.toDouble() ?? 0).reduce(max) *
            1.1 // Increase by 10% for padding
        : 150;
    return Container(
      height: Responsive.height * 25,
      width: Responsive.width * 100,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppConstants.white,
      ),
      // i need line chart here
      child: LineChart(
        LineChartData(
          gridData: const FlGridData(show: false),
          lineTouchData: LineTouchData(
            handleBuiltInTouches: true,
            touchTooltipData: LineTouchTooltipData(
              getTooltipColor: (touchedSpot) => AppConstants.appPrimaryColor,
            ),
          ),
          borderData: FlBorderData(
            show: true,
            border: const Border(
              bottom: BorderSide(color: Colors.transparent),
              left: BorderSide(color: Colors.transparent),
              right: BorderSide(color: Colors.transparent),
              top: BorderSide(color: Colors.transparent),
            ),
          ),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 52,
                interval: 1,
                getTitlesWidget: (value, axis) {
                  final list = data;
                  if (list == null) {
                    return const SizedBox();
                  }
                  if (value.toInt() >= 0 && value.toInt() < list.length) {
                    return SideTitleWidget(
                      axisSide: AxisSide.bottom,
                      space: 10,
                      child: Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: Text(
                          list[value.toInt()].name.toString(),
                        ),
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            leftTitles: const AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
              ),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            show: true,
          ),
          lineBarsData: [
            LineChartBarData(
              color: AppConstants.black,
              spots: data
                      ?.map(
                        (e) => FlSpot(
                          data?.indexOf(e).toDouble() ?? 0,
                          e.value?.toDouble() ?? 0,
                        ),
                      )
                      .toList() ??
                  [],
              isCurved: true,
              barWidth: 2,
              isStrokeCapRound: true,
              preventCurveOverShooting: false,
              belowBarData: BarAreaData(
                show: false,
              ),
              dotData: const FlDotData(
                show: false,
              ),
            ),
          ],
          minX: 0,
          maxX: data?.length.toDouble() ?? 0,
          maxY: maxY.toDouble(),
          minY: 0,
        ),
      ),
    );
  }
}

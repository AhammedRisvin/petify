import 'package:clan_of_pets/app/module/pet%20profile/model/get_growth_model.dart';
import 'package:clan_of_pets/app/utils/app_constants.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view model/pet_profile_provider.dart';

class _LineChart extends StatefulWidget {
  const _LineChart({this.data});
  final GetPetGrowthModel? data;
  @override
  State<_LineChart> createState() => _LineChartState();
}

class _LineChartState extends State<_LineChart> {
  PetProfileProvider petProfileProvider = PetProfileProvider();
  @override
  void initState() {
    super.initState();
    petProfileProvider = context.read<PetProfileProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return LineChart(
      sampleData1,
      duration: const Duration(milliseconds: 250),
    );
  }

  LineChartData get sampleData1 => LineChartData(
        lineTouchData: lineTouchData1,
        gridData: gridData,
        titlesData: titlesData1,
        borderData: borderData,
        lineBarsData: lineBarsData1,
        minX: 0,
        maxX: 11,
        maxY: 4,
        minY: 0,
      );

  LineTouchData get lineTouchData1 => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          getTooltipColor: (touchedSpot) => AppConstants.appPrimaryColor,
        ),
      );

  FlTitlesData get titlesData1 => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
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
      );

  List<LineChartBarData> get lineBarsData1 => [
        lineChartBarData1_3,
      ];

  List<String> yearNames = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];

  List<String> monthNames = [
    "week 1",
    "week 2",
    "week 3",
    "week 4",
  ];

  List<String> weekNames = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 11,
      wordSpacing: 2,
    );
    Widget? text;
    for (var element in widget.data!.heightsData!) {
      if (element.date!.month == value.toInt()) {
        text = Text(
          yearNames[value.toInt()],
          style: style,
        );
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: SideTitleWidget(
        axisSide: meta.axisSide,
        space: 10,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: text ?? const Text(''),
        ),
      ),
    );
  }

  SideTitles get bottomTitles {
    return SideTitles(
      showTitles: true,
      reservedSize: 32,
      interval: 1,
      getTitlesWidget: bottomTitleWidgets,
    );
  }

  FlGridData get gridData => const FlGridData(show: false);

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(color: Colors.transparent),
          left: BorderSide(color: Colors.transparent),
          right: BorderSide(color: Colors.transparent),
          top: BorderSide(color: Colors.transparent),
        ),
      );

  LineChartBarData get lineChartBarData1_3 => LineChartBarData(
        isCurved: true,
        color: AppConstants.black,
        barWidth: 1,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: petProfileProvider.selectedGrowthShowingDateTypeForHeight ==
                "Weekly"
            ? [
                const FlSpot(0, 2.8),
                const FlSpot(1, 1.9),
                const FlSpot(2, 3),
                const FlSpot(3, 1.3),
                const FlSpot(4, 2.5),
                const FlSpot(5, 2.8),
                const FlSpot(6, 1.9),
              ]
            : petProfileProvider.selectedGrowthShowingDateTypeForHeight ==
                    "Monthly"
                ? [
                    const FlSpot(0, 2.8),
                    const FlSpot(1, 1.9),
                    const FlSpot(2, 3),
                    const FlSpot(3, 1.3),
                  ]
                : const [
                    FlSpot(0, 2.8),
                    FlSpot(1, 1.9),
                    FlSpot(2, 3),
                    FlSpot(3, 1.3),
                    FlSpot(4, 2.5),
                    FlSpot(5, 2.8),
                    FlSpot(6, 1.9),
                    FlSpot(7, 3),
                    FlSpot(8, 1.3),
                    FlSpot(9, 2.5),
                    FlSpot(10, 2.8),
                    FlSpot(11, 1.9),
                  ],
      );
}

class LineChartSample1 extends StatefulWidget {
  const LineChartSample1({super.key, this.snapshot});

  final GetPetGrowthModel? snapshot;

  @override
  State<StatefulWidget> createState() => LineChartSample1State();
}

class LineChartSample1State extends State<LineChartSample1> {
  late bool isShowingMainData;

  @override
  void initState() {
    super.initState();
    isShowingMainData = true;
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.2,
      child: Column(
        children: <Widget>[
          Expanded(
            child: _LineChart(data: widget.snapshot),
          ),
        ],
      ),
    );
  }
}

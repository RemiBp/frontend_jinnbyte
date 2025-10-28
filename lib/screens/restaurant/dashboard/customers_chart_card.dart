import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../appColors/colors.dart';
import '../../../customWidgets/custom_text.dart';
import '../../../customWidgets/filter_drop_down.dart';
import '../../../l18n.dart';
import '../../../res/res.dart';

// class CustomersChartCard extends StatefulWidget {
//   const CustomersChartCard({super.key});
//
//   @override
//   State<CustomersChartCard> createState() => _CustomersChartCardState();
// }
//
// class _CustomersChartCardState extends State<CustomersChartCard> {
//   String selectedRange = 'Last Week';
//   late HomeProvider homeProvider;
//
//   @override
//   void initState() {
//     super.initState();
//     homeProvider = Provider.of<HomeProvider>(context, listen: false);
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       homeProvider.getCustomerChartAPI(type: "lastWeek");
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<HomeProvider>(builder: (context, provider, child) {
//
//       final xLabels = provider.customerChartResponse.chart?.labels ?? [];
//
//       final yValues = provider.customerChartResponse.chart?.values ?? [];
//
//       final spots = List<FlSpot>.generate(
//         yValues.length,
//             (index) => FlSpot(index.toDouble(), yValues[index].toDouble()),
//       );
//
//       return Container(
//         padding: EdgeInsets.symmetric(
//           horizontal: getWidthRatio() * 16,
//           vertical: getHeightRatio() * 12,
//         ),
//         decoration: BoxDecoration(
//           color: AppColors.textFieldColor,
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Column(
//           children: [
//             Align(
//               alignment: Alignment.centerRight,
//               child: SizedBox(
//                 width: getWidth() * 0.3,
//                 height: getHeightRatio() * 36,
//                 child: FilterDropDown(
//                   items: const ['Last Week', 'Last Month'],
//                   hintText: 'Select Date Range',
//                   selectedValue: selectedRange,
//                   bfColor: AppColors.appColor,
//                   onChanged: (value) {
//                     setState(() {
//                       selectedRange = value!;
//                     });
//                     print("dsdfsfsfs: $selectedRange");
//                     if(selectedRange == "Last Week"){
//                       provider.getCustomerChartAPI(type: "lastWeek");
//                     }else{
//                       provider.getCustomerChartAPI(type: "lastMonth");
//                     }
//                   },
//                   validator: (value) =>
//                   value == null ? 'Please select a date range' : null,
//                 ),
//               ),
//             ),
//             SizedBox(height: getHeight() * 0.01),
//             SizedBox(
//               height: getHeight() * 0.3,
//               child: provider.isCustomerFetched
//                   ? Stack(
//                     children: [
//                       LineChart(
//                         LineChartData(
//                       minX: 0,
//                       maxX: (xLabels.length - 1).toDouble(),
//                       minY: 0,
//                       maxY: yValues.isNotEmpty
//                           ? (yValues.reduce((a, b) => a > b ? a : b)) + 10
//                           : 10,
//                       gridData: const FlGridData(show: false),
//                       borderData: FlBorderData(
//                         show: true,
//                         border: const Border(
//                           bottom: BorderSide(color: AppColors.whiteColor),
//                           left: BorderSide(color: AppColors.whiteColor),
//                         ),
//                       ),
//                       titlesData: FlTitlesData(
//                         leftTitles: AxisTitles(
//                           sideTitles: SideTitles(
//                             showTitles: true,
//                             reservedSize: getWidth() * 0.08,
//                             getTitlesWidget: (value, meta) {
//                               return CustomText(
//                                 text: value.toInt().toString(),
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w400,
//                               );
//                             },
//                           ),
//                         ),
//                         bottomTitles: AxisTitles(
//                           sideTitles: SideTitles(
//                             showTitles: true,
//                             interval: 1,
//                             reservedSize: getHeight() * 0.05,
//                             getTitlesWidget: (value, meta) {
//                               final int index = value.toInt();
//                               if (index < 0 || index >= xLabels.length) {
//                                 return const SizedBox.shrink();
//                               }
//                               return Padding(
//                                 padding: EdgeInsets.only(
//                                     top: getHeight() * 0.02),
//                                 child: CustomText(
//                                   text: xLabels[index],
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w400,
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//                         topTitles:
//                         const AxisTitles(sideTitles: SideTitles(showTitles: false)),
//                         rightTitles:
//                         const AxisTitles(sideTitles: SideTitles(showTitles: false)),
//                       ),
//                       lineBarsData: [
//                         LineChartBarData(
//                           isCurved: true,
//                           color: AppColors.btnBgColor,
//                           belowBarData: BarAreaData(
//                             show: true,
//                             gradient: const LinearGradient(
//                               begin: Alignment.topCenter,
//                               end: Alignment.bottomCenter,
//                               colors: [AppColors.gradientColor1, AppColors.gradientColor2],
//                             ),
//                           ),
//                           dotData: FlDotData(
//                             show: true,
//                             getDotPainter: (spot, percent, barData, index) {
//                               return FlDotCirclePainter(
//                                 radius: getWidthRatio() * 5,
//                                 color: AppColors.btnBgColor,
//                               );
//                             },
//                           ),
//                           spots: spots,
//                           barWidth: getWidthRatio() * 2,
//                         ),
//                       ],
//                       lineTouchData: LineTouchData(
//                         touchTooltipData: LineTouchTooltipData(
//                           tooltipBgColor: AppColors.appColor,
//                           getTooltipItems: (touchedSpots) {
//                             return touchedSpots.map((touchedSpot) {
//                               return LineTooltipItem(
//                                 '${touchedSpot.y.toInt()} Customer',
//                                 const TextStyle(
//                                   color: AppColors.whiteColor,
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w400,
//                                 ),
//                               );
//                             }).toList();
//                           },
//                         ),
//                         handleBuiltInTouches: true,
//                       ),
//                                       ),
//                       ),
//                       if (yValues.every((value) => value == 0))
//                         const NoChartDataWidget(
//                           icon: Assets.customerChartIcon,
//                         ),
//                     ],
//                   )
//                   : const Center(child: CircularProgressIndicator()),
//             ),
//           ],
//         ),
//       );
//     });
//   }
// }

class CustomersChartCard extends StatefulWidget {
  const CustomersChartCard({super.key});

  @override
  State<CustomersChartCard> createState() => _CustomersChartCardState();
}

class _CustomersChartCardState extends State<CustomersChartCard> {
  final List<String> months = [
    al.january,
    al.february,
    al.march,
    al.april,
    al.may,
    al.june,
    al.july,
    al.august,
    al.september,
    al.october,
    al.november,
    al.december,
  ];

  String selectedRange = DateFormat('MMMM').format(DateTime.now());

  final Map<String, List<FlSpot>> monthlyData = {
    al.january: [FlSpot(0, 50), FlSpot(1, 100), FlSpot(2, 80), FlSpot(3, 120)],
    al.february: [FlSpot(0, 30), FlSpot(1, 90), FlSpot(2, 60), FlSpot(3, 110)],
    al.march: [FlSpot(0, 40), FlSpot(1, 85), FlSpot(2, 95), FlSpot(3, 130)],
    al.april: [FlSpot(0, 100), FlSpot(1, 120), FlSpot(2, 160), FlSpot(3, 180)],
    al.may: [FlSpot(0, 110), FlSpot(1, 140), FlSpot(2, 120), FlSpot(3, 170)],
    al.june: [FlSpot(0, 80), FlSpot(1, 100), FlSpot(2, 90), FlSpot(3, 130)],
    al.july: [FlSpot(0, 60), FlSpot(1, 150), FlSpot(2, 130), FlSpot(3, 200)],
    al.august: [FlSpot(0, 90), FlSpot(1, 110), FlSpot(2, 115), FlSpot(3, 160)],
    al.september: [FlSpot(0, 70), FlSpot(1, 130), FlSpot(2, 125), FlSpot(3, 140)],
    al.october: [FlSpot(0, 100), FlSpot(1, 160), FlSpot(2, 140), FlSpot(3, 190)],
    al.november: [FlSpot(0, 85), FlSpot(1, 100), FlSpot(2, 120), FlSpot(3, 140)],
    al.december: [FlSpot(0, 60), FlSpot(1, 140), FlSpot(2, 150), FlSpot(3, 170)],
  };

  @override
  Widget build(BuildContext context) {
    final List<String> xLabels = ['Week 1', 'Week 2', 'Week 3', 'Week 4'];
    final List<FlSpot> spots = monthlyData[selectedRange] ?? [];

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: getWidthRatio() * 16,
        vertical: getHeightRatio() * 12,
      ),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: AppColors.blackColor.withAlpha(20),
            offset: Offset(0, 0),
            blurRadius: 24,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: al.monthlyEvolution,
                fontSize: sizes?.fontSize14,
                fontWeight: FontWeight.w500,
                color: AppColors.primarySlateColor,
              ),
              SizedBox(
                width: getWidth() * 0.3,
                height: getHeightRatio() * 36,
                child: FilterDropDown(
                  items: months,
                  hintText: al.selectMonth,
                  selectedValue: selectedRange,
                  bfColor: AppColors.whiteColor,
                  onChanged: (value) {
                    setState(() {
                      selectedRange = value!;
                    });
                  },
                  validator: (value) =>
                  value == null ? al.pleaseSelectMonth : null,
                ),
              ),
            ],
          ),
          SizedBox(height: getHeightRatio() * 16),
          SizedBox(
            height: getHeight() * 0.3,
            child: LineChart(
              LineChartData(
                minX: 0,
                maxX: 3,
                minY: 0,
                maxY: 250,
                gridData: const FlGridData(show: false),
                borderData: FlBorderData(
                  show: true,
                  border: const Border(
                    bottom: BorderSide(color: AppColors.greyBordersColor),
                    left: BorderSide(color: AppColors.greyBordersColor),
                  ),
                ),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: getWidth() * 0.08,
                      getTitlesWidget: (value, meta) {
                        return CustomText(
                          text: value.toInt().toString(),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        );
                      },
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 1,
                      reservedSize: getHeight() * 0.05,
                      getTitlesWidget: (value, meta) {
                        final int index = value.toInt();
                        if (index < 0 || index >= xLabels.length) {
                          return const SizedBox.shrink();
                        }
                        return SideTitleWidget(
                          meta: meta,
                          child: Transform.translate(
                            offset: Offset(
                              index == 0
                                  ? 17 // push Week 1 right
                                  : (index == xLabels.length - 1 ? -22 : 0), // push Week 4 left more
                              0,
                            ),
                            child: CustomText(
                              text: xLabels[index],
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                ),
                lineBarsData: [
                  LineChartBarData(
                    isCurved: true,
                    color: AppColors.restaurantPrimaryColor,
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [AppColors.orangeWithOpacity, AppColors.orangeTransparent],
                      ),
                    ),
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, barData, index) {
                        return FlDotCirclePainter(
                          radius: getWidthRatio() * 5,
                          color: AppColors.restaurantPrimaryColor,
                        );
                      },
                    ),
                    spots: spots,
                    barWidth: getWidthRatio() * 2,
                  ),
                ],
                lineTouchData: LineTouchData(
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipColor: (touchedSpot) => AppColors.greyColor,
                    getTooltipItems: (touchedSpots) {
                      return touchedSpots.map((touchedSpot) {
                        return LineTooltipItem(
                          '${touchedSpot.y.toInt()} Customer',
                          const TextStyle(
                            color: AppColors.blackColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        );
                      }).toList();
                    },
                  ),
                  handleBuiltInTouches: true,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}







// class CustomersChartCard extends StatefulWidget {
//   const CustomersChartCard({super.key});
//
//   @override
//   State<CustomersChartCard> createState() => _CustomersChartCardState();
// }
//
// class _CustomersChartCardState extends State<CustomersChartCard> {
//   String? selectedRange = 'Last Week';
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: getWidthRatio() * 16, vertical: getHeightRatio() * 12),
//       decoration: BoxDecoration(
//         color: AppColors.textFieldColor,
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Column(
//         children: [
//           Align(
//             alignment: Alignment.centerRight,
//             child: SizedBox(
//               width: getWidth() * 0.3,
//               height: getHeightRatio() * 36,
//               child: FilterDropDown(
//                 items: const ['Last Week', 'Last Month'],
//                 hintText: 'Select Date Range',
//                 selectedValue: selectedRange,
//                 bfColor: AppColors.appColor,
//                 onChanged: (value) {
//                   setState(() {
//                     selectedRange = value;
//                   });
//                 },
//                 validator: (value) =>
//                 value == null ? 'Please select a date range' : null,
//               ),
//             ),
//           ),
//           SizedBox(height: getHeight() * 0.01),
//           SizedBox(
//             height: getHeight() * 0.3,
//             child: LineChart(
//               LineChartData(
//                 backgroundColor: AppColors.textFieldColor,
//                 titlesData: FlTitlesData(
//                   leftTitles: AxisTitles(
//                     sideTitles: SideTitles(
//                       showTitles: true,
//                       getTitlesWidget: (value, meta) {
//                         return CustomText(
//                             text: value.toInt().toString(),
//                           fontSize: sizes.fontSize12,
//                           fontWeight: FontWeight.w400,
//                         );
//                       },
//                       reservedSize: getWidth() * 0.08,
//                     ),
//                   ),
//                   bottomTitles: AxisTitles(
//                     sideTitles: SideTitles(
//                       showTitles: true,
//                       reservedSize: getHeight() * 0.05,
//                       getTitlesWidget: (value, meta) {
//                         const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
//                         return Container(
//                           padding: EdgeInsets.only(top: getHeight() * 0.02),
//                           child: CustomText(
//                             text: days[value.toInt()],
//                             fontSize: sizes.fontSize12,
//                             fontWeight: FontWeight.w400,
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                   topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
//                   rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
//                 ),
//                 gridData: const FlGridData(show: false),
//                 borderData: FlBorderData(
//                   show: true,
//                   border: const Border(
//                     bottom: BorderSide(color: AppColors.whiteColor),
//                     left: BorderSide(color: AppColors.whiteColor),
//                   ),
//                 ),
//                 minX: 0,
//                 maxX: 6,
//                 minY: 0,
//                 maxY: 100,
//                 lineBarsData: [
//                   LineChartBarData(
//                     isCurved: true,
//                     color: AppColors.btnBgColor,
//                     belowBarData: BarAreaData(
//                       show: true,
//                       gradient: const LinearGradient(
//                         begin: Alignment.topCenter,
//                         end: Alignment.bottomCenter,
//                         colors: [
//                           AppColors.gradientColor1,
//                           AppColors.gradientColor2
//                         ],
//                       ),
//                     ),
//                     dotData: FlDotData(
//                       show: true,
//                       getDotPainter: (spot, percent, barData, index) {
//                         return FlDotCirclePainter(
//                           radius: getWidthRatio() * 5,
//                           color: AppColors.btnBgColor,
//                         );
//                       },
//                     ),
//                     spots: const [
//                       FlSpot(0, 10),
//                       FlSpot(1, 60),
//                       FlSpot(2, 40),
//                       FlSpot(3, 50),
//                       FlSpot(4, 45),
//                       FlSpot(5, 80),
//                       FlSpot(6, 95),
//                     ],
//                     barWidth: getWidthRatio() * 2,
//                   ),
//                 ],
//                 lineTouchData: LineTouchData(
//                   touchTooltipData: LineTouchTooltipData(
//                     tooltipBgColor: AppColors.appColor,
//                     getTooltipItems: (touchedSpots) {
//                       return touchedSpots.map((touchedSpot) {
//                         return LineTooltipItem(
//                           '${touchedSpot.y.toInt()} Customer',
//                           TextStyle(
//                             color: AppColors.whiteColor,
//                             fontSize: sizes.fontSize12,
//                             fontWeight: FontWeight.w400
//                           ),
//                         );
//                       }).toList();
//                     },
//                   ),
//                   touchCallback: (event, response) {},
//                   handleBuiltInTouches: true,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

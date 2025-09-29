
import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../appAssets/app_assets.dart';
import '../../../appColors/colors.dart';
import '../../../customWidgets/custom_text.dart';
import '../../../res/res.dart';



// class BookingChartCard extends StatefulWidget {
//   const BookingChartCard({super.key});
//
//   @override
//   State<BookingChartCard> createState() => _BookingChartCardState();
// }
//
// class _BookingChartCardState extends State<BookingChartCard> {
//   String selectedRange = 'Last Week';
//   late HomeProvider homeProvider;
//
//   @override
//   void initState() {
//     super.initState();
//     homeProvider = Provider.of<HomeProvider>(context, listen: false);
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       homeProvider.getBookingChartAPI(type: "lastWeek");
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<HomeProvider>(builder: (context, provider, child) {
//       final xLabels = provider.bookingChartResponse.chart?.labels ?? [];
//       final yValues = provider.bookingChartResponse.chart?.values ?? [];
//
//       return Container(
//         padding: EdgeInsets.symmetric(
//           horizontal: getWidthRatio() * 12,
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
//                     if (value != null) {
//                       setState(() => selectedRange = value);
//                       final type = selectedRange == 'Last Week' ? 'lastWeek' : 'lastMonth';
//                       provider.getBookingChartAPI(type: type);
//                     }
//                   },
//                   validator: (value) => value == null ? 'Please select a date range' : null,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 16),
//             SizedBox(
//               height: getHeight() * 0.3,
//               child: provider.isBookingFetched
//                   ? Stack(
//                     children: [
//                       BarChart(
//                                       BarChartData(
//                       borderData: FlBorderData(
//                         show: true,
//                         border: const Border(
//                           bottom: BorderSide(color: AppColors.whiteColor),
//                           left: BorderSide(color: AppColors.whiteColor),
//                         ),
//                       ),
//                       gridData: const FlGridData(show: false),
//                       titlesData: FlTitlesData(
//                         leftTitles: AxisTitles(
//                           sideTitles: SideTitles(
//                             showTitles: true,
//                             reservedSize: getWidth() * 0.08,
//                             getTitlesWidget: (value, _) => CustomText(
//                               text: value.toInt().toString(),
//                               fontSize: sizes.fontSize12,
//                               fontWeight: FontWeight.w400,
//                             ),
//                           ),
//                         ),
//                         bottomTitles: AxisTitles(
//                           sideTitles: SideTitles(
//                             showTitles: true,
//                             reservedSize: getHeight() * 0.05,
//                             getTitlesWidget: (value, _) {
//                               int index = value.toInt();
//                               if (index >= 0 && index < xLabels.length) {
//                                 return Padding(
//                                   padding: EdgeInsets.only(top: getHeight() * 0.02),
//                                   child: CustomText(
//                                     text: xLabels[index],
//                                     fontSize: sizes.fontSize12,
//                                     fontWeight: FontWeight.w400,
//                                   ),
//                                 );
//                               }
//                               return const SizedBox.shrink();
//                             },
//                           ),
//                         ),
//                         topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
//                         rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
//                       ),
//                       barGroups: yValues.asMap().entries.map((entry) {
//                         final index = entry.key;
//                         final value = entry.value.toDouble();
//                         return BarChartGroupData(
//                           x: index,
//                           barRods: [
//                             BarChartRodData(
//                               toY: value,
//                               color: AppColors.ratingIconColor,
//                               width: getWidthRatio() * 18,
//                               borderRadius: BorderRadius.circular(2),
//                             ),
//                           ],
//                         );
//                       }).toList(),
//                       barTouchData: BarTouchData(
//                         touchTooltipData: BarTouchTooltipData(
//                           tooltipBgColor: AppColors.appColor,
//                         ),
//                       ),
//                       maxY: yValues.isNotEmpty ? yValues.reduce((a, b) => a > b ? a : b).toDouble() + 10 : 100,
//                       minY: 0,
//                                       ),
//                                     ),
//                       if (yValues.every((value) => value == 0))
//                         const NoChartDataWidget(),
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



class BookingChartCard extends StatefulWidget {
  const BookingChartCard({super.key});

  @override
  State<BookingChartCard> createState() => _BookingChartCardState();
}

class _BookingChartCardState extends State<BookingChartCard> {
  String selectedRange = 'Category';

  List<double> barData = [];
  List<String> xLabels = [];

  @override
  void initState() {
    super.initState();
    fetchChartData(selectedRange);
  }

  void fetchChartData(String range) {
    if (range == 'Category') {
      xLabels = ['Bowl', 'Lasagna', 'Sushi', 'Burger', 'Ramen'];
      // Ratings (1.0–5.0)
      barData = [3.2, 3.5, 3.0, 3.3, 5.0];
    } else if (range == 'Last Month') {
      xLabels = ['Week 1', 'Week 2', 'Week 3', 'Week 4'];
      barData = [2.5, 3.8, 4.1, 3.6];
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getHeight() * 0.35,
      width: double.infinity,
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
            offset: const Offset(0, 0),
            blurRadius: 24,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Header with dropdown
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: "Dish Ratings",
                fontSize: sizes?.fontSize14,
                fontFamily: Assets.onsetMedium,
                fontWeight: FontWeight.w500,
                color: AppColors.primarySlateColor,
              ),
              DropdownButton<String>(
                value: selectedRange,
                underline: const SizedBox(),
                items: ['Category', 'Last Month']
                    .map((e) => DropdownMenuItem(
                  value: e,
                  child: Text(e),
                ))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => selectedRange = value);
                    fetchChartData(value);
                  }
                },
              ),
            ],
          ),

          SizedBox(height: getHeightRatio() * 16),

          /// Chart
          Flexible(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                height: getHeight() * 0.3, // chart height stays consistent
                width: barData.length * getWidthRatio() * 70,
                child: BarChart(
                  BarChartData(
                    backgroundColor: AppColors.whiteColor,
                    borderData: FlBorderData(
                      show: true,
                      border: const Border(
                        bottom: BorderSide(color: AppColors.greyBordersColor),
                        left: BorderSide(color: AppColors.greyBordersColor),
                      ),
                    ),
                    gridData: const FlGridData(show: false),
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 40,
                          interval: 1,
                          getTitlesWidget: (value, meta) {
                            if (value >= 1 && value <= 5) {
                              return CustomText(
                                text: value.toStringAsFixed(1),
                                fontSize: sizes?.fontSize12,
                                fontWeight: FontWeight.w400,
                              );
                            }
                            return const SizedBox();
                          },
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 40,
                          getTitlesWidget: (value, meta) {
                            if (value.toInt() >= 0 &&
                                value.toInt() < xLabels.length) {
                              return Padding(
                                padding: EdgeInsets.only(top: 10),
                                child: CustomText(
                                  text: xLabels[value.toInt()],
                                  fontSize: sizes?.fontSize12,
                                  fontWeight: FontWeight.w400,
                                ),
                              );
                            }
                            return const SizedBox();
                          },
                        ),
                      ),
                      topTitles:
                      const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      rightTitles:
                      const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    ),
                    barGroups: barData.asMap().entries.map((entry) {
                      final index = entry.key;
                      final value = entry.value;
                      return BarChartGroupData(
                        x: index,
                        barRods: [
                          BarChartRodData(
                            toY: value,
                            color: AppColors.restaurantPrimaryColor,
                            width: getWidthRatio() * 18,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ],
                      );
                    }).toList(),
                    barTouchData: BarTouchData(
                      touchTooltipData: BarTouchTooltipData(
                        getTooltipColor: (touchedSpot) => AppColors.greyColor,
                      ),
                      handleBuiltInTouches: true,
                    ),
                    maxY: 5.2,
                    minY: 1,
                    alignment: BarChartAlignment.spaceAround,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}



// class BookingChartCard extends StatefulWidget {
//   const BookingChartCard({super.key});
//
//   @override
//   State<BookingChartCard> createState() => _BookingChartCardState();
// }
//
// class _BookingChartCardState extends State<BookingChartCard> {
//   String selectedRange = 'Category';
//
//   List<double> barData = [];
//   List<String> xLabels = [];
//
//   @override
//   void initState() {
//     super.initState();
//     fetchChartData(selectedRange);
//   }
//
//   void fetchChartData(String range) {
//     // Simulated backend response based on range
//     if (range == 'Category') {
//       xLabels = ['Bowl', 'Ramen', 'Sat', 'Sun'];
//       barData = [85, 65, 28, 70,];
//     } else if (range == 'Last Month') {
//       xLabels = ['Week 1', 'Week 2', 'Week 3', 'Week 4'];
//       barData = [150, 200, 120, 100];
//     }
//     setState(() {});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(
//         horizontal: getWidthRatio() * 16,
//         vertical: getHeightRatio() * 12,
//       ),
//       decoration: BoxDecoration(
//         color: AppColors.whiteColor,
//         borderRadius: BorderRadius.circular(8),
//         boxShadow: [
//           BoxShadow(
//             color: AppColors.blackColor.withAlpha(20),
//             offset: Offset(0, 0),
//             blurRadius: 24,
//             spreadRadius: 0,
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           // Align(
//           //   alignment: Alignment.centerRight,
//           //   child: SizedBox(
//           //     width: getWidth() * 0.3,
//           //     height: getHeightRatio() * 36,
//           //     child: FilterDropDown(
//           //       items: const ['Last Week', 'Last Month'],
//           //       hintText: 'Select Date Range',
//           //       selectedValue: selectedRange,
//           //       bfColor: AppColors.appColor,
//           //       onChanged: (value) {
//           //         if (value != null) {
//           //           selectedRange = value;
//           //           fetchChartData(selectedRange);
//           //         }
//           //       },
//           //       validator: (value) => value == null ? 'Please select a date range' : null,
//           //     ),
//           //   ),
//           // ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               CustomText(
//                 text: 'Dish Ratings',
//                 fontSize: sizes?.fontSize14,
//                 fontWeight: FontWeight.w500,
//                 color: AppColors.primarySlateColor,
//               ),
//               SizedBox(
//                 width: getWidth() * 0.3,
//                 height: getHeightRatio() * 36,
//                 child: FilterDropDown(
//                   items: const ['Category', 'Category1'],
//                   hintText: 'Select Category',
//                   selectedValue: selectedRange,
//                   bfColor: AppColors.whiteColor,
//                   onChanged: (value) {
//                     setState(() {
//                       selectedRange = value!;
//                     });
//                   },
//                   validator: (value) =>
//                   value == null ? 'Please select Category' : null,
//                 ),),
//             ],
//           ),
//           SizedBox(height: getHeightRatio() * 16),
//           SizedBox(
//             height: getHeight() * 0.3,
//             child: BarChart(
//               BarChartData(
//                 backgroundColor: AppColors.whiteColor,
//                 borderData: FlBorderData(
//                   show: true,
//                   border: const Border(
//                     bottom: BorderSide(color: AppColors.greyBordersColor),
//                     left: BorderSide(color: AppColors.greyBordersColor),
//                   ),
//                 ),
//                 gridData: const FlGridData(show: false),
//                 titlesData: FlTitlesData(
//                   leftTitles: AxisTitles(
//                     sideTitles: SideTitles(
//                       showTitles: true,
//                       reservedSize: getWidth() * 0.08,
//                       getTitlesWidget: (value, meta) {
//                         return CustomText(
//                           text: value.toInt().toString(),
//                           fontSize: sizes?.fontSize12,
//                           fontWeight: FontWeight.w400,
//                         );
//                       },
//                     ),
//                   ),
//                   bottomTitles: AxisTitles(
//                     sideTitles: SideTitles(
//                       showTitles: true,
//                       reservedSize: getHeight() * 0.05,
//                       getTitlesWidget: (value, meta) {
//                         if (value.toInt() >= 0 && value.toInt() < xLabels.length) {
//                           return Container(
//                             padding: EdgeInsets.only(top: getHeight() * 0.02),
//                             child: CustomText(
//                               text: xLabels[value.toInt()],
//                               fontSize: sizes?.fontSize12,
//                               fontWeight: FontWeight.w400,
//                             ),
//                           );
//                         }
//                         return const SizedBox();
//                       },
//                     ),
//                   ),
//                   topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
//                   rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
//                 ),
//                 barGroups: barData.asMap().entries.map((entry) {
//                   final index = entry.key;
//                   final value = entry.value;
//                   return BarChartGroupData(
//                     x: index,
//                     barRods: [
//                       BarChartRodData(
//                         toY: value,
//                         color: AppColors.restaurantPrimaryColor,
//                         width: getWidthRatio() * 18,
//                         borderRadius: BorderRadius.circular(2),
//                       ),
//                     ],
//                   );
//                 }).toList(),
//                 barTouchData: BarTouchData(
//                   touchTooltipData: BarTouchTooltipData(
//                     getTooltipColor: (touchedSpot) => AppColors.greyColor,
//                     // tooltipBgColor: AppColors.appColor,
//                   ),
//                   touchCallback: (event, response) {},
//                   handleBuiltInTouches: true,
//                 ),
//                 maxY: (barData.isNotEmpty ? (barData.reduce(max) + 20) : 100),
//                 minY: 0,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }







// class BookingChartCard extends StatefulWidget {
//   const BookingChartCard({super.key});
//
//   @override
//   State<BookingChartCard> createState() => _BookingChartCardState();
// }
//
// class _BookingChartCardState extends State<BookingChartCard> {
//   String? selectedRange = 'Last Week';
//
//   final List<double> barData = [85, 65, 28, 70, 55, 100, 100];
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: getWidthRatio() * 12, vertical: getHeightRatio() * 12),
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
//           const SizedBox(height: 16),
//           SizedBox(
//             height: getHeight() * 0.3,
//             child: BarChart(
//               BarChartData(
//                 backgroundColor: AppColors.textFieldColor,
//                 borderData: FlBorderData(
//                   show: true,
//                   border: const Border(
//                     bottom: BorderSide(color: AppColors.whiteColor),
//                     left: BorderSide(color: AppColors.whiteColor),
//                   ),
//                 ),
//                 gridData: const FlGridData(show: false),
//                 titlesData: FlTitlesData(
//                   leftTitles: AxisTitles(
//                     sideTitles: SideTitles(
//                       showTitles: true,
//                       reservedSize: getWidth() * 0.08,
//                       getTitlesWidget: (value, meta) {
//                         return CustomText(
//                           text: value.toInt().toString(),
//                           fontSize: sizes.fontSize12,
//                           fontWeight: FontWeight.w400,
//                         );
//                       },
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
//                 barGroups: barData.asMap().entries.map((entry) {
//                   final index = entry.key;
//                   final value = entry.value;
//                   return BarChartGroupData(
//                     x: index,
//                     barRods: [
//                       BarChartRodData(
//                         toY: value,
//                         color: AppColors.ratingIconColor,
//                         width: getWidthRatio() * 18,
//                         borderRadius: BorderRadius.circular(2),
//                       ),
//                     ],
//                   );
//                 }).toList(),
//                 barTouchData: BarTouchData(
//                   touchTooltipData: BarTouchTooltipData(
//                     tooltipBgColor: AppColors.appColor,
//                   ),
//                   touchCallback: (event, response) {},
//                   handleBuiltInTouches: true,
//                 ),
//                 maxY: 100,
//                 minY: 0,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

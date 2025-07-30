import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../appColors/colors.dart';
import '../../../customWidgets/custom_text.dart';
import '../../../res/res.dart';

class DishDropAlertsCard extends StatelessWidget {
  const DishDropAlertsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(getHeightRatio() * 16),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.blackColor.withOpacity(0.05),
            blurRadius: 24,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: CustomText(
              text: 'Dish Drop Alerts',
              fontSize: sizes?.fontSize14,
              fontWeight: FontWeight.w500,
              color: AppColors.primarySlateColor,
            ),
          ),
          SizedBox(height: getHeightRatio() * 16),
          SizedBox(
            height: getHeightRatio() * 200,
            child: LineChart(
              LineChartData(
                minX: 0,
                maxX: 5,
                minY: 0,
                maxY: 5,
                gridData: FlGridData(show: false),
                borderData: FlBorderData(
                  show: true,
                  border: const Border(
                    left: BorderSide(color: AppColors.greyBordersColor),
                    bottom: BorderSide(color: AppColors.greyBordersColor),
                  ),
                ),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, _) => Text(value.toStringAsFixed(0)),
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, _) {
                        final days = ['D1', 'D2', 'D3', 'D4', 'D5', 'D6'];
                        return Text(days[value.toInt()]);
                      },
                    ),
                  ),
                  rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                lineBarsData: [
                  LineChartBarData(
                    isCurved: false,
                    color: Colors.red,
                    dotData: FlDotData(show: true),
                    belowBarData: BarAreaData(show: false),
                    spots: const [
                      FlSpot(0, 1),
                      FlSpot(1, 2),
                      FlSpot(2, 1),
                      FlSpot(3, 4),
                      FlSpot(4, 2),
                      FlSpot(5, 3),
                    ],
                  )
                ],
                lineTouchData: LineTouchData(
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipColor: (touchedSpot) => AppColors.greyColor,
                    // tooltipBgColor: Colors.white,
                    // tooltipRoundedRadius: 8,
                    getTooltipItems: (touchedSpots) {
                      return touchedSpots.map((touched) {
                        return LineTooltipItem(
                          '4 days ago\nRating: ⭐ ${touched.y.toStringAsFixed(1)}',
                          const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                        );
                      }).toList();
                    },
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

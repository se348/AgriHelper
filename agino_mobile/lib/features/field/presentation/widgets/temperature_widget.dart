import '../../domain/entities/weather_entity.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/presentation/theme/app_colors.dart';

class TemperatureWidget extends StatelessWidget {
  const TemperatureWidget({super.key, required this.weatherEntities});

  final List<WeatherEntity> weatherEntities;

  @override
  Widget build(BuildContext context) {
    final List<FlSpot> temperatureSpots = weatherEntities
        .asMap()
        .map((index, data) => MapEntry(
            index.toDouble(), FlSpot(index.toDouble(), data.temperature)))
        .values
        .toList();
    final List<String> dayLabels = weatherEntities.map((data) {
      final dayFormat = DateFormat.E('en_US');
      return dayFormat.format(data.dateOfTheWeek);
    }).toList();
    return Container(
      height: 300,
      color: AppColors.white,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, left: 20.0, bottom: 10),
        child: LineChart(LineChartData(
            gridData: FlGridData(
                show: true,
                horizontalInterval: 5,
                drawHorizontalLine: true,
                drawVerticalLine: false,
                getDrawingHorizontalLine: (value) {
                  if (value == 0) {
                    // Customize the appearance of the baseline
                    return const FlLine(
                      color: Colors.red, // Line color
                      strokeWidth: 2, // Line width
                      dashArray: [5], // Dash pattern (optional)
                    );
                  } else {
                    // Customize the appearance of other horizontal lines
                    return FlLine(
                      color: Colors.grey.withOpacity(0.5),
                      strokeWidth: 0.8,
                    );
                  }
                }),
            borderData: FlBorderData(
                border: Border.all(color: AppColors.green), show: false),
            minX: 0,
            maxX: weatherEntities.length.toDouble() - 1,
            minY: 5,
            maxY: 30,
            titlesData: FlTitlesData(
              topTitles: AxisTitles(
                  sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 25,
                getTitlesWidget: (value, meta) {
                  final int index = value.toInt();
                  if (index >= 0 &&
                      index < dayLabels.length &&
                      value == index) {
                    return Text(
                      dayLabels[index],
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium
                          ?.copyWith(fontWeight: FontWeight.w800, fontSize: 15),
                    );
                  }
                  return const Text('');
                },
              )),
              leftTitles:
                  const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              bottomTitles:
                  const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            ),
            lineBarsData: [
              LineChartBarData(
                spots: temperatureSpots,
                isCurved: false,
                color: Theme.of(context).primaryColor,
                dotData: const FlDotData(show: false),
                belowBarData: BarAreaData(show: false),
              )
            ])),
      ),
    );
  }
}
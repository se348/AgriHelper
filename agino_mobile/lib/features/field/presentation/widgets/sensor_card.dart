import '../../../../core/presentation/theme/app_colors.dart';
import '../../../sensor/domain/entities/sensor_entity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SensorCard extends StatelessWidget {
  const SensorCard({super.key, required this.sensor});
  final SensorEntity sensor;
  @override
  Widget build(BuildContext context) {
    sensor.lastResetDate = DateTime.now().add(Duration(days: -2));
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final difference = sensor.cuttingDateCalculated.difference(today);

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    (sensor.batteryStatus == 0)
                        ? Image.asset("assets/red_sensor.png")
                        : Image.asset("assets/green_sensor.png"),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      sensor.serialNumber,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                Icon(Icons.more_vert)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      sensor.calculatedGdd.toString(),
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: (sensor.calculatedGdd! >= sensor.optimalGdd)
                              ? AppColors.red
                              : AppColors.grayDark),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      "Current GDD",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      sensor.optimalGdd.toString(),
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      "GDD Goal",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                Column(
                  children: [
                    difference.inDays < 0
                        ? Text(
                            "-",
                            style: Theme.of(context).textTheme.labelLarge,
                          )
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "${difference.inDays}",
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                              Text("days",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge
                                      ?.copyWith(fontSize: 14)),
                            ],
                          ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      "To cutting",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (sensor.lastResetDate != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Last sensor reset: ${DateFormat.yMd().format(sensor.lastResetDate!)}",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            )
        ],
      ),
    );
  }
}

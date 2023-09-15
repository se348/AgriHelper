import '../../domain/entities/field_entity.dart';
import '../widgets/no_sensor_widget.dart';
import '../widgets/sensor_card.dart';
import '../widgets/temperature_widget.dart';

import '../bloc/field_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/presentation/theme/app_colors.dart';
import '../../../../injection_container.dart';

class FieldDetailScreen extends StatelessWidget {
  const FieldDetailScreen({super.key, required this.fieldId});
  final int fieldId;
  void onAddPressed(BuildContext context) async {
    bool? isCreated = await context.push<bool>("/create-sensor/$fieldId");
    if (isCreated != null && isCreated) {
      // ignore: use_build_context_synchronously
      BlocProvider.of<FieldBloc>(context, listen: false)
          .add(GetFieldEvent(fieldId: fieldId));
    }
  }

  Widget buildHeight(BuildContext context, int height) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          const Icon(Icons.height),
          Text(
            height >= 0
                ? "$height above sea level"
                : "${-1 * height} below sea level",
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }

  // Widget buildTempGraph(
  //     BuildContext context, List<WeatherEntity> weatherEntities) {

  // }

  Widget buildInfoWhenSensorExist(
      BuildContext context, FieldEntity fieldEntity) {
    return Column(
      children: [
        buildHeight(context, fieldEntity.altitude),
        if (fieldEntity.sensorEntities!.isNotEmpty)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Sensors",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              IconButton(
                  onPressed: () {
                    onAddPressed(context);
                  },
                  icon: const Icon(Icons.add))
            ],
          ),
        for (var sensor in fieldEntity.sensorEntities!)
          SensorCard(sensor: sensor),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Weather Forecast",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              "Statistics",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "Temperature",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(
          height: 3,
        ),
        Text(
          "Next 7 days",
          style: Theme.of(context).textTheme.bodySmall,
        ),
        TemperatureWidget(weatherEntities: fieldEntity.weatherEntities!),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<FieldBloc>()..add(GetFieldEvent(fieldId: fieldId)),
      child: Scaffold(
          appBar: AppBar(
            title: Image.asset("assets/agino_logo.png"),
            backgroundColor: AppColors.green,
            actions: [
              IconButton(
                  onPressed: () {
                    onAddPressed(context);
                  },
                  icon: const Icon(Icons.add)),
              IconButton(
                  onPressed: () {
                    context.push("/profile");
                  },
                  icon: const Icon(Icons.person)),
            ],
          ),
          body: BlocBuilder<FieldBloc, FieldState>(
            builder: (context, state) {
              if (state is FieldFailed) {
                return const Center(
                  child: Text("Error"),
                );
              }
              if (state is FieldLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is FieldGotSuccessFuly) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(
                    children: [
                      Card(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                          Radius.circular(0),
                        )),
                        margin: EdgeInsets.zero,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(state.fieldEntity.polygon),
                                const Icon(Icons.more_vert)
                              ]),
                        ),
                      ),
                      if (state.fieldEntity.sensorEntities!.isEmpty)
                        NoSensorWidget(onAddPressed: onAddPressed),
                      if (state.fieldEntity.sensorEntities!.isNotEmpty)
                        buildInfoWhenSensorExist(context, state.fieldEntity)
                    ],
                  ),
                );
              }
              return Container();
            },
          )),
    );
  }
}

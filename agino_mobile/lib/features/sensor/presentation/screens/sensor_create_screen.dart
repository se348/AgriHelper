import 'package:go_router/go_router.dart';

import '../../../../core/presentation/content/create_layout.dart';
import '../../../../core/presentation/content/text_field_with_header.dart';
import '../../../../core/presentation/theme/app_colors.dart';
import '../../domain/entities/sensor_entity.dart';
import '../bloc/position/position_bloc.dart';
import '../bloc/sensor/sensor_bloc.dart';
import 'package:customizable_datetime_picker/sources/i18n/date_picker_i18n.dart';
import 'package:customizable_datetime_picker/sources/model/date_picker_divider_theme.dart';
import 'package:customizable_datetime_picker/sources/model/date_picker_theme.dart';
import 'package:customizable_datetime_picker/sources/widget/customizable_date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../injection_container.dart';
import 'package:intl/intl.dart';

class SensorCreateScreen extends StatefulWidget {
  SensorCreateScreen({super.key, required this.fieldId});
  final int fieldId;

  @override
  State<SensorCreateScreen> createState() => _SensorCreateScreenState();
}

class _SensorCreateScreenState extends State<SensorCreateScreen> {
  final TextEditingController serialNumberController = TextEditingController();

  double? latitude;

  double? longitude;

  final TextEditingController locationController = TextEditingController();

  final TextEditingController gddController = TextEditingController();
  final TextEditingController _sensorInstallationController =
      TextEditingController();
  final TextEditingController _lastCuttingDateController =
      TextEditingController();

  final TextEditingController baseTempController = TextEditingController();

  DateTime? _sensorInstallationDateTime =
      DateTime.now().add(Duration(days: -2));

  DateTime? _lastCuttingDate = DateTime.now().add(Duration(days: 30));
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    _sensorInstallationController.text =
        DateFormat.yMMMEd().format(_sensorInstallationDateTime!);
    _lastCuttingDateController.text =
        DateFormat.yMMMEd().format(_lastCuttingDate!);
    return Form(
      key: formKey,
      child: BlocProvider(
        create: (context) => sl<SensorBloc>(),
        child: BlocConsumer<SensorBloc, SensorState>(
          listener: (context, sensorState) {
            if (sensorState is SensorCreatedSuccessfully){
              context.pop(true);
            }
          },
          builder:(context, sensorState) => BlocProvider(
            create: (context) => sl<PositionBloc>()..add(GetPositionEvent()),
            child: BlocConsumer<PositionBloc, PositionState>(
              listener: (context, state) {
                if (state is PositionGotSuccessfully) {
                  latitude = state.positionEntity.latitude.roundToDouble();
                  longitude = state.positionEntity.longitude.roundToDouble();
                  locationController.text =
                      "${state.positionEntity.latitude.roundToDouble()}, ${state.positionEntity.longitude.roundToDouble()}";
                }
              },
              builder: (context, state) => CreateLayout(
                  disabled: false,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      BlocProvider.of<SensorBloc>(context).add(
                          CreateSensorEvent(SensorEntity(
                              fieldId: widget.fieldId,
                              serialNumber: serialNumberController.text,
                              batteryStatus: -1,
                              optimalGdd: int.parse(gddController.text),
                              cuttingDateCalculated: _lastCuttingDate!,
                              latitude: latitude!,
                              longitude: longitude!,
                              baseTemp: int.parse(baseTempController.text),
                              state: 1)));
                    }
                  },
                  appbarTitle: "NEW SENSOR",
                  buttonText: "ADD NEW SENSOR",
                  content: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: TextFieldWithHeader(
                            header: "Serial Number",
                            textEditingController: serialNumberController,
                            hintText: "Scan or enter serial number",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter a valid serial number";
                              }
                              return null;
                            },
                            textInputType: TextInputType.name,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Sensor Location",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                readOnly: true,
                                controller: locationController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Location not fetched. Please click on the above form field";
                                  }
                                  return null;
                                },
                                onTap: () {
                                  BlocProvider.of<PositionBloc>(context)
                                      .add(GetPositionEvent());
                                },
                                style: Theme.of(context).textTheme.bodyMedium,
                                decoration: const InputDecoration(
                                    suffixIcon: Icon(Icons.search)),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: TextFieldWithHeader(
                            header: "Default GDD",
                            textEditingController: gddController,
                            hintText: "Enter the GDD",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter a valid GDD value";
                              }
                              if (int.tryParse(value) == null) {
                                return 'Please enter a valid GDD value';
                              }
                              return null;
                            },
                            textInputType: TextInputType.number,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Sensor installation Date",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                readOnly: true,
                                controller: _sensorInstallationController,
                                style: Theme.of(context).textTheme.bodyMedium,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please select a sensor installation date";
                                  }
                                  return null;
                                },
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            content: SizedBox(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child:
                                                  CustomizableDatePickerWidget(
                                                      locale:
                                                          DateTimePickerLocale
                                                              .enUs,
                                                      looping: false,
                                                      firstDate: DateTime.now(),
                                                      initialDate:
                                                          _sensorInstallationDateTime,
                                                      dateFormat:
                                                          "dd-MMMM-yyyy",
                                                      pickerTheme: const DateTimePickerTheme(
                                                          itemTextStyle: TextStyle(
                                                              color: Color(
                                                                  0xFF101010),
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                          backgroundColor:
                                                              Color(0xFFEBEBEB),
                                                          itemHeight: 80,
                                                          pickerHeight: 300,
                                                          dividerTheme:
                                                              DatePickerDividerTheme(
                                                                  dividerColor:
                                                                      AppColors
                                                                          .green,
                                                                  thickness: 3,
                                                                  height: 2)),
                                                      onChange: (dateTime,
                                                          selectedIndex) {
                                                        setState(() {
                                                          _sensorInstallationDateTime =
                                                              dateTime;
                                                          _sensorInstallationController
                                                              .text = DateFormat
                                                                  .yMMMEd()
                                                              .format(dateTime);
                                                        });
                                                      }),
                                            ),
                                          ));
                                },
                                decoration: const InputDecoration(
                                    suffixIcon: Icon(Icons.calendar_month)),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Last Cutting Date At This Field",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                readOnly: true,
                                controller: _lastCuttingDateController,
                                style: Theme.of(context).textTheme.bodyMedium,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please select a last cutting date";
                                  }
                                  return null;
                                },
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            content: SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.8,
                                              child:
                                                  CustomizableDatePickerWidget(
                                                      locale:
                                                          DateTimePickerLocale
                                                              .enUs,
                                                      looping: false,
                                                      firstDate: DateTime.now(),
                                                      initialDate:
                                                          _lastCuttingDate,
                                                      dateFormat:
                                                          "dd-MMMM-yyyy",
                                                      pickerTheme: const DateTimePickerTheme(
                                                          itemTextStyle: TextStyle(
                                                              color: Color(
                                                                  0xFF101010),
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                          backgroundColor:
                                                              Color(0xFFEBEBEB),
                                                          itemHeight: 80,
                                                          pickerHeight: 300,
                                                          dividerTheme:
                                                              DatePickerDividerTheme(
                                                                  dividerColor:
                                                                      AppColors
                                                                          .green,
                                                                  thickness: 3,
                                                                  height: 2)),
                                                      onChange: (dateTime,
                                                          selectedIndex) {
                                                        setState(() {
                                                          _lastCuttingDate =
                                                              dateTime;
                                                          _lastCuttingDateController
                                                              .text = DateFormat
                                                                  .yMMMEd()
                                                              .format(dateTime);
                                                        });
                                                      }),
                                            ),
                                          ));
                                },
                                decoration: const InputDecoration(
                                    suffixIcon: Icon(Icons.calendar_month)),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: TextFieldWithHeader(
                            header: "Base Temperature",
                            textEditingController: baseTempController,
                            hintText: "Enter the base temperature",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter a valid base temperature";
                              }
                              if (int.tryParse(value) == null) {
                                return "Please enter a valid base temperature";
                              }
                              return null;
                            },
                            textInputType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
          ),
        ),
      ),
    );
  }
}

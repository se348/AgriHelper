import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/presentation/content/create_layout.dart';
import '../../../../injection_container.dart';
import '../../../auth/presentation/widgets/custom_text_field.dart';
import '../../domain/entities/farm.dart';
import '../bloc/farm_bloc/farm_bloc.dart';
import '../bloc/location_bloc/location_bloc.dart';

class CreateFarmScreen extends StatefulWidget {
  CreateFarmScreen({super.key});

  @override
  State<CreateFarmScreen> createState() => _CreateFarmScreenState();
}

class _CreateFarmScreenState extends State<CreateFarmScreen> {
  bool? disabled;

  final nameController = TextEditingController();

  final cityController = TextEditingController();

  final countryController = TextEditingController();

  final postcodeController = TextEditingController();

  final displayController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: BlocProvider(
        create: (context) => sl<FarmBloc>()..add(GetAllFarms()),
        child: BlocProvider(
          create: (context) => sl<LocationBloc>(),
          child: BlocConsumer<LocationBloc, LocationState>(
            listener: (context, state) {
              if (state is LocationLoaded) {
                setState(() {
                  displayController.text = state.locationEntity.displayName;
                  cityController.text = state.locationEntity.city;
                  countryController.text = state.locationEntity.country;
                  postcodeController.text =
                      state.locationEntity.postcode.toString();
                });
                print(state.locationEntity);
              }
            },
            builder: (context, state) => BlocConsumer<FarmBloc, FarmState>(
              listener: (context, farmState) {
                if (farmState is FarmCreatedSuccessful) {
                  context.go("/farm-detail/${farmState.farmId}");
                }
              },
              builder: (context, farmState) => CreateLayout(
                  disabled:
                      (farmState is FarmLoading || state is LocationLoading)
                          ? true
                          : false,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      BlocProvider.of<FarmBloc>(context).add(CreateFarm(Farm(
                          city: cityController.text,
                          country: countryController.text,
                          postCode: postcodeController.text,
                          name: nameController.text)));
                    }
                  },
                  appbarTitle: "New Farm",
                  buttonText: "Create new Farm",
                  content: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ListView(
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Farm Name",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        CustomTextField(
                            textEditingController: nameController,
                            suffix: const Icon(Icons.home),
                            validator: (value) {
                              if (value == null || value.length < 3) {
                                return "Enter a valid farm name";
                              }
                              return null;
                            },
                            hintText: "Enter farm name"),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Location",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        TextFormField(
                          readOnly: true,
                          controller: displayController,
                          style: Theme.of(context).textTheme.bodyMedium,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Location not fetched, please click on the field";
                            }
                            return null;
                          },
                          onTap: () {
                            BlocProvider.of<LocationBloc>(context)
                                .add(GetLocationEvent());
                          },
                          decoration: const InputDecoration(
                              suffixIcon: Icon(Icons.search)),
                        ),
                        if (state is LocationLoading)
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              LinearProgressIndicator(),
                              Text(
                                "Location is being proccessed",
                                style: Theme.of(context).textTheme.bodyMedium,
                              )
                            ],
                          )
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/presentation/content/create_layout.dart';
import '../../../../core/presentation/content/text_field_with_header.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/field_entity.dart';
import '../bloc/field_bloc.dart';

class CreateFieldScreen extends StatelessWidget {
  CreateFieldScreen({super.key, required this.farmId});

  final int farmId;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController altitudeController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: BlocProvider(
        create: (context) => sl<FieldBloc>(),
        child: BlocConsumer<FieldBloc, FieldState>(
          listener: (context, state) {
            if (state is FieldCreated) context.go('/farm-detail/$farmId');
          },
          builder: (context, state) => CreateLayout(
              disabled: false,
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  BlocProvider.of<FieldBloc>(context).add(CreateFieldEvent(
                      fieldEntity: FieldEntity(
                          altitude: int.parse(altitudeController.text),
                          farmId: farmId,
                          polygon: nameController.text)));
                }
              },
              appbarTitle: "NEW FIELD",
              buttonText: "CREATE NEW FIELD",
              content: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    TextFieldWithHeader(
                        header: "Field name",
                        hintText: "Enter field name",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter a valid field name";
                          }

                          return null;
                        },
                        textEditingController: nameController),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFieldWithHeader(
                        header: "Altitude above sea levels",
                        hintText: "Enter in meters",
                        textInputType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter a valid integer";
                          }
                          if (int.tryParse(value) == null) {
                            return 'Please enter a valid integer';
                          }
                          return null;
                        },
                        textEditingController: altitudeController),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}

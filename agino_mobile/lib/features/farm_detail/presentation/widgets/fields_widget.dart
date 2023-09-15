import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../field/domain/entities/field_entity.dart';

class FieldsWidget extends StatelessWidget {
  const FieldsWidget({super.key, required this.field, required this.farmId});
  final List<FieldEntity> field;
  final int farmId;

  void onAddPressed(BuildContext context) {
    context.push("/create-field/$farmId");
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: field.length + 1,
          itemBuilder: (context, ind) {
            if (ind == 0) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Fields",
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    IconButton(
                        onPressed: () {
                          onAddPressed(context);
                        },
                        icon: Icon(Icons.add))
                  ],
                ),
              );
            }
            return Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  leading: Image.asset("assets/field.png"),
                  onTap: () {
                    context.push("/field-detail/${field[ind - 1].fieldId}");
                  },
                  title: Text(
                    field[ind - 1].polygon,
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  subtitle: Text("${field[ind - 1].altitude}m above sea level"),
                ),
              ),
            );
          }),
    );
  }
}

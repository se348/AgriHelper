import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lorem_ipsum/lorem_ipsum.dart';

import '../../../../core/presentation/content/custom_elevated_button.dart';

class NoFieldWidget extends StatelessWidget {
  const NoFieldWidget({super.key, required this.farmId});
  final int farmId;
  
  void onAddPressed(BuildContext context){
    context.push("/create-field/$farmId");
  }

  
  @override
  Widget build(BuildContext context) {
     return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("assets/field.png"),
          const SizedBox(
            height: 25,
          ),
          Text(
            "Add a field",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            loremIpsum(words: 30),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 30,
          ),
          CustomElevatedButton(
            disabled: false,
            onPressed: () {
              onAddPressed(context);
            },
            text: "Add my first field",
          )
        ],
      ),
    );
  }
}
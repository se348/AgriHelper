import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lorem_ipsum/lorem_ipsum.dart';

import '../../../../core/presentation/content/custom_elevated_button.dart';

class NoFarmWidget extends StatelessWidget {
  const NoFarmWidget({super.key});

   void onAddPressed(BuildContext context) {
    context.go("/create");
  }

  @override
  Widget build(BuildContext context) {
     return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("assets/farm 1.png"),
          const SizedBox(
            height: 25,
          ),
          Text(
            "Welcome to Agino",
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
            text: "CREATE MY FIRST FARM",
          )
        ],
      ),
    );
  }
}
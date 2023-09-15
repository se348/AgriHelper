import 'package:flutter/material.dart';
import 'package:lorem_ipsum/lorem_ipsum.dart';

import '../../../../core/presentation/content/custom_elevated_button.dart';

class NoSensorWidget extends StatelessWidget {
  const NoSensorWidget({super.key, required this.onAddPressed});
  final Function(BuildContext context) onAddPressed;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/agino_image.png'),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Add a sensor",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              loremIpsum(words: 40),
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
                text: "ADD MY FIRST SENSOR"),
          ]),
    );
  }
}
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomElevatedButton extends StatelessWidget {
  CustomElevatedButton(
      {super.key,
      required this.disabled,
      required this.onPressed,
      required this.text});
  bool disabled;
  Function() onPressed;
  String text;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: disabled ? null : onPressed,
      child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          height: 48,
          child: Center(
            child: Text(
              text,
              textAlign: TextAlign.center,
            ),
          )),
    );
  }
}

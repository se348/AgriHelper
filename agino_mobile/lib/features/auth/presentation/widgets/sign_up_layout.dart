import 'package:flutter/material.dart';

import '../../../../core/presentation/theme/app_colors.dart';

class SignupLayout extends StatelessWidget {
  const SignupLayout(
      {super.key,
      required this.disabled,
      required this.onPressed,
      required this.title,
      required this.content});

  final bool disabled;
  final Function() onPressed;
  final String title;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.white,
          title: Text(
            "SIGN UP",
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: AppColors.gray),
          ),
        ),
        body: Column(children: [
          Expanded(
              child: ListView(children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: content,
            )
          ])),
          Container(
            width: double.infinity,
            height: 80,
            color: AppColors.white,
            child: Center(
                child: ElevatedButton(
              onPressed: disabled ? null : onPressed,
              child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 48,
                  child: const Center(
                    child: Text(
                      "CONTINUE",
                      textAlign: TextAlign.center,
                    ),
                  )),
            )),
          )
        ]));
  }
}

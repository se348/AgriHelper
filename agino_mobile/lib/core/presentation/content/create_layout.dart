import 'package:flutter/material.dart';

import '../../../../core/presentation/theme/app_colors.dart';

class CreateLayout extends StatelessWidget {
  const CreateLayout(
      {super.key,
      required this.disabled,
      required this.onPressed,
      required this.appbarTitle,
      required this.buttonText,
      required this.content});

  final bool disabled;
  final Function()? onPressed;
  final Widget content;
  final String appbarTitle;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: AppColors.gray, //change your color here
          ),
          backgroundColor: AppColors.white,
          title: Text(
            appbarTitle,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: AppColors.gray),
          ),
        ),
        body: Column(children: [
          Expanded(child: content),
          Container(
            width: double.infinity,
            height: 80,
            child: Center(
                child: ElevatedButton(
              onPressed: disabled ? null : onPressed,
              child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 48,
                  child: Center(
                    child: Text(
                      buttonText,
                      textAlign: TextAlign.center,
                    ),
                  )),
            )),
          )
        ]));
  }
}

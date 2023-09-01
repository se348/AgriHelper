import 'package:flutter/material.dart';

import '../../../../core/presentation/theme/app_colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: AppColors.green,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/agino_image.png"),
              const SizedBox(
                height: 20,
              ),
              Image.asset("assets/agino_logo.png")
            ],
          )),
    );
  }
}

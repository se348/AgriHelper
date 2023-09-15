import '../bloc/splash_bloc/splash_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/presentation/theme/app_colors.dart';
import '../../../../injection_container.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SplashBloc>()..add(CheckIfLoggedIn()),
      child: BlocConsumer<SplashBloc, SplashState>(
        listener: (context, state) {
          if(state is CheckingFailedState){
            
          }
          if (state is LoggedInState) {
            if (state.state == true) {
              context.go("/farm-lists");
            } else {
              context.go("/onboarding");
            }
          }
        },
        builder: (context, state) {
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
        },
      ),
    );
  }
}

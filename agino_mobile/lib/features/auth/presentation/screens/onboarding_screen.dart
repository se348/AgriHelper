import '../../../../core/presentation/theme/app_colors.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lorem_ipsum/lorem_ipsum.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int curr = 0;

  Widget description(String title) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/agino_image.png"),
          const SizedBox(
            height: 25,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              loremIpsum(words: 20),
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ),
          DotsIndicator(
            dotsCount: 3,
            position: curr,
            decorator: DotsDecorator(
              size: const Size.square(9.0),
              activeColor: AppColors.lightGreen,
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                context.go("/onboarding/phone");
              },
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    "SIGN UP WITH AGINO",
                    textAlign: TextAlign.center,
                  ),
                ),
              )),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Already have an account?"),
              TextButton(
                  onPressed: () {
                    context.go("/onboarding/login");
                  },
                  child: Text(
                    "Log in",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ))
            ],
          )
        ],
      ),
    );
  }

  PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    List<Widget> list = <Widget>[
      description("Start farming"),
      description(loremIpsum(words: 2)),
      description(loremIpsum(words: 2)),
    ];
    return Scaffold(
        appBar: AppBar(
          title: Image.asset("assets/agino_logo.png"),
          backgroundColor: AppColors.green,
        ),
        body: PageView(
          scrollDirection: Axis.horizontal,

          // reverse: true,
          // physics: BouncingScrollPhysics(),
          controller: controller,
          onPageChanged: (number) {
            setState(() {
              curr = number;
            });
          },
          children: list,
        ));
  }
}

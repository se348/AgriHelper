import 'package:agino_mobile/core/presentation/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:lorem_ipsum/lorem_ipsum.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        leading: IconButton(
          icon: const Icon(Icons.cancel_outlined, color: AppColors.gray),
          onPressed: () {},
        ),
        title: Text(
          "TERMS & CONDITIONS",
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
              "Terms and Conditions",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: Text(loremIpsum(paragraphs: 3, words: 400)),
          )
        ])),
        Container(
          width: double.infinity,
          height: 80,
          color: AppColors.white,
          child: Center(
              child: ElevatedButton(
            onPressed: () {},
            child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 48,
                child: const Center(
                  child: Text(
                    "AGREE TO TERMS & CONDITIONS",
                    textAlign: TextAlign.center,
                  ),
                )),
          )),
        )
      ]),
    );
  }
}

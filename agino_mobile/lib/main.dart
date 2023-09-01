import 'package:agino_mobile/core/presentation/theme/app_theme.dart';
import 'package:agino_mobile/features/auth/presentation/screens/onboarding_screen.dart';
import 'package:agino_mobile/features/auth/presentation/screens/terms_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.themeData,
        home: const TermsScreen(),
      ),
    );
  }
}

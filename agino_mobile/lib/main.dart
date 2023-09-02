import 'package:agino_mobile/core/presentation/theme/app_theme.dart';
import 'package:agino_mobile/features/auth/presentation/screens/sign_up/email_screen.dart';
import 'package:agino_mobile/features/auth/presentation/screens/sign_up/password_screen.dart';
import 'package:agino_mobile/features/auth/presentation/screens/sign_up/phone_number_screen.dart';
import 'package:agino_mobile/injection_container.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await init();
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
        home: PasswordScreen(),
        localizationsDelegates: [
          CountryLocalizations.delegate,
          // GlobalMaterialLocalizations.delegate,
          // GlobalWidgetsLocalizations.delegate,
          // GlobalCupertinoLocalizations.delegate,
        ],
      ),
    );
  }
}

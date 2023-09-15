import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract class AppTheme {
  /// Theme data for the app
  ///
  /// This theme data is used in [App] widget
  static final themeData = ThemeData(
    // Color Palette
    colorScheme: const ColorScheme(
      primary: AppColors.green,
      onPrimary: AppColors.white,
      secondary: AppColors.darkerBlue,
      onSecondary: AppColors.white,
      background: AppColors.gray100,
      onBackground: AppColors.darkBlue,
      surface: AppColors.gray200,
      onSurface: AppColors.darkBlue,
      error: AppColors.red,
      onError: AppColors.white,
      brightness: Brightness.light,
    ),

    appBarTheme: AppBarTheme(color: AppColors.lightgray),
    scaffoldBackgroundColor: AppColors.lightgray,
    inputDecorationTheme: const InputDecorationTheme(
        filled: true, fillColor: AppColors.white, border: InputBorder.none),

    // Text Theme
    textTheme: const TextTheme(
      // Headings
      titleMedium: TextStyle(
        color: AppColors.green,
        fontFamily: 'Roboto',
        fontSize: 24,
        fontWeight: FontWeight.w500,
      ),
      titleLarge: TextStyle(
        fontFamily: 'Roboto',
        color: AppColors.green,
        fontSize: 39,
        fontWeight: FontWeight.w500,
      ),

      titleSmall: TextStyle(
          color: AppColors.green,
          fontWeight: FontWeight.w700,
          fontSize: 16,
          fontFamily: 'Roboto'),

      // // Body
      bodySmall: TextStyle(
        color: AppColors.darkGray,
        fontFamily: 'Roboto',
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Roboto',
        color: AppColors.gray,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),

      displayLarge: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 20,
        fontFamily: 'Roboto',
        color: AppColors.green,
      ),

      // displayMedium: GoogleFonts.urbanist(
      //   fontSize: 24,
      //   fontWeight: FontWeight.w100,
      // ),

      // // Caption
      labelLarge: TextStyle(
        fontFamily: 'Roboto',
        color: AppColors.darkGray,
        fontSize: 34,
        fontWeight: FontWeight.w500,
      ),
    ),

    // Elevated Button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        textStyle: const MaterialStatePropertyAll<TextStyle>(
          TextStyle(
            fontFamily: 'Roboto',
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.white,
          ),
        ),
        foregroundColor: const MaterialStatePropertyAll<Color>(Colors.white),
        shape: const MaterialStatePropertyAll<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(9),
            ),
          ),
        ),
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return AppColors.green.withOpacity(0.5);
          }
          return AppColors.green;
        }),
      ),
    ),

    // // Filled button theme
    // filledButtonTheme: FilledButtonThemeData(
    //   style: ButtonStyle(
    //     backgroundColor: const MaterialStatePropertyAll(AppColors.gray200),
    //     foregroundColor: const MaterialStatePropertyAll(AppColors.gray300),
    //     alignment: Alignment.center,
    //     padding: const MaterialStatePropertyAll(EdgeInsets.zero),
    //     shape: MaterialStateProperty.all(
    //       const RoundedRectangleBorder(
    //         borderRadius: BorderRadius.all(
    //           Radius.circular(11),
    //         ),
    //       ),
    //     ),
    //   ),
    // ),

    // // Popup menu theme
    // popupMenuTheme: const PopupMenuThemeData(
    //   color: AppColors.gray100,
    //   textStyle: TextStyle(
    //     color: AppColors.darkBlue,
    //     fontFamily: 'Poppins',
    //     fontSize: 14,
    //     fontWeight: FontWeight.w400,
    //   ),
    // ),

    // actionIconTheme: ActionIconThemeData(
    //   backButtonIconBuilder: (_) => Container(
    //     width: 36.h,
    //     height: 36.h,
    //     decoration: const BoxDecoration(
    //       color: AppColors.gray200,
    //       borderRadius: BorderRadius.all(
    //         Radius.circular(11),
    //       ),
    //     ),
    //     child: const Icon(Icons.chevron_left, color: AppColors.gray300),
    //   ),
    // ),

    // iconTheme: const IconThemeData(
    //   color: AppColors.darkBlue,
    // ),
  );
}

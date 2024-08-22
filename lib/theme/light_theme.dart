import 'package:flutter/material.dart';

ThemeData light({Color color = const Color(0xFF24407B)}) => ThemeData(
      useMaterial3: true,
      fontFamily: 'poppins',
      primaryColor: color,
      secondaryHeaderColor: const Color(0xff112446),
      disabledColor: const Color(0xFFEBEBEB),
      scaffoldBackgroundColor: const Color(0xFFFFFFFF),
      brightness: Brightness.light,
      hintColor: const Color(0xFF9F9F9F),
      cardColor: const Color(0xFFF6F6F6),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: color)),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        titleSpacing: 20,
        color: Color(0xFFFFFFFF),
        iconTheme: IconThemeData(color: Color(0xFF9F9F9F)),
        titleTextStyle: TextStyle(
            color: Color(0xFF000000),
            fontSize: 20,
            fontWeight: FontWeight.w600,
            fontFamily: 'poppins'),
      ),
      colorScheme: ColorScheme.light(primary: color, secondary: color)
          .copyWith(
              background: const Color(0xFFFFFFFF),
              error: const Color(0xFFdd3135),
              outline: const Color(0xFFF4F4F4))
          .copyWith(background: const Color(0xFFFFFFFF))
          .copyWith(background: const Color(0xff112446))
          .copyWith(error: const Color(0xFFE84D4F)),
    );

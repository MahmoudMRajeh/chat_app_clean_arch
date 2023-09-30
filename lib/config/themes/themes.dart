import 'package:flutter/material.dart';

ThemeData lightTheme() {
  return ThemeData(
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.transparent,
      titleTextStyle: const TextStyle(
          fontSize: 24, fontWeight: FontWeight.w600, color: Colors.black,),
      iconTheme: IconThemeData(
        size: 32,
        color: Colors.grey[600],
      ),
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w400,
      ),
      headlineSmall: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    ),
    iconTheme: IconThemeData(
      size: 32,
      color: Colors.grey[600],
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:earn/widget/expanses.dart';

var kColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 169, 145, 225));
void main() {
  runApp(MaterialApp(
    theme: ThemeData().copyWith(
      useMaterial3: true,
      colorScheme: kColorScheme,
      appBarTheme: const AppBarTheme().copyWith(
        backgroundColor: const Color.fromARGB(255, 47, 6, 106),
        foregroundColor: const Color.fromARGB(255, 4, 181, 149),
      ),
      cardTheme: const CardTheme().copyWith(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          color: const Color.fromARGB(255, 45, 141, 123)),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 77, 173, 222)),
      ),
      textTheme: ThemeData().textTheme.copyWith(
            titleLarge: TextStyle(
                fontSize: 16,
                color: kColorScheme.onSecondaryContainer,
                fontWeight: FontWeight.normal),
          ),
    ),
    home: const Expanses(),
  ));
}

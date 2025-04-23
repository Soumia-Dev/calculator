import 'package:flutter/material.dart';

import 'presentation/calculator_screen.dart';

final themeModeNotifier = ValueNotifier(ThemeMode.system);
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeModeNotifier,
      builder: (context, currentTheme, _) {
        return MaterialApp(
          darkTheme: ThemeData.dark(),
          // darkTheme: not defined → uses ThemeData.light() by default
          themeMode: currentTheme,
          title: 'calculator',
          debugShowCheckedModeBanner: false,
          home: const CalculatorScreen(),
        );
      },
    );
  }
}

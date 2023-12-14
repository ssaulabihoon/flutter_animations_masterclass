import 'package:flutter/material.dart';
import 'package:flutter_animations_masterclass/screens/menu_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Animations Masterclass',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: Colors.deepPurple,
        ),
        useMaterial3: true,
        navigationBarTheme: const NavigationBarThemeData(
          indicatorColor: Colors.amber,
        ),
      ),
      home: const MenuScreen(),
    );
  }
}

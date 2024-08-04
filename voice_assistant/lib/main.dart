import 'package:flutter/material.dart';
import 'package:voice_assistant/home_page.dart';
import 'package:voice_assistant/pallete.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aren',
      theme: ThemeData.light(useMaterial3: true).copyWith(
        scaffoldBackgroundColor: Pallete.whiteColor,
        appBarTheme: const  AppBarTheme(
          backgroundColor: Pallete.whiteColor,
        )
      ),
      home: const HomePage(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:snooker_score/welcome_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Snooker Score',
        home: WelcomePage());
  }
}

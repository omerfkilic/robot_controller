import 'package:flutter/material.dart';
import 'package:robot_controller/pages/controller_page/controller_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Robot Controller',
      home: ControllerPage(),
    );
  }
}

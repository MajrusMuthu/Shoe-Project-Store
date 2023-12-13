

import 'package:flutter/material.dart';

import 'Shoe_Project/Main_page.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Demo App",
      home: ShoePage(),
    );
  }
}

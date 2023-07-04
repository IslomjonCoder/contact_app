import 'package:flutter/material.dart';
import 'package:untitled12/ui/contact_add.dart';
import 'package:untitled12/ui/contact_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ContactScreen(),
    );
  }
}

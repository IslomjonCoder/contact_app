import 'package:flutter/material.dart';
import 'package:untitled12/ui/contact_add.dart';
import 'package:untitled12/ui/contact_edit.dart';
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
      theme: ThemeData(
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.black,
            titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
          ),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Colors.black,
          ),
          iconTheme: IconThemeData(color: Colors.white)),
      home: ContactScreen(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/add':
            return MaterialPageRoute(
              builder: (context) => ContactAddScreen(),
            );
            return Scaffold(
              body: Center(
                child: Text('Url not found'),
              ),
            );
        }
      },
    );
  }
}

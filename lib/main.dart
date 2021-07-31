import 'package:flutter/material.dart';

import 'Pages/home/home_page.dart';
import 'Pages/login/login_page.dart';

void main() {
  runApp(MyApp());
}

final routes= {
  '/login': (BuildContext context)=> new LoginPage(),
  '/home': (BuildContext context)=> new  HomePage(),
  '/': (BuildContext context)=> new LoginPage(),
};

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Sqflite App",
      theme: ThemeData(primarySwatch: Colors.teal),
      routes: routes,
    );
  }
}


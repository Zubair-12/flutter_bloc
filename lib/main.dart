import 'package:flutter/material.dart';
import 'package:flutter_bloc/HomePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Employee App",
      theme: ThemeData(primarySwatch: Colors.cyan),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

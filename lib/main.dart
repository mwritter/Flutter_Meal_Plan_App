import 'package:flutter/material.dart';
import './pages/login_page.dart';
import './pages/signup_page.dart';
import './pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meal Plan',
      routes: {
        '/': (BuildContext context) => LoginPage(),
        '/signup': (BuildContext context) => SignUpPage(),
        '/homepage': (BuildContext context) => HomePage(),
      },
    );
  }
}

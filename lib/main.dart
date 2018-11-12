import 'package:flutter/material.dart';
import './pages/login_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meal Plan',
      routes: {
        '/': (BuildContext context) => LoginPage(),
      },
    );
  }
}

//cloned project, testing and pushing my branch up
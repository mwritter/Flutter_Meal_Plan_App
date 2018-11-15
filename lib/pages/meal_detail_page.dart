import 'package:flutter/material.dart';
import '../models/meal.dart';

class MealDetailPage extends StatelessWidget {
  //get assest images like this: AssetImage('assets/img/${meal.image}')
  final Meal meal;
  MealDetailPage(this.meal);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}

import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../models/meal_plan.dart';

class ShoppingList extends StatelessWidget {
  MealPlan mp = new MealPlan();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView.builder(
          itemCount: mp.meals.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                contentPadding: EdgeInsets.all(10.0),
                title: Text(mp.meals[index].ingredients.toString()),
              ),
            );
          },
        ),
      ),
    );
  }
}

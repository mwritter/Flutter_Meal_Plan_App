import 'meal.dart';

class MealPlan {
  List<Meal> meals;
  MealPlan() {
    meals = [];
    buildList();
  }

  void buildList() {
    for (var i = 0; i < 10; i++) {
      meals.add(Meal("Pizza", "SO good", "food4.jpg"));
    }
  }
}

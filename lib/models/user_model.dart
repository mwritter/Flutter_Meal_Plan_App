import './meal.dart';

class UserModel {
  final String name;
  final String email;
  final String uid;
  final String image;
  List<Meal> mealPlan;

  UserModel({this.email, this.name, this.image, this.uid, this.mealPlan});
}

import './meal.dart';

class UserModel {
  final String name;
  final String email;
  final String uid;
  final String image;
  List<dynamic> mealRefs;
  List<Meal> mealPlan;

  UserModel(
      {this.email,
      this.name = "",
      this.image,
      this.uid,
      this.mealRefs,
      this.mealPlan});
}

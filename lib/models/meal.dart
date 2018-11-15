class Meal {
  final String name;
  final String description;
  final String image;
  Map<String, dynamic> ingredients = {"Tomato": 1, "Pizza Dough": 1};

  Meal(this.name, this.description, this.image);
}

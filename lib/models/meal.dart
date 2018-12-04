class Meal {
  final String id;
  final String name;
  final String description;
  final String image;
  List<dynamic> ingredients;
  String instructions;

  Meal(
      {this.id,
      this.name,
      this.description,
      this.image,
      this.ingredients,
      this.instructions});
}

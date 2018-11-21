import 'package:flutter/material.dart';
import '../models/meal.dart';

class ShoppingList extends StatelessWidget {
  final Map<String, dynamic> list;

  ShoppingList(this.list);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              contentPadding: EdgeInsets.all(10.0),
              title: Text(list[index].ingredients.toString()),
            ),
          );
        },
      ),
    );
  }
}

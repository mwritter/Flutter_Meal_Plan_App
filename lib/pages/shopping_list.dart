import 'package:flutter/material.dart';
import '../models/meal.dart';

class ShoppingList extends StatelessWidget {
  final List<String> list;

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
              contentPadding: EdgeInsets.all(1.0),
              title: Text(list[index]),
            ),
          );
        },
      ),
    );
  }
}

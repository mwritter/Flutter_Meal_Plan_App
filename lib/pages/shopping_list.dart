import 'package:flutter/material.dart';
import '../models/meal.dart';

class ShoppingList extends StatelessWidget {
  final List<String> list;

  ShoppingList(this.list);

  List<String> reduceList() {
    List<String> reduced = [];
    for (String item in list) {
      if (!reduced.contains(item)) {
        reduced.add(item);
      }
    }
    return reduced;
  }

  int getCount(String str) {
    print(str);
    print(list);
    int count = 0;
    for (String item in list) {
      if (item == str) {
        count++;
      }
    }
    return count;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: Text(getCount(list[index]).toString()),
              contentPadding: EdgeInsets.all(1.0),
              title: Text(reduceList()[index]),
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:meal_plan/Style.dart';
import 'package:meal_plan/models/meal.dart';
import 'package:meal_plan/models/user_model.dart';

class ShoppingList extends StatelessWidget {
  final UserModel user;
  Set<String> updatedList = new Set<String>();
  ShoppingList(this.user);

  List<dynamic> getList() {
    List<dynamic> list = new List<dynamic>();
    for (int i = 0; i < user.mealPlan.length; i++) {
      for (int j = 0; j < user.mealPlan[i].ingredients.length; j++) {
        list.add(user.mealPlan[i].ingredients[j]);
      }
    }

    return list;
  }

  Widget _buildMyShoppingListContainer(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: const Color(0x29000000),
              offset: Offset(0.0, 2.0),
              blurRadius: 1.0),
        ],
      ),
      margin: EdgeInsets.only(left: 00.0, right: 0.0, top: 0.0, bottom: 50.0),
      height: 130.0,
      child: Padding(
        padding: const EdgeInsets.only(top: 25.0, left: 20),
        child: Material(
          color: Colors.transparent,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Shopping List",
                  style: Style().greyHeadingStyle(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  int getCount(String str, list) {
    int count = 0;
    for (int i = 0; i < list.length; i++) {
      if (list[i] == (str)) {
        updatedList.add(str);
        count++;
      }
    }
    return count;
  }

  Map<String, dynamic> makeMap(List<dynamic> newlist) {
    Map<String, dynamic> map = {};
    for (int i = 0; i < newlist.length; i++) {
      map.addAll({newlist[i]: getCount(newlist[i], newlist)});
    }
    return map;
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> list = new List<dynamic>();
    Map<String, dynamic> map = new Map<String, dynamic>();
    list.addAll(getList());
    map = makeMap(list);
    print(map);
    return Stack(
      children: <Widget>[
        Container(child: _buildMyShoppingListContainer(context)),
        Container(
          padding: EdgeInsets.fromLTRB(0.0, 140.0, 0.0, 0.0),
          child: ListView.builder(
            padding: EdgeInsets.only(left: 50.0),
            itemCount: updatedList.length,
            //"${map[updatedList.elementAt(index)]}  ${updatedList.elementAt(index)}"
            itemBuilder: (context, index) => ListTile(
                  contentPadding: EdgeInsets.all(15.0),
                  leading: Container(
                    width: 30.0,
                    height: 30.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                        child: Text("${map[updatedList.elementAt(index)]}")),
                  ),
                  title: Text("${updatedList.elementAt(index)}"),
                ),
          ),
        ),
      ],
    );
  }
}

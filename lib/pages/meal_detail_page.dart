import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meal_plan/models/user_model.dart';
import 'package:meal_plan/services/user_management.dart';
import '../models/meal.dart';
import '../Style.dart';

class MealDetailPage extends StatelessWidget {
  //get assest images like this: AssetImage('assets/img/${meal.image}')
  final Meal meal;
  final UserModel user;
  Function addMeal;
  String ingredients = "";
  bool adding = true;
  final int index;
  MealDetailPage([this.meal, this.index, this.user, this.adding, this.addMeal]);

  String makeIngredientsList() {
    String ingredients = "";
    for (String s in meal.ingredients) {
      ingredients += s + "\n";
    }
    return ingredients;
  }

  Widget _buildMealImage() {
    return (Hero(
      tag: "MealImage-${meal.image}$index",
      child: Container(
        margin: EdgeInsets.only(left: 10.0, right: 10.0),
        height: 300.0,
        decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: const Color(0x29000000),
                  offset: Offset(0.0, 2.0),
                  blurRadius: 1.0),
            ],
            borderRadius: BorderRadius.circular(15.0),
            image: DecorationImage(
                image: NetworkImage(meal.image), fit: BoxFit.cover)),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Container(
            padding: EdgeInsets.all(5.0),
            decoration: BoxDecoration(
                color: Color(0xFFEDE2C4),
                borderRadius: BorderRadius.circular(15.0)),
            child: Hero(
              tag: "action-button",
              child: FlatButton(
                onPressed: () {
                  if (adding) {
                    addMeal(meal.id);
                    user.mealPlan.add(meal);
                    Navigator.pop(context);
                  } else {
                    Navigator.pop(context);
                  }
                },
                child: adding
                    ? Text(
                        "Add to Meal Plan",
                        style: Style().greenSubHeadingStyle(),
                      )
                    : Text("BACK"),
              ),
            )),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Color(0xFF8A9098),
                    size: 35.0,
                  ),
                ),
                title: Text(
                  "Details",
                  style: Style().greyHeadingStyle(),
                ),
                actions: <Widget>[],
                backgroundColor: Colors.white,
                pinned: true,
                floating: false,
                centerTitle: true,
                expandedHeight: 100.0,
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  _buildMealImage(),
                  Container(
                    padding: EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "${meal.name}",
                          style: TextStyle(
                              fontSize: 35.0, color: Color(0xFF8A9098)),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          "Description",
                          style: Style().greenSubHeadingStyle(),
                        ),
                        Text(
                          "${meal.description}",
                          style: Style().descriptionTextStyle(),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          "Ingredients",
                          style: Style().greenSubHeadingStyle(),
                        ),
                        Text(makeIngredientsList()),
                        meal.instructions != null
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Cooking Instructions",
                                    style: Style().greenSubHeadingStyle(),
                                  ),
                                  Text("${meal.instructions}"),
                                  SizedBox(
                                    height: 100.0,
                                  )
                                ],
                              )
                            : Container()
                      ],
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ));
  }
}

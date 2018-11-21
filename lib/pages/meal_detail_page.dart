import 'package:flutter/material.dart';
import '../models/meal.dart';

class MealDetailPage extends StatelessWidget {
  //get assest images like this: AssetImage('assets/img/${meal.image}')
  final Meal meal;
  MealDetailPage(this.meal);

  Widget _buildMealImage() {
    return (Hero(
      tag: "MealImage-${meal.image}",
      child: Container(
        margin: EdgeInsets.only(left: 10.0, right: 10.0),
        height: 200.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            image: DecorationImage(
                image: NetworkImage(meal.image), fit: BoxFit.cover)),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(top: 30.0),
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
                  style: TextStyle(
                    fontSize: 50.0,
                    color: Color(0xFF8A9098),
                  ),
                ),
                actions: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(
                        Icons.search,
                        color: Color(0xFF8A9098),
                        size: 35.0,
                      ),
                    ),
                  ),
                ],
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
                    child: Column(
                      children: <Widget>[
                        Text(
                          "${meal.name}",
                          style: TextStyle(
                              fontSize: 35.0, color: Color(0xFF8A9098)),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text("Description"),
                        Text("The Best Food Ever"),
                        Text("${meal.ingredients.toString()}")
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

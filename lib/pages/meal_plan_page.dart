import 'package:flutter/material.dart';
import 'package:meal_plan/Style.dart';
import 'package:meal_plan/services/user_management.dart';
import '../models/user_model.dart';

class MealPlanPage extends StatelessWidget {
  final UserModel user;
  MealPlanPage(this.user);

  Widget _buildMyPlanContainer(double deviceWidth, BuildContext context) {
    return Hero(
      tag: "MyPlanContainer",
      child: Container(
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Color(0xFF8A9098),
                      size: 35.0,
                    ),
                  ),
                  Text(
                    "Meal Plan",
                    style: Style().greyHeadingStyle(),
                  ),
                  SizedBox(
                    width: deviceWidth,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHasMeals() {
    return Container(
      child: ListView(
        children: <Widget>[],
      ),
    );
  }

  Widget _buildMealImageContainer(String image, context) {
    return Container(
      width: MediaQuery.of(context).size.width - 30.0,
      height: 200.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          image: DecorationImage(
              fit: BoxFit.cover, image: NetworkImage('$image'))),
    );
  }

  Widget _buildMealPlanList() {
    return Container(
      child: user.mealPlan.length > 0
          ? ListView.builder(
              itemCount: user.mealPlan.length,
              itemBuilder: (context, int index) => Container(
                    child: Column(
                      children: <Widget>[
                        _buildMealImageContainer(
                            user.mealPlan[index].image, context),
                        Text(
                          // user.mealPlan[index].name,
                          user.mealPlan[index].name,
                          style: TextStyle(
                              fontSize: 25.0, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                      ],
                    ),
                  ))
          : Container(
              child: Center(
                child: Text("No Meal Plans"),
              ),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width / 8;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(child: _buildMyPlanContainer(deviceWidth, context)),
          Container(
            padding: EdgeInsets.fromLTRB(0.0, 150.0, 0.0, 0.0),
            child: _buildMealPlanList(),
          ),
        ],
      ),
    );
  }
}

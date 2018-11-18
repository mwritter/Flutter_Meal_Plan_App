import 'package:flutter/material.dart';
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
        margin:
            EdgeInsets.only(left: 00.0, right: 0.0, top: 0.0, bottom: 100.0),
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
                    style: TextStyle(
                        color: Color(0xFF8A9098),
                        fontSize: 50.0,
                        fontWeight: FontWeight.bold),
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

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width / 8;
    return Scaffold(
      body: Container(
        child: ListView(
          children: <Widget>[
            _buildMyPlanContainer(deviceWidth, context),
            Text('This is the meal plan array: ${user.mealPlan.toSet()}')
          ],
        ),
      ),
    );
  }
}

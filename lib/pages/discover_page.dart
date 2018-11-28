import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:meal_plan/Style.dart';
import 'package:meal_plan/models/meal.dart';
import 'package:meal_plan/models/user_model.dart';
import 'package:meal_plan/pages/meal_detail_page.dart';

class DiscoverPage extends StatelessWidget {
  UserModel user;
  Function addMeal;
  DiscoverPage(this.user, this.addMeal);
  Meal _makeMeal(databaseMeal) {
    return Meal(
        description: databaseMeal["description"],
        id: databaseMeal.documentID,
        image: databaseMeal["image"],
        ingredients: databaseMeal["ingredients"],
        name: databaseMeal["name"]);
  }

  Widget _buildMyDiscoverContainer(double deviceWidth, BuildContext context) {
    return Hero(
      tag: "MyDiscoverContainer",
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
        margin: EdgeInsets.only(left: 00.0, right: 0.0, top: 0.0, bottom: 40.0),
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
                    "Discover",
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

  Widget _buildMealImage(image, index) {
    return Hero(
      tag: "MealImage-$image$index",
      child: Container(
        margin: EdgeInsets.only(top: 30.0, left: 10.0, right: 10.0),
        height: 100.0,
        width: 100.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            image:
                DecorationImage(image: NetworkImage(image), fit: BoxFit.cover)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width / 8;
    return Scaffold(
        body: Stack(
      children: <Widget>[
        _buildMyDiscoverContainer(deviceWidth, context),
        Container(
          padding: EdgeInsets.fromLTRB(0.0, 130.0, 0.0, 0.0),
          child: StreamBuilder(
            stream: Firestore.instance.collection('meals').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              return StaggeredGridView.countBuilder(
                crossAxisCount: 4,
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        print(snapshot.data.documents[index].documentID);
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => MealDetailPage(
                                _makeMeal(snapshot.data.documents[index]),
                                index,
                                user,
                                true,
                                addMeal)));
                      },
                      child: _buildMealImage(
                          snapshot.data.documents[index]["image"], index),
                    ),
                staggeredTileBuilder: (index) =>
                    StaggeredTile.count(2, index.isEven ? 3 : 2),
                mainAxisSpacing: 1.0,
                crossAxisSpacing: 1.0,
              );
            },
          ),
        ),
      ],
    ));
  }
}

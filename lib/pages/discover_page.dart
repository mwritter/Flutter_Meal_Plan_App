import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:meal_plan/Style.dart';
import 'package:meal_plan/models/meal.dart';
import 'package:meal_plan/models/user_model.dart';
import 'package:meal_plan/pages/meal_detail_page.dart';

class DiscoverPage extends StatelessWidget {
  UserModel user;
  DiscoverPage(this.user);
  Meal _makeMeal(databaseMeal) {
    return Meal(
        description: databaseMeal["description"],
        id: databaseMeal.documentID,
        image: databaseMeal["image"],
        ingredients: databaseMeal["ingredients"],
        name: databaseMeal["name"]);
  }

  Widget _buildMealImage(image) {
    return Hero(
      tag: "MealImage-$image",
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
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Color(0xFF8A9098),
          ),
          iconSize: 35.0,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          "Discover",
          style: Style().greyHeadingStyle(),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder(
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
                            _makeMeal(snapshot.data.documents[index]), user)));
                  },
                  child:
                      _buildMealImage(snapshot.data.documents[index]["image"]),
                ),
            staggeredTileBuilder: (index) =>
                StaggeredTile.count(2, index.isEven ? 3 : 2),
            mainAxisSpacing: 1.0,
            crossAxisSpacing: 1.0,
          );
        },
      ),
    );
  }
}

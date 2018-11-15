import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/meal.dart';
import './meal_detail_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  String email = '';

  Future _buildUserInfo() async {
    var user = await FirebaseAuth.instance.currentUser();
    var userQuery = Firestore.instance
        .collection('users')
        .where('uid', isEqualTo: user.uid)
        .limit(1);
    userQuery.getDocuments().then((data) {
      if (data.documents.length > 0) {
        setState(() {
          email = data.documents[0].data['email'];
        });
      } else {
        email = "no email";
      }
    });
  }

  Widget _buildMealDetails() {
    Meal meal = new Meal("Pizza", "Its so so good", 'food4.jpg');
    return RaisedButton(
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => MealDetailPage(meal)));
      },
      child: Text("Meal Detail Page"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildMealDetails(),
            Text("HomePage"),
            StreamBuilder(
              stream: Firestore.instance.collection('users').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Container(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Loading Please Wait"),
                          CircularProgressIndicator(),
                        ],
                      ),
                    ),
                  );
                }

                return Text(email);
              },
            ),
            RaisedButton(
              onPressed: () {
                FirebaseAuth.instance.signOut().then((value) {
                  Navigator.of(context).pushReplacementNamed('/');
                }).catchError((e) {
                  print(e);
                });
              },
              child: Text("Logout"),
            ),
          ],
        ),
      ),
    ));
  }

  @override
  void initState() {
    _buildUserInfo();
    super.initState();
  }
}

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meal_plan/models/user_model.dart';

class HomePage extends StatefulWidget {
  final UserModel user;
  HomePage(this.user);
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  String email = '';
  String image = '';

  Future _buildUserInfo() async {
    var user = await FirebaseAuth.instance.currentUser();
    var userQuery = Firestore.instance
        .collection('users')
        .where('uid', isEqualTo: user.uid)
        .limit(1);
    userQuery.getDocuments().then((data) {
      if (data.documents.length > 0) {
        setState(() {
          email = data.documents[0]['email'];
        });
      } else {
        email = "no email";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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

                return Container(
                  child: Column(
                    children: <Widget>[
                      Image(
                        image: NetworkImage(image),
                      ),
                      Text(email)
                    ],
                  ),
                );
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
            )
          ],
        ),
      ),
    ));
  }

  @override
  void initState() {
    _buildUserInfo();
    email = widget.user.email;
    image = widget.user.image;
    super.initState();
  }
}

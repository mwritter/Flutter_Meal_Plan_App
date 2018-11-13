import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatelessWidget {
  Widget _buildMealList(BuildContext context) {
    return StreamBuilder(
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
        return Column(
          children: <Widget>[
            Text(snapshot.data.documents[0]['name']),
            Text(snapshot.data.documents[0]['email']),
            Image(
              image: NetworkImage(snapshot.data.documents[0]['image']),
            )
          ],
        );
      },
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
            Text("HomePage"),
            _buildMealList(context),
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
}

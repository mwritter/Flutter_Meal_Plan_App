import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Center(
        child: Column(
          children: <Widget>[
            Text("HomePage"),
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

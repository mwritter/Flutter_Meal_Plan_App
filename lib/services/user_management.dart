import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../pages/home_page.dart';

class UserManagement {
  UserModel _localUser;
  FirebaseUser _firebaseUser;

  final String _defaultUserImage =
      'https://pngimage.net/wp-content/uploads/2018/06/no-user-image-png.png';
  storeNewUser(FirebaseUser user, context) {
    _firebaseUser = user;
    Firestore.instance.collection('/users').add({
      'email': user.email,
      'uid': user.uid,
      'meal_plans': [],
      'image': _defaultUserImage
    }).then((value) {
      print("Finished Signing Up " + _firebaseUser.email);
      //_createLocalUser();
    }).catchError((e) {
      print(e.message);
    });
  }

  _createLocalUser(BuildContext context) {
    print("Creating Local User for" + _firebaseUser.email);
    UserModel newUser = new UserModel(
        uid: _firebaseUser.email,
        email: _firebaseUser.email,
        mealPlan: [],
        image: _defaultUserImage);
    _localUser = newUser;
    print("Made Local user for " + _localUser.email);
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomePage(_localUser)));
  }

  loginUser(String email, String password, BuildContext context) {
    print("Login in firebaseUser " + email);
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((FirebaseUser user) {
      print("Logged in");
      _createLocalUser(context);
    }).catchError((e) {
      print(e.message);
    });
  }
}

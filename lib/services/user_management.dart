import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../pages/home_page.dart';

class UserManagement {
  UserModel currentLocalUser;
  final String _defaultUserImage =
      'https://pngimage.net/wp-content/uploads/2018/06/no-user-image-png.png';
  storeNewUser(user, context) {
    Firestore.instance.collection('/users').add({
      'email': user.email,
      'uid': user.uid,
      'plan': [],
      'image': _defaultUserImage
    }).then((value) {
      print("made it pass");
      _createLocalUser(user);
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => HomePage(currentLocalUser)));
    }).catchError((e) {
      print(e.message);
    });
  }

  loginLocalUser(user, context) {
    print("THIS IS THE EMAIL " + user.email);
    currentLocalUser = UserModel(
        email: user.email,
        uid: user.uid,
        image: _defaultUserImage,
        mealPlan: []);

    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => HomePage(currentLocalUser)));
  }

  _createLocalUser(user) {
    currentLocalUser = UserModel(
        email: user.email,
        uid: user.uid,
        image: _defaultUserImage,
        mealPlan: []);
  }
}

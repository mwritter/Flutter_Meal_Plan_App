import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meal_plan/Style.dart';
import '../services/user_management.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignUpPage();
  }
}

class _SignUpPage extends State<SignUpPage> {
  final formKey = new GlobalKey<FormState>();
  bool _loading = false;
  String _email;
  String _password;
  String _confirmPassword;

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      setState(() {
        _loading = true;
      });
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: _email, password: _password)
          .then((signedInUser) {
        UserManagement().storeNewUser(signedInUser, context);
        setState(() {
          _loading = false;
        });
        //Navigator.of(context).pushReplacementNamed('/');
      }).catchError((e) {
        print(e.message);
      });
      return true;
    } else {
      return false;
    }
  }

  void validateAndSubmit() {
    if (validateAndSave()) {}
  }

  Widget _buildPageTitleText(BuildContext context) {
    double fromTop = MediaQuery.of(context).size.height / 10;
    return Container(
      padding: EdgeInsets.only(left: 30.0, top: fromTop),
      child: Text(
        "Sign up",
        style: Style().greenHeadingStyle(),
      ),
    );
  }

  Widget _buildPasswordTextField() {
    return Container(
      padding: EdgeInsets.only(top: 5.0, left: 20.0),
      decoration: BoxDecoration(boxShadow: <BoxShadow>[
        BoxShadow(
            color: const Color(0x29000000),
            offset: Offset(0.0, 2.0),
            blurRadius: 1.0)
      ], color: Colors.white, borderRadius: BorderRadius.circular(15.0)),
      child: TextFormField(
        style: TextStyle(
            fontFamily: 'Poppins', fontSize: 20.0, color: Color(0xFF37966F)),
        validator: (value) => value.isEmpty ? 'Password required' : null,
        obscureText: true,
        decoration: InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          labelText: 'password',
          labelStyle: TextStyle(
            fontSize: 15.0,
            color: Color(0x7F37966F),
          ),
        ),
        onSaved: (value) => _password = value,
      ),
    );
  }

  Widget _buildConfirmPasswordTextField() {
    return Container(
      padding: EdgeInsets.only(top: 5.0, left: 20.0),
      decoration: BoxDecoration(boxShadow: <BoxShadow>[
        BoxShadow(
            color: const Color(0x29000000),
            offset: Offset(0.0, 2.0),
            blurRadius: 1.0)
      ], color: Colors.white, borderRadius: BorderRadius.circular(15.0)),
      child: TextFormField(
        style: TextStyle(
            fontFamily: 'Poppins', fontSize: 20.0, color: Color(0xFF37966F)),
        validator: (value) => value.isEmpty && value != _password
            ? 'Confirm Password incorrect'
            : null,
        obscureText: true,
        decoration: InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          labelText: 'confirm password',
          labelStyle: TextStyle(
            fontSize: 15.0,
            color: Color(0x7F37966F),
          ),
        ),
        onSaved: (value) => _confirmPassword = value,
      ),
    );
  }

  Widget _buildEmailTextField() {
    return Container(
      padding: EdgeInsets.only(top: 5.0, left: 20.0),
      decoration: BoxDecoration(boxShadow: <BoxShadow>[
        BoxShadow(
            color: const Color(0x29000000),
            offset: Offset(0.0, 2.0),
            blurRadius: 1.0)
      ], color: Colors.white, borderRadius: BorderRadius.circular(15.0)),
      child: TextFormField(
        style: TextStyle(
            fontFamily: 'Poppins', fontSize: 20.0, color: Color(0xFF37966F)),
        keyboardType: TextInputType.emailAddress,
        validator: (String value) {
          if (value.isEmpty ||
              !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                  .hasMatch(value)) {
            return 'Please enter a valid email';
          }
        },
        decoration: InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          labelText: 'email',
          labelStyle: TextStyle(
            fontSize: 15.0,
            color: Color(0x7F37966F),
          ),
        ),
        onSaved: (value) => _email = value,
      ),
    );
  }

  Widget _buildSignUpButton() {
    return FlatButton(
      onPressed: () {
        validateAndSave();
      },
      child: Text(
        "sign up",
        style: TextStyle(
            fontFamily: 'Poppins', fontSize: 20.0, color: Color(0xFF37966F)),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30.0),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _buildEmailTextField(),
            SizedBox(
              height: 12.0,
            ),
            _buildPasswordTextField(),
            SizedBox(
              height: 12.0,
            ),
            _buildConfirmPasswordTextField(),
            SizedBox(
              height: 12.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildSignUpButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: _loading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: _buildPageTitleText(context),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  _buildLoginForm(),
                  Container(
                    child: Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(bottom: 15.0),
                                child: IconButton(
                                  iconSize: 35.0,
                                  icon: Icon(
                                    Icons.close,
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}

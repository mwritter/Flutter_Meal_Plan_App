import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../pages/home_page.dart';
import '../services/user_management.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  final formKey = new GlobalKey<FormState>();

  String _email;
  String _password;

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();

      FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _email, password: _password)
          .then((FirebaseUser user) {
        UserManagement().loginLocalUser(user, context);
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
        "Login",
        style: TextStyle(
          fontSize: 90.0,
          fontWeight: FontWeight.bold,
          color: Color(0xFF356859),
        ),
      ),
    );
  }

  Widget _buildPasswordTextField() {
    return Container(
      child: TextFormField(
        validator: (value) => value.isEmpty ? 'Password required' : null,
        obscureText: true,
        decoration: InputDecoration(labelText: 'password'),
        onSaved: (value) => _password = value,
      ),
    );
  }

  Widget _buildEmailTextField() {
    return Container(
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        validator: (String value) {
          if (value.isEmpty ||
              !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                  .hasMatch(value)) {
            return 'Please enter a valid email';
          }
        },
        decoration: InputDecoration(
          labelText: 'email',
        ),
        onSaved: (value) => _email = value,
      ),
    );
  }

  Widget _buildLoginButton() {
    return FlatButton(
      onPressed: () {
        validateAndSave();
      },
      child: Text("login"),
    );
  }

  Widget _buildSignUpButton() {
    return FlatButton(
      onPressed: () {
        Navigator.pushNamed(context, '/signup');
      },
      child: Text("sign up"),
    );
  }

  Widget _buildLoginForm() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30.0),
      child: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            _buildEmailTextField(),
            SizedBox(
              height: 12.0,
            ),
            _buildPasswordTextField(),
            SizedBox(
              height: 12.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildLoginButton(),
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
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: _buildPageTitleText(context),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 6,
            ),
            _buildLoginForm(),
          ],
        ),
      ),
    );
  }
}

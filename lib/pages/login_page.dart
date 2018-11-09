import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
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
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(labelText: 'password'),
    );
  }

  Widget _buildEmailTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'email'),
    );
  }

  Widget _buildLoginForm() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.0),
      child: Form(
        child: Column(
          children: <Widget>[_buildEmailTextField(), _buildPasswordTextField()],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

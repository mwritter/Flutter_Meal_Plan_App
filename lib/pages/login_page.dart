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
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: TextFormField(
        obscureText: true,
        decoration: InputDecoration(labelText: 'password'),
      ),
    );
  }

  Widget _buildEmailTextField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: 'email',
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return FlatButton(
      onPressed: () {},
      child: Text("login"),
    );
  }

  Widget _buildSignUpButton() {
    return FlatButton(
      onPressed: () {},
      child: Text("sign up"),
    );
  }

  Widget _buildLoginForm() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.0),
      child: Form(
        child: Column(
          children: <Widget>[
            _buildEmailTextField(),
            _buildPasswordTextField(),
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

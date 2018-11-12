import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignUpPage();
  }
}

class _SignUpPage extends State<SignUpPage> {
  final formKey = new GlobalKey<FormState>();

  String other1;
  String _email;
  String _password;
  String _confirmPassword;

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
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

  Widget _buildConfirmPasswordTextField() {
    return Container(
      child: TextFormField(
        validator: (value) => value.isEmpty && value == _password
            ? 'Confirm Password incorrect'
            : null,
        obscureText: true,
        decoration: InputDecoration(labelText: 'confirm password'),
        onSaved: (value) => _confirmPassword = value,
      ),
    );
  }

  Widget _buildEmailTextField() {
    return Container(
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        validator: (value) => value.isEmpty ? 'Email required' : null,
        decoration: InputDecoration(
          labelText: 'email',
        ),
        onSaved: (value) => _email = value,
      ),
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
      body: Container(
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
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )
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

import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  final _formkey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(18),
        child: Form(
          key: _formkey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                validator: (value) {
                  if (value.isEmpty) return "Email is required";
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                controller: passwordController,
                validator: (value) {
                  if (value.isEmpty) return "Password is required";
                },
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: RaisedButton(
                      child: Text("Sign in"),
                      onPressed: () {
                        if (_formkey.currentState.validate()) {
                          print('Pass');
                        } else {
                          print("Error");
                        }
                      },
                    ),
                  ),
                ],
              ),
              FlatButton(
                child: Text('Register new user'),
                onPressed: () {
                  Navigator.pushNamed(context, "/register");
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
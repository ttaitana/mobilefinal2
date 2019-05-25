import 'package:flutter/material.dart';
import './db/storage.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  final _formkey = GlobalKey<FormState>();
  final StorageProvider _storage = StorageProvider();

  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(18),
        child: Form(
          key: _formkey,
          child: ListView(
            children: <Widget>[
              Image.network(
                  "https://i.kym-cdn.com/photos/images/original/001/165/778/f7c.jpg"),
              TextFormField(
                decoration: InputDecoration(icon: Icon(Icons.person), labelText: 'User Id'),
                keyboardType: TextInputType.emailAddress,
                controller: userController,
                validator: (value) {
                  if (value.isEmpty) return "User Id is required";
                },
              ),
              TextFormField(
                decoration: InputDecoration(icon: Icon(Icons.lock), labelText: 'Password'),
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
                      child: Text("LOGIN"),
                      onPressed: () {
                        if (_formkey.currentState.validate()) {
                          _storage.open('todo.db');
                          bool status = false;
                          _storage.logins(userController.text, passwordController.text).then((data) => status = data);
                          if(status){
                            print('You are in');
                          }else{
                            print('Wrong password');
                          }
                          // print(userController.text);
                          // print(passwordController.text);
                        } else {
                          print("Error");
                        }
                      },
                    ),
                  ),
                ],
              ),
              Align(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    child:
                        Text('Register New Account', textAlign: TextAlign.right),
                    onPressed: () {
                      Navigator.pushNamed(context, "/register");
                    },
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

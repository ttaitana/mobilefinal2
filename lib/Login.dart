import 'package:flutter/material.dart';
import './db/storage.dart';
import 'package:toast/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './db/userInsystem.dart';
import './home.dart';

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
                  if (value.isEmpty) return "Please fill out this form";
                },
              ),
              TextFormField(
                decoration: InputDecoration(icon: Icon(Icons.lock), labelText: 'Password'),
                obscureText: true,
                controller: passwordController,
                validator: (value) {
                  if (value.isEmpty) return "Please fill out this form";
                },
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: RaisedButton(
                      child: Text("LOGIN"),
                      onPressed: () async{
                        if (_formkey.currentState.validate()) {
                          await _storage.open('tester.db');
                          bool status = false;
                          Future<List<Storage>> users = _storage.getAllData();
                          Storage user = Storage();
                          user.user = userController.text;
                          user.password = passwordController.text;
                          Future isInDb(Storage val) async{
                            print('loopy');
                            var allUser = await users;
                            print(allUser.length);
                            for(int i = 0; i < allUser.length; i++){
                              print("-------");
                              print(allUser[i].user);
                              print(allUser[i].name);
                              print("-------");
                              if(val.user == allUser[i].user && val.password == allUser[i].password){
                                final prefs = await SharedPreferences.getInstance();
                                prefs.setInt('id', allUser[i].id);
                                prefs.setString('username', val.user);

                                User.id = allUser[i].id;
                                User.name = allUser[i].name;
                                User.age = allUser[i].age;
                                User.quote = allUser[i].quote;
                                User.username = allUser[i].user;
                                User.password = allUser[i].password;
                                Route route = MaterialPageRoute(builder: (context) => HomePage());
                                Navigator.push(context, route);
                              }
                            }
                          }
                          await isInDb(user);
                          Toast.show("Invalid user or passwod", context,
                      duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                          // if(status){
                          //   print('You are in');
                          // }else{
                          //   print('Wrong password');
                          // }
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

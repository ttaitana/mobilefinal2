import 'package:flutter/material.dart';
import './db/storage.dart';


class RegisterScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RegisterScreenState();
  }
}

class RegisterScreenState extends State<RegisterScreen> {
  final StorageProvider _storage = StorageProvider();
  final _formkey = GlobalKey<FormState>();

  TextEditingController userController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Padding(
        padding: EdgeInsets.all(18),
        child: Form(
          key: _formkey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                    icon: Icon(Icons.person), labelText: 'User id'),
                keyboardType: TextInputType.emailAddress,
                controller: userController,
                validator: (value) {
                  if (value.isEmpty) {
                    return "User id is required";
                  } else if (value.length < 6 || value.length > 12) {
                    return 'Length must between 6 and 12';
                  }
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                    icon: Icon(Icons.account_circle), labelText: 'Name'),
                controller: nameController,
                validator: (value) {
                  if (value.isEmpty) return "Name is required";
                  else if (value.split(" ").length != 2){
                    return "Name must contain First name and Last name";
                  }
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                    icon: Icon(Icons.date_range), labelText: 'Age'),
                controller: ageController,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Age is required";
                  }else if(int.parse(value) < 10 || int.parse(value) > 80){
                    return "Age must between 10 and 80";
                  }
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                    icon: Icon(Icons.lock), labelText: 'Password'),
                obscureText: true,
                controller: passwordController,
                validator: (value) {
                  if (value.isEmpty && value.length < 6)
                    return "Password is required";
                },
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: RaisedButton(
                      child: Text("Register"),
                      onPressed: () async {
                        if (_formkey.currentState.validate()) {
                          await _storage.open('tester.db');
                          Storage data = Storage();
                          data.user = userController.text;
                          data.name = nameController.text;
                          data.age = int.parse(ageController.text);
                          data.quote = "";
                          data.password = passwordController.text;
                          print(data.user);
                          print('wait');
                          Storage resault = await _storage.insert(data);
                          print('complete');
                          print(resault.id);
                          Navigator.pop(context);
                        } else {
                          print('Error');
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

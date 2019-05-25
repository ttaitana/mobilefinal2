import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './db/userInsystem.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("Home"),
        ),
        body: Align(
          alignment: Alignment.center,
          child: ListView(
            children: <Widget>[
              Text(
                "Hello " + User.name,
                textScaleFactor: 2,
              ),
              Text(
                'this is my quote "' + User.quote + '"',
                textScaleFactor: 1.2,
              ),
              Card(
                child: new InkWell(
                    onTap: () {
                      print('text');
                    },
                    child: Container(
                      padding: new EdgeInsets.all(20.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("PROFILE SETUP"),
                      ),
                    )),
              ),
              Card(
                child: new InkWell(
                    onTap: () {
                      print('text');
                    },
                    child: Container(
                      padding: new EdgeInsets.all(20.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("MY FRIEND"),
                      ),
                    )),
              ),
              Card(
                child: new InkWell(
                    onTap: () {
                      print('text');
                    },
                    child: Container(
                      padding: new EdgeInsets.all(20.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("SIGN OUT"),
                      ),
                    )),
              ),
            ],
          ),
        ));
  }
}

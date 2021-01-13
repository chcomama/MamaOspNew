import 'package:flutter/material.dart';
import 'package:mamaosp/utility/my_style.dart';

class MyServiceUser extends StatefulWidget {
  @override
  _MyServiceUserState createState() => _MyServiceUserState();
}

class _MyServiceUserState extends State<MyServiceUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User'),
      ),
      drawer: Drawer(
        child: Column(mainAxisAlignment: MainAxisAlignment.end,
          children: [
            MyStyle().buildSignOut(context),
          ],
        ),
      ),
    );
  }
}

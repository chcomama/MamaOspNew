import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class MyStyle {
  //Classสี  ตามColorTools
  Color darkColor = Color(0xff0086c3);
  Color primaryColor = Color(0xff29b6f6);
  Color lightColor = Color(0xff73e8ff);

  Widget buildSignOut(BuildContext context)  {
    return ListTile(
            onTap: () async {
              await Firebase.initializeApp().then((value) async {
                await FirebaseAuth.instance.signOut().then((value) =>
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/authen', (route) => false));
              });
            },
            tileColor: Colors.red[800],
            leading: Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
            title: Text(
              'Sing Out',
              style: MyStyle().whiteStyle(),
            ),
          );
  }



//loading
  Widget showProgress() => Center(child: CircularProgressIndicator());

  //Method
  TextStyle whiteStyle() => TextStyle(color: Colors.white);
  TextStyle pinkStyle() => TextStyle(color: Colors.pink);

//Methodหาอัตราส่วนหน้าจอ
  double findScreen(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  MyStyle();
}
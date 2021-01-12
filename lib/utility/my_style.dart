import 'package:flutter/material.dart';

class MyStyle {
  //Classสี  ตามColorTools
  Color darkColor = Color(0xff0086c3);
  Color primaryColor = Color(0xff29b6f6);
  Color lightColor = Color(0xff73e8ff);

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
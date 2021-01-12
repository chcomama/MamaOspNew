import 'package:flutter/material.dart';
import 'package:mamaosp/states/authen.dart';
import 'package:mamaosp/states/my_service.dart';
import 'package:mamaosp/states/register.dart';
//สารบัญ
final Map<String, WidgetBuilder> myRoutes = {

  '/authen':(BuildContext context)=> Authen(),
  '/register':(BuildContext context)=>Register(),
  '/myService':(BuildContext context)=> MyService(),
};
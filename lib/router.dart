import 'package:flutter/material.dart';
import 'package:mamaosp/states/authen.dart';
import 'package:mamaosp/states/my_service_user.dart';
import 'package:mamaosp/states/my_servics_shoper.dart';
import 'package:mamaosp/states/register.dart';
//สารบัญ
final Map<String, WidgetBuilder> myRoutes = {

  '/authen':(BuildContext context)=> Authen(),
  '/register':(BuildContext context)=>Register(),
  '/myServiceUser':(BuildContext context)=> MyServiceUser(),
  '/myServiceShoper':(BuildContext context)=> MyServiceShoper(),
};
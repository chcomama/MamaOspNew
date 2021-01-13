import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mamaosp/router.dart';

// void main() {
//  runApp(MyApp());
// }

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  //ตั้งค่าหน้าจอให้ตั้งหรือนอน
    SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    return MaterialApp(
      //ทำให้debugmodeหาย
      debugShowCheckedModeBanner: false,
      routes: myRoutes,
      initialRoute: '/authen',
    );
  }
}

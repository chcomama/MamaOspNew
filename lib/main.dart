import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mamaosp/router.dart';

//varคือไม่รู้ว่าเป็นชนิดอะไร
var initialRoute;

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) async {
    //checkว่าloginอยู่ไหม
    await FirebaseAuth.instance.authStateChanges().listen((event) async {
      if (event == null) {
        initialRoute = '/authen';
        runApp(MyApp());
      } else {
        //ถ้าloginแล้วให้ไปตามหน้าของสิทธิ์นั้น
        String uid = event.uid;
        await FirebaseFirestore.instance
            .collection('typeuser')
            .doc(uid)
            .snapshots()
            .listen((event) {
          String typeuser = event.data()['typeuser'];
          initialRoute = '/myService$typeuser';
          runApp(MyApp());
        });
      }
    });
  });
}

// main() => runApp(MyApp());

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
      initialRoute: initialRoute,
    );
  }
}

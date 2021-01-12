import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:mamaosp/utility/my_style.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  double screen; //ประกาศตัวแปรใช้ได้เฉพาะClassนี้
  String typeUser;
  double lat, long;

  //ทำงานก่อนBuildอีกที
  @override
  void initState() {
    super.initState();
    //เรียกฟังก์ชั่นหา Lat,Long
    findLatLong();
    findToken();
  }

  Future<Null> findToken() async {
    //awaitคือคำสั่งที่ให้ทำจนกว่าจะเสร็จ ถ้าเสร็จแล้วให้ทำคำสั่งหลังจากThen
    await Firebase.initializeApp().then((value) {
      print('###########  initialize Success  #############');
    });
  }

  //ประกาศตัวแปร
  //ทำงานแล้วรอผลลัพธ์ --> Tradจะมีคำว่าasyncเสมอ
  //หาค่าLatLong
  Future<Null> findLatLong() async {
    //ต้องการสั่งให้findLocationDataส่งค่ามาที่data ต้องใช้คำสั่ง await
    LocationData data = await findLocationData();
    //Refreshหน้าจอก่อนโชว์ค่า
    setState(() {
      lat = data.latitude;
      long = data.longitude;
    });
  }

  //หาLocation
  //ต้องติดตั้งLibralyก่อนถึงจะเรียกได้
  Future<LocationData> findLocationData() async {
    Location location = Location();
    try {
      //ถ้ามีค่าให้ส่งค่ากลับ
      return location.getLocation();
    } catch (e) {
      //ถ้าไม่มีให้เป็นค่าว่าง
      return null;
    }
  }

  Container buildName() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white70, borderRadius: BorderRadius.circular(15)),
      margin: EdgeInsets.only(top: 50),
      width: screen * 0.6,
      child: TextField(
        decoration: InputDecoration(
          hintStyle: TextStyle(color: MyStyle().darkColor),
          prefixIcon: Icon(
            Icons.fingerprint,
            color: MyStyle().darkColor,
          ),
          hintText: 'Name : ',
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: MyStyle().darkColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: MyStyle().lightColor)),
        ),
      ),
    );
  }

  Container buildUser() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white70, borderRadius: BorderRadius.circular(15)),
      margin: EdgeInsets.only(top: 16),
      width: screen * 0.6,
      child: TextField(
        decoration: InputDecoration(
          hintStyle: TextStyle(color: MyStyle().darkColor),
          prefixIcon: Icon(
            Icons.perm_identity,
            color: MyStyle().darkColor,
          ),
          hintText: 'User : ',
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: MyStyle().darkColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: MyStyle().lightColor)),
        ),
      ),
    );
  }

  Container buildPassword() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white70, borderRadius: BorderRadius.circular(15)),
      margin: EdgeInsets.only(top: 16),
      width: screen * 0.6,
      child: TextField(
        decoration: InputDecoration(
          hintStyle: TextStyle(color: MyStyle().darkColor),
          prefixIcon: Icon(
            Icons.lock_outline,
            color: MyStyle().darkColor,
          ),
          hintText: 'Password : ',
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: MyStyle().darkColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: MyStyle().lightColor)),
        ),
      ),
    );
  }

  @override
  //buildทำงานอันเรียกเสมอ
  Widget build(BuildContext context) {
    //เรียก Methodหาหน้าจอ
    screen = MyStyle().findScreen(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyStyle().primaryColor,
        title: Text('Register'),
      ),
      body: Center(
        child: Column(
          children: [
            buildName(),
            buildRadioUser(),
            buildRadioShoper(),
            buildUser(),
            buildPassword(),
            buildMap()
          ],
        ),
      ),
    );
  }

  Set<Marker> markers() => <Marker>[
        Marker(
          markerId: MarkerId('idMarker1'),
          position: LatLng(lat, long),
          infoWindow: InfoWindow(
              title: 'คุณอยู่ที่นี่', snippet: 'Lat = $lat , Long = $long'),
        ),
      ].toSet();

  Expanded buildMap() {
    return Expanded(
      //ขอบเขตของแผนที่ Expanded ใช้พื้นที่ที่เหลือ
      child: Container(
        margin: EdgeInsets.all(16), //all ทั้ง4ด้าน
        width: screen,

        child: lat == null
            ? MyStyle().showProgress()
            // : Text('Lat= $lat , Long= $long'),
        : GoogleMap(
            markers: markers(),
            initialCameraPosition: CameraPosition(
              target: LatLng(lat, long),
              zoom: 16,
            ),
            onMapCreated: (controller) {},
          ),
      ),
    );
  }

  Container buildRadioUser() {
    return Container(
      width: screen * 0.6,
      child: RadioListTile(
        subtitle: Text('Type User For Buyer'),
        title: Text('User'),
        value: 'User',
        groupValue: typeUser,
        onChanged: (value) {
          setState(() {
            typeUser = value;
            print('radio_value= $typeUser');
          });
        },
      ),
    );
  }

  Container buildRadioShoper() {
    return Container(
      width: screen * 0.6,
      child: RadioListTile(
        subtitle: Text('สำหรับ ร้านค้าที่ต้องการขายสินค้า'),
        title: Text('Shoper'),
        value: 'Shoper',
        groupValue: typeUser,
        onChanged: (value) {
          setState(() {
            typeUser = value;
            print('radio_value= $typeUser');
          });
        },
      ),
    );
  }
}
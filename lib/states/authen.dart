import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mamaosp/utility/my_style.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  double screen; //ประกาศตัวแปรที่ใช้เฉพาะClassนี้
  bool status = true;
  @override
  Widget build(BuildContext context) {
    //Methodหลักที่เรียกตัวนี้เป็นตัวแรก
    screen = MediaQuery.of(context).size.width; //หาอัตราส่วนของหน้าจอ
    print('screen = $screen'); //echo ค่าของตัวแปร
    return Scaffold(
      //ปุ่มด้านล่างจอ
      floatingActionButton: buildRegister(),
      body: Container(
        //ส่วนตกแต่ง
        decoration: BoxDecoration(
          //พื้นหลังแบบไล่สี
          gradient: RadialGradient(
            center: Alignment(0, -0.35),
            radius: 1.0,
            colors: <Color>[Colors.white, MyStyle().primaryColor],
          ),
        ),
        child: Center(//จัดให้อยู่กึ่งกลางของหน้าจอ
          child: Column(//แสดงผลจากบนลงล่าง
            mainAxisSize: MainAxisSize.min, //กำหนดให้ขนาดพอดีกับlogo
            children: [
              bulidLogo(),
              buildText(),
              buildUser(),
              buildPassword(),
              buildLogin(),
            ],
          ),
        ),
      ),
    );
  }

  TextButton buildRegister() {
    return TextButton( //เมื่อคำว่า New Register
      //Route แบบ pushName คือ ปูทับหน้าเดิมยังอยู่
      onPressed: () =>Navigator.pushNamed(context, '/register'),
      child: Text(
        'New Register',
        style: MyStyle().pinkStyle(),
      ),
    );
  }

  Container buildLogin() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: screen * 0.6,
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: MyStyle().darkColor,
        onPressed: () {},
        child: Text(
          'Login',
          style: MyStyle().whiteStyle(),
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
        obscureText: status,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            //if_else แบบสั้น หลัง?=True หลัง :=False
            icon: status
                ? Icon(Icons.remove_red_eye)
                : Icon(Icons.remove_red_eye_outlined),
            onPressed: () {
              setState(() {
                //Refrshหน้าจอ
                status = !status;
              });
              print('You Click RedEye status = $status');
            },
          ), //รูปตา
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

  Text buildText() => Text(
        'MaMa OSP',
        style: GoogleFonts.parisienne(
            textStyle: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w700,
          fontStyle: FontStyle.italic,
          color: MyStyle().darkColor, //ใช้Classสี
        )),
      ); //มีคำสั้งเดียวเลยใช้ => (ArrowFuction)

  Container bulidLogo() {
    return Container(
      width: screen * 0.40, //โชว์โลโก้ตามขนาดหน้าจอ
      child: Image.asset('images/logo.png'),
    );
  }
}
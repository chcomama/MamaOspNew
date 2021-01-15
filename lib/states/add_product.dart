import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mamaosp/utility/dialog.dart';
import 'package:mamaosp/utility/my_constant.dart';
import 'package:mamaosp/utility/my_style.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  double screen;
  File file;
  String name, descrip, price, urtPath, uid;
  bool statusProgress = false;

  @override
  void initState() {
    super.initState();
    findUid();
  }

  Future<Null> findUid() async {
    await Firebase.initializeApp().then((value) async {
      await FirebaseAuth.instance.authStateChanges().listen((event) {
        uid = event.uid;
      });
    });
  }

  Container buildName() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white70, borderRadius: BorderRadius.circular(15)),
      margin: EdgeInsets.only(top: 16),
      width: screen * 0.6,
      child: TextField(
        onChanged: (value) => name = value.trim(),
        decoration: InputDecoration(
          hintStyle: TextStyle(color: MyStyle().darkColor),
          prefixIcon: Icon(
            Icons.card_giftcard,
            color: MyStyle().darkColor,
          ),
          hintText: 'Name Product : ',
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

  Container buildDescription() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white70, borderRadius: BorderRadius.circular(15)),
      margin: EdgeInsets.only(top: 16),
      width: screen * 0.6,
      child: TextField(
        onChanged: (value) => descrip = value.trim(),
        decoration: InputDecoration(
          hintStyle: TextStyle(color: MyStyle().darkColor),
          prefixIcon: Icon(
            Icons.description,
            color: MyStyle().darkColor,
          ),
          hintText: 'Description : ',
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

  Container buildPrice() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white70, borderRadius: BorderRadius.circular(15)),
      margin: EdgeInsets.only(top: 16),
      width: screen * 0.6,
      child: TextField(
        keyboardType: TextInputType.number,
        onChanged: (value) => price = value.trim(),
        decoration: InputDecoration(
          hintStyle: TextStyle(color: MyStyle().darkColor),
          prefixIcon: Icon(
            Icons.money,
            color: MyStyle().darkColor,
          ),
          hintText: 'Price : ',
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
  Widget build(BuildContext context) {
    screen = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyStyle().primaryColor,
        title: Text('Add Product'),
      ),
      body: Stack(
        children: [
          statusProgress ? MyStyle().showProgress() : SizedBox(),
          buildSingleChildScrollView(),
        ],
      ),
    );
  }

  SingleChildScrollView buildSingleChildScrollView() {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          buildRowImage(),
          buildName(),
          buildDescription(),
          buildPrice(),
          buildSaveProduct(),
        ],
      ),
    );
  }

  Container buildSaveProduct() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: screen * 0.6,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: MyStyle().darkColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {
          //Check Blank
          if (file == null) {
            normalDialog(
                context, 'Please Choose Image ? by Click Camera Or Gallery');
          } else if ((name?.isEmpty ?? true) ||
              (descrip?.isEmpty ?? true) ||
              (price?.isEmpty ?? true)) {
            normalDialog(context, 'Have Space ? Please Fill Every Blank');
          } else {
            confirmSave();
          }
        },
        child: Text('Save Product'),
      ),
    );
  }

//alertแบบโชว์Detail
  Future<Null> confirmSave() async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: ListTile(
          leading: Image.file(file),
          title: Text(name),
          subtitle: Text(descrip),
        ),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Price : $price BTH',
                style: TextStyle(color: Colors.pink, fontSize: 25),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {
                  //methodsave
                  uploadImageAndInsertData();
                  //refrehก่อน
                  setState(() {
                    statusProgress = true;
                  });
                  Navigator.pop(context);
                },
                child: Text('Save Product'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Cacel',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          )
          //ต่อข้อมูลได้เรื่อยๆ
        ],
      ),
    );
  }

  Future<Null> chooseSourceImage(ImageSource source) async {
    try {
      //getpictureandresize
      var result = await ImagePicker()
          .getImage(source: source, maxWidth: 800, maxHeight: 800);
      setState(() {
        file = File(result.path);
      });
    } catch (e) {}
  }

  Row buildRowImage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: Icon(Icons.add_a_photo),
          onPressed: () => chooseSourceImage(ImageSource.camera),
        ),
        Container(
          width: screen * 0.6,
          child:
              file == null ? Image.asset('images/image.png') : Image.file(file),
        ),
        IconButton(
          icon: Icon(Icons.add_photo_alternate),
          onPressed: () => chooseSourceImage(ImageSource.gallery),
        ),
      ],
    );
  }

//Uploadfile
  Future<Null> uploadImageAndInsertData() async {
    //สุ่มId Product
    int i = Random().nextInt(1000000);
    String nameImage = 'Product$i.jpg';

    try {
      Map<String, dynamic> map = Map();
      map['file'] =
          await MultipartFile.fromFile(file.path, filename: nameImage);
      //ทำค่าMapให้เป็นFromDataก่อน
      FormData data = FormData.fromMap(map);
      await Dio()
          .post(MyConstant().urlSaveFile, data: data)
          .then((value) async {
        urtPath = 'maproduct/$nameImage';
        print('************ ${MyConstant().domain}$urtPath');

        String urlAPI =
            'https://www.androidthai.in.th/osp/addDataMa.php?isAdd=true&uidshop=$uid&name=$name&detail=$descrip&price=$price&urlproduct=$urtPath';
        await Dio().get(urlAPI).then((value) => Navigator.pop(context));
      }).catchError((value) {
        print(value.toString());
      });
    } catch (e) {
      print('Error ---------------> ${e.toString()}');
    }
  }
}

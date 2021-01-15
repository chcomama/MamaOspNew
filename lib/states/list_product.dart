import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mamaosp/models/product_model.dart';
import 'package:mamaosp/utility/my_constant.dart';
import 'package:mamaosp/utility/my_style.dart';

class ListProduct extends StatefulWidget {
  @override
  _ListProductState createState() => _ListProductState();
}

class _ListProductState extends State<ListProduct> {
  List<ProductModel> productmodel = List();
  double screen;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readAllProduct();
  }

  Future<Null> readAllProduct() async {
    if (productmodel.length != 0) {
      productmodel.clear();
    }

//หาUid
    await Firebase.initializeApp().then((value) async {
      await FirebaseAuth.instance.authStateChanges().listen((event) async {
        String uid = event.uid;
        print('*******  Read All Product work uid => $uid');

        String urlAPI =
            'https://www.androidthai.in.th/osp/getProductWhereUidMa.php?isAdd=true&uid=$uid';
        await Dio().get(urlAPI).then((value) {
          print('****  value = $value');
          //แปลงโค้ดให้เป็น utf8
          var result = json.decode(value.data);
          print('#####  result = $result');

          //เอาค่าออกมาโชว์
          for (var item in result) {
            ProductModel model = ProductModel.fromMap(item);
            setState(() {
              productmodel.add(model);
            });
          }
        });
      });
    });
  }

//methodตัดคำ
  String cutDetail(String string) {
    String result = string;
    if (result.length >= 60) {
      result = result.substring(0, 59);
      result = '$result ...';
    }
    //ทำเสร็จส่งค่ากลับ
    return result;
  }

  @override
  Widget build(BuildContext context) {
    screen = MediaQuery.of(context).size.width;
    return Scaffold(
      //ปุ่มAddด้านล่างจอ
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyStyle().primaryColor,
        onPressed: () => Navigator.pushNamed(context, '/addProduct')
            .then((value) => readAllProduct()),
        child: Icon(Icons.add),
      ),
      body: productmodel.length == 0
          ? MyStyle().showProgress()
          : ListView.builder(
              itemCount: productmodel.length,
              itemBuilder: (context, index) => Card(
                //เรียงสีสลับกัน
                color: index % 2 == 0
                    ? MyStyle().lightColor
                    : Colors.grey.shade200,
                child: Row(
                  children: [
                    Container(
                      //ขยับให้ตัวหนังสือขยับเข้ามา
                      padding: EdgeInsets.all(8),
                      width: screen * 0.5 - 5,
                      height: screen * 0.5,
                      child: Column(
                        //เรียงซ้ายไปขวา
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            productmodel[index].name,
                            style: MyStyle().titleH1Style(),
                          ),
                          Text(
                            ' ${productmodel[index].price} BTH',
                            style: MyStyle().titleH0Style(),
                          ),
                          Text(cutDetail(productmodel[index].detail)),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      //ดึงภาพมาโชว์
                      width: screen * 0.5 - 5,
                      height: screen * 0.5,
                      child: CachedNetworkImage(
                          //ถ้าไม่เจอรูปให้โชว์รูปอื่นแทน
                          errorWidget: (context, url, error) =>
                              Image.asset('images/image.png'),
                          //ถ้ายังโหลดภาพไม่ได้ให้โชว์ Loading
                          placeholder: (context, url) =>
                              MyStyle().showProgress(),
                          imageUrl:
                              '${MyConstant().domain}${productmodel[index].urlproduct}'),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}

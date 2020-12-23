import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nutaicapp/widget/edit_information.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/usermodel.dart';
import '../models/usermodel.dart';
import '../utility/myconstant.dart';
import '../utility/mystyle.dart';

class InformationUser extends StatefulWidget {
  @override
  _InformationUserState createState() => _InformationUserState();
}

class _InformationUserState extends State<InformationUser> {
  String idLogin;
  UserModel userModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findInformation();
  }

  Future<Null> findInformation() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    idLogin = preferences.getString('id');
    print('idLogin ==> $idLogin');

    String path =
        '${MyConstant().domain}/aic/getUserWhereId.php?isAdd=true&id=$idLogin';
    await Dio().get(path).then((value) {
      print('value ==> $value');
      var result = jsonDecode(value.data);
      print(result);

      for (var item in result) {
        setState(() {
          userModel = UserModel.fromMap(item);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context, 
          MaterialPageRoute(
            builder: (context) => Edit_Information(
              userModel: userModel,))).then((value) => findInformation()),
        child: Text('Edit'),
      ),
      body: userModel == null
          ? MyStyle().showProgess()
          : userModel.address.isEmpty
              ? Center(child: Text('ข้อมูลไม่ครบกรุณากด Edit'))
              : Text('Have Data'),
    );
  }
}

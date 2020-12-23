import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nutaicapp/utility/dialog.dart';
import 'package:nutaicapp/utility/myconstant.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String typeUser //= 'User'
      ,
      user,
      name,
      password,
      errmsg;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkInternet();
  }

  Future<Null> checkInternet() async {
    try {
      var result = await InternetAddress.lookup('google.com');

      if ((result.isNotEmpty) && (result[0].rawAddress.isNotEmpty)) {
        print('Internet OK, OK number one.');
      }
    } catch (e) {
      print('error Internet ==> ${e.toString()}');
      normalDialog(
          context, 'Your Internet was Fucked. Just change internet brand.');
    }
  }

  Container buildName() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: 250,
      child: TextField(
        onChanged: (value) => name = value.trim(),
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.group),
          border: OutlineInputBorder(),
          hintText: 'Name',
        ),
      ),
    );
  }

  Container buildUser() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: 250,
      child: TextField(
        onChanged: (value) => user = value.trim(),
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.rowing),
          border: OutlineInputBorder(),
          hintText: 'User',
        ),
      ),
    );
  }

  Container buildPassword() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: 250,
      child: TextField(
        onChanged: (value) => password = value.trim(),
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock),
          border: OutlineInputBorder(),
          hintText: 'Password',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print(
              'name = $name, user = $user , password = $password , typeUser = $typeUser');
          if (name == null ||
              name.isEmpty ||
              (user?.isEmpty ?? true) ||
              (password?.isEmpty ?? true)) {
            print('You have space for me.');
            errmsg = 'You have space for me.';
            normalDialog(context, errmsg);
          } else if (typeUser == null) {
            errmsg = 'Choose TypeUser Please.';
            normalDialog(context, errmsg);
          } else {
            checkUser();
          }
        },
        child: Icon(Icons.cloud_upload),
      ),
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildName(),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                buildRadioListTileUser(),
                buildRadioListTileOfficer(),
              ]),
              buildUser(),
              buildPassword(),
            ],
          ),
        ),
      ),
    );
  }

  Container buildRadioListTileOfficer() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.45,
      child: RadioListTile(
        subtitle: Text('for Register Type Officer'),
        title: const Text('Officer'),
        value: 'Officer',
        groupValue: typeUser,
        onChanged: (value) {
          setState(() {
            typeUser = value;
            //print(typeUser);
          });
        },
      ),
    );
  }

  Container buildRadioListTileUser() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.45,
      child: RadioListTile(
        subtitle: Text('for Register Type User'),
        title: const Text('User'),
        value: 'User',
        groupValue: typeUser,
        onChanged: (value) {
          setState(() {
            typeUser = value;
            //print(typeUser);
          });
        },
      ),
    );
  }

  Future<Null> checkUser() async {
    String path =
        '${MyConstant().domain}/aic/getUserWhereUser.php?isAdd=true&user=$user';

    await Dio().get(path).then((value) {
      //print('value = $value');
      if (value.toString() == 'null') {
        insertUser();
      } else {
        normalDialog(context,
            '$user is already using by other user in this program. Just change username or don\'t user this application. \n\n$user มีคนใช้แล้ว เปลี่ยนชื่อซะไม่ก็ไม่ต้องใช้โปรแกรมนี้');
      }
    });
  }

  Future<Null> insertUser() async {
    String path =
        '${MyConstant().domain}/aic/addUserUng.php?isAdd=true&name=$name&user=$user&password=$password&typeuser=$typeUser';
    await Dio().get(path).then((value) {
      if (value.toString() == 'true') {
        Navigator.pop(context);
      } else {
        normalDialog(context, 'Please try again.');
      }
    });
  }
}

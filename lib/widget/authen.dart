import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutaicapp/models/usermodel.dart';
import 'package:nutaicapp/utility/dialog.dart';
import 'package:nutaicapp/utility/myconstant.dart';
import 'package:nutaicapp/utility/mystyle.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utility/myconstant.dart';
import '../utility/myconstant.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  bool statusRedEye = true, statusProgress = true;
  String user, password;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
              center: Alignment(0, -0.2),
              radius: 0.9,
              colors: <Color>[
                Colors.white,
                Colors.blue,
                Colors.indigo,
                Colors.grey.shade700
              ]),
        ),
        child: Stack(
          children: [
            buildContent(),
            statusProgress ? SizedBox() : MyStyle().showProgess(),
          ],
        ),
      ),
    );
  }

  Center buildContent() {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildLogo(),
            buildSnorlax(),
            buildAppName(),
            buildUser(),
            buildPassword(),
            buildLogin(),
            buildRegister()
          ],
        ),
      ),
    );
  }

  TextButton buildRegister() => TextButton(
      onPressed: () {
        Navigator.pushNamed(context, '/register');
      },
      child: Text('Register'));

  Container buildLogin() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      width: 250,
      child: ElevatedButton(
        onPressed: () {
          if ((user?.isEmpty ?? true) || (password?.isEmpty ?? true)) {
            normalDialog(
                context, 'Don\'t give me space!!! \n\nอย่าส่งค่าว่างให้ฉัน!!!');
          } else {
            setState(() {
              statusProgress = false;
            });
            checkAuthen();
          }
        },
        child: Text('Login'),
      ),
    );
  }

  Container buildPassword() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: 250,
      child: TextField(
        onChanged: (value) => password = value.trim(),
        autofocus: false,
        obscureText: statusRedEye,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: Icon(Icons.remove_red_eye),
            onPressed: () {
              setState(() {
                statusRedEye = !statusRedEye;
              });
              print('You kick myeye statusRedEye = $statusRedEye');
            },
          ),
          prefixIcon: Icon(Icons.lock),
          border: OutlineInputBorder(),
          hintText: 'Password',
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
          hintText: 'Username',
        ),
      ),
    );
  }

  Text buildAppName() => Text(
        'NUT AIC App',
        style: GoogleFonts.zcoolKuaiLe(
            textStyle: TextStyle(
          fontSize: 27,
          fontWeight: FontWeight.bold,
          color: Colors.indigo.shade900,
          fontStyle: FontStyle.italic,
        )),
      );

  Container buildLogo() {
    return Container(
      width: 150,
      child: Image.asset('images/AIC.png'),
    );
  }

  Container buildSnorlax() {
    return Container(
      width: 100,
      child: Image.asset('images/snorlax.png'),
    );
  }

  Future<Null> checkAuthen() async {
    String path =
        '${MyConstant().domain}/aic/getUserWhereUser.php?isAdd=true&user=$user';
    await Dio().get(path).then((value) async {
      if (value.toString() == 'null') {
        count++;
        checkCount();
        setState(() {
          statusProgress = true;
        });
        normalDialog(context,
            'You don\'t have username in my application. Just register \n\nไปสมัครสมาชิกซะ');
      } else {
        print('value = $value');
        var result = json.decode(value.data);
        print('result = $result');
        //normalDialog(context, result.toString());
        for (var item in result) {
          print('item = $item');
          UserModel model = UserModel.fromMap(item);
          if (model.password == password) {
            normalDialog(context, 'VVT');

            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            preferences.setString(MyConstant().keyName, model.name);
            preferences.setString(MyConstant().keyType, model.typeuser);
            preferences.setString('id', model.id);

            switch (model.typeuser) {
              case 'User':
                Navigator.pushNamedAndRemoveUntil(
                    context, '/serviceuser', (route) => false);
                break;
              case 'Officer':
                Navigator.pushNamedAndRemoveUntil(
                    context, '/serviceoffice', (route) => false);
                break;
            }
          } else {
            count++;
            checkCount();
            normalDialog(context, 'จำรหัสไม่ได้หละสิ $count');
          }
          setState(() {
            statusProgress = true;
          });
        }
      }
    });
  }

  void checkCount() {
    if (count >= 4) {
      normalDialog(context, 'Login เกิน ($count ครั้ง)');
    }
  }
}

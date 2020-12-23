import 'package:flutter/material.dart';
import 'package:nutaicapp/widget/informationuser.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utility/mystyle.dart';

class MyServiceUser extends StatefulWidget {
  @override
  _MyServiceUserState createState() => _MyServiceUserState();
}

class _MyServiceUserState extends State<MyServiceUser> {
  Widget currentWidget = InformationUser();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<Null> readInfomation() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User :'),
      ),
      drawer: Drawer(
        child: MyStyle().buildSignOut(context),
      ),
      body: currentWidget,
    );
  }
}

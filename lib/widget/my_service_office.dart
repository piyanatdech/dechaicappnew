import 'package:flutter/material.dart';
import 'package:nutaicapp/widget/page2.dart';
import 'package:nutaicapp/widget/showlistjob.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utility/myconstant.dart';
import '../utility/mystyle.dart';

class MyServiceOffice extends StatefulWidget {
  @override
  _MyServiceOfficeState createState() => _MyServiceOfficeState();
}

class _MyServiceOfficeState extends State<MyServiceOffice> {
  String nameLogin;
  Widget currentWidget = ShowListJob();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    findLogin();
  }

  Future<Null> findLogin() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      nameLogin = preferences.getString(MyConstant().keyName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(nameLogin == null ? 'Officer :' : 'Officer : $nameLogin'),
      ),
      drawer: buildDrawer(context),
      body: currentWidget,
    );
  }

  Drawer buildDrawer(BuildContext context) {
    return Drawer(
      child: Stack(
        children: [
          Column(
            children: [
              buildUserAccountsDrawerHeader(),
              buildMenuShowJob(),
              buildPage2(),
            ],
          ),
          MyStyle().buildSignOut(context),
        ],
      ),
    );
  }

  ListTile buildMenuShowJob() {
    return ListTile(
      leading: Icon(Icons.list),
      title: Text('Show List Jop'),
      subtitle: Text('แสดงรายชื่อของงานที่รับผิดชอบ'),
      onTap: () {
        Navigator.pop(context);

        setState(() {
          currentWidget = ShowListJob();
        });
      },
    );
  }

  ListTile buildPage2() {
    return ListTile(
      leading: Icon(Icons.list),
      title: Text('Display Page2'),
      subtitle: Text('แสดงรายชื่อของงานที่รับผิดชอบ'),
      onTap: () {
        Navigator.pop(context);

        setState(() {
          currentWidget = Page2();
        });
      },
    );
  }

  UserAccountsDrawerHeader buildUserAccountsDrawerHeader() {
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage('images/wall.jpg'),
        fit: BoxFit.cover,
      )),
      currentAccountPicture: Image.asset('images/eevee.png'),
      accountName: nameLogin == null ? Text('Name') : Text(nameLogin),
      accountEmail: Text('Logined'),
    );
  }
}

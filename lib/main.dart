import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nutaicapp/router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'utility/myconstant.dart';

var myIntial;

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String type = preferences.getString(MyConstant().keyType);

  print('type ==> $type');

  if(type != null){
      switch(type){
        case 'User':
          myIntial = '/serviceuser';
        break;
        case 'Officer':
          myIntial = '/serviceoffice';
        break;
      }
  }else{
      myIntial = '/authen';
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.red),
      debugShowCheckedModeBanner: false,
       routes: rounts, initialRoute: myIntial,
      //home: Authen(),
    );
  }
}

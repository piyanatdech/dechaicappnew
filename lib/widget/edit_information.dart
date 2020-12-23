import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../models/usermodel.dart';
import '../models/usermodel.dart';
import '../utility/mystyle.dart';

class Edit_Information extends StatefulWidget {
  final UserModel userModel;
  Edit_Information({Key key, this.userModel}) : super(key: key);

  @override
  _Edit_InformationState createState() => _Edit_InformationState();
}

class _Edit_InformationState extends State<Edit_Information> {
  UserModel model;
  double lat, lng;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    model = widget.userModel;
    findLatLng();
  }

  Future<Null> findLatLng() async {
    LocationData locationData = await findlocation();
    setState(() {
      lat = locationData.latitude;
      lng = locationData.longitude;
      print('lat = $lat , lng = $lng');
    });
  }

  Future<LocationData> findlocation() async {
    Location location = Location();
    try {
      return location.getLocation();
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Information'),
      ),
      body: Center(
        child: Column(
          children: [
            buildName(),
            buildAdress(),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width,
                // color: Colors.red,
                child: lat == null
                    ? MyStyle().showProgess()
                    : GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: LatLng(lat, lng),
                          zoom: 16,
                        ),
                        mapType: MapType.normal,
                        onMapCreated: (controller) {},
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Container buildName() {
    return Container(
        margin: EdgeInsets.only(top: 16),
        width: 250,
        child: TextFormField(
          decoration: InputDecoration(
            labelText: 'Name',
            border: OutlineInputBorder(),
          ),
          initialValue: model.name,
        ));
  }

  Container buildAdress() {
    return Container(
        margin: EdgeInsets.only(top: 16, bottom: 16),
        width: 250,
        child: TextFormField(
          decoration: InputDecoration(
            labelText: 'Adress',
            border: OutlineInputBorder(),
          ),
          initialValue:
              model.address.isEmpty ? 'ข้อมูลที่ต้องเพิ่ม' : model.address,
        ));
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:vidyaniketan_app/widgets/drawer.dart';

class DriverScreen extends StatefulWidget {
  const DriverScreen({super.key});

  @override
  State<DriverScreen> createState() => _DriverScreenState();
}

class _DriverScreenState extends State<DriverScreen> {

  Location _locationController = Location();

  CollectionReference usersRef = FirebaseFirestore.instance.collection('users');
  CollectionReference busRef = FirebaseFirestore.instance.collection('bus_tracking');

  final auth = FirebaseAuth.instance;
  String busNo = "";


  @override
  void initState(){
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Driver Screen",style: TextStyle(fontSize: 20),),
      ),
      drawer: AltDrawer(),
      body: ElevatedButton(
        onPressed: (){
          final user = auth.currentUser;
          usersRef.doc(user?.phoneNumber.toString()).get().then((DocumentSnapshot snapshot){
            setState(() {
              busNo = snapshot.get('busNo');
              getLocationUpdates(busNo);
            });
          });
        },
        child: Text("Enable Live Location"),
      ),
    );
  }


  Future<void> getLocationUpdates(String busNo1) async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await _locationController.serviceEnabled();
    if (_serviceEnabled) {
      _serviceEnabled = await _locationController.requestService();
    } else {
      return;
    }

    _permissionGranted = await _locationController.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _locationController.requestPermission();

      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }


    _locationController.onLocationChanged
        .listen((LocationData currentLocation) {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        setState(() {
          busRef.doc('bus$busNo1').update({
            'lat': currentLocation.latitude.toString(),
            'lon': currentLocation.longitude.toString(),
          });
        });
      }
    });
  }
}

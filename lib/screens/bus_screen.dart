import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:vidyaniketan_app/constants/api_key.dart';

class BusScreen extends StatefulWidget {

  String docId = "";
  BusScreen({super.key,required this.docId});

  @override
  State<BusScreen> createState() => _BusScreenState(docId: docId);
}

class _BusScreenState extends State<BusScreen> {
  String docId;
  _BusScreenState({required this.docId});

  Location _locationController = Location();


  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

  static const LatLng _home = LatLng(19.0215711, 72.8707695);
  static const LatLng _vidyalankar = LatLng(19.029861695020962, 72.84325371847486);

  LatLng? _currentP = null;

  BitmapDescriptor sourceDestinationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor currentIcon = BitmapDescriptor.defaultMarker;

  // List<LatLng> polylineCoordinates = [];
  CollectionReference busRef = FirebaseFirestore.instance.collection('bus_tracking');

  @override
  void initState() {
    // getPolyPoints();
    super.initState();
    setCustomMarkerIcon();
    getLocationUpdates();

  }

  void setCustomMarkerIcon() {
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "assets/icons/source_dest_pin.png")
        .then((icon) {
          sourceDestinationIcon = icon;
    });

    BitmapDescriptor.fromAssetImage(
        ImageConfiguration.empty, "assets/icons/bus-pin.png")
        .then((icon) {
      currentIcon = icon;
    });
  }

  // void getPolyPoints() async {
  //   PolylinePoints polylinePoints = PolylinePoints();
  //   PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
  //       GOOGLE_MAPS_API_KEY,
  //       PointLatLng(_home.latitude, _home.longitude),
  //       PointLatLng(_vidyalankar.latitude, _vidyalankar.longitude));
  //
  //   if (result.points.isNotEmpty) {
  //     result.points.forEach((PointLatLng point) =>
  //         polylineCoordinates.add(LatLng(point.latitude, point.longitude)));
  //     setState(() {
  //
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bus Number: $docId"),
      ),
      body: _currentP == null
          ? const Center(
              child: Text("Loading...",style: TextStyle(fontSize: 25),),
            )
          : GoogleMap(
              onMapCreated: ((GoogleMapController controller) =>
                  _mapController.complete(controller)),
              initialCameraPosition:
                  const CameraPosition(target: _home, zoom: 10),
              markers: {
                Marker(
                    markerId: MarkerId("_sourceLocation"),
                    icon: sourceDestinationIcon,
                    infoWindow: InfoWindow(
                      title: "Home",
                      snippet: "Source Address",
                    ),
                    position: _home),
                Marker(
                    markerId: MarkerId("_destinationLocation"),
                    icon: sourceDestinationIcon,
                    position: _vidyalankar),
                Marker(
                    markerId: MarkerId("_currentLocation"),
                    icon: currentIcon,
                    position: _currentP!),
              },
            ),
    );
  }

  Future<void> _cameraToPosition(LatLng pos) async {
    final GoogleMapController controller = await _mapController.future;
    CameraPosition _newCameraPosition = CameraPosition(
      target: pos,
      zoom: 16,
    );
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(_newCameraPosition),
    );
  }

  Future<void> getLocationUpdates() async {
    final docRef = busRef.doc(docId);

    docRef.snapshots().listen((DocumentSnapshot snapshot) {
      if(snapshot.get('lat')!= null && snapshot.get('lon')!=null){
        setState(() {
          double lat = double.parse(snapshot.get('lat').toString()) ;
          double lon = double.parse(snapshot.get('lon').toString());
          _currentP = LatLng(lat,lon);
          _cameraToPosition(_currentP!);
        });
      }
    });


  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolygenScreen extends StatefulWidget {
  const PolygenScreen({Key? key}) : super(key: key);

  @override
  State<PolygenScreen> createState() => _PolygenScreenState();
}

class _PolygenScreenState extends State<PolygenScreen> {

  List<LatLng>points=const [
    LatLng(24.96938577473527, 66.9919511107712),LatLng(24.969346870533933, 67.00568402133717),
    LatLng(24.95619654561082, 67.02233517476851),LatLng(24.97564919075646, 67.01825821695452),
    LatLng(24.97771099090698, 67.03632557662019),LatLng(24.973781870268933, 66.9911786343215),
    LatLng(24.96938577473527, 66.9919511107712)

  ];

  CameraPosition cameraPosition=const CameraPosition(target: LatLng(24.96938577473527, 66.9919511107712),zoom: 14.5 );
  Completer<GoogleMapController>completer=Completer();

  List<Polygon>polygon=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    polygon.add( Polygon(polygonId: const PolygonId("1"),points:points,fillColor: Colors.red.withOpacity(0.3),strokeWidth: 3,strokeColor: Colors.deepOrange));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Polygone"),
        centerTitle: true,
      ),
      body: GoogleMap(
        initialCameraPosition: cameraPosition,
        onMapCreated: (GoogleMapController controller){
          completer.complete(controller);
        },
        compassEnabled: true,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        mapType: MapType.normal,
        polygons: Set<Polygon>.of(polygon),
      ),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolyLineScreen extends StatefulWidget {
  const PolyLineScreen({Key? key}) : super(key: key);

  @override
  State<PolyLineScreen> createState() => _PolyLineScreenState();
}

class _PolyLineScreenState extends State<PolyLineScreen> {
  List<LatLng>points=const [
  LatLng(24.96938577473527, 66.9919511107712),LatLng(24.969346870533933, 67.00568402133717),
    LatLng(24.95619654561082, 67.02233517476851),LatLng(24.97564919075646, 67.01825821695452),
    LatLng(24.97771099090698, 67.03632557662019),LatLng(24.973781870268933, 66.9911786343215),
  ];
  CameraPosition cameraPosition=const CameraPosition(target:LatLng(24.96938577473527, 66.9919511107712),zoom: 14.5 );
  Completer<GoogleMapController>completer=Completer();
  List<Marker>marker=[];
  List<Polyline>polyline=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }
  loadData(){
    for(int i=0;i<points.length;i++){
      marker.add(Marker(markerId: MarkerId(i.toString()),position: points[i],infoWindow: InfoWindow(
        title: "Position" + i.toString(),
        snippet: "Beautiful"
      )));
    }
    polyline.add(Polyline(polylineId: const PolylineId("1"),points: points,color: Colors.deepOrange,width: 5,endCap: Cap.roundCap));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PolyLine"),
      ),
      body:GoogleMap(
        initialCameraPosition: cameraPosition,
        markers: Set<Marker>.of(marker),
        polylines: Set<Polyline>.of(polyline),
      ) ,

    );
  }
}

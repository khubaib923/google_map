import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  final CameraPosition cameraPosition=const CameraPosition(target: LatLng(24.97374296744312, 66.99109280386082),zoom: 14.3);
  Completer<GoogleMapController>completer=Completer();
  List<Marker>markers=[];
  List<Marker>list=[
    const Marker(
        position: LatLng(24.973937481376385, 66.99100697316979),
        markerId: MarkerId("1"),infoWindow: InfoWindow(
      title: "Gulshan Bihar Market"
    )),
    const Marker(
        position: LatLng(24.968763306037594, 67.00542652926407),
        markerId: MarkerId("2"),infoWindow: InfoWindow(
        title: "Karachi Ijtemah"
    )),
    const Marker(
        position: LatLng(24.974411096267158, 67.04678550354132),
        markerId: MarkerId("3"),infoWindow: InfoWindow(
        title: "Gulshan Bihar Market"
    )),

  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    markers.addAll(list);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async{
           GoogleMapController controller=await completer.future;
           controller.animateCamera(CameraUpdate.newCameraPosition(const CameraPosition(target: LatLng(24.974411096267158, 67.04678550354132),zoom: 14)));
           // setState(() {
           //
           // });
          },
          child: const Icon(Icons.location_disabled_outlined),
        ),
        body: GoogleMap(
          initialCameraPosition: cameraPosition,
          onMapCreated: (GoogleMapController controller){
            completer.complete(controller);

          },
          compassEnabled: true,
          myLocationEnabled: true,
          mapType: MapType.normal,
          markers: Set<Marker>.of(markers),



        ),
      ),
    );
  }
}

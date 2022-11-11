import 'dart:async';

import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomInfoMarker extends StatefulWidget {
  const CustomInfoMarker({Key? key}) : super(key: key);

  @override
  State<CustomInfoMarker> createState() => _CustomInfoMarkerState();
}

class _CustomInfoMarkerState extends State<CustomInfoMarker> {
  
  CustomInfoWindowController customInfoWindowController=CustomInfoWindowController();

  List<LatLng>latlng=const [
    LatLng(24.96938577473527, 66.9919511107712),LatLng(24.969346870533933, 67.00568402133717),
    LatLng(24.95619654561082, 67.02233517476851),LatLng(24.97564919075646, 67.01825821695452),
    LatLng(24.97771099090698, 67.03632557662019),LatLng(24.973781870268933, 66.9911786343215)
  ];
  
  CameraPosition cameraPosition=const CameraPosition(target: LatLng(24.96938577473527, 66.9919511107712),zoom: 14.5);
  //Completer<GoogleMapController>completer=Completer();
  
  List<Marker>marker=[];
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }
  
  loadData(){
    for(int i=0;i<latlng.length;i++){
      marker.add(Marker(markerId: MarkerId(i.toString()),position: latlng[i],onTap: (){
        customInfoWindowController.addInfoWindow!(Container(
          height: 200,
          width: 300,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Container(
                height: 100,
                width: 300,
                decoration: const BoxDecoration(
                  color: Colors.deepOrange,
                  image: DecorationImage(
                    image: AssetImage("images/car.png"),
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.high
                  )
                ),
              ),
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("Beef Tacos"),
                    Text(".3 mi"),
                  ],

                ),
              ),
              const SizedBox(height: 10,),
              const Text("I am the khubaib Irfan i am a programmer\nand also the crickter")
            ],
          ),

        ),latlng[i]);
      }));
    }
  }
  
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Custom Info Window Example"),
        backgroundColor: Colors.deepOrange,
      ),
      body: Stack(
        children: [
           GoogleMap(
            initialCameraPosition: cameraPosition,
            onMapCreated: (GoogleMapController controller){
              customInfoWindowController.googleMapController=controller;
            },
             onTap: (position){
              customInfoWindowController.hideInfoWindow!();
             },
             onCameraMove: (position){
              customInfoWindowController.onCameraMove!();
             },
             markers: Set<Marker>.of(marker),
           ),
          CustomInfoWindow(controller: customInfoWindowController,height: 200,width: 300,offset:35,)
        ],
      ),
    );
  }
}

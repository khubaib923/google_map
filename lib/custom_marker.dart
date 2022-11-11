
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMarker extends StatefulWidget {
  const CustomMarker({Key? key}) : super(key: key);

  @override
  State<CustomMarker> createState() => _CustomMarkerState();
}

class _CustomMarkerState extends State<CustomMarker> {
  Completer<GoogleMapController>completer=Completer();
  CameraPosition cameraPosition=const CameraPosition(target:LatLng(24.96938577473527, 66.9919511107712),zoom: 14.5 );
  List<Marker>marker=[];
  List<LatLng>latlng=const [
    LatLng(24.96938577473527, 66.9919511107712),LatLng(24.969346870533933, 67.00568402133717),
    LatLng(24.95619654561082, 67.02233517476851),LatLng(24.97564919075646, 67.01825821695452),
    LatLng(24.97771099090698, 67.03632557662019),LatLng(24.973781870268933, 66.9911786343215)
  ];

  List<String>images=["images/car.png","images/car2.png","images/marker.png","images/marker2.png","images/motorbike.png","images/motorbike2.png"];
 Uint8List? imageMarker;
 
 Future<Uint8List>getBytesFromAsset(String path,int width)async{
   ByteData data=await rootBundle.load(path);
   ui.Codec codec=await ui.instantiateImageCodec(data.buffer.asUint8List(),targetHeight: width);
   ui.FrameInfo frameInfo=await codec.getNextFrame();
   return (await frameInfo.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
   
 }
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }
  loadData() async{
     for(int i=0;i<images.length;i++){
       Uint8List markerIcon= await getBytesFromAsset(images[i], 100);
       marker.add(Marker(markerId: MarkerId(i.toString()),position: latlng[i],icon:BitmapDescriptor.fromBytes(markerIcon),infoWindow: InfoWindow(
         title: "Location is awesome" + i.toString(),
       )));
     }

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:GoogleMap(
          initialCameraPosition: cameraPosition,
          onMapCreated: (GoogleMapController controller){
            completer.complete(controller);
          },
          compassEnabled: true,
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          markers: Set<Marker>.of(marker),
          mapType: MapType.normal,
        ) ,
      ),
    );
  }
}





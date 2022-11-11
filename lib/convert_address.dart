import 'dart:async';

import 'package:flutter/material.dart';

import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ConvertAddress extends StatefulWidget {
  const ConvertAddress({Key? key}) : super(key: key);

  @override
  State<ConvertAddress> createState() => _ConvertAddressState();
}

class _ConvertAddressState extends State<ConvertAddress> {

//  final CameraPosition cameraPosition=const CameraPosition(target: LatLng(24.97374296744312, 66.99109280386082),zoom: 14.3);

  //Completer<GoogleMapController>completer=Completer();
  String text="";
  String text1="";

  @override
  Widget build(BuildContext context) {

    return Scaffold(
     body: Padding(
       padding: const EdgeInsets.all(8.0),
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         crossAxisAlignment: CrossAxisAlignment.center,
         children: [
           Text(text),
         const SizedBox(height: 20,),
         Text(text1),
         InkWell(
           onTap: () async{
             // Coordinates coordinates=Coordinates(24.97374296744312, 66.99109280386082);
             // var address=await Geocoder.local.findAddressesFromCoordinates(coordinates);
             // var first=address.first;
             //
             // const query="1600 Amphiteatre Parkway, Mountain View";
             // var addresses=await Geocoder.local.findAddressesFromQuery(query);
             // var second=addresses.first;

             List<Location> locations = await locationFromAddress("Gronausestraat 710, Enschede");
             List<Placemark> placemarks = await placemarkFromCoordinates(52.2165157, 6.9437819);
             setState(() {
               text=locations.first.latitude.toString()+ " "+locations.first.longitude.toString();
               text1=placemarks.first.country.toString()+ " "+placemarks.first.name.toString();
             });
           },
           child: Container(
             height: 50,
             decoration: const BoxDecoration(
               color: Colors.green,
             ),
             child: const Center(child: Text("Convert")),
           ),
         )
         ],
       ),
     ),
    );
  }
}

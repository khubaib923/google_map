import 'package:flutter/material.dart';
import 'package:google_map/convert_address.dart';
import 'package:google_map/custom_marker.dart';
import 'package:google_map/custom_marker_info_window.dart';
import 'package:google_map/get_user_current_location.dart';
import 'package:google_map/home_screen.dart';
import 'package:google_map/network_image_marker.dart';
import 'package:google_map/polygen.dart';
import 'package:google_map/polyline.dart';
import 'package:google_map/searching_location.dart';


void main()=>runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home:NetworkImageMarker()
    );
  }
}

import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;
import 'dart:ui';
class NetworkImageMarker extends StatefulWidget {
  const NetworkImageMarker({Key? key}) : super(key: key);

  @override
  State<NetworkImageMarker> createState() => _NetworkImageMarkerState();
}

class _NetworkImageMarkerState extends State<NetworkImageMarker> {
  Uint8List? markerImage;
  CameraPosition cameraPosition=const CameraPosition(target: LatLng(24.96938577473527, 66.9919511107712),zoom: 14.65);
  Completer<GoogleMapController> completer=Completer();
  List<LatLng>points=const [
  LatLng(24.96938577473527, 66.9919511107712),LatLng(24.969346870533933, 67.00568402133717),
  LatLng(24.95619654561082, 67.02233517476851)
  ];

  List<Marker>marker=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }
  loadData() async{
    for(int i=0;i<points.length;i++){
      Uint8List image=await loadNetworkImage("https://yt3.ggpht.com/s3afMb211lmC40iZ1nqebhaSYzz3Wplbu4YBDxGw5DC3EGyitAwqYXZInI-T3467PanwLoL_Brc=s900-c-k-c0x00ffffff-no-rj");
      ui.Codec codec=await ui.instantiateImageCodec(image.buffer.asUint8List(),targetHeight: 100,targetWidth: 100);
      ui.FrameInfo frameInfo=await codec.getNextFrame();
      final ByteData? byteData=await frameInfo.image.toByteData(
        format: ui.ImageByteFormat.png
      );
      final Uint8List resizedImageMaker=byteData!.buffer.asUint8List();


      marker.add(Marker(markerId: MarkerId(i.toString()),position: points[i],icon: BitmapDescriptor.fromBytes(resizedImageMaker),infoWindow: InfoWindow(
        title: "Position"+i.toString()
      )
      )

      );
      setState(() {

      });
    }
  }

  Future<Uint8List>loadNetworkImage(String path) async{
    Completer<ImageInfo> completed=Completer();
    var image=NetworkImage(path);
    image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener((info,_)=>completed.complete(info))
    ) ;

    final imageInfo=await completed.future;
    final byteData=await imageInfo.image.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: cameraPosition,
          mapType: MapType.normal,
          markers: Set<Marker>.of(marker),
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          onMapCreated: (GoogleMapController controller){
            completer.complete(controller);
          },
        ),
      ),
    );
  }
}

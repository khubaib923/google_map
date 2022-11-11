

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class SearchingLocation extends StatefulWidget {
  const SearchingLocation({Key? key}) : super(key: key);

  @override
  State<SearchingLocation> createState() => _SearchingLocationState();
}

class _SearchingLocationState extends State<SearchingLocation> {
  TextEditingController textEditingController=TextEditingController();
  Uuid uuid=const Uuid();
  String sessionToken="1234567";
  List<dynamic>list=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textEditingController.addListener(() {
      onChanged();
    });
  }

  onChanged(){
    if(sessionToken==null){
      sessionToken=uuid.v4();
    }
    else{
      generatedSearchingList(textEditingController.text);
    }
  }

  generatedSearchingList(String input) async{

    String kPLACESAPIKEY="AIzaSyC-DpRhWlFE5AUUhwKu0-5sb97Djt6Srvw";
    String baseURL ='https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request = '$baseURL?input=$input&key=$kPLACESAPIKEY&sessiontoken=$sessionToken';

    final response=await http.get(Uri.parse(request));
    if(response.statusCode==200){
      list=jsonDecode(response.body.toString())['predictions'];

    }
    else{

      throw Exception("Failed");
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      title: const Text("Google Search Places Api"),
      centerTitle: true,
    ),
    body: Column(
      children: [
        TextFormField(
          controller: textEditingController,
          decoration: const InputDecoration(
            hintText: "Search Cities with name"
          ),
        ),
        Expanded(child: ListView.builder(
          itemCount: list.length,
            itemBuilder: (context,index){
              return ListTile(
                onTap: () async{
                  List<Location> locations = await locationFromAddress(list[index]['desccription']);
                  print(locations.first.longitude);
                  print(locations.first.latitude);
                },
                title:Text(list[index]['description']) ,
              );
            }

        ))
      ],
    ),
    );
  }
}

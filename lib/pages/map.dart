import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  static const String token = 'pk.eyJ1IjoibWVkc291aSIsImEiOiJjbTFwZ3UxZWowNGVmMmlzanlieWRzdDI5In0.new4dhJzrpAH5rv-7gM1Bg';
  static const String urlTemp = 'https://api.mapbox.com/styles/v1/mapbox/streets-v12/tiles/256/{z}/{x}/{y}?access_token=$token';
  final MapController _mapController = MapController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
      home:  Scaffold(
        body:Stack(
          children: [
            FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                  initialCenter: LatLng(27.055366, -13.424025),
                  initialZoom: 16.7,
                  onTap: (tapPosition,LatLng){

                  }
              ),
              children: [
                TileLayer(
                  urlTemplate: urlTemp,
                  fallbackUrl: urlTemp,
                  //urlTemplate:"http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png" ,
                ),

              ],
            ),

          ],
        ) ,
      )
    );
  }
}

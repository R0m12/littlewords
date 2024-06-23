import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';


class LittleWordsMap extends StatelessWidget {
   LittleWordsMap({Key? key}): super(key: key);

  final _mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        zoom: 14,
        onMapReady: () {
          // TODO: Utiliser le package Location pour récupérer la position de l'utilisateur
          Location location = new Location();

          Timer.periodic(Duration(seconds: 1), (timer) {
            location.getLocation().then((value) {
              print(value.latitude);
              print(value.longitude);
            });
          });

          _mapController.move(LatLng(51.03, 2.38), _mapController.zoom);
        }
      ),

        //TODO: Ajouter un marker pour indiquer la position de l'utilisateur
        //var currentLatitude;
        //var currentLongitude;

       // FlutterMap(
       //   options: MapOptions(
       //     center: LatLng(currentLatitude, currentLongitude),
       //     zoom: 15.0,
       //   ),
       //   layers: [
       //     TileLayerOptions(
       //         urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
       //         subdomains: ['a', 'b', 'c']
       //     ),
       //     MarkerLayerOptions(markers: _markers)
       //   ],
       //   mapController: _mapController,
       // )


        //TODO: Ajouter des markers sur les mots présentes aux alentours
      //],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';


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
          _mapController.move(LatLng(51.03, 2.38), _mapController.zoom);
        }
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://',
          userAgentPackageName: ''
        ),

        //TODO: Ajouter un marker pour indiquer la position de l'utilisateur
        //TODO: Ajouter des markers sur les mots présentes aux alentours
      ],
    );
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class Map extends StatefulWidget{
  const Map({super.key});

  @override
  State<StatefulWidget> createState() => MapState();
}

class MapState extends State<Map> {
  MapController mapController = MapController();
  double zoom = 2;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      FlutterMap(mapController: mapController,
        options: MapOptions(
          interactiveFlags: InteractiveFlag.drag | InteractiveFlag.pinchZoom,
            minZoom: zoom,
            maxBounds: LatLngBounds(
                LatLng(50.974927, -4.611596), LatLng(41.379981, 9.582739))),

        nonRotatedChildren: [
          TileLayer(
            tileDisplay: const TileDisplay.fadeIn(duration: Duration(milliseconds: 300),startOpacity: 0, reloadStartOpacity: 0),
              minZoom: 1,
              maxZoom: 18,
              urlTemplate:
              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: ['a', 'b', 'c'])
        ],
      ),
      Positioned(bottom: 10,child: ElevatedButton(
          onPressed: () =>
              setState(() {
                zoom += 1;
              }),
          child: Text("more"))),
      Positioned(bottom: 50,child: ElevatedButton(
          onPressed: () =>
              setState(() {
                mapController.move(LatLng(48.850241, 2.353556), 12);
              }),
          child: Text("less"))),
    ]);
  }

}
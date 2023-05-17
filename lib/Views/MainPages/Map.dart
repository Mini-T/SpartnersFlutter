import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:spartners_app/services/AuthService.dart';

class Map extends StatefulWidget {
  const Map({super.key});

  @override
  State<StatefulWidget> createState() => MapState();
}

class MapState extends State<Map> {
  AuthService authService = AuthService();
  MapController mapController = MapController();
  double zoom = 2;
  late LocationPermission permission;
  List listSalle = [];
  List listUser = [];
  List markerData = [];
  late Position position;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Geolocator.requestPermission().then((value) => {
          getLocations(),
          updatePosition(),
        });
  }

  void mergeLocations() {
    print("salles: $listSalle");
    print("users: $listUser");
    setState(() {
      markerData = [...listSalle, ...listUser];
    });
    print(markerData);
  }

  Future<void> updatePosition() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    mapController.move(LatLng(position.latitude, position.longitude), zoom);
    authService.sendLocation(position.latitude, position.longitude);
  }

  Future<void> getLocations() async {
    List userResult = await authService.getUsers();
    List salleResult = await authService.getSalles();
    listUser = userResult;
    listSalle = salleResult;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      FlutterMap(
        mapController: mapController,
        options: MapOptions(
            center: LatLng(45.904730, 6.126740),
            interactiveFlags: InteractiveFlag.drag | InteractiveFlag.pinchZoom,
            minZoom: zoom,
            maxBounds: LatLngBounds(
                LatLng(50.974927, -4.611596), LatLng(41.379981, 9.582739))),
        nonRotatedChildren: [
          TileLayer(
              tileDisplay: const TileDisplay.fadeIn(
                  duration: Duration(milliseconds: 300),
                  startOpacity: 0,
                  reloadStartOpacity: 0),
              minZoom: 1,
              maxZoom: 18,
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: ['a', 'b', 'c']),
          MarkerLayer(
              markers: listSalle.isNotEmpty
                  ? listSalle.map((element) {
                      return Marker(
                        width: 80,
                        height: 80,
                        point:
                            LatLng(element["latitude"], element["longitude"]),
                        builder: (context) =>
                            Icon(Icons.fitness_center, size: 60),
                      );
                    }).toList()
                  : []),
          MarkerLayer(
              markers: listUser.isNotEmpty
                  ? listUser.map((element) {
                      if (element['latitude'] != null &&
                          element["longitude"] != null) {
                        return Marker(
                          width: 80,
                          height: 80,
                          point:
                              LatLng(element["latitude"], element["longitude"]),
                          builder: (context) =>
                              Icon(Icons.person_pin_circle, size: 60),
                        );
                      }
                      return Marker(point: LatLng(0,0), builder: (context) => Container());
                    }
                    ).toList()
                  : []),
        ],
      ),
    ]);
  }
}

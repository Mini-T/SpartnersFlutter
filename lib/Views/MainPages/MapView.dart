import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:core';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:spartners_app/Views/Dialogs/ProfileDialog.dart';
import 'package:spartners_app/Views/Dialogs/SalleDialog.dart';
import 'package:spartners_app/services/AuthService.dart';
import 'package:getwidget/getwidget.dart';

import '../../Models/UserDTO.dart';

class MapView extends StatefulWidget {
  List listUser;
  List listSalle;
  UserDTO profile;

  MapView(
      {super.key,
      required this.listUser,
      required this.listSalle,
      required this.profile});

  @override
  State<StatefulWidget> createState() =>
      MapViewState(listUser: listUser, listSalle: listSalle, profile: profile);
}

class MapViewState extends State<MapView> {
  AuthService authService = AuthService();
  MapController mapController = MapController();
  double zoom = 2;
  late LocationPermission permission;
  late List listSalle;
  late List listUser;
  List markerData = [];
  UserDTO profile;
  late Position position;
  bool loading = false;

  Map<String, Map<String, double>> cityCoordinates = {
    'Annecy': {'latitude': 45.899247, 'longitude': 6.129384}
  };

  void placeMapOnCurrentLocation() {
    if(profile.latitude == null || profile.longitude == null) {
      mapController.move(
          LatLng(cityCoordinates['Annecy']!['latitude']!,
              cityCoordinates['Annecy']!['longitude']!),
          13);
      return;
    }
    mapController.move(
        LatLng(profile.latitude!,
            profile.longitude!),
        13);
  }

  MapViewState(
      {required this.listUser, required this.listSalle, required this.profile});

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('innit');
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if(this.mounted) {
        print('postFrame');
        placeMapOnCurrentLocation();
        refreshInfo();
      }
    });

  }

  Future<void> refreshInfo() async {
    setState(() => loading = true);
    Geolocator.requestPermission().then((value) async => {
          if (value == LocationPermission.whileInUse ||
              value == LocationPermission.always)
            {
              await updatePosition(),
            },
          await getLocations(),
          if(mounted) setState(() => loading = false)
        });
  }

  Future<void> updatePosition() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    mapController.move(LatLng(position.latitude, position.longitude), zoom);
    if(profile.visible) {
      authService.sendLocation(position.latitude, position.longitude);
    }
  }

  Future<void> getLocations() async {
    List userResult = await authService.getUsers();
    List salleResult = await authService.getSalles();
    listUser = userResult;
    listSalle = salleResult;
    if(this.mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      FlutterMap(
        mapController: mapController,
        options: MapOptions(
            center: LatLng(41.40338, 2.17403),
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
                        width: 50,
                        height: 50,
                        point:
                            LatLng(element["latitude"], element["longitude"]),
                        builder: (context) => Tooltip(
                            message: element['name'],
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(100)),
                                child: IconButton(
                                    onPressed: () {
                                      showModalBottomSheet(
                                        isScrollControlled: true,
                                        context: context,
                                        builder: (context) =>
                                            SalleDialog(salleInfo: element),
                                      );
                                    },
                                    icon: const Icon(Icons.fitness_center,
                                        size: 35)))),
                      );
                    }).toList()
                  : []),
          MarkerLayer(
              markers: listUser.isNotEmpty
                  ? listUser.map((element) {
                    print(element.toString());
                      if (element['latitude'] != null &&
                          element["longitude"] != null && element['visible']) {
                        return Marker(
                            width: 50,
                            height: 50,
                            point: LatLng(
                                element["latitude"], element["longitude"]),
                            builder: (context) => Tooltip(
                                message: element['firstname'],
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    child: IconButton(
                                        onPressed: () => showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  Dialog.fullscreen(
                                                      child: ProfileDialog(
                                                          userInfo: element)),
                                            ),
                                        icon: const Center(
                                            child: Icon(Icons.person_2,
                                                size: 29))))));
                      }
                      return Marker(
                          point: LatLng(0, 0),
                          builder: (context) => Container());
                    }).toList()
                  : []),
        ],
      ),
      Positioned(
          right: 20,
          top: 60,
          child: ElevatedButton(
              onPressed: () async => refreshInfo(),
              style: ButtonStyle(
                  shape: MaterialStatePropertyAll(CircleBorder()),
                  backgroundColor: MaterialStatePropertyAll(Colors.white),
                  fixedSize: MaterialStatePropertyAll(Size(60, 60))),
              child: !loading
                  ? Center(
                      child: Icon(Icons.refresh, color: Colors.blue, size: 30))
                  : const GFLoader(size: 30, type: GFLoaderType.android))),
    ]);
  }
}

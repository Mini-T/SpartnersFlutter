import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:spartners_app/Views/Dialogs/ProfileDialog.dart';
import 'package:spartners_app/Views/Dialogs/SalleDialog.dart';
import 'package:spartners_app/services/AuthService.dart';
import 'package:getwidget/getwidget.dart';

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
  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    refreshInfo();
  }
  Future<void> refreshInfo() async {
    setState(() => loading = true);
    Geolocator.requestPermission().then((value) async => {
      if (value == LocationPermission.whileInUse || value == LocationPermission.always){
        await updatePosition(),
      },
      await getLocations(),
      setState(()=> loading = false)
    });
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
                        width: 50,
                        height: 50,
                        point: LatLng(element["latitude"], element["longitude"]),
                        builder: (context) => Tooltip(
                            message: element['name'],
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(100)),
                                child: IconButton(
                                    onPressed: () => showDialog(
                                          context: context,
                                          builder: (context) =>
                                              Dialog.fullscreen(child: SalleDialog(salleInfo: element)),
                                        ),
                                    icon: const Icon(Icons.fitness_center, size: 35)))),
                      );
                    }).toList()
                  : []),
          MarkerLayer(
              markers: listUser.isNotEmpty
                  ? listUser.map((element) {
                      if (element['latitude'] != null &&
                          element["longitude"] != null) {
                        return Marker(
                          width: 50,
                          height: 50,
                          point:
                              LatLng(element["latitude"], element["longitude"]),
                          builder: (context) =>
                              Tooltip(
                                  message: element['firstname'],
                                  child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.blue, width: 3, style: BorderStyle.solid),
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(100)),
                                      child: IconButton(
                                          onPressed: () => showDialog(
                                            context: context,
                                            builder: (context) =>
                                                Dialog.fullscreen(child: ProfileDialog(userInfo: element)),
                                          ),
                                          icon: const Center(child:Icon(Icons.person_2, size: 29)))))
                        );
                      }
                      return Marker(
                          point: LatLng(0, 0),
                          builder: (context) => Container());
                    }).toList()
                  : []),
        ],
      ),
       Positioned(right: 20, top: 60, child: ElevatedButton(onPressed: () async => refreshInfo(),
           style: ButtonStyle(shape: MaterialStatePropertyAll(CircleBorder()),backgroundColor: MaterialStatePropertyAll(Colors.white),fixedSize: MaterialStatePropertyAll(Size(60, 60))),
           child: !loading ? Center(child: Icon(Icons.refresh, color: Colors.blue, size: 30)) : const GFLoader(size:30, type: GFLoaderType.android)
       ))
    ]);
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:workmanagers_example/bloc/movement_cubit/movement_cubit.dart';

class MapScreen extends StatefulWidget {
  LatLng? currentLocation;
  MapScreen({this.currentLocation,Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  late CameraPosition initialCameraPosition;
  late CameraPosition cameraPosition;

  Set<Marker> mapMarkers = {};
  LatLng? currentLatLng;

  _init() {
    var routes = context.read<MovementCubit>().routes;
    currentLatLng = routes[routes.length-1];
    initialCameraPosition = CameraPosition(
      target: widget.currentLocation??LatLng(
        routes[routes.length-1].latitude,
        routes[routes.length-1].longitude,
      ),
      zoom: 15,
    );
    cameraPosition = CameraPosition(
      target: widget.currentLocation??LatLng(
        routes[routes.length-1].latitude,
        routes[routes.length-1].longitude,
      ),
      zoom: 15,
    );
  }
  @override
  void initState() {
    _init();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              onCameraMove: (position) {
                cameraPosition = position;
              },
              markers: widget.currentLocation==null?context.read<MovementCubit>().markers:{},
              mapType: MapType.hybrid,
              onMapCreated: (controller) {
                // controller.;
              },
              initialCameraPosition: CameraPosition(
                  zoom: 11,
                  target:
                  currentLatLng!),
            ),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 50,
                height: 50,
                child: Image.asset(
                  "assets/ronaldo.png",
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }



}
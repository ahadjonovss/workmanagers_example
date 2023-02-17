import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:workmanagers_example/bloc/movement_cubit/movement_cubit.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late CameraPosition initialCameraPosition;
  late CameraPosition cameraPosition;
  late GoogleMapController mapController;

  Set<Marker> mapMarkers = {};

  _init() {
    initialCameraPosition = const CameraPosition(
      target: LatLng(
        1,
        1,
      ),
      zoom: 15,
    );
    cameraPosition = const CameraPosition(
      target: LatLng(
        1,
        1,
      ),
      zoom: 15,
    );

    print(context.read<MovementCubit>().routes);
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
      child: Stack(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: GoogleMap(

                polylines: {
                  Polyline(
                      polylineId: const PolylineId("1"),
                      points: context.read<MovementCubit>().routes,
                      color: Colors.red,
                      width: 7)
                },
                onCameraMove: (position) {
                  cameraPosition = position;
                },
                markers: mapMarkers,
                mapType: MapType.normal,
                onMapCreated: (controller) {
                  mapController = controller;
                },
                initialCameraPosition: const CameraPosition(
                    target: LatLng(41.285416, 69.204007), zoom: 17),
              ),
            ),
          ],
        ),
      ]),
    ));
  }
}

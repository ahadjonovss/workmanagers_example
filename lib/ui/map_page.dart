import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:workmanagers_example/bloc/movement_cubit/movement_cubit.dart';
import 'dart:ui' as ui;
class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

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
      target: LatLng(
        routes[routes.length-1].latitude,
        routes[routes.length-1].longitude,
      ),
      zoom: 15,
    );
    cameraPosition = CameraPosition(
      target: LatLng(
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
              markers: context.read<MovementCubit>().markers,
              mapType: MapType.hybrid,
              onMapCreated: (controller) {},
              initialCameraPosition: CameraPosition(
                  zoom: 19.151926040649414,
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

  Future<void> _addMarker(String title) async {
    Uint8List markerImage = await getBytesFromAsset(
      "assets/ronaldo.png",
      150,
    );
    mapMarkers.add(
      Marker(
        markerId: MarkerId(cameraPosition.target.latitude.toString()),
        infoWindow: InfoWindow(
          title: "Manzil",
          snippet: title,
        ),
        position: cameraPosition.target,
        icon: BitmapDescriptor.fromBytes(markerImage),
      ),
    );
    setState(() {});
  }

  static Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
      targetWidth: width,
    );
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }
}
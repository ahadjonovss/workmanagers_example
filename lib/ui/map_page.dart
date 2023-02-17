import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late CameraPosition initialCameraPosition;
  late CameraPosition cameraPosition;

  Set<Marker> mapMarkers = {};

  _init() {
    initialCameraPosition = CameraPosition(
      target: LatLng(
        1,
        1,
      ),
      zoom: 15,
    );
    cameraPosition = CameraPosition(
      target: LatLng(
        1,
        1,
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
      child: Stack(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: GoogleMap(
                onCameraMove: (position) {
                  cameraPosition = position;
                },
                markers: mapMarkers,
                mapType: MapType.hybrid,
                onMapCreated: (controller) {},
                initialCameraPosition: const CameraPosition(
                    zoom: 19.151926040649414, target: LatLng(1, 1)),
              ),
            ),
          ],
        ),
      ]),
    ));
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

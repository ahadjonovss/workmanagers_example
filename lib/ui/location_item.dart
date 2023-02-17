import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:workmanagers_example/data/model/movement_model.dart';

class LocationItem extends StatelessWidget {
  MovementModel movementModel;
   LocationItem({required this.movementModel,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text( movementModel.time),
      subtitle: Text("Lat: ${movementModel.lat}  - Long: ${movementModel.long}"),
      leading: Icon(Icons.location_city),
    );
  }
}

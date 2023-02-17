import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:workmanagers_example/data/model/movement_model.dart';
import 'package:workmanagers_example/ui/map_page.dart';

class LocationItem extends StatelessWidget {
  MovementModel movement;
   LocationItem({required this.movement,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.parse(movement.time);
    return Container(
      margin: const  EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.blue.shade200
      ),
      child: ListTile(
        trailing: IconButton(onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => MapScreen(currentLocation: LatLng(movement.lat.toDouble(),movement.long.toDouble()),)));
        },icon: const Icon(Icons.map,color: Colors.white,),
        ),
        title: Text("${date.day}.${date.month}..${date.year} / ${date.hour}:${date.minute}"),
        subtitle: Text("Lat: ${movement.lat}  - Long: ${movement.long}"),
        leading: const Icon(Icons.location_city,),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:workmanagers_example/bloc/location_permission_cubit/location_permission_cubit.dart';
import 'package:workmanagers_example/bloc/movement_cubit/movement_cubit.dart';
import 'package:workmanagers_example/data/model/movement_model.dart';
import 'package:workmanagers_example/data/repositories/movement_repository.dart';
import 'package:workmanagers_example/service/api_service.dart';
import 'package:workmanagers_example/ui/location_item.dart';
import 'package:workmanagers_example/ui/map_page.dart';

class MovementInfoPage extends StatelessWidget {
  const MovementInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // context.read<LocationPermissionCubit>().listenPermissionStatus();
    return Scaffold(
      appBar: AppBar(title: Text("Movements"),
        actions: [
          IconButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => MapScreen(),));

          }, icon: Icon(Icons.next_plan))
        ],
      ),
      body: FutureBuilder(
        future: MovementRepository().getMovements(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            List<MovementModel> movements = snapshot.data!;
            context.read<MovementCubit>().initRoutes(movements);

            print("Movements: $movements");
              return ListView.builder(
              itemCount: movements.length,
              shrinkWrap: true,
              itemBuilder: (context, index) => LocationItem());

            // return IconButton(onPressed: () async {
            //   // await Geolocator.requestPermission();
            //   // Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
            //   // await MovementRepository().addMovement(MovementModel(lat: position.latitude, long: position.longitude, time: DateTime.now().toString()));
            //   // print("Movement added");
            //
            //   ApiService().getLocation();
            // }, icon: Icon(Icons.add));
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}

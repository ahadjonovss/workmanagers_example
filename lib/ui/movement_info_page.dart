import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:workmanagers_example/bloc/movement_cubit/movement_cubit.dart';
import 'package:workmanagers_example/data/model/movement_model.dart';
import 'package:workmanagers_example/data/repositories/movement_repository.dart';
import 'package:workmanagers_example/ui/widgets/location_item.dart';
import 'package:workmanagers_example/ui/map_page.dart';

class MovementInfoPage extends StatelessWidget {
  const MovementInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movements"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MapScreen(),
                    ));
              },
              icon: Icon(Icons.next_plan))
        ],
      ),
      body: BlocBuilder<MovementCubit,MovementState>(
       builder: (context, state) {
         if (state is GotMovementInSuccess) {
           List<MovementModel> movements = state.movements;
           context.read<MovementCubit>().initRoutes(movements);
           return ListView.builder(
               itemCount: movements.length,
               shrinkWrap: true,
               itemBuilder: (context, index) => LocationItem(
                 movement: movements[index],
               ));
         }
         if(state is GotMovementInProgress){
           return const Center(child: CircularProgressIndicator(),);
         }
         return IconButton(
             onPressed: () async {
               await Geolocator.requestPermission();
             },
             icon: const Icon(Icons.add));
       },
      ),
    );
  }
}

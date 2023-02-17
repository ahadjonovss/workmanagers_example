import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workmanager/workmanager.dart';
import 'package:workmanagers_example/bloc/movement_cubit/movement_cubit.dart';
import 'package:workmanagers_example/data/model/movement_model.dart';
import 'package:workmanagers_example/data/repositories/movement_repository.dart';
import 'package:workmanagers_example/ui/movement_info_page.dart';
import 'package:geolocator/geolocator.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
      await Future.delayed(const Duration(seconds: 2));
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      Geolocator.getPositionStream().listen((event) async {
        await MovementRepository().addMovement(MovementModel(lat: position.latitude, long: position.longitude, time: DateTime.now().toString()));
      });
      print("Movement added");

    return Future.value(true);
  });
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().initialize(
      callbackDispatcher,
      isInDebugMode: true);
  Workmanager().registerPeriodicTask("task-identifier", "simpleTask",frequency: const Duration(minutes: 15));
  runApp( MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => MovementCubit(),),
    ],
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MovementInfoPage(),
    );
  }
}

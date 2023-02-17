import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import 'package:workmanagers_example/data/model/movement_model.dart';

part 'movement_state.dart';

class MovementCubit extends Cubit<MovementState> {
  MovementCubit() : super(MovementInitial());


  List<LatLng> routes = [];

  initRoutes(List<MovementModel> movements){
    for (var element in movements) {
      routes.add(LatLng(element.lat.toDouble(),element.long.toDouble()));
    }
  }
}

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import 'package:workmanagers_example/data/model/movement_model.dart';
import 'package:workmanagers_example/data/repositories/movement_repository.dart';

part 'movement_state.dart';

class MovementCubit extends Cubit<MovementState> {
  MovementCubit() : super(MovementInitial()){
    getMovements();
  }


  List<LatLng> routes = [];
  Set<Marker> markers = {};



  initRoutes(List<MovementModel> movements) async {
    for (int i = 0; i < movements.length; i++) {
      routes.add(LatLng(movements[i].lat.toDouble(),movements[i].long.toDouble()));
      markers.add(
          Marker(
        position: LatLng(movements[i].lat.toDouble(),movements[i].long.toDouble()),
            markerId: MarkerId(i.toString())));
    }
    // print("MANA $markers");
  }

  getMovements() async {
    List<MovementModel> movements= await MovementRepository().getMovements();
    emit(GotMovementInSuccess(movements: movements));
  }
}

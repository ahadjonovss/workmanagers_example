
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';

part 'location_permission_state.dart';

class LocationPermissionCubit extends Cubit<LocationPermissionState> {
  LocationPermissionCubit() : super(LocationPermissionState(permissionStatus: LocationPermissionStatus.DENIED)){
    listenPermissionStatus();
  }

  listenPermissionStatus(){
    print("MaanaaaAAAAAAAAAAAAAAAA");
    Geolocator.getServiceStatusStream().listen((event) {
      print("Location Status: ${event.name}");
    });
  }
}

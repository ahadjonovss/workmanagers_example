part of 'location_permission_cubit.dart';

@immutable
class LocationPermissionState extends Equatable{

  LocationPermissionStatus permissionStatus;

  LocationPermissionState({required this.permissionStatus});

  copyWith({LocationPermissionStatus? permissionStatus}){
    return LocationPermissionState(permissionStatus: permissionStatus??this.permissionStatus);
  }
  @override
  // TODO: implement props
  List<Object?> get props => [
    permissionStatus
  ];


}


enum LocationPermissionStatus{
  GRANTED,
  DENIED
}

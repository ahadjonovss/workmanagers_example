import 'package:dio/dio.dart';

class ApiService{

  getLocation() async {
    Dio dio = Dio();
    String url = "https://api.openrouteservice.org/v2/directions/driving-car?api_key=5b3ce3597851110001cf624819ae9ea7d13d460f95d6ca894f96b5d0&start=8.681495,49.41461&end=8.687872,49.420318";
    final response = await dio.get('https://dart.dev');
    print(response);
  }
}
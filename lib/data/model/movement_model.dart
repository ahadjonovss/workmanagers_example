class MovementModel {
  num lat;
  num long;
  String time;

  MovementModel({required this.lat, required this.long, required this.time});

  factory MovementModel.fromJson(Map<String, dynamic> json) {
    return MovementModel(
        lat: json["lat"], long: json['lat'], time: json['time']);
  }

  toJson() => {"lat": lat, "long": long, "time": time};
}

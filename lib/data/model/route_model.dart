class RouteModel {
  RouteModel({
    required this.routes,
    required this.bbox,
    required this.metadata,
  });

  List<Route> routes;
  List<double> bbox;
  Metadata metadata;

  factory RouteModel.fromJson(Map<String, dynamic> json) => RouteModel(
    routes: List<Route>.from(json["routes"].map((x) => Route.fromJson(x))),
    bbox: List<double>.from(json["bbox"].map((x) => x?.toDouble())),
    metadata: Metadata.fromJson(json["metadata"]),
  );

  Map<String, dynamic> toJson() => {
    "routes": List<dynamic>.from(routes.map((x) => x.toJson())),
    "bbox": List<dynamic>.from(bbox.map((x) => x)),
    "metadata": metadata.toJson(),
  };
}

class Metadata {
  Metadata({
    required this.attribution,
    required this.service,
    required this.timestamp,
    required this.query,
    required this.engine,
  });

  String attribution;
  String service;
  int timestamp;
  Query query;
  Engine engine;

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
    attribution: json["attribution"],
    service: json["service"],
    timestamp: json["timestamp"],
    query: Query.fromJson(json["query"]),
    engine: Engine.fromJson(json["engine"]),
  );

  Map<String, dynamic> toJson() => {
    "attribution": attribution,
    "service": service,
    "timestamp": timestamp,
    "query": query.toJson(),
    "engine": engine.toJson(),
  };
}

class Engine {
  Engine({
    required this.version,
    required this.buildDate,
    required this.graphDate,
  });

  String version;
  DateTime buildDate;
  DateTime graphDate;

  factory Engine.fromJson(Map<String, dynamic> json) => Engine(
    version: json["version"],
    buildDate: DateTime.parse(json["build_date"]),
    graphDate: DateTime.parse(json["graph_date"]),
  );

  Map<String, dynamic> toJson() => {
    "version": version,
    "build_date": buildDate.toIso8601String(),
    "graph_date": graphDate.toIso8601String(),
  };
}

class Query {
  Query({
    required this.coordinates,
    required this.profile,
    required this.format,
  });

  List<List<double>> coordinates;
  String profile;
  String format;

  factory Query.fromJson(Map<String, dynamic> json) => Query(
    coordinates: List<List<double>>.from(json["coordinates"].map((x) => List<double>.from(x.map((x) => x?.toDouble())))),
    profile: json["profile"],
    format: json["format"],
  );

  Map<String, dynamic> toJson() => {
    "coordinates": List<dynamic>.from(coordinates.map((x) => List<dynamic>.from(x.map((x) => x)))),
    "profile": profile,
    "format": format,
  };
}

class Route {
  Route({
    required this.summary,
    required this.segments,
    required this.bbox,
    required this.geometry,
    required this.wayPoints,
  });

  Summary summary;
  List<Segment> segments;
  List<double> bbox;
  String geometry;
  List<int> wayPoints;

  factory Route.fromJson(Map<String, dynamic> json) => Route(
    summary: Summary.fromJson(json["summary"]),
    segments: List<Segment>.from(json["segments"].map((x) => Segment.fromJson(x))),
    bbox: List<double>.from(json["bbox"].map((x) => x?.toDouble())),
    geometry: json["geometry"],
    wayPoints: List<int>.from(json["way_points"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "summary": summary.toJson(),
    "segments": List<dynamic>.from(segments.map((x) => x.toJson())),
    "bbox": List<dynamic>.from(bbox.map((x) => x)),
    "geometry": geometry,
    "way_points": List<dynamic>.from(wayPoints.map((x) => x)),
  };
}

class Segment {
  Segment({
    required this.distance,
    required this.duration,
    required this.steps,
  });

  double distance;
  double duration;
  List<Step> steps;

  factory Segment.fromJson(Map<String, dynamic> json) => Segment(
    distance: json["distance"]?.toDouble(),
    duration: json["duration"]?.toDouble(),
    steps: List<Step>.from(json["steps"].map((x) => Step.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "distance": distance,
    "duration": duration,
    "steps": List<dynamic>.from(steps.map((x) => x.toJson())),
  };
}

class Step {
  Step({
    required this.distance,
    required this.duration,
    required this.type,
    required this.instruction,
    required this.name,
    required this.wayPoints,
  });

  double distance;
  double duration;
  int type;
  String instruction;
  String name;
  List<int> wayPoints;

  factory Step.fromJson(Map<String, dynamic> json) => Step(
    distance: json["distance"]?.toDouble(),
    duration: json["duration"]?.toDouble(),
    type: json["type"],
    instruction: json["instruction"],
    name: json["name"],
    wayPoints: List<int>.from(json["way_points"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "distance": distance,
    "duration": duration,
    "type": type,
    "instruction": instruction,
    "name": name,
    "way_points": List<dynamic>.from(wayPoints.map((x) => x)),
  };
}

class Summary {
  Summary({
    required this.distance,
    required this.duration,
  });

  double distance;
  double duration;

  factory Summary.fromJson(Map<String, dynamic> json) => Summary(
    distance: json["distance"]?.toDouble(),
    duration: json["duration"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "distance": distance,
    "duration": duration,
  };
}

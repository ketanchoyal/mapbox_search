part of mapbox_search;

class Geometry {
  Geometry({
    required this.coordinates,
    required this.type,
  });

  // final List<double> coordinates;
  final String type;
  final ({double long, double lat}) coordinates;

  // (long: coordinates[0], lat: coordinates[1]);

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        coordinates: (
          long: json["coordinates"][0],
          lat: json["coordinates"][1],
        ),
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "coordinates": [coordinates.long, coordinates.lat],
        "type": type,
      };
}

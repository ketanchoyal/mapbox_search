part of mapbox_search;

class BBox {
  final Location min;
  final Location max;

  BBox({
    required this.min,
    required this.max,
  });

  String get asString => min.asString + ',' + max.asString;

  List<double> get asList => [
        ...min.asList,
        ...max.asList,
      ];

  factory BBox.fromJson(Map<String, dynamic> json) => BBox(
        min: (
          long: json["bbox"][0],
          lat: json["bbox"][1],
        ),
        max: (
          long: json["bbox"][2],
          lat: json["bbox"][3],
        ),
      );
  factory BBox.fromList(List<dynamic> list) => BBox(
        min: list.asLocation,
        max: list.sublist(2).asLocation,
      );
}

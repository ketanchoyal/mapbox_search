import 'package:json_annotation/json_annotation.dart';
import 'package:mapbox_search/models/location.dart';

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

  factory BBox.fromList(List<double> list) => BBox(
        min: list.asLocation,
        max: list.sublist(2).asLocation,
      );
}

class BBoxConverter extends JsonConverter<BBox, List<dynamic>> {
  const BBoxConverter() : super();

  @override
  BBox fromJson(List<dynamic> json) {
    return BBox(
      min: (
        long: json[0].toString().toDouble(),
        lat: json[1].toString().toDouble()
      ),
      max: (
        long: json[2].toString().toDouble(),
        lat: json[3].toString().toDouble()
      ),
    );
  }

  @override
  List<double> toJson(BBox object) {
    return object.asList;
  }
}

extension on String {
  double toDouble() {
    return double.tryParse(this) ?? 0.0;
  }
}

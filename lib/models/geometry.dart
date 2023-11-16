import 'package:json_annotation/json_annotation.dart';
import 'package:mapbox_search/models/location.dart';

part 'geometry.g.dart';

@JsonSerializable()
class Geometry {
  Geometry({
    required this.coordinates,
    required this.type,
  });

  final String type;
  @LocationConverter()
  final Location coordinates;

  factory Geometry.fromJson(Map<String, dynamic> json) =>
      _$GeometryFromJson(json);

  Map<String, dynamic> toJson() => _$GeometryToJson(this);
}

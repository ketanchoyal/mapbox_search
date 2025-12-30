import 'package:json_annotation/json_annotation.dart';
import 'package:mapbox_search/models/v6/geocoding_v6_response.dart';

part 'batch_response.g.dart';

@JsonSerializable()
class BatchGeocodingResponse {
  final List<GeocodingResponseV6> batch;

  BatchGeocodingResponse({required this.batch});

  factory BatchGeocodingResponse.fromJson(Map<String, dynamic> json) =>
      _$BatchGeocodingResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BatchGeocodingResponseToJson(this);
}
